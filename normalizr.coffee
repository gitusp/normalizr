###
全角 => 半角
###
zen2han = (zen) ->
	han = zen.replace /[Ａ-Ｚａ-ｚ０-９！＂＃＄％＆＇（）＊＋，－．／：；＜＝＞？＠［＼］＾＿｀｛｜｝～]/g, (c) ->
		String.fromCharCode c.charCodeAt(0) - 0xFEE0
	han.split('　').join(' ')

###
数字のみ
###
filterNaN = (nan) ->
	nan.replace /\D/g, ''

###
変換ハンドリング
###
convert = (str, condition) ->
	# キャスト
	str = '' + str
	conditions = if condition instanceof Array then condition else [condition]

	# フィルタ適用
	for c in conditions
		switch c
			when 'zen2han'
				str = zen2han str

			when 'numeric'
				str = filterNaN str

			# カスタムフィルタ
			else
				str = c str if typeof c is 'function'
	str

###
インターフェース
###
normalizr = (obj, opts) ->
	# 文字単体
	if typeof obj is 'string'
		convert obj, opts

	# オブジェクト
	else
		result = {}

		for key, value of obj
			condition = opts[key]

			if condition?
				result[key] = convert value, condition
					
			else
				result[key] = value
		result

	# TODO?: 配列

###
export
###
(->
		# 環境に応じたグローバルなオブジェクトをさがす
		if typeof self isnt 'undefined'
			return self
		if typeof window isnt 'undefined'
			return window
		if typeof global isnt 'undefined'
			return global
		null
	)()?.normalizr = normalizr
