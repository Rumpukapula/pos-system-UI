'use strict';

/* App Module */
var posApp = angular.module('posApp', [
   'ngRoute',
   'ui.bootstrap',
   'posControllers'
]);

posApp.config(['$routeProvider',
   function($routeProvider) {
		$routeProvider
			.when('/', {
				templateUrl: 'views/pos.jsp',
				controller: 'PosMainController'
			})
			.otherwise({
				redirectTo: '/'
			});
}]);