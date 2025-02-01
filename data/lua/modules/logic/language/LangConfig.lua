module("modules.logic.language.LangConfig", package.seeall)

slot0 = class("LangConfig", BaseConfig)

function slot0.ctor(slot0)
	addGlobalModule("modules.logic.language.lua_language", "lua_language")
end

function slot0.reqConfigNames(slot0)
	return {
		"language_coder",
		"language_prefab",
		"video_lang"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.updateLanguage(slot0, slot1)
	lua_language.onLoad(slot1)
end

function slot0.updateServerLanguage(slot0, slot1)
	lua_language_server.onLoad(slot1)
end

function slot0.getLangTxt(slot0, slot1, slot2)
	if not string.nilorempty(lua_language.configDict[slot2] and slot3.content) then
		return slot4
	end

	if string.find(slot2, "language_") and string.getLastNum(slot2) then
		return tostring(slot2)
	end

	return ""
end

function slot0.getServerLangTxt(slot0, slot1, slot2)
	if lua_language_server.configDict[slot2] then
		return slot3.content
	end

	return slot2
end

function slot0.getLangTxtFromeKey(slot0, slot1, slot2)
	if not (lua_language_coder.configDict[slot2] or lua_language_prefab.configDict[slot2]) then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. slot2 .. " 请检查！")

		return slot2
	end

	if LuaUtil.isEmptyStr(slot0:getLangTxt(slot1, slot3.lang)) then
		return slot3.lang
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
