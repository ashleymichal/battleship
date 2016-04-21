describe('Controller: CellController', function() {

  beforeEach(function(){
    module('battleship');
  });

  beforeEach(inject(function ($controller, $rootScope){
    scope = $rootScope.$new();
    controller = $controller('CellController', { $scope: scope });
  }));

  describe('scope#init', function() {
    beforeEach(function(){
      scope.init(1, 0, 'blank', 'path');
    });

    it("assigns x coordinate", function(){
      expect(scope.x).toBe(1);
    });

    it("assigns y coordinate", function(){
      expect(scope.y).toBe(0);
    });

    it("assigns status", function(){
      expect(scope.status).toBe('blank');
    });

    it("assigns path", function(){
      expect(scope.path).toBe('path');
    });
  });

  describe('scope#fire', function(){

    it("changes #status", inject(function($httpBackend){
      scope.init(1, 0, 'blank', 'path');

      $httpBackend
        .when('PATCH', 'path?x=1&y=0')
        .respond(200, { status: 'hit' });

      scope.fire();

      $httpBackend.flush();

      expect(scope.status).toBe('hit');
    }));

  });
});