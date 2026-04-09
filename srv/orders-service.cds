// ─────────────────────────────────────────────
//  srv/orders-service.cds  –  Service Definition
// ─────────────────────────────────────────────
using { orders.db as db } from '../db/schema';

service OrdersService @(path: '/orders-api') {

  // Draft-enabled Orders
  @odata.draft.enabled

  // ── Full CRUD on Orders (incl. deep access to items) ──
  entity Orders      as projection on db.Orders;

  // ── Standalone CRUD on items (optional convenience) ──
  entity OrderItems  as projection on db.OrderItems;

  // ── Custom Action: recalculate totals for one order ──
  action recalculate(orderId: UUID) returns Orders;
}
