module("modules.logic.fight.system.work.trigger.FightWorkTriggerPrompt", package.seeall)

slot0 = class("FightWorkTriggerPrompt", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]

	if slot0._config then
		FightController.instance:dispatchEvent(FightEvent.ShowFightPrompt, tonumber(slot0._config.param1), tonumber(slot0._config.param2))
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
