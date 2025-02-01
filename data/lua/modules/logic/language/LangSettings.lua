module("modules.logic.language.LangSettings", package.seeall)

slot0 = class("LangSettings", BaseConfig)
slot0.zh = 1
slot0.tw = 2
slot0.en = 4
slot0.kr = 8
slot0.jp = 16
slot0.de = 32
slot0.fr = 64
slot0.thai = 128
slot0.shortcutTab = {
	[slot0.zh] = "zh",
	[slot0.tw] = "tw",
	[slot0.en] = "en",
	[slot0.kr] = "kr",
	[slot0.jp] = "jp",
	[slot0.de] = "de",
	[slot0.fr] = "fr",
	[slot0.thai] = "thai"
}
slot0.shortCut2LangIdxTab = {
	zh = slot0.zh,
	tw = slot0.tw,
	en = slot0.en,
	kr = slot0.kr,
	jp = slot0.jp,
	de = slot0.de,
	fr = slot0.fr,
	thai = slot0.thai
}
slot0.aihelpKey = {
	[slot0.zh] = "zh-CN",
	[slot0.tw] = "zh-TW",
	[slot0.en] = "en",
	[slot0.kr] = "ko",
	[slot0.jp] = "ja",
	[slot0.de] = "de",
	[slot0.fr] = "fr",
	[slot0.thai] = "th"
}
slot0._captionsSetting = {
	[slot0.zh] = true,
	[slot0.tw] = true,
	[slot0.en] = false,
	[slot0.kr] = false,
	[slot0.jp] = false
}
slot0.pcWindowsTitle = {
	[slot0.zh] = "重返未来：1999",
	[slot0.tw] = "重返未來：1999",
	[slot0.en] = "Reverse: 1999",
	[slot0.kr] = "리버스: 1999",
	[slot0.jp] = "リバース：1999",
	[slot0.de] = "reverse:1999",
	[slot0.fr] = "reverse:1999",
	[slot0.thai] = "reverse:1999"
}

function slot0.ctor(slot0)
	slot0._curLang = GameConfig:GetCurLangType()
	slot0._defaultLang = GameConfig:GetDefaultLangType()
	slot0._curLangShortcut = uv0.shortcutTab[slot0._curLang]
	slot0._captionsActive = uv0._captionsSetting[slot0._curLang] ~= false
	slot0._supportedLangs = {}

	for slot6 = 0, GameConfig:GetSupportedLangs().Length - 1 do
		slot0._supportedLangs[slot1[slot6]] = true
	end

	if uv0.aihelpKey[slot0._curLang] then
		SDKMgr.instance:setLanguage(slot3)
	else
		logError("aihelpKey miss :" .. slot0._curLang)
	end

	slot1 = nil
end

function slot0.loadLangConfig(slot0, slot1, slot2)
	slot0._onLoadedCallback = slot1
	slot0._onLoadedCallbackObj = slot2

	if GameResMgr.IsFromEditorDir then
		loadNonAbAsset("configs/language/json_language_" .. slot0._curLangShortcut .. ".json", SLFramework.AssetType.TEXT, slot0._onConfigAbCallback, slot0)
		loadNonAbAsset("configs/language/json_language_server_" .. slot0._curLangShortcut .. ".json", SLFramework.AssetType.TEXT, slot0._onServerConfigAbCallback, slot0)
	else
		loadNonAbAsset("configs/language/json_language_" .. slot0._curLangShortcut .. ".json.dat", SLFramework.AssetType.DATA, slot0._onConfigAbCallback, slot0)
		loadNonAbAsset("configs/language/json_language_server_" .. slot0._curLangShortcut .. ".json.dat", SLFramework.AssetType.DATA, slot0._onServerConfigAbCallback, slot0)
	end
end

function slot0._onServerConfigAbCallback(slot0, slot1)
	slot2 = nil
	slot3 = cjson.decode((not GameResMgr.IsFromEditorDir or slot1.TextAsset) and slot1:GetNonAbTextAsset(true))
	slot4 = slot3[1]

	LangConfig.instance:updateServerLanguage(slot3[2])
end

function slot0._onConfigAbCallback(slot0, slot1)
	slot2 = nil
	slot3 = cjson.decode((not GameResMgr.IsFromEditorDir or slot1.TextAsset) and slot1:GetNonAbTextAsset(true))
	slot4 = slot3[1]

	LangConfig.instance:updateLanguage(slot3[2])

	if slot0._onLoadedCallback then
		if slot0._onLoadedCallbackObj then
			slot0._onLoadedCallback(slot0._onLoadedCallbackObj)
		else
			slot0._onLoadedCallback()
		end
	end

	ZProj.MaterialPropsTMPCtrl.useSubMesh = slot0._curLang == uv0.jp
	slot0._onLoadedCallback = nil
	slot0._onLoadedCallbackObj = nil
end

function slot0.init(slot0)
	GameLanguageMgr.instance:setStoryIndexByShortCut(slot0._curLangShortcut)

	if BootNativeUtil.isWindows() then
		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.WindowsTitle, nil)) then
			return
		end

		if not uv0.pcWindowsTitle[slot0._curLang] then
			logError("can not get windows title for cur lang = " .. slot0._curLangShortcut)

			return
		end

		ZProj.WindowsHelper.Instance:SetWindowsTitle(slot2)
		PlayerPrefsHelper.setString(PlayerPrefsKey.WindowsTitle, slot2)
	end
end

function slot0.getCostumerServiceName(slot0)
	if SettingsModel.instance:isZhRegion() then
		return "深蓝互动"
	end

	if not uv0.pcWindowsTitle[slot0._curLang] then
		logError("can not get windows title for cur lang = " .. slot0._curLangShortcut)

		return ""
	end

	return slot1
end

function slot0.supportLang(slot0, slot1)
	return slot0._supportedLangs[slot1] ~= nil
end

function slot0.langCaptionsActive(slot0)
	return slot0._captionsActive
end

function slot0.getCurLang(slot0)
	return slot0._curLang
end

function slot0.getDefaultLang(slot0)
	return slot0._defaultLang
end

function slot0.getCurLangShortcut(slot0)
	return uv0.shortcutTab[slot0._curLang]
end

function slot0.getDefaultLangShortcut(slot0)
	return uv0.shortcutTab[slot0._defaultLang]
end

function slot0.getCurLangKeyByShortCut(slot0, slot1)
	slot2 = slot0:getCurLangShortcut()

	if not slot1 and GameChannelConfig.isEfun() then
		return LanguageEnum.Lang2KeyEFun[slot2] or slot2
	end

	return LanguageEnum.Lang2KeyGlobal[slot2] or slot2
end

function slot0.SetCurLangType(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(uv0.shortcutTab) do
		if slot8 == slot1 then
			slot0._curLang = slot7

			break
		end
	end

	slot0._curLangShortcut = slot1
	slot0._captionsActive = uv0._captionsSetting[slot0._curLang] ~= false

	SLFramework.LanguageMgr.Instance:SetCurLangType(slot1)
	GameLanguageMgr.instance:setStoryIndexByShortCut(slot1)
	slot0:loadLangConfig(slot2, slot3)
end

function slot0._lang(slot0, slot1)
	return LangConfig.instance:getLangTxt(slot0._curLangShortcut, slot1)
end

function slot0._serverLang(slot0, slot1)
	return LangConfig.instance:getServerLangTxt(slot0._curLangShortcut, slot1)
end

function slot0._luaLang(slot0, slot1)
	return LangConfig.instance:getLangTxtFromeKey(slot0._curLangShortcut, slot1)
end

slot0.empty = ""

function slot0._formatLuaLang(slot0, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return uv0.empty
	end

	if ({
		...
	})[1] == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return uv0.empty
	end

	return string.format(slot0:_luaLang(slot2), unpack(slot1, 2))
end

function slot0._langVideoUrl(slot0, slot1)
	slot3 = GameConfig:GetCurVoiceShortcut()
	slot4 = GameConfig:GetDefaultVoiceShortcut()

	if video_lang.configDict[slot1] then
		if tabletool.indexOf(slot2.supportLang, slot3) then
			return ResUrl.getVideo(string.format("%s/%s", slot3, slot1))
		elseif tabletool.indexOf(slot2.supportLang, slot4) then
			return ResUrl.getVideo(string.format("%s/%s", slot4, slot1))
		end
	end

	return ResUrl.getVideo(slot1)
end

slot0.instance = slot0.New()

function lang(slot0)
	return uv0.instance:_lang(slot0)
end

function serverLang(slot0)
	return uv0.instance:_serverLang(slot0)
end

function luaLang(slot0)
	return uv0.instance:_luaLang(slot0)
end

function formatLuaLang(...)
	return uv0.instance:_formatLuaLang(...)
end

function slot0.isZh(slot0)
	return slot0:getCurLang() == uv0.zh
end

function slot0.isTw(slot0)
	return slot0:getCurLang() == uv0.tw
end

function slot0.isEn(slot0)
	return slot0:getCurLang() == uv0.en
end

function slot0.isKr(slot0)
	return slot0:getCurLang() == uv0.kr
end

function slot0.isJp(slot0)
	return slot0:getCurLang() == uv0.jp
end

function slot0.isDe(slot0)
	return slot0:getCurLang() == uv0.de
end

function slot0.isFr(slot0)
	return slot0:getCurLang() == uv0.fr
end

function slot0.isThai(slot0)
	return slot0:getCurLang() == uv0.thai
end

function langVideoUrl(slot0)
	return uv0.instance:_langVideoUrl(slot0)
end

setGlobal("lang", lang)
setGlobal("serverLang", serverLang)
setGlobal("luaLang", luaLang)
setGlobal("formatLuaLang", formatLuaLang)
setGlobal("langVideoUrl", langVideoUrl)

return slot0
