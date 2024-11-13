using {jagga.db} from '../db/datamodel';
using {cappo.cds} from '../db/CDSViews';

// service CatalogService @(path:'CatalogService') {
//     entity EmployeeSet as projection on master.employees;
// }

extend db.transaction.purchaseorder with {
    virtual PRIORITY : String(10);
};

service CatalogService @(path: 'CatalogService') {

    @Capabilities: {
        Insertable,
        Deletable: false
    }
    entity BusinessPartnerSet               as projection on db.master.businesspartner;

    entity AddressSet                       as projection on db.master.address;
    //@readonly
    entity EmployeeSet                      as projection on db.master.employees;
    entity PurchaseOrderItems               as projection on db.transaction.poitems;

    entity POs @(odata.draft.enabled: true) as
        projection on db.transaction.purchaseorder {
            *,
            case OVERALL_STATUS
                when
                    'P'
                then
                    'Paid'
                when
                    'A'
                then
                    'Approved'
                when
                    'N'
                then
                    'New'
                when
                    'X'
                then
                    'Rejected'
            end as OverllStatus : String(10),
            case OVERALL_STATUS
                when
                    'P'
                then
                    3
                when
                    'A'
                then
                    3
                when
                    'N'
                then
                    2
                when
                    'X'
                then
                    1
            end as IconColor    : Integer,
            // round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
            Items               : redirected to PurchaseOrderItems
        }
        actions {
            action boost() returns POs
        };

    function largestOrder() returns POs;

    entity ProductSet                       as
        projection on db.master.product {
            *,
        };

    //entity CProductValuesView               as projection on cds.CDSViews.CProductValuesView;
}
