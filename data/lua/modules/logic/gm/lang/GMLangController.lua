module("modules.logic.gm.lang.GMLangController", package.seeall)

slot0 = class("GMLangController", BaseController)

GameUtil.getEventId()

slot1 = GameUtil.getSubPlaceholderLuaLang

function slot0.getSubPlaceholderLuaLang(slot0, slot1)
	slot2 = uv0.instance:cur2AllLang(slot0)

	if slot1 and #slot1 > 0 and uv0.instance:checkHasCache(uv1(slot0, slot1)) == false then
		uv0.instance._inUseDic[slot0] = {}

		for slot6, slot7 in pairs(slot2) do
			uv0.instance._inUseDic[slot0][slot6] = uv1(slot7, slot1)
		end

		uv0.instance:dispatchInUseUpdate(slot0)
	end

	return slot0
end

function slot0.lang(slot0)
	slot1 = LangSettings.instance:_lang(slot0)

	uv0.instance:updateInUseId(slot1, slot0)

	return slot1
end

function slot0.luaLang(slot0)
	slot1 = LangSettings.instance:_luaLang(slot0)

	uv0.instance:updateInUse(slot1, slot0)

	return slot1
end

function slot0.formatLuaLang(...)
	slot0 = LangSettings.instance:_formatLuaLang(...)

	uv0.instance:updateFormatInUse(slot0, ...)

	return slot0
end

function slot0.updateInUseId(slot0, slot1, slot2)
	if slot0:checkHasCache(slot1) then
		return
	end

	slot0._inUseDic[slot1] = {}

	for slot6, slot7 in pairs(slot0._langDic) do
		slot0._inUseDic[slot1][slot6] = slot0:getLangTxt(slot6, slot2)
	end

	uv0.instance:dispatchInUseUpdate(slot1)
end

function slot0.updateInUse(slot0, slot1, slot2)
	if slot0:checkHasCache(slot1) then
		return
	end

	slot0._inUseDic[slot1] = {}

	for slot6, slot7 in pairs(slot0._langDic) do
		slot0._inUseDic[slot1][slot6] = slot0:getLangTxtFromeKey(slot6, slot2)
	end

	uv0.instance:dispatchInUseUpdate(slot1)
end

function slot0.updateFormatInUse(slot0, slot1, ...)
	if slot0:checkHasCache(slot1) then
		return
	end

	slot0._inUseDic[slot1] = {}

	for slot5, slot6 in pairs(slot0._langDic) do
		slot0._inUseDic[slot1][slot5] = slot0:_formatLuaLang(slot5, ...)
	end

	uv0.instance:dispatchInUseUpdate(slot1)
end

function slot0.checkHasCache(slot0, slot1)
	return slot0._inUseDic[slot1] ~= nil
end

function slot0.cur2AllLang(slot0, slot1)
	return slot0._inUseDic[slot1]
end

if GameResMgr.IsFromEditorDir then
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.loadassembly("Assembly-CSharp-Editor")
	tolua.loadassembly("System.Core")

	slot0.AddMsg = tolua.getmethod(tolua.findtype("ZProjEditor.LangTextSearchWindows"), "AddMsg", tolua.findtype("System.String"))
end

function slot0.dispatchInUseUpdate(slot0, slot1)
	if GameResMgr.IsFromEditorDir then
		uv0.AddMsg:Call(slot1)
	end

	GMLangTxtModel.instance:addLangTxt(slot1)
end

function slot0.print(slot0)
	for slot4, slot5 in pairs(slot0._inUseDic) do
		logNormal(slot4, "===================================")

		for slot9, slot10 in pairs(slot5) do
			logNormal(slot9, ":", slot10)
		end
	end
end

function slot0.getInUseDic(slot0)
	return slot0._inUseDic
end

function slot0.clearInUse(slot0)
	tabletool.clear(slot0._inUseDic)
	GMLangTxtModel.instance:clearAll()
end

function slot0.hasInit(slot0)
	return slot0._hasInit
end

function slot0.init(slot0)
	if slot0._hasInit then
		return slot0._hasInit
	end

	slot1 = LangSettings.zh
	slot0._hasInit = true

	setGlobal("lang", uv0.lang)
	setGlobal("luaLang", uv0.luaLang)
	setGlobal("formatLuaLang", uv0.formatLuaLang)

	GameUtil.getSubPlaceholderLuaLang = uv0.getSubPlaceholderLuaLang
	slot0._langDic = {}
	slot0._inUseDic = {}
	slot2 = GameConfig:GetCurLangShortcut()
	slot0._supportedLangCount = GameConfig:GetSupportedLangShortcuts().Length

	for slot7 = 0, slot0._supportedLangCount - 1 do
		if GameResMgr.IsFromEditorDir then
			loadNonAbAsset("configs/language/json_language_" .. slot3[slot7] .. ".json", SLFramework.AssetType.TEXT, slot0._onConfigAbCallback, slot0)
		else
			loadNonAbAsset("configs/language/json_language_" .. slot8 .. ".json.dat", SLFramework.AssetType.DATA, slot0._onConfigAbCallback, slot0)
		end
	end

	return slot0._hasInit
end

function slot0.changeLang(slot0, slot1)
	slot6 = slot0

	LangSettings.instance:SetCurLangType(slot1, slot0._onChangeLangTxtType2, slot6)
	GameGlobalMgr.instance:getLangFont():changeFontAsset()
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()

	for slot6, slot7 in pairs(slot0._inUseDic) do
		-- Nothing
	end

	slot0._inUseDic = {
		[slot7[slot1]] = slot7
	}
end

function slot0._onChangeLangTxtType2(slot0)
	slot2 = GameLanguageMgr.instance:getStoryIndexByShortCut(GameConfig:GetCurLangShortcut())

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(slot2)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", slot2 - 1)
end

function slot0._onConfigAbCallback(slot0, slot1)
	slot2 = ""
	slot3 = cjson.decode((not GameResMgr.IsFromEditorDir or slot1.TextAsset) and slot1:GetNonAbTextAsset(true))
	slot11, slot12 = JsonToLuaParser.parse(slot3[2], {
		content = 2,
		key = 1
	}, {
		"key"
	}, {})
	slot0._langDic[slot3[1]:gsub("language_", "")] = {
		configDict = slot12,
		configList = slot11
	}
end

function slot0.getLangTxtFromeKey(slot0, slot1, slot2)
	if not (lua_language_coder.configDict[slot2] or lua_language_prefab.configDict[slot2]) then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. slot2 .. " 请检查！")

		return slot2
	end

	if LuaUtil.isEmptyStr(slot0:getLangTxt(slot1, rawget(slot3, 2))) then
		return slot3.lang
	end

	return slot5
end

function slot0.getLangTxt(slot0, slot1, slot2)
	if not string.nilorempty(slot0._langDic[slot1].configDict[slot2] and slot4.content) then
		return slot5
	end

	if string.find(slot2, "language_") and string.getLastNum(slot2) then
		return tostring(slot2)
	end

	return ""
end

function slot0._formatLuaLang(slot0, slot1, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return LangSettings.empty
	end

	if ({
		...
	})[1] == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return LangSettings.empty
	end

	return string.format(slot0:getLangTxtFromeKey(slot1, slot3), unpack(slot2, 2))
end

slot0.instance = slot0.New()

return slot0
