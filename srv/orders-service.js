// ─────────────────────────────────────────────
//  srv/orders-service.js  –  Service Handler
// ─────────────────────────────────────────────
const cds = require("@sap/cds");

module.exports = class OrdersService extends cds.ApplicationService {
  async init() {
    const { Orders, OrderItems } = this.entities;

    // ────────────────────────────────────────────────────────
    //  BEFORE CREATE / UPDATE  –  compute line totals + order total
    // ────────────────────────────────────────────────────────
    this.before(["CREATE", "UPDATE"], "Orders", (req) => {

      // Validate OrderItems quantity during deep insert
      if (req.data.items && Array.isArray(req.data.items)) {
        for (const item of req.data.items) {
          const userQtd = item.quantity;
          if (userQtd == 100) {
            // req.warn erzeugt eine Meldung, lässt die Aktion aber durch
            req.warn(400, "Hoppla, 100 ==> pass uff!", "quantity");
          }
        }
      }

      _calcTotals(req.data);
    });

    this.after(["DELETE"], "Orders", (req) => {
      // 'data' enthält bei DELETE oft die Anzahl der gelöschten Sätze
      console.log(`Order wurde gelöscht, huaaaaaa!`);
    });

    this.before(["CREATE", "UPDATE"], "OrderItems", (req) => {
      _calcLineTotal(req.data);
    });

    // ────────────────────────────────────────────────────────
    //  ACTION  –  recalculate(orderId)
    //  Re-reads the order, recomputes all totals, persists.
    // ────────────────────────────────────────────────────────
    this.on("recalculate", async (req) => {
      const { orderId } = req.data;

      // Read order header
      const order = await SELECT.one.from(Orders).where({ ID: orderId });
      if (!order) return req.error(404, `Order ${orderId} not found`);

      // Read items separately (avoids CQL expand syntax issues)
      const items = await SELECT.from(OrderItems).where({ order_ID: orderId });

      // Recalculate every item
      let total = 0;
      for (const item of items) {
        const lineTotal =
          Math.round((item.quantity ?? 0) * (item.unitPrice ?? 0) * 100) / 100;
        total += lineTotal;
        await UPDATE(OrderItems, item.ID).with({ lineTotal });
      }

      total = Math.round(total * 100) / 100;
      await UPDATE(Orders, orderId).with({ totalAmount: total });

      // Return updated order with items as plain object
      const updated = await SELECT.one.from(Orders).where({ ID: orderId });
      updated.items = await SELECT.from(OrderItems).where({
        order_ID: orderId,
      });
      return updated;
    });

    await super.init();
  }
};

// ── Helpers ──────────────────────────────────────────────────────────────────

/**
 * Compute lineTotal for a single item payload.
 * Safe to call even if qty / price are undefined (edit only changes one field).
 */
function _calcLineTotal(item) {
  if (item.quantity != null && item.unitPrice != null) {
    item.lineTotal = item.quantity * item.unitPrice;
  }
}

/**
 * Compute lineTotals for all items of an order payload,
 * then sum them into order.totalAmount.
 */
function _calcTotals(order) {
  if (!Array.isArray(order.items)) return;

  let total = 0;
  for (const item of order.items) {
    _calcLineTotal(item);
    total += item.lineTotal ?? 0;
  }
  order.totalAmount = total;
}
