module("modules.logic.fight.system.flow.FightEndSequence", package.seeall)

local var_0_0 = class("FightEndSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.StartFightEnd)
	FightController.instance:dispatchEvent(FightEvent.SwitchFightendBgm)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_fightingsfx)

	if FightModel.instance:getRecordMO().fightResult == FightEnum.FightResult.Succ then
		arg_1_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.Success, FightDataHelper.fieldMgr.battleId))
		arg_1_0:_addDialogView()
		arg_1_0:_addCloseFightView()
		arg_1_0:addWork(FightWorkEndVictory.New())
		arg_1_0:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	else
		arg_1_0:addWork(FunctionWork.New(function()
			FightViewPartVisible.set()
			FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		end))
		arg_1_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.FightFail))
		arg_1_0:_addCloseFightView()
		arg_1_0:addWork(FightWorkEndLose.New())
	end

	arg_1_0:addWork(FightWorkEndGuide.New())
	arg_1_0:addWork(FunctionWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end))
	arg_1_0:addWork(FightWorkEndGC.New())
	arg_1_0:addWork(FightWorkEndResultViewShow.New())
	arg_1_0:addWork(FightWorkSeasonPopupAndStory.New())
	arg_1_0:addWork(FightWorkWeekWalkRevive.New())
	arg_1_0:addWork(FightWorkAct114RoundEndStory.New())
	arg_1_0:addWork(FightWorkCachotResult.New())
	arg_1_0:addWork(FightWorkCachotStory.New())
	arg_1_0:addWork(FightWorkCachotEnding.New())
	arg_1_0:addWork(FightWorkAct183Repress.New())
	arg_1_0:addWork(FightWorkAct183Ending.New())
	arg_1_0:addWork(FightWorkOpenLoadingBlackView.New())
	arg_1_0:addWork(FunctionWork.New(function()
		FightSystem.instance:dispose()
		FightController.instance:exitFightScene()
		FightModel.instance:clearRecordMO()
	end))
end

function var_0_0._addDialogView(arg_5_0)
	local var_5_0 = FightModel.instance:getCurWaveId()

	var_0_0.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, var_5_0)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, var_5_0)

	if var_0_0.needStopMonsterWave then
		arg_5_0:addWork(FightWorkWaitDialog.New())
	end
end

function var_0_0._addCloseFightView(arg_6_0)
	arg_6_0:addWork(FunctionWork.New(function()
		ViewMgr.instance:closeView(ViewName.FightView)
	end))
end

return var_0_0
