module("modules.logic.versionactivity2_1.aergusi.model.AergusiDialogModel", package.seeall)

local var_0_0 = class("AergusiDialogModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curGroup = 0
	arg_2_0._curStep = 0
	arg_2_0._targetList = {}
	arg_2_0._errorOperates = {}
	arg_2_0._promptOperates = {}
end

function var_0_0.setDialogGroup(arg_3_0, arg_3_1)
	arg_3_0._curGroup = arg_3_1
	arg_3_0._curStep = 0
end

function var_0_0.getCurDialogGroup(arg_4_0)
	if arg_4_0._curGroup == 0 then
		local var_4_0 = AergusiModel.instance:getCurEpisode()

		arg_4_0._curGroup = AergusiConfig.instance:getEpisodeConfig(nil, var_4_0).initialDialog
	end

	return arg_4_0._curGroup
end

function var_0_0.setCurDialogStep(arg_5_0, arg_5_1)
	arg_5_0._curStep = arg_5_1
end

function var_0_0.getCurDialogStep(arg_6_0)
	if arg_6_0._curStep == 0 then
		local var_6_0 = arg_6_0:getCurDialogGroup()

		arg_6_0._curStep = arg_6_0:getGroupFirstStep(var_6_0)
	end

	return arg_6_0._curStep
end

function var_0_0.getGroupFirstStep(arg_7_0, arg_7_1)
	local var_7_0 = AergusiConfig.instance:getEvidenceDialogConfigs(arg_7_1)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_1.nextStep)
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		for iter_7_4, iter_7_5 in pairs(var_7_1) do
			if iter_7_3.stepId == iter_7_5 then
				break
			end
		end

		return iter_7_3.stepId
	end

	return 1
end

function var_0_0.setCurDialogProcess(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._curGroup = arg_8_1
	arg_8_0._curStep = arg_8_2
end

function var_0_0.getCurDialogProcess(arg_9_0)
	local var_9_0 = arg_9_0:getCurDialogGroup()
	local var_9_1 = arg_9_0:getCurDialogStep()

	return var_9_0, var_9_1
end

function var_0_0.clearDialogProcess(arg_10_0)
	arg_10_0:reInit()
end

function var_0_0.getDialogStepList(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getGroupFirstStep(arg_11_1)
	local var_11_1 = {}

	local function var_11_2(arg_12_0)
		local var_12_0 = AergusiConfig.instance:getDialogConfig(arg_11_1, arg_12_0)

		table.insert(var_11_1, var_12_0)

		if var_12_0.nextStep > 0 then
			return var_11_2(var_12_0.nextStep)
		end
	end

	var_11_2(var_11_0)

	return var_11_1
end

function var_0_0.addPromptOperate(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		if not arg_13_0._promptOperates.inClue then
			arg_13_0._promptOperates.inClue = {}
		end

		table.insert(arg_13_0._promptOperates.inClue, arg_13_1)
	else
		if not arg_13_0._promptOperates.inEvidence then
			arg_13_0._promptOperates.inEvidence = {}
		end

		table.insert(arg_13_0._promptOperates.inEvidence, arg_13_1)
	end
end

function var_0_0.isOperateHasPrompted(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		if not arg_14_0._promptOperates.inClue then
			arg_14_0._promptOperates.inClue = {}
		end

		for iter_14_0, iter_14_1 in pairs(arg_14_0._promptOperates.inClue) do
			if iter_14_1.groupId == arg_14_1.groupId and iter_14_1.stepId == arg_14_1.stepId and iter_14_1.clueId == arg_14_1.clueId then
				return true
			end
		end
	else
		if not arg_14_0._promptOperates.inEvidence then
			arg_14_0._promptOperates.inEvidence = {}
		end

		for iter_14_2, iter_14_3 in pairs(arg_14_0._promptOperates.inEvidence) do
			if iter_14_3.groupId == arg_14_1.groupId and iter_14_3.stepId == arg_14_1.stepId and iter_14_3.type == arg_14_1.type then
				return true
			end
		end
	end

	return false
end

function var_0_0.getLastPromptOperate(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 then
		if not arg_15_0._promptOperates.inClue then
			arg_15_0._promptOperates.inClue = {}
		end

		for iter_15_0, iter_15_1 in pairs(arg_15_0._promptOperates.inClue) do
			if iter_15_1.stepId == arg_15_2 then
				return iter_15_1
			end
		end

		return arg_15_0._promptOperates.inClue[#arg_15_0._promptOperates.inClue]
	end

	if not arg_15_0._promptOperates.inEvidence then
		arg_15_0._promptOperates.inEvidence = {}
	end

	return arg_15_0._promptOperates.inEvidence[#arg_15_0._promptOperates.inEvidence]
end

function var_0_0.getNextPromptOperate(arg_16_0, arg_16_1)
	local var_16_0 = AergusiConfig.instance:getDialogConfigs(arg_16_0._curGroup)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1.condition ~= "" then
			local var_16_1 = string.splitToNumber(iter_16_1.condition, "#")

			if var_16_1[1] == AergusiEnum.OperationType.Submit then
				local var_16_2 = {
					groupId = arg_16_0._curGroup,
					stepId = iter_16_1.stepId,
					type = AergusiEnum.OperationType.Submit
				}

				if arg_16_1 then
					var_16_2.clueId = var_16_1[2]

					if not arg_16_0:isOperateHasPrompted(var_16_2, true) then
						return var_16_2
					end
				elseif not arg_16_0:isOperateHasPrompted(var_16_2, false) then
					return var_16_2
				end
			elseif var_16_1[1] == AergusiEnum.OperationType.Refutation then
				local var_16_3 = {
					groupId = arg_16_0._curGroup,
					stepId = iter_16_1.stepId,
					type = AergusiEnum.OperationType.Refutation
				}

				if arg_16_1 then
					var_16_3.clueId = var_16_1[2]

					if not arg_16_0:isOperateHasPrompted(var_16_3, true) then
						return var_16_3
					end
				elseif not arg_16_0:isOperateHasPrompted(var_16_3, false) then
					return var_16_3
				end
			elseif var_16_1[1] == AergusiEnum.OperationType.Probe then
				local var_16_4 = {
					groupId = arg_16_0._curGroup,
					stepId = iter_16_1.stepId,
					type = AergusiEnum.OperationType.Probe
				}

				if not arg_16_0:isOperateHasPrompted(var_16_4) then
					return var_16_4
				end
			end
		end
	end

	return nil
end

function var_0_0.getLeftPromptTimes(arg_17_0)
	local var_17_0 = AergusiModel.instance:getCurEpisode()

	return AergusiModel.instance:getEvidenceInfo(var_17_0).tipCount
end

function var_0_0.getLeftErrorTimes(arg_18_0)
	local var_18_0 = AergusiModel.instance:getCurEpisode()

	return AergusiModel.instance:getEvidenceInfo(var_18_0).hp
end

function var_0_0.isOperateHasError(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._errorOperates) do
		if iter_19_1.groupId == arg_19_1.groupId and iter_19_1.stepId == arg_19_1.stepId and iter_19_1.type == arg_19_1.type then
			return true
		end
	end

	return false
end

function var_0_0.isCurClueHasOperateError(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._errorOperates) do
		if iter_20_1.groupId == arg_20_0._curGroup and iter_20_1.stepId == arg_20_1 and iter_20_1.clueId == arg_20_2 then
			return true
		end
	end

	return false
end

function var_0_0.addErrorOperate(arg_21_0, arg_21_1)
	table.insert(arg_21_0._errorOperates, arg_21_1)
end

function var_0_0.getTargetGroupList(arg_22_0)
	return arg_22_0._targetList
end

function var_0_0.addTargetGroup(arg_23_0, arg_23_1)
	table.insert(arg_23_0._targetList, arg_23_1)
end

function var_0_0.getFinishedTargetGroupCount(arg_24_0)
	return #arg_24_0._targetList > 0 and #arg_24_0._targetList - 1 or 0
end

function var_0_0.setShowingGroup(arg_25_0, arg_25_1)
	arg_25_0._showinggroup = arg_25_1
end

function var_0_0.getShowingGroupState(arg_26_0)
	return arg_26_0._showinggroup
end

function var_0_0.getBubbleFirstStep(arg_27_0, arg_27_1)
	local var_27_0 = AergusiConfig.instance:getBubbleConfigs(arg_27_1)
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		table.insert(var_27_1, iter_27_1.nextStep)
	end

	for iter_27_2, iter_27_3 in pairs(var_27_0) do
		for iter_27_4, iter_27_5 in pairs(var_27_1) do
			if iter_27_3.stepId == iter_27_5 then
				break
			end
		end

		return iter_27_3.stepId
	end

	return 1
end

function var_0_0.getBubbleStepList(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getBubbleFirstStep(arg_28_1)
	local var_28_1 = {}

	local function var_28_2(arg_29_0)
		local var_29_0 = AergusiConfig.instance:getBubbleConfig(arg_28_1, arg_29_0)

		table.insert(var_28_1, var_29_0)

		if var_29_0.nextStep > 0 then
			return var_28_2(var_29_0.nextStep)
		end
	end

	var_28_2(var_28_0)

	return var_28_1
end

function var_0_0.setUnlockAutoShow(arg_30_0, arg_30_1)
	arg_30_0._unlockShow = arg_30_1
end

function var_0_0.getUnlockAutoShow(arg_31_0)
	local var_31_0 = AergusiModel.instance:getCurEpisode()

	if AergusiModel.instance:isEpisodePassed(var_31_0) then
		return false
	end

	local var_31_1 = AergusiModel.instance:getUnlockAutoTipProcess()

	if var_31_1[1] == arg_31_0._curGroup and var_31_1[2] == arg_31_0._curStep then
		return true
	end

	return arg_31_0._unlockShow
end

var_0_0.instance = var_0_0.New()

return var_0_0
