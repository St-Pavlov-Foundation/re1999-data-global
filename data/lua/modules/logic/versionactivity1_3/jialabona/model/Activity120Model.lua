module("modules.logic.versionactivity1_3.jialabona.model.Activity120Model", package.seeall)

local var_0_0 = class("Activity120Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curEpisodeId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curEpisodeId = 0
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._curActivityId
end

function var_0_0.onReceiveGetAct120InfoReply(arg_4_0, arg_4_1)
	arg_4_0._curActivityId = arg_4_1.activityId
	arg_4_0._episodeInfoData = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.episodes) do
		local var_4_0 = iter_4_1.id

		arg_4_0._episodeInfoData[var_4_0] = {}
		arg_4_0._episodeInfoData[var_4_0].id = iter_4_1.id
		arg_4_0._episodeInfoData[var_4_0].star = iter_4_1.star
		arg_4_0._episodeInfoData[var_4_0].totalCount = iter_4_1.totalCount
	end
end

function var_0_0.getEpisodeData(arg_5_0, arg_5_1)
	return arg_5_0._episodeInfoData and arg_5_0._episodeInfoData[arg_5_1]
end

function var_0_0.isEpisodeClear(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getEpisodeData(arg_6_1)

	if var_6_0 then
		return var_6_0.star > 0
	end

	return false
end

function var_0_0.getTaskData(arg_7_0, arg_7_1)
	return TaskModel.instance:getTaskById(arg_7_1)
end

function var_0_0.increaseCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._episodeInfoData and arg_8_0._episodeInfoData[arg_8_1]

	if var_8_0 then
		var_8_0.totalCount = var_8_0.totalCount + 1
	end
end

function var_0_0.setCurEpisodeId(arg_9_0, arg_9_1)
	arg_9_0._curEpisodeId = arg_9_1
end

function var_0_0.getCurEpisodeId(arg_10_0)
	return arg_10_0._curEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
