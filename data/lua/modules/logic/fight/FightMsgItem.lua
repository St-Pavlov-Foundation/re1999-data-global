module("modules.logic.fight.FightMsgItem", package.seeall)

slot0 = class("FightMsgItem")

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.msgId = slot1
	slot0.callback = slot2
	slot0.handle = slot3
	slot0.msgName = FightMsgId.id2Name[slot1]
end

function slot0.sendMsg(slot0, ...)
	xpcall(slot0.callback, __G__TRACKBACK__, slot0.handle, ...)
end

return slot0
