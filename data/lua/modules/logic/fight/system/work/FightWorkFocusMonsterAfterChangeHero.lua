module("modules.logic.fight.system.work.FightWorkFocusMonsterAfterChangeHero", package.seeall)

slot0 = class("FightWorkFocusMonsterAfterChangeHero", FightWorkItem)

function slot0.onConstructor(slot0)
	slot0._counter = 0
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	slot1, slot2 = FightWorkFocusMonster.getFocusEntityId()

	if slot1 and slot0._counter < 5 then
		slot0._counter = slot0._counter + 1
		slot3 = slot0:com_registFlowSequence()

		slot3:addWork(Work2FightWork.New(FightWorkFocusMonster))
		slot3:registFinishCallback(slot0.onStart, slot0)
		slot3:start()
	else
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
end

return slot0
