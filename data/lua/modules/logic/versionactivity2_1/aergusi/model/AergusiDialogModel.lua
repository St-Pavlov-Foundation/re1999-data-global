module("modules.logic.versionactivity2_1.aergusi.model.AergusiDialogModel", package.seeall)

slot0 = class("AergusiDialogModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curGroup = 0
	slot0._curStep = 0
	slot0._targetList = {}
	slot0._errorOperates = {}
	slot0._promptOperates = {}
end

function slot0.setDialogGroup(slot0, slot1)
	slot0._curGroup = slot1
	slot0._curStep = 0
end

function slot0.getCurDialogGroup(slot0)
	if slot0._curGroup == 0 then
		slot0._curGroup = AergusiConfig.instance:getEpisodeConfig(nil, AergusiModel.instance:getCurEpisode()).initialDialog
	end

	return slot0._curGroup
end

function slot0.setCurDialogStep(slot0, slot1)
	slot0._curStep = slot1
end

function slot0.getCurDialogStep(slot0)
	if slot0._curStep == 0 then
		slot0._curStep = slot0:getGroupFirstStep(slot0:getCurDialogGroup())
	end

	return slot0._curStep
end

function slot0.getGroupFirstStep(slot0, slot1)
	for slot7, slot8 in pairs(AergusiConfig.instance:getEvidenceDialogConfigs(slot1)) do
		table.insert({}, slot8.nextStep)
	end

	for slot7, slot8 in pairs(slot2) do
		for slot12, slot13 in pairs(slot3) do
			if slot8.stepId == slot13 then
				break
			end
		end

		return slot8.stepId
	end

	return 1
end

function slot0.setCurDialogProcess(slot0, slot1, slot2)
	slot0._curGroup = slot1
	slot0._curStep = slot2
end

function slot0.getCurDialogProcess(slot0)
	return slot0:getCurDialogGroup(), slot0:getCurDialogStep()
end

function slot0.clearDialogProcess(slot0)
	slot0:reInit()
end

function slot0.getDialogStepList(slot0, slot1)
	function (slot0)
		slot1 = AergusiConfig.instance:getDialogConfig(uv0, slot0)

		table.insert(uv1, slot1)

		if slot1.nextStep > 0 then
			return uv2(slot1.nextStep)
		end
	end(slot0:getGroupFirstStep(slot1))

	return {}
end

function slot0.addPromptOperate(slot0, slot1, slot2)
	if slot2 then
		if not slot0._promptOperates.inClue then
			slot0._promptOperates.inClue = {}
		end

		table.insert(slot0._promptOperates.inClue, slot1)
	else
		if not slot0._promptOperates.inEvidence then
			slot0._promptOperates.inEvidence = {}
		end

		table.insert(slot0._promptOperates.inEvidence, slot1)
	end
end

function slot0.isOperateHasPrompted(slot0, slot1, slot2)
	if slot2 then
		if not slot0._promptOperates.inClue then
			slot0._promptOperates.inClue = {}
		end

		for slot6, slot7 in pairs(slot0._promptOperates.inClue) do
			if slot7.groupId == slot1.groupId and slot7.stepId == slot1.stepId and slot7.clueId == slot1.clueId then
				return true
			end
		end
	else
		if not slot0._promptOperates.inEvidence then
			slot0._promptOperates.inEvidence = {}
		end

		for slot6, slot7 in pairs(slot0._promptOperates.inEvidence) do
			if slot7.groupId == slot1.groupId and slot7.stepId == slot1.stepId and slot7.type == slot1.type then
				return true
			end
		end
	end

	return false
end

function slot0.getLastPromptOperate(slot0, slot1, slot2)
	if slot1 then
		if not slot0._promptOperates.inClue then
			slot0._promptOperates.inClue = {}
		end

		for slot6, slot7 in pairs(slot0._promptOperates.inClue) do
			if slot7.stepId == slot2 then
				return slot7
			end
		end

		return slot0._promptOperates.inClue[#slot0._promptOperates.inClue]
	end

	if not slot0._promptOperates.inEvidence then
		slot0._promptOperates.inEvidence = {}
	end

	return slot0._promptOperates.inEvidence[#slot0._promptOperates.inEvidence]
end

function slot0.getNextPromptOperate(slot0, slot1)
	for slot6, slot7 in pairs(AergusiConfig.instance:getDialogConfigs(slot0._curGroup)) do
		if slot7.condition ~= "" then
			if string.splitToNumber(slot7.condition, "#")[1] == AergusiEnum.OperationType.Submit then
				slot9 = {
					groupId = slot0._curGroup,
					stepId = slot7.stepId,
					type = AergusiEnum.OperationType.Submit,
					clueId = slot8[2]
				}

				if slot1 then
					if not slot0:isOperateHasPrompted(slot9, true) then
						return slot9
					end
				elseif not slot0:isOperateHasPrompted(slot9, false) then
					return slot9
				end
			elseif slot8[1] == AergusiEnum.OperationType.Refutation then
				slot9 = {
					groupId = slot0._curGroup,
					stepId = slot7.stepId,
					type = AergusiEnum.OperationType.Refutation,
					clueId = slot8[2]
				}

				if slot1 then
					if not slot0:isOperateHasPrompted(slot9, true) then
						return slot9
					end
				elseif not slot0:isOperateHasPrompted(slot9, false) then
					return slot9
				end
			elseif slot8[1] == AergusiEnum.OperationType.Probe and not slot0:isOperateHasPrompted({
				groupId = slot0._curGroup,
				stepId = slot7.stepId,
				type = AergusiEnum.OperationType.Probe
			}) then
				return slot9
			end
		end
	end

	return nil
end

function slot0.getLeftPromptTimes(slot0)
	return AergusiModel.instance:getEvidenceInfo(AergusiModel.instance:getCurEpisode()).tipCount
end

function slot0.getLeftErrorTimes(slot0)
	return AergusiModel.instance:getEvidenceInfo(AergusiModel.instance:getCurEpisode()).hp
end

function slot0.isOperateHasError(slot0, slot1)
	for slot5, slot6 in pairs(slot0._errorOperates) do
		if slot6.groupId == slot1.groupId and slot6.stepId == slot1.stepId and slot6.type == slot1.type then
			return true
		end
	end

	return false
end

function slot0.isCurClueHasOperateError(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._errorOperates) do
		if slot7.groupId == slot0._curGroup and slot7.stepId == slot1 and slot7.clueId == slot2 then
			return true
		end
	end

	return false
end

function slot0.addErrorOperate(slot0, slot1)
	table.insert(slot0._errorOperates, slot1)
end

function slot0.getTargetGroupList(slot0)
	return slot0._targetList
end

function slot0.addTargetGroup(slot0, slot1)
	table.insert(slot0._targetList, slot1)
end

function slot0.getFinishedTargetGroupCount(slot0)
	return #slot0._targetList > 0 and #slot0._targetList - 1 or 0
end

function slot0.setShowingGroup(slot0, slot1)
	slot0._showinggroup = slot1
end

function slot0.getShowingGroupState(slot0)
	return slot0._showinggroup
end

function slot0.getBubbleFirstStep(slot0, slot1)
	for slot7, slot8 in pairs(AergusiConfig.instance:getBubbleConfigs(slot1)) do
		table.insert({}, slot8.nextStep)
	end

	for slot7, slot8 in pairs(slot2) do
		for slot12, slot13 in pairs(slot3) do
			if slot8.stepId == slot13 then
				break
			end
		end

		return slot8.stepId
	end

	return 1
end

function slot0.getBubbleStepList(slot0, slot1)
	function (slot0)
		slot1 = AergusiConfig.instance:getBubbleConfig(uv0, slot0)

		table.insert(uv1, slot1)

		if slot1.nextStep > 0 then
			return uv2(slot1.nextStep)
		end
	end(slot0:getBubbleFirstStep(slot1))

	return {}
end

function slot0.setUnlockAutoShow(slot0, slot1)
	slot0._unlockShow = slot1
end

function slot0.getUnlockAutoShow(slot0)
	if AergusiModel.instance:isEpisodePassed(AergusiModel.instance:getCurEpisode()) then
		return false
	end

	if AergusiModel.instance:getUnlockAutoTipProcess()[1] == slot0._curGroup and slot3[2] == slot0._curStep then
		return true
	end

	return slot0._unlockShow
end

slot0.instance = slot0.New()

return slot0
