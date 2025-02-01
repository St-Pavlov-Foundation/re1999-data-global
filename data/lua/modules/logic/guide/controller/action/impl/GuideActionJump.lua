module("modules.logic.guide.controller.action.impl.GuideActionJump", package.seeall)

slot0 = class("GuideActionJump", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	JumpController.instance:jumpByParam(slot0.actionParam)
	slot0:onDone(true)
end

return slot0
