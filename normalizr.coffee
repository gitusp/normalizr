zen2han = (zen = '') ->
	han = zen.replace /[Ａ-Ｚａ-ｚ０-９！＂＃＄％＆＇（）＊＋，－．／：；＜＝＞？＠［＼］＾＿｀｛｜｝～]/g, (c) ->
		String.fromCharCode c.charCodeAt(0) - 0xFEE0
	han.split('　').join(' ')

filterNaN = (nan) ->
	nan.replace /\D/g, ''

normalizr = (obj, opts) ->
	result = {}
	for key, value of obj
		condition = opts[key]

		if condition?
			conditions = if condition instanceof Array then condition else [condition]

			for c in conditions
				switch c
					when 'zen2han'
						value = zen2han value

					when 'numeric'
						value = filterNaN value
			result[key] = value
				
		else
			result[key] = value

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
