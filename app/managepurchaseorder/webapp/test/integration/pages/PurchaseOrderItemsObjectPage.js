sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'mycapapp.managepurchaseorder',
            componentId: 'PurchaseOrderItemsObjectPage',
            contextPath: '/POs/Items'
        },
        CustomPageDefinitions
    );
});