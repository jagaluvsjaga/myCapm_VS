sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'mycapapp/managepurchaseorder/test/integration/FirstJourney',
		'mycapapp/managepurchaseorder/test/integration/pages/POsList',
		'mycapapp/managepurchaseorder/test/integration/pages/POsObjectPage',
		'mycapapp/managepurchaseorder/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('mycapapp/managepurchaseorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);