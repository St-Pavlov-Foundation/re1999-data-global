module("modules.logic.fight.system.work.FightWorkTrigger", package.seeall)

slot0 = class("FightWorkTrigger", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO.effectNum

	if slot0._actEffectMO.configEffect == -1 and slot1 == 4150002 then
		slot2 = false

		if slot0._fightStepMO.actEffectMOs then
			slot3 = false

			for slot7, slot8 in ipairs(slot0._fightStepMO.actEffectMOs) do
				if slot8 == slot0._actEffectMO then
					slot3 = slot7
					slot2 = true
				end
			end

			for slot7 = slot3 + 1, #slot0._fightStepMO.actEffectMOs do
				if slot0._fightStepMO.actEffectMOs[slot7].effectType == FightEnum.EffectType.TRIGGER and slot8.configEffect == -1 and slot8.effectNum == 4150002 then
					slot2 = false
				end
			end
		end

		if slot2 then
			slot0:cancelFightWorkSafeTimer()
			slot0:com_registTimer(slot0._yuranDelayDone, 0.3)
		else
			slot0:onDone(true)
		end

		return
	end

	if lua_trigger_action.configDict[slot1] then
		if _G["FightWorkTrigger" .. slot2.actionType] then
			slot0:cancelFightWorkSafeTimer()

			slot0._work = slot3.New(slot0._fightStepMO, slot0._actEffectMO)

			slot0._work:registerDoneListener(slot0._onWorkDone, slot0)
			slot0._work:onStart(slot0.context)
		else
			slot0:onDone(true)
		end
	else
		logError("触发器行为表找不到id:" .. slot1)
		slot0:onDone(true)
	end
end

function slot0._yuranDelayDone(slot0)
	slot0:onDone(true)
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._work then
		slot0._work:unregisterDoneListener(slot0._onWorkDone, slot0)
		slot0._work:onStop()

		slot0._work = nil
	end
end

return slot0
