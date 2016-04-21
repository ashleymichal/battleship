angular.module('battleship')
.controller('CellController', function CellController ($scope, GameService){
    $scope.init = function(x, y, status, path){
      $scope.x = x;
      $scope.y = y;
      $scope.status = status;
      $scope.path = path;
    }
    $scope.fire = function(){
      GameService.fire($scope.x, $scope.y, $scope.path).success(function(response){
          $scope.status = response.status
      });
    }
  });

angular.module('battleship')
.service('GameService', function($http){
  return {
    "fire" : function(x, y, path){
      return $http({
        method: 'PATCH',
        url: path,
        params: {
          x: x,
          y: y
        }
      })
    }
  }
});