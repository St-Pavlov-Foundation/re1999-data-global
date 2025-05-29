module("modules.logic.gm.lang.GMLangController", package.seeall)

local var_0_0 = class("GMLangController", BaseController)

GameUtil.getEventId()

local var_0_1 = GameUtil.getSubPlaceholderLuaLang

function var_0_0.getSubPlaceholderLuaLang(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.instance:cur2AllLang(arg_1_0)

	if arg_1_1 and #arg_1_1 > 0 then
		arg_1_0 = var_0_1(arg_1_0, arg_1_1)

		if not var_0_0.instance:checkHasCache(arg_1_0) then
			var_0_0.instance._inUseDic[arg_1_0] = {}

			for iter_1_0, iter_1_1 in pairs(var_1_0 or {}) do
				var_0_0.instance._inUseDic[arg_1_0][iter_1_0] = var_0_1(iter_1_1, arg_1_1)
			end

			var_0_0.instance:dispatchInUseUpdate(arg_1_0)
		end
	end

	return arg_1_0
end

function var_0_0.lang(arg_2_0)
	local var_2_0 = LangSettings.instance:_lang(arg_2_0)

	var_0_0.instance:updateInUseId(var_2_0, arg_2_0)

	return var_2_0
end

function var_0_0.luaLang(arg_3_0)
	local var_3_0 = LangSettings.instance:_luaLang(arg_3_0)

	var_0_0.instance:updateInUse(var_3_0, arg_3_0)

	return var_3_0
end

function var_0_0.formatLuaLang(...)
	local var_4_0 = LangSettings.instance:_formatLuaLang(...)

	var_0_0.instance:updateFormatInUse(var_4_0, ...)

	return var_4_0
end

function var_0_0.updateInUseId(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0:checkHasCache(arg_5_1) then
		return
	end

	arg_5_0._inUseDic[arg_5_1] = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._langDic) do
		local var_5_0 = arg_5_0:getLangTxt(iter_5_0, arg_5_2)

		arg_5_0._inUseDic[arg_5_1][iter_5_0] = var_5_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_5_1)
end

function var_0_0.updateInUse(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:checkHasCache(arg_6_1) then
		return
	end

	arg_6_0._inUseDic[arg_6_1] = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._langDic) do
		local var_6_0 = arg_6_0:getLangTxtFromeKey(iter_6_0, arg_6_2)

		arg_6_0._inUseDic[arg_6_1][iter_6_0] = var_6_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_6_1)
end

function var_0_0.updateFormatInUse(arg_7_0, arg_7_1, ...)
	if arg_7_0:checkHasCache(arg_7_1) then
		return
	end

	arg_7_0._inUseDic[arg_7_1] = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._langDic) do
		local var_7_0 = arg_7_0:_formatLuaLang(iter_7_0, ...)

		arg_7_0._inUseDic[arg_7_1][iter_7_0] = var_7_0
	end

	var_0_0.instance:dispatchInUseUpdate(arg_7_1)
end

function var_0_0.checkHasCache(arg_8_0, arg_8_1)
	return arg_8_0._inUseDic[arg_8_1] ~= nil
end

function var_0_0.cur2AllLang(arg_9_0, arg_9_1)
	return arg_9_0._inUseDic[arg_9_1]
end

if GameResMgr.IsFromEditorDir then
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.loadassembly("Assembly-CSharp-Editor")
	tolua.loadassembly("System.Core")

	local var_0_2 = tolua.findtype("System.String")
	local var_0_3 = tolua.findtype("ZProjEditor.LangTextSearchWindows")

	var_0_0.AddMsg = tolua.getmethod(var_0_3, "AddMsg", var_0_2)
end

function var_0_0.dispatchInUseUpdate(arg_10_0, arg_10_1)
	if GameResMgr.IsFromEditorDir then
		var_0_0.AddMsg:Call(arg_10_1)
	end

	GMLangTxtModel.instance:addLangTxt(arg_10_1)
end

function var_0_0.print(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._inUseDic) do
		logNormal(iter_11_0, "===================================")

		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			logNormal(iter_11_2, ":", iter_11_3)
		end
	end
end

function var_0_0.getInUseDic(arg_12_0)
	return arg_12_0._inUseDic
end

function var_0_0.clearInUse(arg_13_0)
	tabletool.clear(arg_13_0._inUseDic)
	GMLangTxtModel.instance:clearAll()
end

function var_0_0.hasInit(arg_14_0)
	return arg_14_0._hasInit
end

function var_0_0.init(arg_15_0)
	if arg_15_0._hasInit then
		return arg_15_0._hasInit
	end

	local var_15_0 = LangSettings.zh

	arg_15_0._hasInit = true

	setGlobal("lang", var_0_0.lang)
	setGlobal("luaLang", var_0_0.luaLang)
	setGlobal("formatLuaLang", var_0_0.formatLuaLang)

	GameUtil.getSubPlaceholderLuaLang = var_0_0.getSubPlaceholderLuaLang
	arg_15_0._langDic = {}
	arg_15_0._inUseDic = {}

	local var_15_1 = GameConfig:GetCurLangShortcut()
	local var_15_2 = GameConfig:GetSupportedLangShortcuts()

	arg_15_0._supportedLangCount = var_15_2.Length

	for iter_15_0 = 0, arg_15_0._supportedLangCount - 1 do
		local var_15_3 = var_15_2[iter_15_0]

		if GameResMgr.IsFromEditorDir then
			local var_15_4 = "configs/language/json_language_" .. var_15_3 .. ".json"

			loadNonAbAsset(var_15_4, SLFramework.AssetType.TEXT, arg_15_0._onConfigAbCallback, arg_15_0)
		else
			local var_15_5 = "configs/language/json_language_" .. var_15_3 .. ".json.dat"

			loadNonAbAsset(var_15_5, SLFramework.AssetType.DATA, arg_15_0._onConfigAbCallback, arg_15_0)
		end
	end

	return arg_15_0._hasInit
end

function var_0_0.changeLang(arg_16_0, arg_16_1)
	LangSettings.instance:SetCurLangType(arg_16_1, arg_16_0._onChangeLangTxtType2, arg_16_0)
	GameGlobalMgr.instance:getLangFont():changeFontAsset()
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0._inUseDic) do
		var_16_0[iter_16_1[arg_16_1]] = iter_16_1
	end

	arg_16_0._inUseDic = var_16_0
end

function var_0_0._onChangeLangTxtType2(arg_17_0)
	local var_17_0 = GameConfig:GetCurLangShortcut()
	local var_17_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_17_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_17_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_17_1 - 1)
end

function var_0_0._onConfigAbCallback(arg_18_0, arg_18_1)
	local var_18_0 = ""

	if GameResMgr.IsFromEditorDir then
		var_18_0 = arg_18_1.TextAsset
	else
		var_18_0 = arg_18_1:GetNonAbTextAsset(true)
	end

	local var_18_1 = cjson.decode(var_18_0)
	local var_18_2 = var_18_1[1]
	local var_18_3 = var_18_1[2]
	local var_18_4 = {}
	local var_18_5 = {
		content = 2,
		key = 1
	}
	local var_18_6 = {
		"key"
	}
	local var_18_7 = {}
	local var_18_8 = var_18_2.gsub(var_18_2, "language_", "")

	var_18_4.configList, var_18_4.configDict = JsonToLuaParser.parse(var_18_3, var_18_5, var_18_6, var_18_7)
	arg_18_0._langDic[var_18_8] = var_18_4
end

function var_0_0.getLangTxtFromeKey(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = lua_language_coder.configDict[arg_19_2] or lua_language_prefab.configDict[arg_19_2]

	if not var_19_0 then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. arg_19_2 .. " 请检查！")

		return arg_19_2
	end

	local var_19_1 = rawget(var_19_0, 2)
	local var_19_2 = arg_19_0:getLangTxt(arg_19_1, var_19_1)

	if LuaUtil.isEmptyStr(var_19_2) then
		return var_19_0.lang
	end

	return var_19_2
end

function var_0_0.getLangTxt(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._langDic[arg_20_1].configDict[arg_20_2]
	local var_20_1 = var_20_0 and var_20_0.content

	if not string.nilorempty(var_20_1) then
		return var_20_1
	end

	if string.find(arg_20_2, "language_") then
		arg_20_2 = string.getLastNum(arg_20_2)

		if arg_20_2 then
			return tostring(arg_20_2)
		end
	end

	return ""
end

function var_0_0._formatLuaLang(arg_21_0, arg_21_1, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return LangSettings.empty
	end

	local var_21_0 = {
		...
	}
	local var_21_1 = var_21_0[1]

	if var_21_1 == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return LangSettings.empty
	end

	local var_21_2 = arg_21_0:getLangTxtFromeKey(arg_21_1, var_21_1)

	return string.format(var_21_2, unpack(var_21_0, 2))
end

var_0_0.instance = var_0_0.New()

return var_0_0
