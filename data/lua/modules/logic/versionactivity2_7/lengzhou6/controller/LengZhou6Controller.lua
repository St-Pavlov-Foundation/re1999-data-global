module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6Controller", package.seeall)

local var_0_0 = class("LengZhou6Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0.showEpisodeId = nil
end

function var_0_0.enterLevelView(arg_5_0, arg_5_1)
	LengZhou6Rpc.instance:sendGetAct190InfoRequest(arg_5_1)
end

function var_0_0.clickEpisode(arg_6_0, arg_6_1)
	local var_6_0 = LengZhou6Model.instance:getAct190Id()

	if not LengZhou6Model.instance:isAct190Open(true) then
		return
	end

	if not LengZhou6Model.instance:isUnlockEpisode(arg_6_1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	arg_6_0:dispatchEvent(LengZhou6Event.OnClickEpisode, var_6_0, arg_6_1)
end

function var_0_0.enterEpisode(arg_7_0, arg_7_1)
	LengZhou6Enum.enterGM = false

	local var_7_0 = LengZhou6Model.instance:getCurActId()

	if not var_7_0 or arg_7_1 == nil then
		return
	end

	local var_7_1 = LengZhou6Config.instance:getEpisodeConfig(var_7_0, arg_7_1)

	LengZhou6Model.instance:setCurEpisodeId(arg_7_1)

	local var_7_2 = var_7_1.storyBefore

	if var_7_2 ~= 0 then
		StoryController.instance:playStory(var_7_2, nil, arg_7_0._enterGame, arg_7_0)
	else
		arg_7_0:_enterGame()
	end
end

function var_0_0._enterGame(arg_8_0)
	local var_8_0 = LengZhou6Model.instance:getCurActId()
	local var_8_1 = LengZhou6Model.instance:getCurEpisodeId()

	if LengZhou6Config.instance:getEpisodeConfig(var_8_0, var_8_1).eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:enterLevel(var_8_0, var_8_1)
	else
		arg_8_0:finishLevel(var_8_1)
		arg_8_0:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	end
end

function var_0_0.restartGame(arg_9_0)
	local var_9_0 = LengZhou6Model.instance:getCurActId()
	local var_9_1 = LengZhou6Model.instance:getCurEpisodeId()

	if LengZhou6Config.instance:getEpisodeConfig(var_9_0, var_9_1).eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:restartLevel(var_9_0, var_9_1)
	end
end

function var_0_0.openLengZhou6LevelView(arg_10_0)
	arg_10_0.showEpisodeId = nil

	ViewMgr.instance:openView(ViewName.LengZhou6LevelView)
end

function var_0_0.finishLevel(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = LengZhou6Model.instance:getEpisodeInfoMo(arg_11_1)

	if var_11_0 ~= nil then
		LengZhou6Rpc.instance:sendAct190FinishEpisodeRequest(arg_11_1, arg_11_2)
	end

	if var_11_0 ~= nil and arg_11_2 ~= nil then
		var_11_0:setProgress(arg_11_2)
	end
end

function var_0_0.onFinishEpisode(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_1.activityId
	local var_12_1 = arg_12_1.episodeId

	arg_12_0.showEpisodeId = var_12_1

	LengZhou6Model.instance:onFinishActInfo(arg_12_1)

	if var_12_0 == LengZhou6Model.instance:getAct190Id() then
		arg_12_0:_playStoryClear(var_12_1)
	end
end

function var_0_0._playStoryClear(arg_13_0, arg_13_1)
	if not LengZhou6Model.instance:isFinishedEpisode(arg_13_1) then
		return
	end

	local var_13_0 = LengZhou6Model.instance:getCurActId()
	local var_13_1 = LengZhou6Model.instance:getCurEpisodeId()

	if var_13_0 == nil then
		return
	end

	local var_13_2 = 0

	if var_13_1 ~= nil then
		var_13_2 = LengZhou6Config.instance:getEpisodeConfig(var_13_0, var_13_1).storyClear
	end

	if var_13_2 ~= 0 then
		StoryController.instance:playStory(var_13_2, nil, arg_13_0.showFinishEffect, arg_13_0)
	else
		arg_13_0:showFinishEffect()
	end
end

function var_0_0.showFinishEffect(arg_14_0)
	arg_14_0:dispatchEvent(LengZhou6Event.OnFinishEpisode, arg_14_0.showEpisodeId)

	arg_14_0.showEpisodeId = nil
end

function var_0_0.openTaskView(arg_15_0)
	LengZhou6TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity190
	}, arg_15_0._realOpenTaskView, arg_15_0)
end

function var_0_0._realOpenTaskView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 ~= 0 then
		return
	end

	LengZhou6TaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.LengZhou6TaskView)
end

function var_0_0.isNeedForceDrop(arg_17_0)
	return GuideModel.instance:isGuideRunning(27201)
end

function var_0_0.getFixChessPos(arg_18_0)
	if GuideModel.instance:isGuideRunning(27202) then
		return true, {
			x = 2,
			y = 2
		}
	end

	return false, nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
