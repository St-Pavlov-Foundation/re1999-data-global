module("modules.logic.language.LangConfig", package.seeall)

local var_0_0 = class("LangConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	addGlobalModule("modules.logic.language.lua_language", "lua_language")
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"language_coder",
		"language_prefab",
		"video_lang"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.updateLanguage(arg_4_0, arg_4_1)
	lua_language.onLoad(arg_4_1)
end

function var_0_0.updateServerLanguage(arg_5_0, arg_5_1)
	lua_language_server.onLoad(arg_5_1)
end

function var_0_0.getLangTxt(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_language.configDict[arg_6_2]
	local var_6_1 = var_6_0 and var_6_0.content

	if not string.nilorempty(var_6_1) then
		return var_6_1
	end

	if string.find(arg_6_2, "language_") then
		arg_6_2 = string.getLastNum(arg_6_2)

		if arg_6_2 then
			return tostring(arg_6_2)
		end
	end

	return ""
end

function var_0_0.getServerLangTxt(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_language_server.configDict[arg_7_2]

	if var_7_0 then
		return var_7_0.content
	end

	return arg_7_2
end

function var_0_0.getLangTxtFromeKey(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lua_language_coder.configDict[arg_8_2] or lua_language_prefab.configDict[arg_8_2]

	if not var_8_0 then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. arg_8_2 .. " 请检查！")

		return arg_8_2
	end

	local var_8_1 = arg_8_0:getLangTxt(arg_8_1, var_8_0.lang)

	if LuaUtil.isEmptyStr(var_8_1) then
		return var_8_0.lang
	end

	return var_8_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
