module("modules.logic.dragonboat.config.DragonBoatFestivalConfig", package.seeall)

local var_0_0 = class("DragonBoatFestivalConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity101_dragonboat"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._dragonConfig = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity101_dragonboat" then
		arg_3_0._dragonConfig = arg_3_2
	end
end

function var_0_0.getDragonBoatCos(arg_4_0)
	local var_4_0 = ActivityEnum.Activity.DragonBoatFestival

	return arg_4_0._dragonConfig.configDict[var_4_0]
end

function var_0_0.getDragonBoatCo(arg_5_0, arg_5_1)
	local var_5_0 = ActivityEnum.Activity.DragonBoatFestival

	return arg_5_0._dragonConfig.configDict[var_5_0][arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
