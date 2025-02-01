module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenAttrViewWork", package.seeall)

slot0 = class("Activity114OpenAttrViewWork", Activity114OpenViewWork)

function slot0.onStart(slot0, slot1)
	if not Activity114Helper.haveAttrOrFeatureChange(slot0.context) then
		slot0:onDone(true)

		return
	end

	slot0._viewName = ViewName.Activity114FinishEventView

	uv0.super.onStart(slot0, slot1)
end

return slot0
