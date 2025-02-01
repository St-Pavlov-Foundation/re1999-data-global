module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ReqBaseWork", package.seeall)

slot0 = class("Activity114ReqBaseWork", Activity114BaseWork)

function slot0.onReply(slot0, slot1, slot2, slot3)
	slot0:onDone(slot2 == 0)
end

return slot0
