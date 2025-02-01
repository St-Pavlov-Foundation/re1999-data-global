module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WeekEndWork", package.seeall)

slot0 = class("Activity114WeekEndWork", Activity114OpenViewWork)

function slot0.onStart(slot0, slot1)
	slot0._viewName = ViewName.Activity114ScoreReportView

	uv0.super.onStart(slot0, slot1)
end

return slot0
