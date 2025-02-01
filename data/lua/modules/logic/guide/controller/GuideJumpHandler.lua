module("modules.logic.guide.controller.GuideJumpHandler", package.seeall)

slot0 = class("GuideJumpHandler")
slot1 = {
	"113#OnGuideFightEndContinue",
	"116#"
}

function slot0.ctor(slot0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, slot0._onOneKeyFinishGuides, slot0)
end

function slot0.reInit(slot0)
end

function slot0._onOneKeyFinishGuides(slot0, slot1)
	slot0._guideSteps = {}

	for slot5, slot6 in ipairs(slot1) do
		slot9 = GuideConfig.instance:getNextStepId(slot6, GuideModel.instance:getById(slot6).currStepId)

		while slot9 > 0 do
			for slot15 = 1, #string.split(GuideConfig.instance:getStepCO(slot6, slot9).action, "|") do
				slot16 = slot11[slot15]

				for slot20, slot21 in ipairs(uv0) do
					if string.find(slot16, slot21) == 1 then
						if GuideActionBuilder.buildAction(slot6, slot8, slot16) then
							slot22:onStart()
							slot22:clearWork()
							logError("跳过指引，执行必要的收尾动作 guide_" .. slot6 .. "_" .. slot9 .. " " .. slot16)
						end

						break
					end
				end
			end

			slot9 = GuideConfig.instance:getNextStepId(slot6, slot9)
		end
	end
end

return slot0
