(function() {
  describe('General', function() {
    var Straxel;

    Straxel = require('straxel');
    return it('should be able to detect API failure', function(done) {
      var pkg;

      pkg = {
        id: 'd803e6ec-130b-403f-8f87-0ab41950e21e'
      };
      return Straxel.User.get(pkg, function(res) {
        console.log("detect API failure res", res);
        expect(res).to.be.an(Object);
        expect(res.body).to.be.an(Object);
        expect(res.body.error).to.be.an(Object);
        expect(res.body.error.status).to.be.a('string');
        expect(res.body.error.type).to.be.a('string');
        expect(res.body.error.type).to.equal('unreachable');
        return done();
      });
    });
  });

}).call(this);
