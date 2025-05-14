module("modules.logic.versionactivity2_1.lanshoupa.model.Activity164Model", package.seeall)

local var_0_0 = class("Activity164Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._passEpisodes = {}
	arg_1_0._unLockCount = 0
	arg_1_0._curActivityId = 0
	arg_1_0.currChessGameEpisodeId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._passEpisodes = {}
	arg_2_0._unLockCount = 0
	arg_2_0._curActivityId = 0
	arg_2_0.currChessGameEpisodeId = 0
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._curActivityId
end

function var_0_0.onReceiveGetAct164InfoReply(arg_4_0, arg_4_1)
	arg_4_0._curActivityId = arg_4_1.activityId
	arg_4_0._passEpisodes = {}
	arg_4_0._unLockCount = 0
	arg_4_0.currChessGameEpisodeId = arg_4_1.currChessGameEpisodeId

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.episodes) do
		local var_4_0 = iter_4_1.episodeId
		local var_4_1 = Activity164Config.instance:getEpisodeCo(arg_4_1.activityId, var_4_0)

		if var_4_1 and var_4_1.mapIds <= 0 then
			arg_4_0._passEpisodes[var_4_0] = StoryModel.instance:isStoryFinished(var_4_1.storyBefore)
		else
			arg_4_0._passEpisodes[var_4_0] = iter_4_1.passChessGame
		end

		if arg_4_0._passEpisodes[var_4_0] then
			arg_4_0._unLockCount = arg_4_0._unLockCount + 1
		else
			break
		end
	end
end

function var_0_0.markEpisodeFinish(arg_5_0, arg_5_1)
	if not arg_5_0._passEpisodes[arg_5_1] then
		arg_5_0._passEpisodes[arg_5_1] = true
		arg_5_0._unLockCount = arg_5_0._unLockCount + 1

		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.OnEpisodeFinish, arg_5_0._episodeId)
	end
end

function var_0_0.getUnlockCount(arg_6_0)
	return arg_6_0._unLockCount
end

function var_0_0.getEpisodeData(arg_7_0, arg_7_1)
	return arg_7_0._passEpisodes[arg_7_1]
end

function var_0_0.isEpisodeClear(arg_8_0, arg_8_1)
	if arg_8_0:getEpisodeData(arg_8_1) then
		return true
	end

	return false
end

function var_0_0.setCurEpisodeId(arg_9_0, arg_9_1)
	arg_9_0._curEpisodeId = arg_9_1
end

function var_0_0.getCurEpisodeId(arg_10_0)
	return arg_10_0._curEpisodeId or LanShouPaEnum.episodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
