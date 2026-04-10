using OrdersService as S from '../../srv/orders-service';

// ─────────────────────────────────────────────────────────────
//  Fiori Elements Annotations
// ─────────────────────────────────────────────────────────────

// ── Orders List Page ─────────────────────────────────────────
annotate S.Orders with @(
  UI.SelectionFields: [ orderNumber, customer, status_code ],
  UI.LineItem: [
    { Value: orderNumber,   Label: '{i18n>orderNumber}'   },
    { Value: customer,      Label: '{i18n>customer}'      },
    { Value: status_code,   Label: '{i18n>status}'        },
    { Value: totalAmount,   Label: '{i18n>totalAmount}'   },
    { Value: createdAt,     Label: '{i18n>createdAt}'     }
  ],
  UI.HeaderInfo: {
    TypeName:       '{i18n>Order}',
    TypeNamePlural: '{i18n>Orders}',
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
      Label:  '{i18n>GeneralInfo}',
      Target: '@UI.FieldGroup#GeneralInfo'
    },
    {
      $Type:  'UI.ReferenceFacet',
      ID:     'Items',
      Label:  '{i18n>ItemsFacet}',
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
      { Value: createdAt,   Label: '{i18n>createdAt}'   },
      { Value: modifiedAt,  Label: '{i18n>modifiedAt}'  }
    ]
  }
);

// ── Field-level annotations (Order) ──────────────────────────
annotate S.Orders with {
  orderNumber @(
    Common.FieldControl: #Mandatory,
    Common.Label: '{i18n>orderNumber}',
    UI.HiddenFilter: false
  );
  customer @(
    Common.FieldControl: #Mandatory,
    Common.Label: '{i18n>customer}'
  );
  status @(
    Common.Label: '{i18n>status_code}'
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
    { Value: product,   Label: '{i18n>product}'    },
    { Value: quantity,  Label: '{i18n>quantity}'    },
    { Value: unitPrice, Label: '{i18n>unitPrice}'   },
    { Value: lineTotal, Label: '{i18n>lineTotal}'   }
  ],
  UI.FieldGroup#ItemDetails: {
    Data: [
      { Value: product,   Label: '{i18n>product}'    },
      { Value: quantity,  Label: '{i18n>quantity}'    },
      { Value: unitPrice, Label: '{i18n>unitPrice}'   },
      { Value: lineTotal, Label: '{i18n>lineTotal}'   }
    ]
  },
  UI.Facets: [
    {
      $Type:  'UI.ReferenceFacet',
      Label:  '{i18n>ItemDetails}',
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