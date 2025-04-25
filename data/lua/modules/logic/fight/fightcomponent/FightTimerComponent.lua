module("modules.logic.fight.fightcomponent.FightTimerComponent", package.seeall)

slot0 = class("FightTimerComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._timerList = {}
end

function slot0.cancelTimer(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.isDone = true
end

function slot0.registRepeatTimer(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = FightTimer.registRepeatTimer(slot1, slot2, slot3, slot4, slot5)

	table.insert(slot0._timerList, slot6)

	return slot6
end

function slot0.restartRepeatTimer(slot0, slot1, slot2, slot3, slot4)
	return FightTimer.restartRepeatTimer(slot1, slot2, slot3, slot4)
end

function slot0.registSingleTimer(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 then
		if slot1.isDone then
			return slot0:registRepeatTimer(slot2, slot3, slot4, slot5, slot6)
		else
			slot1:restart(slot4, slot5, slot6)

			return slot1
		end
	else
		return slot0:registRepeatTimer(slot2, slot3, slot4, slot5, slot6)
	end
end

function slot0.releaseAllTimer(slot0)
	for slot4, slot5 in ipairs(slot0._timerList) do
		slot5.isDone = true
	end
end

function slot0.onDestructor(slot0)
	slot0:releaseAllTimer()
end

return slot0
