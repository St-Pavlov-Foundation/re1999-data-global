module("projbooter.lang.BootLangEnum", package.seeall)

local var_0_0 = _M

var_0_0.Font = {
	b_hwzs = "bootres/fonts/b_hwzs.ttf",
	b_korea = "bootres/fonts/b_korea.ttf",
	b_japan = "bootres/fonts/b_japan.otf"
}
var_0_0.zh = 1
var_0_0.tw = 2
var_0_0.en = 4
var_0_0.ko = 8
var_0_0.jp = 16
var_0_0.de = 32
var_0_0.fr = 64
var_0_0.thai = 128
var_0_0.LangFont = {
	[var_0_0.zh] = var_0_0.Font.b_hwzs,
	[var_0_0.en] = var_0_0.Font.b_hwzs,
	[var_0_0.jp] = var_0_0.Font.b_japan,
	[var_0_0.ko] = var_0_0.Font.b_korea
}
var_0_0.SystemLanguageShortcut = {
	[UnityEngine.SystemLanguage.ChineseSimplified] = "zh",
	[UnityEngine.SystemLanguage.ChineseTraditional] = "tw",
	[UnityEngine.SystemLanguage.English] = "en",
	[UnityEngine.SystemLanguage.Korean] = "kr",
	[UnityEngine.SystemLanguage.Japanese] = "jp"
}

return var_0_0
