module("modules.logic.versionactivity2_1.aergusi.model.AergusiModel", package.seeall)

local var_0_0 = class("AergusiModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeInfos = {}
	arg_2_0._evidenceDicts = {}
	arg_2_0._curEpisodeId = 0
	arg_2_0._curClueId = 0
	arg_2_0._readClueList = {}
	arg_2_0._unlockProcess = {
		0,
		0
	}
end

function var_0_0.setEpisodeInfos(arg_3_0, arg_3_1)
	arg_3_0._episodeInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = AergusiEpisodeMo.New()

		var_3_0:init(iter_3_1)

		arg_3_0._episodeInfos[iter_3_1.episodeId] = var_3_0
	end
end

function var_0_0.getEpisodeInfo(arg_4_0, arg_4_1)
	return arg_4_0._episodeInfos[arg_4_1]
end

function var_0_0.getEpisodeInfos(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = arg_5_0:getFirstEpisode()

	local function var_5_2(arg_6_0)
		local var_6_0 = AergusiConfig.instance:getEpisodeConfigs()

		table.insert(var_5_0, var_6_0[arg_6_0])

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if iter_6_1.preEpisodeId == arg_6_0 then
				return var_5_2(iter_6_1.episodeId)
			end
		end
	end

	var_5_2(var_5_1)

	return var_5_0
end

function var_0_0.getMaxUnlockEpisodeIndex(arg_7_0)
	local var_7_0 = arg_7_0:getEpisodeInfos()

	for iter_7_0 = 1, #var_7_0 do
		if not arg_7_0:isEpisodeUnlock(var_7_0[iter_7_0].episodeId) and arg_7_0:isEpisodeUnlock(var_7_0[iter_7_0].preEpisodeId) then
			return iter_7_0 - 1
		end
	end

	return #var_7_0
end

function var_0_0.getFirstEpisode(arg_8_0)
	local var_8_0 = AergusiConfig.instance:getEpisodeConfigs()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1.preEpisodeId == 0 then
			return iter_8_1.episodeId
		end
	end

	return 0
end

function var_0_0.getEpisodeNextEpisode(arg_9_0, arg_9_1)
	local var_9_0 = AergusiConfig.instance:getEpisodeConfigs()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.preEpisodeId == arg_9_1 then
			return iter_9_1.episodeId
		end
	end

	return 0
end

function var_0_0.getEpisodeIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getEpisodeInfos()

	for iter_10_0 = 1, #var_10_0 do
		if var_10_0[iter_10_0].episodeId == arg_10_1 then
			return iter_10_0
		end
	end

	return 0
end

function var_0_0.getNewFinishEpisode(arg_11_0)
	return arg_11_0._newFinishEpisode or -1
end

function var_0_0.setNewFinishEpisode(arg_12_0, arg_12_1)
	arg_12_0._newFinishEpisode = arg_12_1
end

function var_0_0.getNewUnlockEpisode(arg_13_0)
	return arg_13_0._newUnlockEpisode or -1
end

function var_0_0.setNewUnlockEpisode(arg_14_0, arg_14_1)
	arg_14_0._newUnlockEpisode = arg_14_1
end

function var_0_0.isStoryEpisode(arg_15_0, arg_15_1)
	return AergusiConfig.instance:getEpisodeConfig(nil, arg_15_1).evidenceId == ""
end

function var_0_0.getMaxPassedEpisode(arg_16_0)
	local var_16_0 = AergusiConfig.instance:getEpisodeConfigs()
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = arg_16_0:isEpisodePassed(iter_16_1.episodeId)

		if iter_16_1.preEpisodeId > 0 and arg_16_0:isEpisodePassed(iter_16_1.preEpisodeId) then
			if not var_16_2 then
				return iter_16_1.preEpisodeId
			else
				var_16_1 = iter_16_1.episodeId
			end
		end
	end

	return var_16_1
end

function var_0_0.setCurEpisode(arg_17_0, arg_17_1)
	arg_17_0._curEpisodeId = arg_17_1
end

function var_0_0.getCurEpisode(arg_18_0)
	return arg_18_0._curEpisodeId
end

function var_0_0.isEpisodeUnlock(arg_19_0, arg_19_1)
	if arg_19_0._episodeInfos[arg_19_1].episodeState >= AergusiEnum.ProgressState.Finished then
		return true
	else
		local var_19_0 = AergusiConfig.instance:getEpisodeConfig(nil, arg_19_1).preEpisodeId

		if not var_19_0 or var_19_0 == 0 then
			return true
		end

		return arg_19_0._episodeInfos[var_19_0].episodeState >= AergusiEnum.ProgressState.Finished
	end
end

function var_0_0.isEpisodePassed(arg_20_0, arg_20_1)
	return arg_20_0._episodeInfos[arg_20_1] and arg_20_0._episodeInfos[arg_20_1].episodeState >= AergusiEnum.ProgressState.Finished
end

function var_0_0.setReadClueList(arg_21_0, arg_21_1)
	arg_21_0._readClueList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		table.insert(arg_21_0._readClueList, iter_21_1)
	end
end

function var_0_0.isClueReaded(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._readClueList) do
		if iter_22_1 == arg_22_1 then
			return true
		end
	end

	if arg_22_0._evidenceDicts[arg_22_0._curEpisodeId] then
		for iter_22_2, iter_22_3 in pairs(arg_22_0._evidenceDicts[arg_22_0._curEpisodeId].clueInfos) do
			if iter_22_3.clueId == arg_22_1 then
				return iter_22_3.status == 1
			end
		end
	end

	return false
end

function var_0_0.setClueReaded(arg_23_0, arg_23_1)
	table.insert(arg_23_0._readClueList, arg_23_1)
end

function var_0_0.setEvidenceInfo(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0._evidenceDicts[arg_24_1] then
		arg_24_0._evidenceDicts[arg_24_1] = AergusiEvidenceMo.New()

		arg_24_0._evidenceDicts[arg_24_1]:init(arg_24_2)
	else
		arg_24_0._evidenceDicts[arg_24_1]:update(arg_24_2)
	end
end

function var_0_0.setEpisodeUnlockAutoTipProcess(arg_25_0, arg_25_1)
	if arg_25_1 == "" then
		arg_25_0._unlockProcess = {
			0,
			0
		}
	else
		local var_25_0 = string.splitToNumber(arg_25_1, "_")

		arg_25_0._unlockProcess = {
			var_25_0[1],
			var_25_0[2]
		}
	end
end

function var_0_0.getUnlockAutoTipProcess(arg_26_0)
	return arg_26_0._unlockProcess
end

function var_0_0.getEvidenceInfo(arg_27_0, arg_27_1)
	return arg_27_0._evidenceDicts[arg_27_1]
end

function var_0_0.hasClueNotRead(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		if not arg_28_0:isClueReaded(iter_28_1.clueId) then
			return true
		end
	end

	return false
end

function var_0_0.getAllClues(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getEpisodeInfos()

	if not arg_29_0:isEpisodePassed(var_29_0[1].episodeId) then
		return {}
	end

	for iter_29_0 = 1, #var_29_0 do
		if not arg_29_0:isEpisodePassed(var_29_0[iter_29_0].episodeId) then
			local var_29_1 = AergusiConfig.instance:getEpisodeConfig(nil, var_29_0[iter_29_0].episodeId)

			if arg_29_0:isEpisodePassed(var_29_1.preEpisodeId) then
				return arg_29_0:getEpisodeClueConfigs(var_29_1.preEpisodeId, arg_29_1)
			end
		end
	end

	return arg_29_0:getEpisodeClueConfigs(var_29_0[#var_29_0].episodeId, arg_29_1)
end

function var_0_0.getEpisodeClueConfigs(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:isEpisodePassed(arg_30_1)
	local var_30_1 = {}

	if arg_30_2 then
		local var_30_2 = arg_30_0._evidenceDicts[arg_30_1].clueInfos

		for iter_30_0, iter_30_1 in pairs(var_30_2) do
			local var_30_3 = AergusiConfig.instance:getClueConfig(iter_30_1.clueId)

			table.insert(var_30_1, var_30_3)
		end
	else
		local var_30_4 = {}
		local var_30_5 = AergusiConfig.instance:getClueConfigs()

		for iter_30_2, iter_30_3 in pairs(var_30_5) do
			if var_30_0 and arg_30_1 > iter_30_3.episodeId or arg_30_1 >= iter_30_3.episodeId then
				table.insert(var_30_1, iter_30_3)

				if iter_30_3.materialId ~= "" then
					local var_30_6 = string.splitToNumber(iter_30_3.materialId, "#")

					for iter_30_4, iter_30_5 in ipairs(var_30_6) do
						table.insert(var_30_4, iter_30_5)
					end
				end

				if iter_30_3.replaceId ~= 0 then
					table.insert(var_30_4, iter_30_3.replaceId)
				end
			end
		end

		for iter_30_6 = #var_30_1, 1, -1 do
			for iter_30_7, iter_30_8 in pairs(var_30_4) do
				if var_30_1[iter_30_6].clueId == iter_30_8 then
					table.remove(var_30_1, iter_30_6)

					break
				end
			end
		end
	end

	table.sort(var_30_1, function(arg_31_0, arg_31_1)
		return arg_31_0.clueId < arg_31_1.clueId
	end)

	return var_30_1
end

function var_0_0.getCouldMergeClues(arg_32_0, arg_32_1)
	local var_32_0 = {}
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		var_32_1[iter_32_1.clueId] = iter_32_1
	end

	local var_32_2 = AergusiConfig.instance:getClueConfigs()

	for iter_32_2, iter_32_3 in pairs(var_32_2) do
		if iter_32_3.materialId ~= "" then
			local var_32_3 = string.splitToNumber(iter_32_3.materialId, "#")

			if var_32_1[var_32_3[1]] and var_32_1[var_32_3[2]] then
				table.insert(var_32_0, {
					var_32_3[1],
					var_32_3[2]
				})
			end
		end
	end

	return var_32_0
end

function var_0_0.getCurClueId(arg_33_0)
	return arg_33_0._curClueId
end

function var_0_0.setCurClueId(arg_34_0, arg_34_1)
	arg_34_0._curClueId = arg_34_1
end

function var_0_0.setClueMergePosSelect(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._mergeClueState.pos[arg_35_1].selected = arg_35_2
	arg_35_0._mergeClueState.pos[3 - arg_35_1].selected = false
end

function var_0_0.getClueMergePosSelectState(arg_36_0, arg_36_1)
	return arg_36_0._mergeClueState.pos[arg_36_1].selected
end

function var_0_0.setClueMergePosClueId(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._mergeClueState.pos[arg_37_1].clueId = arg_37_2

	if arg_37_2 > 0 and not arg_37_0._mergeClueState.pos[3 - arg_37_1].selected and arg_37_0._mergeClueState.pos[3 - arg_37_1].clueId <= 0 then
		arg_37_0._mergeClueState.pos[arg_37_1].selected = false
		arg_37_0._mergeClueState.pos[3 - arg_37_1].selected = true
	end
end

function var_0_0.isClueInMerge(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_0._mergeClueState.pos) do
		if iter_38_1.clueId == arg_38_1 then
			return true
		end
	end

	return false
end

function var_0_0.getSelectPos(arg_39_0)
	if not arg_39_0._mergeClueState or not arg_39_0._mergeClueState.pos then
		return 0
	end

	for iter_39_0, iter_39_1 in pairs(arg_39_0._mergeClueState.pos) do
		if iter_39_1.selected then
			return iter_39_0
		end
	end

	return 0
end

function var_0_0.getMergeClueState(arg_40_0)
	return arg_40_0._mergeClueState
end

function var_0_0.clearMergePosState(arg_41_0)
	if not arg_41_0._mergeClueState then
		arg_41_0._mergeClueState = {}
	end

	arg_41_0._mergeClueState.open = false

	for iter_41_0 = 1, 2 do
		if not arg_41_0._mergeClueState.pos then
			arg_41_0._mergeClueState.pos = {}
		end

		if not arg_41_0._mergeClueState.pos[iter_41_0] then
			arg_41_0._mergeClueState.pos[iter_41_0] = {}
		end

		arg_41_0._mergeClueState.pos[iter_41_0].selected = iter_41_0 == 1
		arg_41_0._mergeClueState.pos[iter_41_0].clueId = 0
	end
end

function var_0_0.setMergeClueOpen(arg_42_0, arg_42_1)
	arg_42_0._mergeClueState.open = arg_42_1
end

function var_0_0.isMergeClueOpen(arg_43_0)
	return arg_43_0._mergeClueState.open
end

function var_0_0.getMergeClues(arg_44_0)
	local var_44_0 = {}

	for iter_44_0 = 1, 2 do
		table.insert(var_44_0, arg_44_0._mergeClueState.pos[iter_44_0].clueId)
	end

	return var_44_0
end

function var_0_0.getTargetMergeClue(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = AergusiConfig.instance:getClueConfigs()

	for iter_45_0, iter_45_1 in pairs(var_45_0) do
		if iter_45_1.materialId == string.format("%s#%s", arg_45_1, arg_45_2) or iter_45_1.materialId == string.format("%s#%s", arg_45_2, arg_45_1) then
			return iter_45_1.clueId
		end
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
