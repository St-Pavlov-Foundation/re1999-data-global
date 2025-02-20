module("modules.logic.fight.FightMsgMgr", package.seeall)

slot0 = class("FightMsgMgr")
slot1 = {}
slot2 = false
slot3 = {}
slot4 = {}

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

	if not uv1[slot0] then
		slot2 = {}
		uv1[slot0] = slot2
		slot2.index = 0
		slot2.list = {}
	end

	slot2.index = slot2.index + 1

	for slot8 = 1, #slot1 do
		if not slot1[slot8].isDone and not slot9.isLock then
			slot9:sendMsg(...)
		end
	end

	slot2.index = slot3 - 1

	if slot2.list[slot3] then
		slot2.list[slot3] = nil

		return slot5[1], slot5
	end
end

function slot0.replyMsg(slot0, slot1)
	if not uv0[slot0] then
		return
	end

	if not slot2.list[slot2.index] then
		slot2.list[slot2.index] = {}
	end

	table.insert(slot3, slot1)
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
