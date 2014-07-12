<div class="col-xs-12">
	<div id="control" class="col-lg-7">
		<h1>Valintapaneeli</h1>
		<accordion close-others="false">
			<accordion-group heading="Ateriat" is-open="status1">
				<table class="table">
					<thead>
						<tr>
							<th>Tilausnimike</th>
							<th>Lisuke</th>
							<th>Juoma</th>
							<th>Onko Plus?</th>
							<th>M‰‰r‰</th>
							<th>Hinta</th>
							<th>Lis‰‰ tilaukseen</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="meal in meals">
							<td>{{meal.name}}</td>
							
							<!-- Vaihda t‰m‰ templateksi!? -->
							<td>
								<select ng-model="sideselect">
									<option ng-repeat="side in sides">{{side.name}}</option>
								</select>
							</td>
							
							<!-- Vaihda t‰m‰ templateksi!? -->
							<td>
								<select ng-model="drinkselect">
									<option ng-repeat="drink in drinks">{{drink.name}}</option>
								</select>
							</td>
							
							<td><input ng-model="isplus" type="checkbox"></td>
							<td><input ng-model="quantity" type="number" min="1"></td>
							<td>{{(isplus) && (meal.price+plusprice)*quantity || meal.price*quantity | number : 2}}</td>
							<td>
								<button ng-click="addMealToOrder(meal.name,meal.price,sideselect,drinkselect,isplus,quantity)" class="btn btn-primary">Lis‰‰</button>
							</td>
						</tr>
					</tbody>
				</table>				
			</accordion-group>
			
			<accordion-group heading="Hampurilaiset" is-open="status2">
				<table class="table">
					<thead>
						<tr>
							<th>Tilausnimike</th>
							<th>M‰‰r‰</th>
							<th>Hinta</th>
							<th>Lis‰‰ tilaukseen</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="burger in burgers">
							<td>{{burger.name}}</td>
							
							<td><input ng-model="quantity" type="number" min="1"></td>
							<td>{{burger.price*quantity | number : 2}}</td>
							<td>
								<button ng-click="addItemToOrder(burger.name,burger.price,quantity)" class="btn btn-primary">Lis‰‰</button>
							</td>
						</tr>
					</tbody>
				</table>
			</accordion-group>
			
			<accordion-group heading="Lisukkeet" is-open="status3">
				<table class="table">
					<thead>
						<tr>
							<th>Tilausnimike</th>
							<th>Koko</th>
							<th>M‰‰r‰</th>
							<th>Hinta</th>
							<th>Lis‰‰ tilaukseen</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-if="side.id=='fries'" ng-repeat="side in sides">
							<td>{{side.name}}</td>
							<td>
								<select ng-model="friesselect">
									<option ng-if="side.id=='fries'" ng-repeat="frie in fries">{{frie.name}}</option>
								</select>
							</td>
							<td><input ng-model="quantity" type="number" min="1"></td>
							<td>{{(friesselect==fries[0].name) && fries[0].price*quantity || (friesselect==fries[1].name) && fries[1].price*quantity || fries[2].price*quantity | number : 2}}</td>
							<td>
								<button ng-click="addItemToOrder(side.name,friesselect,quantity)" class="btn btn-primary">Lis‰‰</button>	
							</td>
						</tr>
						<tr ng-if="side.id!='fries'" ng-repeat="side in sides">
							<td>{{side.name}}</td>
							<td>normaali</td>
							<td><input ng-model="quantity" type="number" min="1"></td>
							<td>{{side.price*quantity | number : 2}}</td>
							<td>
								<button ng-click="addItemToOrder(side.name,side.price,quantity)" class="btn btn-primary">Lis‰‰</button>	
							</td>
						</tr>
					</tbody>
				</table>
			</accordion-group>
			
			<accordion-group heading="Juomat" is-open="status4">
				<table class="table">
					<thead>
						<tr>
							<th>Tilausnimike</th>
							<th>Koko</th>
							<th>M‰‰r‰</th>
							<th>Hinta</th>
							<th>Lis‰‰ tilaukseen</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="drink in drinks">
							<td>{{drink.name}}</td>
							<td>
								<select ng-model="drinksizeselect">
									<option ng-repeat="drinksi in drinksize">{{drinksi.name}}</option>
								</select>
							</td>
							<td><input ng-model="quantity" type="number" min="1"></td>
							<td>{{(drinksizeselect==drinksize[0].name) && drinksize[0].price*quantity || (drinksizeselect==drinksize[1].name) && drinksize[1].price*quantity || drinksize[2].price*quantity | number : 2}}</td>
							<td>
								<button ng-click="addItemToOrder(drink.name,drinksizeselect,quantity)" class="btn btn-primary">Lis‰‰</button>
							</td>
						</tr>
					</tbody>
				</table>
			</accordion-group>
			
			
		</accordion>
	</div>
	<div id="order" class="col-lg-5">
		<h1>Nykyinen tilaus</h1>
		<table class="table">
			<thead>
				<tr>
					<th>Tilausnimike</th>
					<th>Info</th>
					<th>M‰‰r‰</th>
					<th>Hinta</th>
					<th>Poista</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-if="getTotal()>0" class="info">
					<td>Yhteens‰</td>
					<td></td>
					<td></td>
					<td>{{getTotal() | number : 2}}</td>
					<td></td>
				</tr>
				<tr ng-repeat="item in order">
					<td>{{item.name}}<span ng-if="item.type=='meal' && item.plus"> (plus)</span></td>
					<td>
						<span ng-if="item.type=='meal'">{{item.side}} + {{item.drink}}</span>
						<span ng-if="item.type=='fries'">{{item.friessize}}</span>
						<span ng-if="item.type=='drinks'">{{item.drinksize}}</span>
					</td>
					<td>{{item.quantity}}</td>
					<td>{{item.totalprice | number : 2}}</td>
					<td><button ng-click="removeItemFromOrder(item.id)" class="btn btn-default">Poista</button></td>
				</tr>
				<tr ng-if="getTotal()>0" class="info">
					<td>Yhteens‰</td>
					<td></td>
					<td></td>
					<td>{{getTotal() | number : 2}}</td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<button ng-if="getTotal()>0" ng-click="completeOrder()" class="btn btn-primary pull-right">Vahvista tilaus</button>
	</div>
</div>