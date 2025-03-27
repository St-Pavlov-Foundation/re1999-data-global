module("projbooter.lang.BootLangEnum", package.seeall)

slot0 = _M
slot0.Font = {
	b_hwzs = "bootres/fonts/b_hwzs.ttf",
	b_korea = "bootres/fonts/b_korea.ttf",
	b_japan = "bootres/fonts/b_japan.otf"
}
slot0.zh = 1
slot0.tw = 2
slot0.en = 4
slot0.ko = 8
slot0.jp = 16
slot0.de = 32
slot0.fr = 64
slot0.thai = 128
slot0.LangFont = {
	[slot0.zh] = slot0.Font.b_hwzs,
	[slot0.en] = slot0.Font.b_hwzs,
	[slot0.jp] = slot0.Font.b_japan,
	[slot0.ko] = slot0.Font.b_korea
}
slot0.SystemLanguageShortcut = {
	[UnityEngine.SystemLanguage.ChineseSimplified] = "zh",
	[UnityEngine.SystemLanguage.ChineseTraditional] = "tw",
	[UnityEngine.SystemLanguage.English] = "en",
	[UnityEngine.SystemLanguage.Korean] = "kr",
	[UnityEngine.SystemLanguage.Japanese] = "jp"
}

return slot0
