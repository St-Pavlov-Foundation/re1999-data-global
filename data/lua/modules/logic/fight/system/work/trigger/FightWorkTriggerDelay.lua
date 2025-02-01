module("modules.logic.fight.system.work.trigger.FightWorkTriggerDelay", package.seeall)

slot0 = class("FightWorkTriggerDelay", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]

	if slot0._config then
		slot0._startTime = ServerTime.now()
		slot0._delayTime = slot0._config.param1 / 1000

		FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
		TaskDispatcher.runDelay(slot0._delay, slot0, slot0._delayTime / FightModel.instance:getSpeed())
	else
		slot0:onDone(true)
	end
end

function slot0._onUpdateSpeed(slot0)
	TaskDispatcher.runDelay(slot0._delay, slot0, (slot0._delayTime - (ServerTime.now() - slot0._startTime)) / FightModel.instance:getSpeed())
end

function slot0._delay(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	TaskDispatcher.cancelTask(slot0._delay, slot0)
end

return slot0
