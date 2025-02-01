module("modules.logic.guide.controller.action.impl.GuideActionEnableClick", package.seeall)

slot0 = class("GuideActionEnableClick", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._isEnable = slot3 == "1"
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GuideViewMgr.instance:enableClick(slot0._isEnable)
	slot0:onDone(true)
end

return slot0
