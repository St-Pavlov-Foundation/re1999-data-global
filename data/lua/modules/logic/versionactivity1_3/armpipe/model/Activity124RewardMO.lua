module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardMO", package.seeall)

local var_0_0 = pureTable("Activity124RewardMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.episodeId
	arg_1_0.config = arg_1_1
end

function var_0_0.isLock(arg_2_0)
	return false
end

function var_0_0.isReceived(arg_3_0)
	return Activity124Model.instance:isReceived(arg_3_0.config.activityId, arg_3_0.config.episodeId)
end

function var_0_0.isHasReard(arg_4_0)
	return Activity124Model.instance:isHasReard(arg_4_0.config.activityId, arg_4_0.config.episodeId)
end

return var_0_0
