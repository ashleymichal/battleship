angular.module('battleship')
.service('GameService', function($http) {
  return {
    set_game_id: function(id){
      this.game_id = id;
    },
    fire: function(x, y){
      return $http({
        method: 'PATCH',
        url: this.fire_path(),
        params: { x: x,
                  y: y }
      })
      .then(function(response) {
        return response.data.status;
      });
    },
    fire_path: function(){
      return this.game_id + "/fire.json";
    }
  }
});
