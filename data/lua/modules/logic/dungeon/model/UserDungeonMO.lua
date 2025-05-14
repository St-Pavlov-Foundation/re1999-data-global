module("modules.logic.dungeon.model.UserDungeonMO", package.seeall)

local var_0_0 = pureTable("UserDungeonMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.chapterId = arg_1_1.chapterId
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.star = arg_1_1.star
	arg_1_0.challengeCount = arg_1_1.challengeCount
	arg_1_0.hasRecord = arg_1_1.hasRecord
	arg_1_0.todayPassNum = arg_1_1.todayPassNum
	arg_1_0.todayTotalNum = arg_1_1.todayTotalNum
end

function var_0_0.initFromManual(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.chapterId = arg_2_1
	arg_2_0.episodeId = arg_2_2
	arg_2_0.star = arg_2_3
	arg_2_0.challengeCount = arg_2_4
	arg_2_0._manual = true
	arg_2_0.isNew = true
	arg_2_0.hasRecord = false

	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_2)

	arg_2_0.todayPassNum = 0
	arg_2_0.todayTotalNum = var_2_0.dayNum
end

return var_0_0
