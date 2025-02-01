module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

slot0 = class("FightWorkComponent", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0._sequeueWork = {}
end

function slot0.registWork(slot0, slot1, ...)
	return slot0:registClass(slot1, ...)
end

function slot0.playWork(slot0, slot1, ...)
	return slot0:registClass(slot1, ...):start()
end

function slot0.playIdSequeueWork(slot0, slot1, slot2, ...)
	if not slot0._sequeueWork[slot1] then
		slot0._sequeueWork[slot1] = {}
	end

	slot4 = slot0:registClass(slot2, ...)

	slot4:registFinishCallback(slot0._onQueueWorkFinish, slot0, slot1)
	table.insert(slot3, slot4)

	if #slot3 == 1 then
		return slot4:start()
	end
end

function slot0._onQueueWorkFinish(slot0, slot1)
	if slot0._sequeueWork[slot1] then
		table.remove(slot2, 1)

		if slot2[1] then
			return slot3:start()
		end
	end
end

function slot0.onDestructor(slot0)
end

return slot0
