module("modules.logic.guide.controller.action.impl.GuideActionCloseView", package.seeall)

slot0 = class("GuideActionCloseView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if string.nilorempty(slot0.actionParam) then
		ViewMgr.instance:closeAllModalViews()
	else
		for slot6, slot7 in ipairs(string.split(slot0.actionParam, "#")) do
			ViewMgr.instance:closeView(slot7, true)
		end
	end

	slot0:onDone(true)
end

return slot0
