module("modules.logic.fight.FightMsgMgr", package.seeall)

slot0 = class("FightMsgMgr")
slot1 = {}
slot2 = false
slot3 = {}
slot4 = {}
slot5 = {}

function slot0.registMsg(slot0, slot1, slot2)
	if not uv0[slot0] then
		uv0[slot0] = {}
	end

	slot4 = FightMsgItem.New(slot0, slot1, slot2)

	table.insert(slot3, slot4)

	return slot4
end

function slot0.sendMsg(slot0, ...)
	if not uv0[slot0] then
		return
	end

	uv1[slot0] = (uv1[slot0] or 0) + 1

	for slot7 = 1, #slot1 do
		if not slot1[slot7].isDone and not slot8.isLock then
			slot8:sendMsg(...)
		end
	end

	uv1[slot0] = slot2 - 1

	if uv2[slot0] and slot4.list[slot2] then
		slot4.list[slot2] = nil

		return slot5[1], slot5
	end
end

function slot0.replyMsg(slot0, slot1)
	if (uv0[slot0] or 0) == 0 then
		return
	end

	if not uv1[slot0] then
		slot3 = {}
		uv1[slot0] = slot3
		slot3.list = {}
	end

	if not slot3.list[slot2] then
		slot3.list[slot2] = {}
	end

	table.insert(slot4, slot1)
end

function slot0.removeMsg(slot0)
	if not slot0 then
		return
	end

	slot0.isDone = true
	uv0[slot0.msgId] = true
	uv1 = true
end

function slot0.lockItem(slot0)
	if not slot0 then
		return
	end

	slot0.isLock = true
end

function slot0.unlockItem(slot0)
	if not slot0 then
		return
	end

	slot0.isLock = false
end

function slot0.clearMsg()
	if not uv0 then
		return
	end

	for slot3, slot4 in pairs(uv1) do
		if uv2[slot3] then
			for slot9 = #slot5, 1, -1 do
				if slot5[slot9].isDone then
					table.remove(slot5, slot9)
				end
			end

			if #slot5 == 0 then
				uv2[slot3] = nil
				uv3[slot3] = nil
			end
		end

		uv1[slot3] = nil
	end

	uv0 = false
end

FightTimer.registRepeatTimer(slot0.clearMsg, slot0, 10, -1)

return slot0
