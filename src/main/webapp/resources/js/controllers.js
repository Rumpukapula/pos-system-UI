'use strict';

var posControllers = angular.module('posControllers', []);

posControllers.controller('PosMainController', ['$scope','$http',
    function($scope,$http) {
		$scope.order = [];
		$scope.newid = 0;
		
		function getNewItemId() {
			var id = $scope.newid;
			$scope.newid = $scope.newid+1;
			return id;
		};
		
		$scope.addItemToOrder = function(name,price,quantity) {
			if(name=="Ranskalaiset") {
				var id = getNewItemId();
				var totalprice = quantity;
				if(price=="pieni") {
					totalprice = totalprice*$scope.fries[0].price;
				} else if(price=="keskikoko") {
					totalprice = totalprice*$scope.fries[1].price;
				} else {
					totalprice = totalprice*$scope.fries[2].price;
				}
				var item = {
					'id': id,
					'type':'fries',
					'name':name,
					'friessize':price,
					'totalprice':totalprice,
					'quantity':quantity
				};
				$scope.order.push(item);
				
			} else if(price=="pieni" || price=="keskikoko" || price=="iso") {
				// this means the drinks
				var id = getNewItemId();
				var totalprice = quantity;
				if(price=="pieni") {
					totalprice = totalprice*$scope.drinksize[0].price;
				} else if(price=="keskikoko") {
					totalprice = totalprice*$scope.drinksize[1].price;
				} else {
					totalprice = totalprice*$scope.drinksize[2].price;
				}
				var item = {
					'id': id,
					'type':'drinks',
					'name':name,
					'drinksize':price,
					'totalprice':totalprice,
					'quantity':quantity
				};
				$scope.order.push(item);
				
			} else {
				var id = getNewItemId();
				var totalprice = price*quantity;
				var item = {
					'id': id,
					'type':'other',
					'name':name,
					'totalprice':totalprice,
					'quantity':quantity
				};
				$scope.order.push(item);
			}
		};
		
		$scope.addMealToOrder = function(name,price,side,drink,isPlus,quantity) {
			var id = getNewItemId();
			var totalprice = 0;
			if(isPlus) {
				totalprice = (price+$scope.plusprice)*quantity;
			} else {
				totalprice = price*quantity;
			}
			
			var item = {
				'id': id,
				'type':'meal',
				'name':name,
				'totalprice':totalprice,
				'side':side,
				'drink':drink,
				'plus':isPlus,
				'quantity':quantity
			};
			$scope.order.push(item);
		};
		
		$scope.removeItemFromOrder = function(itemId) {
			for(var i = 0; i < $scope.order.length; i++) {
				if(itemId==$scope.order[i].id) {
					$scope.order.splice(i,1);
					break;
				}
			}
		};
		
		$scope.getTotal = function() {
			var total = 0;
			for(var i = 0; i < $scope.order.length; i++) {
				total = total + $scope.order[i].totalprice;
			}
			return total;
		};
	
		$scope.quantity = 1;
		
		$scope.completeOrder = function() {
			while($scope.order.length > 0) {
			    $scope.order.pop();
			}
		};
	
		$http.get('resources/json/restaurant-menu.json')
		.then(function(res){
			$scope.meals = res.data.meals;
			$scope.burgers = res.data.burgers;
			
			$scope.sides = res.data.sides;
			$scope.fries = res.data.friessize;
			$scope.drinksize = res.data.drinksize;
			$scope.drinks = res.data.drinks;
			
			$scope.friesselect = res.data.friessize[1].name;
			$scope.sideselect = res.data.sides[0].name;
			$scope.drinkselect = res.data.drinks[0].name;
			$scope.drinksizeselect = res.data.drinksize[1].name;
			$scope.plusprice = res.data.special.plus.price;
		});
}]);