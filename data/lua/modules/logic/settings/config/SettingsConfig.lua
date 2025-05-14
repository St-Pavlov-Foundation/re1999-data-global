module("modules.logic.settings.config.SettingsConfig", package.seeall)

local var_0_0 = class("SettingsConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.SettingsConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"setting_lang",
		"setting_voice"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "setting_lang" then
		arg_3_0.SettingLangConfig = arg_3_2
	elseif arg_3_1 == "setting_voice" then
		arg_3_0.SettingVoiceConfig = arg_3_2
	end
end

function var_0_0.getSettingLang(arg_4_0, arg_4_1)
	return arg_4_0.SettingLangConfig.configDict[arg_4_1].lang
end

function var_0_0.getVoiceTips(arg_5_0, arg_5_1)
	if arg_5_0.SettingVoiceConfig.configDict[arg_5_1] then
		return arg_5_0.SettingVoiceConfig.configDict[arg_5_1].tips
	end

	return ""
end

var_0_0.instance = var_0_0.New()

return var_0_0
