module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishAndInMainScene", package.seeall)

local var_0_0 = class("GuideTriggerEpisodeFinishAndInMainScene", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, arg_1_0._checkStartGuide, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._checkStartGuide, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_1_0._checkStartGuide, arg_1_0)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, arg_1_0._checkStartGuide, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenViewFinish, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2)
	local var_2_1 = OpenConfig.instance:getOpenCo(var_2_0)
	local var_2_2 = var_2_1 and var_2_1.episodeId or var_2_0
	local var_2_3 = DungeonModel.instance:getEpisodeInfo(var_2_2)
	local var_2_4 = DungeonConfig.instance:getEpisodeCO(var_2_2)

	if var_2_4 and var_2_3 and var_2_3.star > DungeonEnum.StarType.None then
		if not (var_2_4.afterStory <= 0 or var_2_4.afterStory > 0 and StoryModel.instance:isStoryFinished(var_2_4.afterStory)) then
			return false
		end
	else
		return false
	end

	local var_2_5 = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
	local var_2_6 = GameSceneMgr.instance:isLoading()
	local var_2_7 = GameSceneMgr.instance:isClosing()
	local var_2_8 = PatFaceModel.instance:getIsPatting()

	if var_2_5 and not var_2_6 and not var_2_7 and not var_2_8 then
		local var_2_9 = false
		local var_2_10 = ViewMgr.instance:getOpenViewNameList()

		for iter_2_0, iter_2_1 in ipairs(var_2_10) do
			if ViewMgr.instance:isModal(iter_2_1) or ViewMgr.instance:isFull(iter_2_1) then
				var_2_9 = true

				break
			end
		end

		if not var_2_9 then
			return true
		end
	end

	return false
end

function var_0_0._onOpenViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.MainView then
		arg_3_0:checkStartGuide()
	end
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	arg_4_0:checkStartGuide()
end

function var_0_0._checkStartGuide(arg_5_0)
	arg_5_0:checkStartGuide()
end

return var_0_0
