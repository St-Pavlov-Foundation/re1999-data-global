module("modules.logic.guide.controller.action.impl.GuideActionOpenHelpView", package.seeall)

slot0 = class("GuideActionOpenHelpView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	ViewMgr.instance:openView(ViewName.HelpView, {
		openFromGuide = true,
		guideId = slot0.guideId,
		stepId = slot0.stepId,
		viewParam = tonumber(slot0.actionParam),
		matchAllPage = true
	})
	slot0:onDone(true)
end

return slot0
