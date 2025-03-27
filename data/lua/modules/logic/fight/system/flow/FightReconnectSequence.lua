module("modules.logic.fight.system.flow.FightReconnectSequence", package.seeall)

slot0 = class("FightReconnectSequence", BaseFightSequence)

function slot0.buildFlow(slot0, slot1)
	uv0.super.buildFlow(slot0)
	slot0:addWork(FunctionWork.New(function ()
		FightRpc.instance:dealCardInfoPushData()
	end))
	slot0:addWork(FightWorkDetectReplayEnterSceneActive.New())
	slot0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	slot0:addWork(WorkWaitSeconds.New(0.5))
	slot0:addWork(FightWorkFocusMonster.New())
	slot0:addWork(FunctionWork.New(function ()
		for slot3, slot4 in ipairs(FightHelper.getAllEntitys()) do
			if slot4.buff then
				slot4.buff:dealStartBuff()
			end
		end
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	if FightStepBuilder.buildStepWorkList(slot1.fightStepMOs) then
		for slot6, slot7 in ipairs(slot2) do
			slot0:addWork(slot7)
		end
	end

	slot0:addWork(FunctionWork.New(function ()
		FightDataMgr.instance:afterPlayRoundProto(FightDataModel.instance.cacheRoundProto)
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.OnFightReconnectLastWork)
	end))
end

return slot0
