using OrdersService as S from '../../srv/orders-service';

// ─────────────────────────────────────────────────────────────
//  Fiori Elements Annotations
// ─────────────────────────────────────────────────────────────

// ── Orders List Page ─────────────────────────────────────────
annotate S.Orders with @(
  UI.SelectionFields: [ orderNumber, customer, status_code ],
  UI.LineItem: [
    { Value: orderNumber,   Label: 'Order #'   },
    { Value: customer,      Label: 'Customer'  },
    { Value: status_code,   Label: 'Status'    },
    { Value: totalAmount,   Label: 'Total'     },
    { Value: createdAt,     Label: 'Created'   }
  ],
  UI.HeaderInfo: {
    TypeName:       'Order',
    TypeNamePlural: 'Orders',
    Title:          { Value: orderNumber },
    Description:    { Value: customer }
  }
);

// ── Orders Object Page (Header Facets) ───────────────────────
annotate S.Orders with @(
  UI.Facets: [
    {
      $Type:  'UI.ReferenceFacet',
      ID:     'GeneralInfo',
      Label:  'General Information',
      Target: '@UI.FieldGroup#GeneralInfo'
    },
    {
      $Type:  'UI.ReferenceFacet',
      ID:     'Items',
      Label:  'Order Items',
      Target: 'items/@UI.LineItem'
    }
  ],
  UI.FieldGroup#GeneralInfo: {
    Data: [
      { Value: orderNumber  },
      { Value: customer     },
      { Value: status_code  },
      { Value: totalAmount  },
      { Value: note         },
      { Value: createdAt    },
      { Value: modifiedAt   }
    ]
  }
);

// ── Field-level annotations (Order) ──────────────────────────
annotate S.Orders with {
  orderNumber @(
    Common.FieldControl: #Mandatory,
    UI.HiddenFilter: false
  );
  customer @(
    Common.FieldControl: #Mandatory
  );
  status @(
    Common.Text: status.name,
    Common.TextArrangement: #TextOnly,
    Common.ValueListWithFixedValues: true,
    Common.ValueList: {
      CollectionPath: 'OrderStatus',
      Parameters: [
        { $Type: 'Common.ValueListParameterOut', LocalDataProperty: status_code, ValueListProperty: 'code' },
        { $Type: 'Common.ValueListParameterDisplayOnly',                          ValueListProperty: 'name' }
      ]
    }
  );
  totalAmount @(
    Measures.ISOCurrency: 'CHF'
  );
}

// ── OrderItems List (inside Object Page) ─────────────────────
annotate S.OrderItems with @(
  UI.LineItem: [
    { Value: product,   Label: 'Product'    },
    { Value: quantity,  Label: 'Qty'        },
    { Value: unitPrice, Label: 'Unit Price' },
    { Value: lineTotal, Label: 'Line Total' }
  ],
  UI.FieldGroup#ItemDetails: {
    Data: [
      { Value: product   },
      { Value: quantity  },
      { Value: unitPrice },
      { Value: lineTotal }
    ]
  },
  UI.Facets: [
    {
      $Type:  'UI.ReferenceFacet',
      Label:  'Item Details',
      Target: '@UI.FieldGroup#ItemDetails'
    }
  ]
);

annotate S.OrderItems with {
  product   @Common.FieldControl: #Mandatory;
  quantity  @Common.FieldControl: #Mandatory;
  unitPrice @Common.FieldControl: #Mandatory;
  lineTotal @UI.HiddenFilter: true;
}