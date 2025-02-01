module("modules.logic.guide.config.GuideConfig", package.seeall)

slot0 = class("GuideConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._guideList = {}
	slot0._guide2StepList = {}
	slot0._stepId2AdditionStepMap = {}
	slot0._triggerTypeDict = {}
	slot0._triggerParamDict = {}
	slot0._invalidTypeListDict = {}
	slot0._invalidListDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"guide",
		"guide_step",
		"guide_mask",
		"guide_step_addition"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "guide" then
		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.isOnline == 1 then
				table.insert(slot0._guideList, slot7)

				slot8 = string.split(slot7.trigger, "#")
				slot0._triggerTypeDict[slot7.id] = slot8[1]
				slot0._triggerParamDict[slot7.id] = slot8[2]
				slot8 = GameUtil.splitString2(slot7.invalid, false, "|", "#")
				slot0._invalidTypeListDict[slot7.id] = {}
				slot0._invalidListDict[slot7.id] = {}

				if not string.nilorempty(slot7.invalid) then
					for slot12, slot13 in ipairs(slot8) do
						table.insert(slot0._invalidTypeListDict[slot7.id], slot13[1])
						table.insert(slot0._invalidListDict[slot7.id], slot13)
					end
				end
			end
		end
	elseif slot1 == "guide_step" then
		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._guide2StepList[slot7.id] then
				slot0._guide2StepList[slot7.id] = {}
			end

			table.insert(slot8, slot7)
		end
	elseif slot1 == "guide_step_addition" then
		slot0._stepId2AdditionStepMap = slot2.configDict
	end
end

function slot0.getGuideList(slot0)
	return slot0._guideList
end

function slot0.getGuideCO(slot0, slot1)
	return lua_guide.configDict[slot1]
end

function slot0.getStepList(slot0, slot1)
	return slot0._guide2StepList[slot1]
end

function slot0.getStepCO(slot0, slot1, slot2)
	if lua_guide_step.configDict[slot1] then
		return slot3[slot2]
	else
		return slot0:getAddtionStepCfg(slot1, slot2)
	end
end

function slot0.getAddtionStepCfg(slot0, slot1, slot2)
	if slot0._stepId2AdditionStepMap[slot1] then
		return slot3[slot2]
	end
end

function slot0.getHighestPriorityGuideId(slot0, slot1)
	for slot7, slot8 in ipairs(slot1) do
		if slot0:getGuideCO(slot8) and (not nil or not slot3 or slot3 < slot9.priority) then
			slot2 = slot8
			slot3 = slot9.priority
		end
	end

	return slot2 or slot1 and slot1[1]
end

function slot0.getTriggerType(slot0, slot1)
	return slot0._triggerTypeDict[slot1]
end

function slot0.getTriggerParam(slot0, slot1)
	return slot0._triggerParamDict[slot1]
end

function slot0.getInvalidTypeList(slot0, slot1)
	return slot0._invalidTypeListDict[slot1]
end

function slot0.getInvalidList(slot0, slot1)
	return slot0._invalidListDict[slot1]
end

function slot0.getPrevStepId(slot0, slot1, slot2)
	if slot0:getStepList(slot1)[1].stepId == slot2 then
		return 0
	end

	for slot7 = 2, #slot3 do
		if slot3[slot7].stepId == slot2 then
			return slot3[slot7 - 1].stepId
		end
	end

	return -1
end

function slot0.getNextStepId(slot0, slot1, slot2)
	if slot0:getStepList(slot1) then
		for slot7 = 1, #slot3 - 1 do
			if slot3[slot7].stepId == slot2 then
				return slot3[slot7 + 1].stepId
			end
		end
	end

	return -1
end

slot0.instance = slot0.New()

return slot0
