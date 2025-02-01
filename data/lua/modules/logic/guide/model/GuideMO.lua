module("modules.logic.guide.model.GuideMO", package.seeall)

slot0 = pureTable("GuideMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.serverStepId = -1
	slot0.clientStepId = -1
	slot0.currGuideId = -1
	slot0.currStepId = -1
	slot0.isFinish = false
	slot0.isExceptionFinish = false
	slot0.isJumpPass = false
	slot0.targetStepId = nil
	slot0._againStepCOs = nil
end

function slot0.getCurStepCO(slot0)
	return GuideConfig.instance:getStepCO(slot0.currGuideId, slot0.currStepId)
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.guideId
	slot0.serverStepId = slot1.stepId or 0
	slot0.clientStepId = slot1.stepId or 0

	slot0:_setCurrStep()

	slot0.isFinish = slot0.serverStepId == -1

	if GuideConfig.instance:getStepCO(slot0.id, slot0.currStepId) ~= nil and string.nilorempty(slot2.againSteps) == false then
		slot0._againStepCOs = {}
		slot7 = "#"

		for slot7, slot8 in ipairs(GameUtil.splitString2(slot2.againSteps, true, "|", slot7)) do
			if GuideConfig.instance:getStepCO(#slot8 == 1 and slot0.id or slot8[1], #slot8 == 1 and slot8[1] or slot8[2]) then
				table.insert(slot0._againStepCOs, slot11)
			else
				logError("againSteps invalid: guide_" .. slot0.id .. "_" .. slot2.stepId)
			end
		end

		if #slot0._againStepCOs > 0 then
			slot0.currGuideId = slot0._againStepCOs[1].id
			slot0.currStepId = slot0._againStepCOs[1].stepId

			table.remove(slot0._againStepCOs, 1)
		end
	end
end

function slot0.exceptionFinishGuide(slot0)
	slot0.serverStepId = -1
	slot0.clientStepId = -1
	slot0.currGuideId = -1
	slot0.currStepId = -1
	slot0.isFinish = true
	slot0.isExceptionFinish = true
end

function slot0.updateGuide(slot0, slot1)
	slot0._againStepCOs = nil
	slot0.id = slot1.guideId
	slot0.serverStepId = slot1.stepId

	if slot0.targetStepId then
		slot0.clientStepId = GuideConfig.instance:getPrevStepId(slot0.id, slot0.targetStepId)
		slot0.targetStepId = nil
	elseif slot0.isJumpPass then
		slot0.clientStepId = -1
	elseif slot1.stepId ~= -1 then
		slot0.clientStepId = slot1.stepId
	else
		slot2 = -1
		slot3 = GuideConfig.instance:getStepList(slot0.id)

		if slot3[#slot3].keyStep ~= 1 then
			for slot7 = #slot3 - 1, 1, -1 do
				if slot3[slot7].keyStep == 1 then
					slot2 = slot8.stepId

					break
				end
			end
		end

		slot0.clientStepId = slot2
	end

	slot0:_setCurrStep()

	slot0.isFinish = slot0.serverStepId == -1
end

function slot0.setClientStep(slot0, slot1)
	if (slot0._againStepCOs and #slot0._againStepCOs or 0) == 0 and slot1 < slot0.serverStepId then
		slot0.clientStepId = slot0.serverStepId
	else
		slot0.clientStepId = slot1

		if GuideConfig.instance:getStepList(slot0.id) and slot3[#slot3] and slot0.clientStepId == slot4.stepId then
			slot0.clientStepId = -1
		end
	end

	slot0:_setCurrStep()
end

function slot0.gotoStep(slot0, slot1)
	slot0._againStepCOs = nil
	slot0.clientStepId = GuideConfig.instance:getPrevStepId(slot0.id, slot1)

	slot0:_setCurrStep()
end

function slot0.toGotoStep(slot0, slot1)
	slot0._againStepCOs = nil
	slot0.targetStepId = slot1
end

function slot0._setCurrStep(slot0)
	slot1 = GuideConfig.instance:getStepList(slot0.id)
	slot0.currGuideId = -1
	slot0.currStepId = -1

	if slot0._againStepCOs and #slot0._againStepCOs > 0 then
		slot0.currGuideId = slot0._againStepCOs[1].id
		slot0.currStepId = slot0._againStepCOs[1].stepId

		table.remove(slot0._againStepCOs, 1)
	elseif slot0.clientStepId == 0 then
		slot0.currGuideId = slot0.id
		slot0.currStepId = slot1[1].stepId
	elseif slot0.clientStepId > 0 then
		slot0.currGuideId = slot0.id
		slot0.currStepId = GuideConfig.instance:getNextStepId(slot0.id, slot0.clientStepId)
	end
end

return slot0
