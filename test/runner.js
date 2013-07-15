// Generated by CoffeeScript 1.6.2
(function() {
  var assert;

  mocha.setup('bdd');

  assert = function(expr, msg) {
    if (msg == null) {
      msg = 'failed';
    }
    if (!expr) {
      throw new Error(msg);
    }
  };

  describe('文字単体', function() {
    it('zen2han', function() {
      var zen;

      zen = '　ｇ　／';
      return assert((normalizr(zen, 'zen2han')) === ' g /');
    });
    it('numeric', function() {
      var zen;

      zen = '　ｇ11３４　／';
      return assert((normalizr(zen, 'numeric')) === '11');
    });
    it('numeric_graceful(custom)', function() {
      var ng, zen;

      ng = function(str) {
        return (normalizr(str, 'numeric')) || str;
      };
      zen = '　ｇ　／';
      return assert((normalizr(zen, ng)) === '　ｇ　／');
    });
    return it('zen2han => numeric', function() {
      var zen;

      zen = '　ｇ11３４　／';
      return assert((normalizr(zen, ['zen2han', 'numeric'])) === '1134');
    });
  });

  describe('オブジェクト', function() {
    it('zen2han', function() {
      var obj, result;

      obj = {
        zen1: '　ｇ　／',
        zen2: '？！'
      };
      result = normalizr(obj, {
        zen1: 'zen2han'
      });
      assert(result.zen1 === ' g /');
      return assert(result.zen2 === '？！');
    });
    return it('なんか複雑そうな条件', function() {
      var obj, result;

      obj = {
        zen1: '　ｇ　／',
        zen2: '？！12',
        zen3: '３５',
        zen4: '３５'
      };
      result = normalizr(obj, {
        zen1: 'numeric',
        zen2: 'zen2han',
        zen3: ['zen2han', 'numeric'],
        zen4: ['numeric', 'zen2han']
      });
      assert(result.zen1 === '');
      assert(result.zen2 === '?!12');
      assert(result.zen3 === '35');
      return assert(result.zen4 === '');
    });
  });

  mocha.run();

}).call(this);
