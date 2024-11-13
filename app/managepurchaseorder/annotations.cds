using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(

    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        CURRENCY_code,
        GROSS_AMOUNT,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],


    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Inline: true,
            Label : 'boost',
            Action: 'service.boost',
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverllStatus,
            Criticality: IconColor
        },
    ],


    UI.HeaderInfo           : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/1200px-IBM_logo.svg.png'
    },


    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'idParent',
            Label : 'More Information',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target: '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing',
                    Target: '@UI.FieldGroup#Spiderman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target: '@UI.FieldGroup#Superman',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Items',
            Target: 'Items/@UI.LineItem',
        },
    ],
    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
        },


    ],
    UI.FieldGroup #Spiderman: {
        Label: 'Pricing',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #Superman : {
        Label: 'Status',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
            {
                $Type: 'UI.DataField',
                Value: LIFECYCLE_STATUS,
            },
        ],
    }
);

annotate service.PurchaseOrderItems with @(

    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ],
    UI.HeaderInfo    : {
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Item Details',
        Target: '@UI.Identification',
    }, ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        }
    ]
);

annotate service.POs with {
    PARTNER_GUID @(
        Common          : {Text: PARTNER_GUID.COMPANY_NAME, },
        ValueList.entity: service.BusinessPartnerSet
    )
};

annotate service.PurchaseOrderItems with {
    PRODUCT_GUID @(
        Common          : {Text: PRODUCT_GUID.DESCRIPTION, },
        ValueList.entity: service.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: COMPANY_NAME
}]);

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION
}]);
