module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckWork", package.seeall)

slot0 = class("Activity114CheckWork", Activity114OpenViewWork)

function slot0.onStart(slot0, slot1)
	if slot0.context.eventCo.config.isCheckEvent == 1 or slot2.config.testId > 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		slot0._viewName = ViewName.Activity114EventSelectView

		uv0.super.onStart(slot0, slot1)
	elseif Activity114Model.instance.serverData.checkEventId > 0 then
		Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true, slot0.onCheckDone, slot0)
	else
		slot0.context.result = Activity114Enum.Result.Success

		slot0:onDone(true)
	end
end

function slot0.onCheckDone(slot0, slot1, slot2, slot3)
	slot0:onDone(slot2 == 0)
end

return slot0
