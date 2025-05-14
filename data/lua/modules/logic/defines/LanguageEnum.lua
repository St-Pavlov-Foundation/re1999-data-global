module("modules.logic.defines.LanguageEnum", package.seeall)

local var_0_0 = _M

var_0_0.LanguageStoryType = {
	KR = 4,
	DE = 6,
	JP = 5,
	TW = 2,
	THAI = 8,
	CN = 1,
	FR = 7,
	EN = 3
}
var_0_0.LanguageStoryType2Key = {
	"cn",
	"tw",
	"en",
	"kr",
	"jp",
	"de",
	"fr",
	"thai"
}
var_0_0.Lang2KeyEFun = {
	jp = "ja-JP",
	kr = "ko-KR",
	zh = "zh-CN",
	tw = "zh-TW",
	thai = "th-TH",
	en = "en-US"
}
var_0_0.Lang2KeyGlobal = {
	jp = "ja_JP",
	kr = "ko_KR",
	zh = "zh_CN",
	tw = "zh_TW",
	thai = "thai",
	en = "en"
}

return var_0_0
