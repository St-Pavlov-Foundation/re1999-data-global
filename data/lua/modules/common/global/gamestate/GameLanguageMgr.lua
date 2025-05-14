module("modules.common.global.gamestate.GameLanguageMgr", package.seeall)

local var_0_0 = class("GameLanguageMgr")

function var_0_0.ctor(arg_1_0)
	local var_1_0 = LangSettings.shortcutTab[GameConfig:GetCurLangType()]

	arg_1_0._languageType = arg_1_0:getStoryIndexByShortCut(var_1_0)
	arg_1_0._voiceType = arg_1_0:getStoryIndexByShortCut(SettingsController.instance:getStoryVoiceType())
end

function var_0_0.getLanguageTypeStoryIndex(arg_2_0)
	return arg_2_0._languageType
end

function var_0_0.setLanguageTypeByStoryIndex(arg_3_0, arg_3_1)
	arg_3_0._languageType = arg_3_1
end

function var_0_0.setVoiceTypeByStoryIndex(arg_4_0, arg_4_1)
	arg_4_0._voiceType = arg_4_1
end

function var_0_0.getVoiceTypeStoryIndex(arg_5_0)
	if arg_5_0._voiceType then
		return arg_5_0._voiceType
	else
		local var_5_0 = SettingsController.instance:getStoryVoiceType()

		return arg_5_0:getStoryIndexByShortCut(var_5_0)
	end

	return LanguageEnum.LanguageStoryType.EN
end

function var_0_0.getShortCutByStoryIndex(arg_6_0, arg_6_1)
	local var_6_0 = bit.lshift(1, arg_6_1 - 1)

	return LangSettings.shortcutTab[var_6_0]
end

function var_0_0.setStoryIndexByShortCut(arg_7_0, arg_7_1)
	local var_7_0 = LangSettings[arg_7_1]

	arg_7_0._languageType = var_7_0 and math.log(var_7_0) / math.log(2) + 1
end

function var_0_0.getStoryIndexByShortCut(arg_8_0, arg_8_1)
	local var_8_0 = LangSettings[arg_8_1]

	return var_8_0 and math.log(var_8_0) / math.log(2) + 1 or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
