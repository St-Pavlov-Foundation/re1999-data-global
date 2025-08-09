module("modules.logic.language.LangSettings", package.seeall)

local var_0_0 = class("LangSettings", BaseConfig)

var_0_0.zh = 1
var_0_0.tw = 2
var_0_0.en = 4
var_0_0.kr = 8
var_0_0.jp = 16
var_0_0.de = 32
var_0_0.fr = 64
var_0_0.thai = 128
var_0_0.shortcutTab = {
	[var_0_0.zh] = "zh",
	[var_0_0.tw] = "tw",
	[var_0_0.en] = "en",
	[var_0_0.kr] = "kr",
	[var_0_0.jp] = "jp",
	[var_0_0.de] = "de",
	[var_0_0.fr] = "fr",
	[var_0_0.thai] = "thai"
}
var_0_0.shortCut2LangIdxTab = {
	zh = var_0_0.zh,
	tw = var_0_0.tw,
	en = var_0_0.en,
	kr = var_0_0.kr,
	jp = var_0_0.jp,
	de = var_0_0.de,
	fr = var_0_0.fr,
	thai = var_0_0.thai
}
var_0_0.aihelpKey = {
	[var_0_0.zh] = "zh-CN",
	[var_0_0.tw] = "zh-TW",
	[var_0_0.en] = "en",
	[var_0_0.kr] = "ko",
	[var_0_0.jp] = "ja",
	[var_0_0.de] = "de",
	[var_0_0.fr] = "fr",
	[var_0_0.thai] = "th"
}
var_0_0._captionsSetting = {
	[var_0_0.zh] = true,
	[var_0_0.tw] = true,
	[var_0_0.en] = false,
	[var_0_0.kr] = false,
	[var_0_0.jp] = false
}
var_0_0.pcWindowsTitle = {
	[var_0_0.zh] = "重返未来：1999",
	[var_0_0.tw] = "重返未來：1999",
	[var_0_0.en] = "Reverse: 1999",
	[var_0_0.kr] = "리버스: 1999",
	[var_0_0.jp] = "リバース：1999",
	[var_0_0.de] = "reverse:1999",
	[var_0_0.fr] = "reverse:1999",
	[var_0_0.thai] = "reverse:1999"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._curLang = GameConfig:GetCurLangType()
	arg_1_0._defaultLang = GameConfig:GetDefaultLangType()
	arg_1_0._curLangShortcut = var_0_0.shortcutTab[arg_1_0._curLang]
	arg_1_0._captionsActive = var_0_0._captionsSetting[arg_1_0._curLang] ~= false
	arg_1_0._supportedLangs = {}

	local var_1_0 = GameConfig:GetSupportedLangs()
	local var_1_1 = var_1_0.Length

	for iter_1_0 = 0, var_1_1 - 1 do
		arg_1_0._supportedLangs[var_1_0[iter_1_0]] = true
	end

	local var_1_2 = var_0_0.aihelpKey[arg_1_0._curLang]

	if var_1_2 then
		SDKMgr.instance:setLanguage(var_1_2)
	else
		logError("aihelpKey miss :" .. arg_1_0._curLang)
	end

	local var_1_3
end

function var_0_0.loadLangConfig(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._onLoadedCallback = arg_2_1
	arg_2_0._onLoadedCallbackObj = arg_2_2

	if GameResMgr.IsFromEditorDir then
		local var_2_0 = "configs/language/json_language_" .. arg_2_0._curLangShortcut .. ".json"

		loadNonAbAsset(var_2_0, SLFramework.AssetType.TEXT, arg_2_0._onConfigAbCallback, arg_2_0)

		local var_2_1 = "configs/language/json_language_server_" .. arg_2_0._curLangShortcut .. ".json"

		loadNonAbAsset(var_2_1, SLFramework.AssetType.TEXT, arg_2_0._onServerConfigAbCallback, arg_2_0)
	else
		local var_2_2 = "configs/language/json_language_" .. arg_2_0._curLangShortcut .. ".json.dat"

		loadNonAbAsset(var_2_2, SLFramework.AssetType.DATA, arg_2_0._onConfigAbCallback, arg_2_0)

		local var_2_3 = "configs/language/json_language_server_" .. arg_2_0._curLangShortcut .. ".json.dat"

		loadNonAbAsset(var_2_3, SLFramework.AssetType.DATA, arg_2_0._onServerConfigAbCallback, arg_2_0)
	end
end

function var_0_0._onServerConfigAbCallback(arg_3_0, arg_3_1)
	local var_3_0

	if GameResMgr.IsFromEditorDir then
		var_3_0 = arg_3_1.TextAsset
	else
		var_3_0 = arg_3_1:GetNonAbTextAsset(true)
	end

	local var_3_1 = cjson.decode(var_3_0)
	local var_3_2 = var_3_1[1]
	local var_3_3 = var_3_1[2]

	LangConfig.instance:updateServerLanguage(var_3_3)
end

function var_0_0._onConfigAbCallback(arg_4_0, arg_4_1)
	local var_4_0

	if GameResMgr.IsFromEditorDir then
		var_4_0 = arg_4_1.TextAsset
	else
		var_4_0 = arg_4_1:GetNonAbTextAsset(true)
	end

	local var_4_1 = cjson.decode(var_4_0)
	local var_4_2 = var_4_1[1]
	local var_4_3 = var_4_1[2]

	LangConfig.instance:updateLanguage(var_4_3)

	if arg_4_0._onLoadedCallback then
		if arg_4_0._onLoadedCallbackObj then
			arg_4_0._onLoadedCallback(arg_4_0._onLoadedCallbackObj)
		else
			arg_4_0._onLoadedCallback()
		end
	end

	ZProj.MaterialPropsTMPCtrl.useSubMesh = arg_4_0._curLang == var_0_0.jp
	arg_4_0._onLoadedCallback = nil
	arg_4_0._onLoadedCallbackObj = nil
end

function var_0_0.init(arg_5_0)
	GameLanguageMgr.instance:setStoryIndexByShortCut(arg_5_0._curLangShortcut)

	if BootNativeUtil.isWindows() then
		local var_5_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.WindowsTitle, nil)

		if not string.nilorempty(var_5_0) then
			return
		end

		local var_5_1 = var_0_0.pcWindowsTitle[arg_5_0._curLang]

		if not var_5_1 then
			logError("can not get windows title for cur lang = " .. arg_5_0._curLangShortcut)

			return
		end

		ZProj.WindowsHelper.Instance:SetWindowsTitle(var_5_1)
		PlayerPrefsHelper.setString(PlayerPrefsKey.WindowsTitle, var_5_1)
	end
end

function var_0_0.getCostumerServiceName(arg_6_0)
	if SettingsModel.instance:isZhRegion() then
		return "深蓝互动"
	end

	local var_6_0 = var_0_0.pcWindowsTitle[arg_6_0._curLang]

	if not var_6_0 then
		logError("can not get windows title for cur lang = " .. arg_6_0._curLangShortcut)

		return ""
	end

	return var_6_0
end

function var_0_0.supportLang(arg_7_0, arg_7_1)
	return arg_7_0._supportedLangs[arg_7_1] ~= nil
end

function var_0_0.langCaptionsActive(arg_8_0)
	return arg_8_0._captionsActive
end

function var_0_0.getCurLang(arg_9_0)
	return arg_9_0._curLang
end

function var_0_0.getDefaultLang(arg_10_0)
	return arg_10_0._defaultLang
end

function var_0_0.getCurLangShortcut(arg_11_0)
	return var_0_0.shortcutTab[arg_11_0._curLang]
end

function var_0_0.getDefaultLangShortcut(arg_12_0)
	return var_0_0.shortcutTab[arg_12_0._defaultLang]
end

function var_0_0.getCurLangKeyByShortCut(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getCurLangShortcut()

	if not arg_13_1 and GameChannelConfig.isEfun() then
		return LanguageEnum.Lang2KeyEFun[var_13_0] or var_13_0
	end

	return LanguageEnum.Lang2KeyGlobal[var_13_0] or var_13_0
end

function var_0_0.SetCurLangType(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in pairs(var_0_0.shortcutTab) do
		if iter_14_1 == arg_14_1 then
			arg_14_0._curLang = iter_14_0

			break
		end
	end

	arg_14_0._curLangShortcut = arg_14_1
	arg_14_0._captionsActive = var_0_0._captionsSetting[arg_14_0._curLang] ~= false

	SLFramework.LanguageMgr.Instance:SetCurLangType(arg_14_1)
	GameLanguageMgr.instance:setStoryIndexByShortCut(arg_14_1)
	arg_14_0:loadLangConfig(arg_14_2, arg_14_3)
end

function var_0_0._lang(arg_15_0, arg_15_1)
	return LangConfig.instance:getLangTxt(arg_15_0._curLangShortcut, arg_15_1)
end

function var_0_0._serverLang(arg_16_0, arg_16_1)
	return LangConfig.instance:getServerLangTxt(arg_16_0._curLangShortcut, arg_16_1)
end

function var_0_0._luaLang(arg_17_0, arg_17_1)
	return LangConfig.instance:getLangTxtFromeKey(arg_17_0._curLangShortcut, arg_17_1)
end

var_0_0.empty = ""

function var_0_0._formatLuaLang(arg_18_0, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return var_0_0.empty
	end

	local var_18_0 = {
		...
	}
	local var_18_1 = var_18_0[1]

	if var_18_1 == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return var_0_0.empty
	end

	local var_18_2 = arg_18_0:_luaLang(var_18_1)

	return string.format(var_18_2, unpack(var_18_0, 2))
end

function var_0_0._langVideoUrl(arg_19_0, arg_19_1)
	local var_19_0 = video_lang.configDict[arg_19_1]
	local var_19_1 = GameConfig:GetCurVoiceShortcut()
	local var_19_2 = GameConfig:GetDefaultVoiceShortcut()

	if var_19_0 then
		if tabletool.indexOf(var_19_0.supportLang, var_19_1) then
			local var_19_3 = string.format("%s/%s", var_19_1, arg_19_1)

			return ResUrl.getVideo(var_19_3)
		elseif tabletool.indexOf(var_19_0.supportLang, var_19_2) then
			local var_19_4 = string.format("%s/%s", var_19_2, arg_19_1)

			return ResUrl.getVideo(var_19_4)
		end
	end

	return ResUrl.getVideo(arg_19_1)
end

var_0_0.instance = var_0_0.New()

function lang(arg_20_0)
	return var_0_0.instance:_lang(arg_20_0)
end

function serverLang(arg_21_0)
	return var_0_0.instance:_serverLang(arg_21_0)
end

function luaLang(arg_22_0)
	return var_0_0.instance:_luaLang(arg_22_0)
end

function formatLuaLang(...)
	return var_0_0.instance:_formatLuaLang(...)
end

function luaLangUTC(arg_24_0)
	local var_24_0 = luaLang(arg_24_0)

	if var_0_0.instance:isOverseas() then
		var_24_0 = ServerTime.ReplaceUTCStr(var_24_0)
	else
		var_24_0 = string.gsub(var_24_0, "%(UTC%+8%)", "")
		var_24_0 = string.gsub(var_24_0, "（UTC%+8）", "")
	end

	return var_24_0
end

function var_0_0.isOverseas(arg_25_0)
	return true
end

function var_0_0.isZh(arg_26_0)
	return arg_26_0:getCurLang() == var_0_0.zh
end

function var_0_0.isTw(arg_27_0)
	return arg_27_0:getCurLang() == var_0_0.tw
end

function var_0_0.isEn(arg_28_0)
	return arg_28_0:getCurLang() == var_0_0.en
end

function var_0_0.isKr(arg_29_0)
	return arg_29_0:getCurLang() == var_0_0.kr
end

function var_0_0.isJp(arg_30_0)
	return arg_30_0:getCurLang() == var_0_0.jp
end

function var_0_0.isDe(arg_31_0)
	return arg_31_0:getCurLang() == var_0_0.de
end

function var_0_0.isFr(arg_32_0)
	return arg_32_0:getCurLang() == var_0_0.fr
end

function var_0_0.isThai(arg_33_0)
	return arg_33_0:getCurLang() == var_0_0.thai
end

function var_0_0.isCn(arg_34_0)
	return arg_34_0:isZh() or arg_34_0:isTw()
end

function langVideoUrl(arg_35_0)
	return var_0_0.instance:_langVideoUrl(arg_35_0)
end

setGlobal("lang", lang)
setGlobal("serverLang", serverLang)
setGlobal("luaLang", luaLang)
setGlobal("formatLuaLang", formatLuaLang)
setGlobal("langVideoUrl", langVideoUrl)
setGlobal("luaLangUTC", luaLangUTC)

return var_0_0
