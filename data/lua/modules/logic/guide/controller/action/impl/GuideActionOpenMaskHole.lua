module("modules.logic.guide.controller.action.impl.GuideActionOpenMaskHole", package.seeall)

slot0 = class("GuideActionOpenMaskHole", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GuideViewMgr.instance:open(slot0.guideId, slot0.stepId)
	slot0:onDone(true)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	GuideViewMgr.instance:close()
end

return slot0
