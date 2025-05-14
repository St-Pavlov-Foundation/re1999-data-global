module("modules.logic.versionactivity1_6.act152.config.Activity152Config", package.seeall)

local var_0_0 = class("Activity152Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._activityConfig = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity152"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity152" then
		arg_3_0._activityConfig = arg_3_2.configDict
	end
end

function var_0_0.getAct152Co(arg_4_0, arg_4_1)
	return arg_4_0._activityConfig[ActivityEnum.Activity.NewYearEve][arg_4_1]
end

function var_0_0.getAct152Cos(arg_5_0)
	return arg_5_0._activityConfig[ActivityEnum.Activity.NewYearEve]
end

var_0_0.instance = var_0_0.New()

return var_0_0
