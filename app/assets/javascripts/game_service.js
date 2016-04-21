angular.module('battleship')
.factory('GameService', function($http){
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