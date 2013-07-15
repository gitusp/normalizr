mocha.setup 'bdd'
assert = (expr, msg = 'failed') ->
	throw new Error msg unless expr

describe '文字単体', ->
	it 'zen2han', ->
		zen = '　ｇ　／'
		console.log normalizr zen, 'numeric'
		assert (normalizr(zen, 'zen2han')) is ' g /'

mocha.run()
