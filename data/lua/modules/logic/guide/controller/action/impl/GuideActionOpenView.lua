module("modules.logic.guide.controller.action.impl.GuideActionOpenView", package.seeall)

slot0 = class("GuideActionOpenView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")

	ViewMgr.instance:openView(slot2[1], {
		openFromGuide = true,
		guideId = slot0.guideId,
		stepId = slot0.stepId,
		viewParam = not string.nilorempty(slot2[2]) and cjson.decode(slot2[2]) or nil
	}, true)
	slot0:onDone(true)
end

return slot0
