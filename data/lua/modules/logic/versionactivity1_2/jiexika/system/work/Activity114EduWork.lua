module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114EduWork", package.seeall)

slot0 = class("Activity114EduWork", Activity114ReqBaseWork)

function slot0.onStart(slot0, slot1)
	Activity114Rpc.instance:eduRequest(Activity114Model.instance.id, tonumber(slot0.context.eventCo.config.param), slot0.onReply, slot0)
end

return slot0
