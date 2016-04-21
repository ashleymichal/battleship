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