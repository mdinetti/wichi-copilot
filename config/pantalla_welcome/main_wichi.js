angular.module('personalizacionWichi', ['personalizacionWichi.controller']);
		//nombre del modulo     // nombre de nuestro controller

angular.module('personalizacionWichi.controller', [])
.controller('wichiController', function($scope, $http) {

	$scope.imagenesSIU = ['img/wichi/SIU-Guarani.png',
					'img/wichi/SIU-Mapuche.png',
					'img/wichi/SIU-Pilaga.png',
					'img/wichi/SIU-Araucano.png',	
					'img/wichi/SIU-Querandies.png',									
					'img/wichi/RHUN-SPU.png',
					'img/wichi/SIU-Diaguita.png',
					'img/wichi/SIU-Kolla.png',
					'img/wichi/SIU-Guarani3.png',
					'img/wichi/SIU-Preinscripciones.png',	
					'img/wichi/SIU-Sanavirón.png',									
					'img/wichi/Sudocu.png',
					'img/wichi/Moodle.png'
					];
 

	$http.get("http://localhost:8080/pentaho/plugin/cda/api/doQuery?path=/welcome_page/fecha_actualizacion.cda&dataAccessId=fecha_actualizacion")
	.then(function (data) {
		$scope.actualizaciones2 = data;
		var fila = 1;
		angular.forEach($scope.actualizaciones2.data, function(result) {
			if (fila ==2){
				$scope.actualizaciones=result;
				fila=fila+1;
				}
			else{fila=fila+1;}

		})
	})	
})
