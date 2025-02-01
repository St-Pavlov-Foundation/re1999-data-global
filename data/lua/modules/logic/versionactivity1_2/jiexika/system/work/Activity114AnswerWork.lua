module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114AnswerWork", package.seeall)

slot0 = class("Activity114AnswerWork", Activity114OpenViewWork)

function slot0.onStart(slot0, slot1)
	if Activity114Model.instance.serverData.testEventId > 0 then
		slot0._viewName = ViewName.Activity114EventSelectView

		uv0.super.onStart(slot0, slot1)
	else
		slot0.context.result = Activity114Enum.Result.Success

		slot0:onDone(true)
	end
end

return slot0
