module("modules.logic.guide.controller.action.impl.WaitGuideActionClickAnywhere", package.seeall)

slot0 = class("WaitGuideActionClickAnywhere", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GuideViewMgr.instance:setHoleClickCallback(slot0._onClickTarget, slot0)
	GuideViewMgr.instance:enableSpaceBtn(true)
end

function slot0.clearWork(slot0)
	GuideViewMgr.instance:setHoleClickCallback(nil, )
	GuideViewMgr.instance:enableSpaceBtn(false)
	TaskDispatcher.cancelTask(slot0._delayCheckPressingState, slot0)
end

function slot0._onClickTarget(slot0, slot1)
	slot0:onDone(true)
end

return slot0
