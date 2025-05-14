module("modules.logic.versionactivity1_6.act149.model.Activity149Mo", package.seeall)

local var_0_0 = class("Activity149Mo")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0._activityId = arg_1_2
	arg_1_0.cfg = arg_1_0:getAct149EpisodeCfg(arg_1_1)
end

function var_0_0.getAct149EpisodeCfg(arg_2_0, arg_2_1)
	return Activity149Config.instance:getAct149EpisodeCfg(arg_2_1)
end

return var_0_0
