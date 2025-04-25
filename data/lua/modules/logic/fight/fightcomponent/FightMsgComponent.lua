module("modules.logic.fight.fightcomponent.FightMsgComponent", package.seeall)

slot0 = class("FightMsgComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._msgItems = {}
end

function slot0.registMsg(slot0, slot1, slot2, slot3)
	table.insert(slot0._msgItems, FightMsgMgr.registMsg(slot1, slot2, slot3))

	if slot0._lock then
		FightMsgMgr.lockItem(slot4)
	end

	return slot4
end

function slot0.removeMsg(slot0, slot1)
	FightMsgMgr.removeMsg(slot1)
end

function slot0.sendMsg(slot0, slot1, ...)
	return FightMsgMgr.sendMsg(slot1, ...)
end

function slot0.replyMsg(slot0, slot1, slot2)
	FightMsgMgr.replyMsg(slot1, slot2)
end

function slot0.lockMsg(slot0)
	slot0._lock = true

	for slot4, slot5 in ipairs(slot0._msgItems) do
		FightMsgMgr.lockItem(slot5)
	end
end

function slot0.unlockMsg(slot0)
	slot0._lock = false

	for slot4, slot5 in ipairs(slot0._msgItems) do
		FightMsgMgr.unlockItem(slot5)
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0._msgItems, 1, -1 do
		FightMsgMgr.removeMsg(slot0._msgItems[slot4])
	end
end

return slot0
