module("modules.logic.fight.system.flow.FightEndSequence", package.seeall)

slot0 = class("FightEndSequence", BaseFightSequence)

function slot0.buildFlow(slot0, slot1)
	uv0.super.buildFlow(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.StartFightEnd)
	FightController.instance:dispatchEvent(FightEvent.SwitchFightendBgm)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_fightingsfx)

	if FightModel.instance:getRecordMO().fightResult == FightEnum.FightResult.Succ then
		slot0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.Success, FightDataHelper.fieldMgr.battleId))
		slot0:_addDialogView()
		slot0:_addCloseFightView()
		slot0:addWork(FightWorkEndVictory.New())
		slot0:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	else
		slot0:addWork(FunctionWork.New(function ()
			FightViewPartVisible.set()
			FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		end))
		slot0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.FightFail))
		slot0:_addCloseFightView()
		slot0:addWork(FightWorkEndLose.New())
	end

	slot0:addWork(FightWorkEndGuide.New())
	slot0:addWork(FunctionWork.New(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end))
	slot0:addWork(FightWorkEndGC.New())
	slot0:addWork(FightWorkEndResultViewShow.New())
	slot0:addWork(FightWorkSeasonPopupAndStory.New())
	slot0:addWork(FightWorkWeekWalkRevive.New())
	slot0:addWork(FightWorkAct114RoundEndStory.New())
	slot0:addWork(FightWorkCachotResult.New())
	slot0:addWork(FightWorkCachotStory.New())
	slot0:addWork(FightWorkCachotEnding.New())
	slot0:addWork(FightWorkAct183Repress.New())
	slot0:addWork(FightWorkAct183Ending.New())
	slot0:addWork(FightWorkOpenLoadingBlackView.New())
	slot0:addWork(FunctionWork.New(function ()
		FightSystem.instance:dispose()
		FightController.instance:exitFightScene()
		FightModel.instance:clearRecordMO()
	end))
end

function slot0._addDialogView(slot0)
	slot1 = FightModel.instance:getCurWaveId()
	uv0.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, slot1)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, slot1)

	if uv0.needStopMonsterWave then
		slot0:addWork(FightWorkWaitDialog.New())
	end
end

function slot0._addCloseFightView(slot0)
	slot0:addWork(FunctionWork.New(function ()
		ViewMgr.instance:closeView(ViewName.FightView)
	end))
end

return slot0
