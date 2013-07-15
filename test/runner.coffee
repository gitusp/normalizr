mocha.setup 'bdd'
assert = (expr, msg = 'failed') ->
	throw new Error msg unless expr

describe '文字単体', ->
	it 'zen2han', ->
		zen = '　ｇ　／'
		assert (normalizr(zen, 'zen2han')) is ' g /'

	it 'numeric', ->
		zen = '　ｇ11３４　／'
		assert (normalizr(zen, 'numeric')) is '11'

	it 'zen2han => numeric', ->
		zen = '　ｇ11３４　／'
		assert (normalizr(zen, ['zen2han', 'numeric'])) is '1134'

describe 'オブジェクト', ->
	it 'zen2han', ->
		obj = 
			zen1: '　ｇ　／'
			zen2: '？！'
		result = normalizr obj, zen1: 'zen2han'
		assert result.zen1 is ' g /'
		assert result.zen2 is '？！'

	it 'なんか複雑そうな条件', ->
		obj = 
			zen1: '　ｇ　／'
			zen2: '？！12'
			zen3: '３５'
			zen4: '３５'

		result = normalizr obj,
			zen1: 'numeric'
			zen2: 'zen2han'
			zen3: ['zen2han', 'numeric']
			zen4: ['numeric', 'zen2han']

		assert result.zen1 is ''
		assert result.zen2 is '?!12'
		assert result.zen3 is '35'
		assert result.zen4 is ''

mocha.run()
