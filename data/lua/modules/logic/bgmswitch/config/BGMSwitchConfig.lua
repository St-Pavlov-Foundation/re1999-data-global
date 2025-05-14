module("modules.logic.bgmswitch.config.BGMSwitchConfig", package.seeall)

local var_0_0 = class("BGMSwitchConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._bgmSwitchConfig = nil
	arg_1_0._bgmTypeConfig = nil
	arg_1_0._bgmEasterEggConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"bgm_switch",
		"bgm_type",
		"bgm_easteregg"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "bgm_switch" then
		arg_3_0._bgmSwitchConfig = arg_3_2
	elseif arg_3_1 == "bgm_type" then
		arg_3_0._bgmTypeConfig = arg_3_2
	elseif arg_3_1 == "bgm_easteregg" then
		arg_3_0._bgmEasterEggConfig = arg_3_2
	end
end

function var_0_0.getBGMSwitchCos(arg_4_0)
	return arg_4_0._bgmSwitchConfig.configDict
end

function var_0_0.getBGMSwitchCO(arg_5_0, arg_5_1)
	return arg_5_0._bgmSwitchConfig.configDict[arg_5_1]
end

function var_0_0.getBGMSwitchCoByAudioId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._bgmSwitchConfig.configDict) do
		if iter_6_1.audio == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.getBGMTypeCos(arg_7_0)
	return arg_7_0._bgmTypeConfig.configDict
end

function var_0_0.getBGMTypeCO(arg_8_0, arg_8_1)
	return arg_8_0._bgmTypeConfig.configDict[arg_8_1]
end

function var_0_0.getBgmEasterEggCos(arg_9_0)
	return arg_9_0._bgmEasterEggConfig.configDict
end

function var_0_0.getBgmEasterEggCosByType(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._bgmEasterEggConfig.configDict) do
		if iter_10_1.type == arg_10_1 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.getBgmEasterEggCo(arg_11_0, arg_11_1)
	return arg_11_0._bgmEasterEggConfig.configDict[arg_11_1]
end

function var_0_0.getBgmNames(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = var_0_0.instance:getBGMSwitchCO(iter_12_1)

		if var_12_1 then
			table.insert(var_12_0, var_12_1.audioName)
		end
	end

	return var_12_0
end

function var_0_0.getBgmName(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.instance:getBGMSwitchCO(arg_13_1)

	return var_13_0 and var_13_0.audioName
end

var_0_0.instance = var_0_0.New()

return var_0_0
