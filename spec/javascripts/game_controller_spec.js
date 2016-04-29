describe('GameController', function() {

  beforeEach(inject(function (_GameService_, $controller, $rootScope){
    GameService = _GameService_;
    scope = $rootScope.$new();
    controller = $controller('GameController', { $scope: scope });
  }));

  describe('scope#init', function() {
    it("sends the id to GameService", function(){
      spyOn(GameService, 'set_game_id');
      scope.init(1);
      expect(GameService.set_game_id).toHaveBeenCalledWith(1);
    });
  });
});
