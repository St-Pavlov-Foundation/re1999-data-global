module("modules.logic.guide.controller.action.impl.GuideActionLockGuide", package.seeall)

slot0 = class("GuideActionLockGuide", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if not (string.splitToNumber(slot0.actionParam, "#")[1] == 0) then
		GuideModel.instance:setLockGuide(slot0.guideId, slot2[2] == 1)
	else
		GuideModel.instance:setLockGuide(nil, slot4)
	end

	slot0:onDone(true)
end

return slot0
