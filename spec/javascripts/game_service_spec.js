describe("GameService", function () {

  describe("#fire", function() {

    beforeEach(inject(function (_GameService_, $httpBackend) {
      GameService = _GameService_;
      httpBackend = $httpBackend;
    }));

    it("sends a valid request", function () {
      httpBackend.when("PATCH", "1/fire.json?x=1&y=0").respond({
        status: 'hit'
      });
      GameService.set_game_id(1);
      GameService.fire(1, 0).then(function(status){
        expect(status).toBe('hit');
      })
      httpBackend.flush();
    });

  });
});
