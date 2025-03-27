module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

slot0 = class("FightWorkComponent", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0.workList = {}
end

function slot0.registWork(slot0, slot1, ...)
	slot2 = slot0:registClass(slot1, ...)

	table.insert(slot0.workList, slot2)

	return slot2
end

function slot0.playWork(slot0, slot1, ...)
	slot2 = slot0:registClass(slot1, ...)

	table.insert(slot0.workList, slot2)

	return slot2:start()
end

function slot0.getWorkList(slot0)
	return slot0.workList
end

function slot0.getAliveWorkList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.workList) do
		if not slot6.WORKFINISHED then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.onDestructor(slot0)
end

return slot0
