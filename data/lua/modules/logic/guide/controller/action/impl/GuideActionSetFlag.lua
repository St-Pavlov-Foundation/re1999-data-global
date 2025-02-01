module("modules.logic.guide.controller.action.impl.GuideActionSetFlag", package.seeall)

slot0 = class("GuideActionSetFlag", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")

	if slot2[2] == "1" then
		GuideModel.instance:setFlag(tonumber(slot2[1]), slot2[3] or true, slot0.guideId)
	else
		GuideModel.instance:setFlag(slot3, nil, slot0.guideId)
	end

	slot0:onDone(true)
end

return slot0
