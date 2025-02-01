module("modules.logic.guide.controller.action.impl.WaitGuideActionClickMask", package.seeall)

slot0 = class("WaitGuideActionClickMask", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._beforeClickWaitSecond = #string.split(slot3, "#") >= 1 and tonumber(slot4[1]) or 0
	slot0._afterClickWaitSecond = #slot4 >= 2 and tonumber(slot4[2]) or 0
	slot0._isForceGuide = GuideConfig.instance:getStepCO(slot1, slot2).notForce == 0
	slot0._alpha = nil

	if #slot4 >= 3 then
		slot0._alpha = tonumber(slot4[3])
	end

	slot0._goPath = GuideModel.instance:getStepGOPath(slot1, slot2)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._beforeClickWaitSecond > 0 then
		GuideViewMgr.instance:disableHoleClick()
		TaskDispatcher.runDelay(slot0._onDelayStart, slot0, slot0._beforeClickWaitSecond)
	else
		slot0:_onDelayStart()
	end
end

function slot0.clearWork(slot0)
	GuideViewMgr.instance:setHoleClickCallback(nil, )
	TaskDispatcher.cancelTask(slot0._onDelayStart, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayDone, slot0)
end

function slot0._onClickTarget(slot0, slot1)
	if slot1 or not slot0._isForceGuide then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, )

		slot0._isInside = slot1

		TaskDispatcher.runDelay(slot0._onDelayDone, slot0, slot0._afterClickWaitSecond + 0.01)
	end
end

function slot0._onDelayStart(slot0)
	if slot0._alpha or slot0._isForceGuide == false and 0 or nil then
		GuideViewMgr.instance:setMaskAlpha(slot1)
	end

	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(slot0._onClickTarget, slot0)
end

function slot0._onDelayDone(slot0)
	if slot0._isInside then
		slot0:onDone(true)
	elseif not slot0._isForceGuide then
		GuideController.instance:oneKeyFinishGuide(slot0.guideId, false)
	end
end

return slot0
