module("modules.logic.fight.system.work.trigger.FightWorkTriggerDialog", package.seeall)

slot0 = class("FightWorkTriggerDialog", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	if FightReplayModel.instance:isReplay() then
		slot0:onDone(true)

		return
	end

	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]

	if slot0._config and lua_battle_dialog.configDict[tonumber(slot0._config.param1)] and lua_battle_dialog.configDict[slot1][tonumber(slot0._config.param2)] then
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.Trigger, slot3)

		slot0._dialogWork = FightWorkWaitDialog.New()

		slot0._dialogWork:registerDoneListener(slot0._onFightDialogEnd, slot0)
		slot0._dialogWork:onStart()

		return
	end

	slot0:onDone(true)
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)

	if slot0._dialogWork then
		slot0._dialogWork:unregisterDoneListener(slot0._onFightDialogEnd, slot0)

		slot0._dialogWork = nil
	end
end

return slot0
