module("modules.logic.guide.controller.action.impl.GuideActionEmptyStep", package.seeall)

slot0 = class("GuideActionEmptyStep", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	slot0:onDone(true)
end

return slot0
