sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"bits/cap/order/capmini/test/integration/pages/OrdersList",
	"bits/cap/order/capmini/test/integration/pages/OrdersObjectPage",
	"bits/cap/order/capmini/test/integration/pages/OrderItemsObjectPage"
], function (JourneyRunner, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('bits/cap/order/capmini') + '/test/flp.html#app-preview',
        pages: {
			onTheOrdersList: OrdersList,
			onTheOrdersObjectPage: OrdersObjectPage,
			onTheOrderItemsObjectPage: OrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

