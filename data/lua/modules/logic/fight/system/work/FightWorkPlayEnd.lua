module("modules.logic.fight.system.work.FightWorkPlayEnd", package.seeall)

local var_0_0 = class("FightWorkPlayEnd", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registFlowSequence()

	FightController.instance:dispatchEvent(FightEvent.StartFightEnd)
	FightController.instance:dispatchEvent(FightEvent.SwitchFightendBgm)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_fightingsfx)

	if FightModel.instance:getRecordMO().fightResult == FightEnum.FightResult.Succ then
		var_1_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.Success, FightDataHelper.fieldMgr.battleId))
		arg_1_0:_addDialogView(var_1_0)
		arg_1_0:_addCloseFightView(var_1_0)
		var_1_0:addWork(FightWorkEndVictory.New())
		var_1_0:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	else
		var_1_0:addWork(FunctionWork.New(function()
			FightViewPartVisible.set()
			FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		end))
		var_1_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.FightFail))
		arg_1_0:_addCloseFightView(var_1_0)
		var_1_0:addWork(FightWorkEndLose.New())
	end

	var_1_0:addWork(FightWorkEndGuide.New())
	var_1_0:addWork(FunctionWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end))
	var_1_0:addWork(FightWorkEndGC.New())

	if FightWorkDirectStartNewFightAfterEndFight.directStartNewFight(FightDataHelper.fieldMgr.episodeId) then
		var_1_0:registWork(FightWorkFunction, FightGameMgr.restartMgr.directStartNewFight, FightGameMgr.restartMgr)
		arg_1_0:playWorkAndDone(var_1_0, {})

		return
	end

	var_1_0:addWork(FightWorkEndResultViewShow.New())
	var_1_0:addWork(FightWorkSeasonPopupAndStory.New())
	var_1_0:addWork(FightWorkWeekWalkRevive.New())
	var_1_0:addWork(FightWorkAct114RoundEndStory.New())
	var_1_0:addWork(FightWorkCachotResult.New())
	var_1_0:addWork(FightWorkCachotStory.New())
	var_1_0:addWork(FightWorkCachotEnding.New())
	var_1_0:addWork(FightWorkAct183Repress.New())
	var_1_0:addWork(FightWorkAct183Ending.New())
	var_1_0:addWork(FightWorkOpenLoadingBlackView.New())
	var_1_0:registFinishCallback(arg_1_0.onFlowFinish, arg_1_0)

	var_1_0.CALLBACK_EVEN_IF_UNFINISHED = true

	arg_1_0:playWorkAndDone(var_1_0, {})
end

function var_0_0.onFlowFinish(arg_4_0)
	DungeonMainStoryModel.instance:saveBattleChapterId(DungeonModel.instance.curSendEpisodeId)
	FightSystem.instance:dispose()
	FightController.instance:exitFightScene()
	FightModel.instance:clearRecordMO()
end

function var_0_0._addDialogView(arg_5_0, arg_5_1)
	local var_5_0 = FightModel.instance:getCurWaveId()

	var_0_0.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, var_5_0)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, var_5_0)

	if var_0_0.needStopMonsterWave then
		arg_5_1:addWork(FightWorkWaitDialog.New())
	end
end

function var_0_0._addCloseFightView(arg_6_0, arg_6_1)
	arg_6_1:addWork(FunctionWork.New(function()
		ViewMgr.instance:closeView(ViewName.FightView)
	end))
end

function var_0_0.replaceEndCallback(arg_8_0, arg_8_1)
	arg_8_0._callback = arg_8_1
end

return var_0_0
