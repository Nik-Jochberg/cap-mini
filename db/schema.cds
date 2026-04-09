// ─────────────────────────────────────────────
//  db/schema.cds  –  Data Model
// ─────────────────────────────────────────────
namespace orders.db;

using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

// ── Status Code List (Value Help) ─────────────────────────────
entity OrderStatus : CodeList {
  key code : String(20);
}

// ── Orders (Parent) ──────────────────────────
entity Orders : cuid, managed {
  orderNumber : String(20)  not null;
  customer    : String(100) not null;
  status      : Association to OrderStatus default 'New';
  totalAmount : Decimal(15,2);               // computed / stored

  // Composition: Orders OWNs OrderItems
  items       : Composition of many OrderItems on items.order = $self;
}

// ── OrderItems (Child) ───────────────────────
entity OrderItems : cuid {
  order       : Association to Orders;       // back-link (managed by CAP)
  product     : String(100) not null;
  quantity    : Integer     not null  default 1 @assert.range: [1, 100];
  unitPrice   : Decimal(15,2) not null;
  lineTotal   : Decimal(15,2);               // quantity * unitPrice (set in handler)
}
