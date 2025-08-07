module("modules.logic.sp01.act205.model.Act205GameInfoMo", package.seeall)

local var_0_0 = pureTable("Act205GameInfoMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.gameType = arg_1_2
	arg_1_0.config = Act205Config.instance:getStageConfig(arg_1_0.activityId, arg_1_0.gameType)

	arg_1_0:setHaveGameCount()

	arg_1_0.gameInfo = ""
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1.activityId
	arg_2_0.gameType = arg_2_1.gameType

	arg_2_0:setHaveGameCount(arg_2_1.haveGameCount)
end

function var_0_0.setGameInfo(arg_3_0, arg_3_1)
	arg_3_0.gameInfo = arg_3_1
end

function var_0_0.setHaveGameCount(arg_4_0, arg_4_1)
	arg_4_0.haveGameCount = arg_4_1 or 0
end

function var_0_0.getGameInfo(arg_5_0)
	return arg_5_0.gameInfo
end

function var_0_0.getHaveGameCount(arg_6_0)
	return arg_6_0.haveGameCount
end

return var_0_0
