angular.module('battleship')
.controller('CellController', function CellController ($scope, GameService){
  $scope.init = function(x, y, status){
    $scope.x = x;
    $scope.y = y;
    $scope.status = status;
  }
  $scope.fire = function(){
    if($scope.status == 'blank'){
      GameService.fire($scope.x, $scope.y).then(function(status){
        $scope.status = status;
      });
    };
  }
});
