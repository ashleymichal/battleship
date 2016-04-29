angular.module('battleship')
.controller('GameController', function GameController($scope, GameService){
  $scope.init = function(id){
    GameService.set_game_id(id);
  }
});