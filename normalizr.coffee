zen2han = (zen) ->
	han = zen.replace /[Ａ-Ｚａ-ｚ０-９！＂＃＄％＆＇（）＊＋，－．／：；＜＝＞？＠［＼］＾＿｀｛｜｝～]/g, (c) ->
		String.fromCharCode c.charCodeAt(0) - 0xFEE0
	han.split('　').join(' ')

filterNaN = (nan) ->
	nan.replace /\D/g, ''

convert = (str, condition) ->
	str = '' + str
	conditions = if condition instanceof Array then condition else [condition]

	for c in conditions
		switch c
			when 'zen2han'
				str = zen2han str

			when 'numeric'
				str = filterNaN str
	str

normalizr = (obj, opts) ->
	if typeof obj is 'string'
		convert obj, opts

	else
		result = {}

		for key, value of obj
			condition = if isString then opts else opts[key]

			if condition?
				result[key] = convert value, condition
					
			else
				result[key] = value
		result

###
export
###
(->
		if typeof self isnt 'undefined'
			return self
		if typeof window isnt 'undefined'
			return window
		if typeof global isnt 'undefined'
			return global
		null
	)()?.normalizr = normalizr
