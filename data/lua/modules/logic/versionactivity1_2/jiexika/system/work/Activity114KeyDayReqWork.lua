module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayReqWork", package.seeall)

slot0 = class("Activity114KeyDayReqWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	Activity114Rpc.instance:keyDayRequest(Activity114Model.instance.id, slot0.onReply, slot0)
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	slot0:onDone(slot2 == 0)
end

return slot0
