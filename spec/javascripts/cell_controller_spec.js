describe('CellController', function() {

  beforeEach(inject(function (_GameService_, $q, $controller, $rootScope){
    GameService = _GameService_;
    scope = $rootScope.$new();
    controller = $controller('CellController', { $scope: scope });
    scope.init(1, 0, 'blank', 'path');
  }));

  describe('scope#init', function() {

    it("assigns x coordinate", function(){
      expect(scope.x).toBe(1);
    });

    it("assigns y coordinate", function(){
      expect(scope.y).toBe(0);
    });

    it("assigns status", function(){
      expect(scope.status).toBe('blank');
    });
  });

  describe('scope#fire', function() {

    describe('calling GameService', function(){
      beforeEach(function(){
        spyOn(GameService, 'fire').and.callThrough();
      });

      it("does not call GameService if $scope.status is not 'blank'", function(){
        scope.status = 'hit';
        scope.fire();
        expect(GameService.fire).not.toHaveBeenCalled();
      });

      it("calls GameService if $scope.status is 'blank'", function(){
        scope.fire();
        expect(GameService.fire).toHaveBeenCalled();
      });

    });

    describe('updating', function(){
      beforeEach(inject(function($q){
        deferred = $q.defer();
        spyOn(GameService, 'fire').and.returnValue(deferred.promise);
      }))

      it("updates $scope.status", function(){
        scope.fire();
        deferred.resolve('hit');
        scope.$apply();
        expect(scope.status).toBe('hit');
      })

    });

  })

});