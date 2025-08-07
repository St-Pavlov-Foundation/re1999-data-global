module("modules.logic.gm.lang.GMLangController", package.seeall)

local var_0_0 = class("GMLangController", BaseController)

GameUtil.getEventId()

local function var_0_1(arg_1_0)
	if string.sub(arg_1_0, -1, -1) ~= "%" then
		return arg_1_0
	else
		return arg_1_0 .. "%"
	end
end

local var_0_2 = GameUtil.getSubPlaceholderLuaLang

function var_0_0.getSubPlaceholderLuaLang(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.instance:cur2AllLang(arg_2_0)

	if arg_2_1 and #arg_2_1 > 0 then
		arg_2_0 = var_0_2(arg_2_0, arg_2_1)

		if not var_0_0.instance:checkHasCache(arg_2_0) then
			var_0_0.instance._inUseDic[arg_2_0] = {}

			for iter_2_0, iter_2_1 in pairs(var_2_0 or {}) do
				var_0_0.instance._inUseDic[arg_2_0][iter_2_0] = var_0_2(iter_2_1, arg_2_1)
			end

			var_0_0.instance:dispatchInUseUpdate(arg_2_0)
		end
	end

	return arg_2_0
end

function var_0_0.lang(arg_3_0)
	local var_3_0 = LangSettings.instance:_lang(arg_3_0)

	var_0_0.instance:updateInUseId(var_3_0, arg_3_0)

	return var_3_0
end

function var_0_0.luaLang(arg_4_0)
	local var_4_0 = LangSettings.instance:_luaLang(arg_4_0)

	var_0_0.instance:updateInUse(var_4_0, arg_4_0)

	return var_4_0
end

function var_0_0.formatLuaLang(...)
	local var_5_0 = LangSettings.instance:_formatLuaLang(...)

	var_0_0.instance:updateFormatInUse(var_5_0, ...)

	return var_5_0
end

function var_0_0.updateInUseId(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:checkHasCache(arg_6_1) then
		return
	end

	arg_6_0._inUseDic[arg_6_1] = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._langDic) do
		local var_6_0 = arg_6_0:getLangTxt(iter_6_0, arg_6_2)

		arg_6_0._inUseDic[arg_6_1][iter_6_0] = var_6_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_6_1)
end

function var_0_0.updateInUse(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0:checkHasCache(arg_7_1) then
		return
	end

	arg_7_0._inUseDic[arg_7_1] = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._langDic) do
		local var_7_0 = arg_7_0:getLangTxtFromeKey(iter_7_0, arg_7_2)

		arg_7_0._inUseDic[arg_7_1][iter_7_0] = var_7_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_7_1)
end

function var_0_0.updateFormatInUse(arg_8_0, arg_8_1, ...)
	if arg_8_0:checkHasCache(arg_8_1) then
		return
	end

	arg_8_0._inUseDic[arg_8_1] = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._langDic) do
		local var_8_0 = arg_8_0:_formatLuaLang(iter_8_0, ...)

		arg_8_0._inUseDic[arg_8_1][iter_8_0] = var_8_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_8_1)
end

function var_0_0.checkHasCache(arg_9_0, arg_9_1)
	return arg_9_0._inUseDic[arg_9_1] ~= nil
end

function var_0_0.cur2AllLang(arg_10_0, arg_10_1)
	return arg_10_0._inUseDic[arg_10_1] or {}
end

if GameResMgr.IsFromEditorDir then
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.loadassembly("Assembly-CSharp-Editor")
	tolua.loadassembly("System.Core")

	local var_0_3 = tolua.findtype("System.String")
	local var_0_4 = tolua.findtype("ZProjEditor.LangTextSearchWindows")

	var_0_0.AddMsg = tolua.getmethod(var_0_4, "AddMsg", var_0_3)
end

function var_0_0.dispatchInUseUpdate(arg_11_0, arg_11_1)
	if GameResMgr.IsFromEditorDir then
		var_0_0.AddMsg:Call(arg_11_1)
	end

	GMLangTxtModel.instance:addLangTxt(arg_11_1)
end

function var_0_0.print(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._inUseDic) do
		logNormal(iter_12_0, "===================================")

		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			logNormal(iter_12_2, ":", iter_12_3)
		end
	end
end

function var_0_0.getInUseDic(arg_13_0)
	return arg_13_0._inUseDic
end

function var_0_0.clearInUse(arg_14_0)
	tabletool.clear(arg_14_0._inUseDic)
	GMLangTxtModel.instance:clearAll()
end

function var_0_0.hasInit(arg_15_0)
	return arg_15_0._hasInit
end

function var_0_0.init(arg_16_0)
	if arg_16_0._hasInit then
		return arg_16_0._hasInit
	end

	local var_16_0 = LangSettings.zh

	arg_16_0._hasInit = true

	setGlobal("lang", var_0_0.lang)
	setGlobal("luaLang", var_0_0.luaLang)
	setGlobal("formatLuaLang", var_0_0.formatLuaLang)

	GameUtil.getSubPlaceholderLuaLang = var_0_0.getSubPlaceholderLuaLang
	arg_16_0._langDic = {}
	arg_16_0._inUseDic = {}

	local var_16_1 = GameConfig:GetCurLangShortcut()
	local var_16_2 = GameConfig:GetSupportedLangShortcuts()

	arg_16_0._supportedLangCount = var_16_2.Length

	for iter_16_0 = 0, arg_16_0._supportedLangCount - 1 do
		local var_16_3 = var_16_2[iter_16_0]

		if GameResMgr.IsFromEditorDir then
			local var_16_4 = "configs/language/json_language_" .. var_16_3 .. ".json"

			loadNonAbAsset(var_16_4, SLFramework.AssetType.TEXT, arg_16_0._onConfigAbCallback, arg_16_0)
		else
			local var_16_5 = "configs/language/json_language_" .. var_16_3 .. ".json.dat"

			loadNonAbAsset(var_16_5, SLFramework.AssetType.DATA, arg_16_0._onConfigAbCallback, arg_16_0)
		end
	end

	return arg_16_0._hasInit
end

function var_0_0.changeLang(arg_17_0, arg_17_1)
	LangSettings.instance:SetCurLangType(arg_17_1, arg_17_0._onChangeLangTxtType2, arg_17_0)
	GameGlobalMgr.instance:getLangFont():changeFontAsset()
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._inUseDic) do
		var_17_0[iter_17_1[arg_17_1]] = iter_17_1
	end

	arg_17_0._inUseDic = var_17_0
end

function var_0_0._onChangeLangTxtType2(arg_18_0)
	local var_18_0 = GameConfig:GetCurLangShortcut()
	local var_18_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_18_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_18_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_18_1 - 1)
end

function var_0_0._onConfigAbCallback(arg_19_0, arg_19_1)
	local var_19_0 = ""

	if GameResMgr.IsFromEditorDir then
		var_19_0 = arg_19_1.TextAsset
	else
		var_19_0 = arg_19_1:GetNonAbTextAsset(true)
	end

	local var_19_1 = cjson.decode(var_19_0)
	local var_19_2 = var_19_1[1]
	local var_19_3 = var_19_1[2]
	local var_19_4 = {}
	local var_19_5 = {
		content = 2,
		key = 1
	}
	local var_19_6 = {
		"key"
	}
	local var_19_7 = {}
	local var_19_8 = var_19_2.gsub(var_19_2, "language_", "")

	var_19_4.configList, var_19_4.configDict = JsonToLuaParser.parse(var_19_3, var_19_5, var_19_6, var_19_7)
	arg_19_0._langDic[var_19_8] = var_19_4
end

function var_0_0.getLangTxtFromeKey(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = lua_language_coder.configDict[arg_20_2] or lua_language_prefab.configDict[arg_20_2]

	if not var_20_0 then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. arg_20_2 .. " 请检查！")

		return arg_20_2
	end

	local var_20_1 = rawget(var_20_0, 2)
	local var_20_2 = arg_20_0:getLangTxt(arg_20_1, var_20_1)

	if LuaUtil.isEmptyStr(var_20_2) then
		return var_20_0.lang
	end

	return var_20_2
end

function var_0_0.getLangTxt(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._langDic[arg_21_1].configDict[arg_21_2]
	local var_21_1 = var_21_0 and var_21_0.content

	if not string.nilorempty(var_21_1) then
		return var_21_1
	end

	if string.find(arg_21_2, "language_") then
		arg_21_2 = string.getLastNum(arg_21_2)

		if arg_21_2 then
			return tostring(arg_21_2)
		end
	end

	return ""
end

function var_0_0._formatLuaLang(arg_22_0, arg_22_1, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return LangSettings.empty
	end

	local var_22_0 = {
		...
	}
	local var_22_1 = var_22_0[1]

	if var_22_1 == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return LangSettings.empty
	end

	local var_22_2 = arg_22_0:getLangTxtFromeKey(arg_22_1, var_22_1)

	return string.format(var_22_2, unpack(var_22_0, 2))
end

var_0_0.instance = var_0_0.New()

return var_0_0
