module("modules.logic.guide.controller.action.impl.GuideActionAppendStep", package.seeall)

slot0 = class("GuideActionAppendStep", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot3 = string.split(slot0.actionParam, "#")

	for slot11, slot12 in ipairs(string.split(slot3[2], "_")) do
		GuideStepController.instance:getActionBuilder():addActionToFlow(GuideStepController.instance:getActionFlow(slot0.guideId), tonumber(slot3[1]), tonumber(slot12), true)
	end

	slot0:onDone(true)
end

return slot0
