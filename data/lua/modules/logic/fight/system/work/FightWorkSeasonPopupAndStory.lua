module("modules.logic.fight.system.work.FightWorkSeasonPopupAndStory", package.seeall)

local var_0_0 = class("FightWorkSeasonPopupAndStory", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_1_0 and var_1_0.type == DungeonEnum.EpisodeType.Season then
		if PopupController.instance:getPopupCount() > 0 then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
		else
			arg_1_0:_checkStory()
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0)
	if PopupController.instance:getPopupCount() == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
		arg_2_0:_checkStory()
	end
end

function var_0_0._checkStory(arg_3_0)
	local var_3_0 = FightModel.instance:getAfterStory()

	if var_3_0 > 0 and not StoryModel.instance:isStoryFinished(var_3_0) then
		local var_3_1 = {}

		var_3_1.mark = true
		var_3_1.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_3_0, var_3_1, arg_3_0._storyEnd, arg_3_0)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._storyEnd(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
end

return var_0_0
