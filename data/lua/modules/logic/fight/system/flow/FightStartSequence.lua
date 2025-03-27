module("modules.logic.fight.system.flow.FightStartSequence", package.seeall)

slot0 = class("FightStartSequence", BaseFightSequence)

function slot0.buildFlow(slot0, slot1)
	uv0.super.buildFlow(slot0)

	slot0.startRoundMO = slot1

	slot0:_buildStartRoundSteps()
end

function slot0._buildStartRoundSteps(slot0)
	slot0:addWork(FightWorkDialogBeforeStartFight.New())
	slot0:addWork(FightWorkAppearPerformance.New())
	slot0:addWork(FightWorkDetectReplayEnterSceneActive.New())

	uv0.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, 1)

	if FightWorkFocusMonster.getFocusEntityId() or uv0.needStopMonsterWave then
		slot0:_buildFocusBorn()
	else
		slot0:_buildNormalBorn()
	end

	slot0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	slot0:addWork(FunctionWork.New(function ()
		FightRpc.instance:dealCardInfoPushData()
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightDataMgr.instance:afterPlayRoundProto(FightDataModel.instance.cacheRoundProto)
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightViewPartVisible.set(true, true, true, false, false)
	end))
end

function slot0._buildFocusBorn(slot0)
	if uv0.needStopMonsterWave then
		slot0:addWork(FunctionWork.New(function ()
			uv0:_setMonsterVisible(false)
		end))
	end

	slot0:addWork(FightWorkStartBorn.New())

	if uv0.needStopMonsterWave then
		slot0:addWork(FightWorkWaitDialog.New(1))
		slot0:addWork(FunctionWork.New(function ()
			uv0:_setMonsterVisible(true)
		end))
	end

	slot0:addWork(FightWorkFocusMonster.New())

	if FightModel.instance:getVersion() < 4 then
		slot0:addWork(FightWorkDistributeCard.New())
		slot0:addWork(FunctionWork.New(function ()
			FightController.instance:setCurStage(FightEnum.Stage.StartRound)
		end))
	end

	slot0:addWork(FunctionWork.New(slot0._dealStartBuff))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	if FightStepBuilder.buildStepWorkList(slot0.startRoundMO.fightStepMOs) then
		for slot6, slot7 in ipairs(slot2) do
			slot0:addWork(slot7)
		end
	end

	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))

	if FightController.instance:canOpenRoundView() then
		slot0:addWork(FightWorkBeforeStartNoticeView.New())
	end

	if slot0:_buildRoundViewWork() then
		slot0:addWork(slot3)
	end
end

function slot0._buildNormalBorn(slot0)
	slot1 = FlowParallel.New()

	slot1:addWork(FightWorkStartBorn.New())

	slot2 = FlowSequence.New()

	slot1:addWork(slot2)
	slot0:addWork(slot1)
	slot2:addWork(WorkWaitSeconds.New(1.4 / FightModel.instance:getSpeed()))

	if slot0:_buildRoundViewWork() then
		slot2:addWork(slot3)
		slot2:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getSpeed()))
	end

	if FightModel.instance:getVersion() < 4 then
		slot2:addWork(FightWorkDistributeCard.New())
		slot0:addWork(FunctionWork.New(function ()
			FightController.instance:setCurStage(FightEnum.Stage.StartRound)
		end))
	end

	slot0:addWork(FunctionWork.New(slot0._dealStartBuff))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	if FightStepBuilder.buildStepWorkList(slot0.startRoundMO and slot0.startRoundMO.fightStepMOs) then
		for slot9, slot10 in ipairs(slot5) do
			slot0:addWork(slot10)
		end
	end

	if FightController.instance:canOpenRoundView() then
		slot0:addWork(FightWorkBeforeStartNoticeView.New())
	end
end

function slot0._buildRoundViewWork(slot0)
	if FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		return FunctionWork.New(function ()
			FightController.instance:openRoundView()
		end)
	end
end

function slot0._dealStartBuff(slot0)
	for slot4, slot5 in ipairs(FightHelper.getAllEntitys()) do
		if slot5.buff then
			slot5.buff:dealStartBuff()
		end
	end
end

function slot0._setMonsterVisible(slot0, slot1)
	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)) do
		slot7:setActive(slot1)
	end
end

return slot0
