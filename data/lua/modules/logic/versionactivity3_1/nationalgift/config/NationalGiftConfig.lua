module("modules.logic.versionactivity3_1.nationalgift.config.NationalGiftConfig", package.seeall)

local var_0_0 = class("NationalGiftConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._constConfig = nil
	arg_1_0._bonusConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity212_const",
		"activity212_bonus"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity212_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity212_bonus" then
		arg_3_0._bonusConfig = arg_3_2
	end
end

function var_0_0.getConstCO(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_4_0._constConfig.configDict[arg_4_2][arg_4_1]
end

function var_0_0.getBonusCo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_5_0._bonusConfig.configDict[arg_5_2][arg_5_1]
end

function var_0_0.getBonusCos(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_6_0._bonusConfig.configDict[arg_6_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
