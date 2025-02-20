module("modules.logic.guide.controller.action.impl.GuideActionAppendStep", package.seeall)

slot0 = class("GuideActionAppendStep", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot3 = string.split(slot0.actionParam, "#")
	slot6 = GuideStepController.instance:getActionFlow(slot0.sourceGuideId or slot0.guideId)

	for slot11, slot12 in ipairs(string.split(slot3[2], "_")) do
		GuideStepController.instance:getActionBuilder():addActionToFlow(slot6, tonumber(slot3[1]), tonumber(slot12), true)
	end

	if slot6 and slot6:getWorkList() then
		for slot12, slot13 in pairs(slot8) do
			slot13.sourceGuideId = slot2
		end
	end

	slot0:onDone(true)
end

return slot0
