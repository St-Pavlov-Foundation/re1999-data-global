module("modules.logic.rouge.config.RougeTalentConfig", package.seeall)

local var_0_0 = class("RougeTalentConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_genius",
		"rouge_genius_branch",
		"rouge_genius_overview",
		"rouge_genius_branchlight"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._talentDict = nil
	arg_2_0._talentBranchDict = {}
	arg_2_0._talentBranchList = nil
	arg_2_0._talentoverList = nil
	arg_2_0._talentBranchLightList = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rouge_genius" then
		arg_3_0._talentDict = arg_3_2.configDict
	end

	if arg_3_1 == "rouge_genius_branch" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if iter_3_1.talent then
				if arg_3_0._talentBranchDict[iter_3_1.talent] == nil then
					arg_3_0._talentBranchDict[iter_3_1.talent] = {}
				end

				table.insert(arg_3_0._talentBranchDict[iter_3_1.talent], iter_3_1)
			end
		end

		arg_3_0._talentBranchList = arg_3_2.configDict
	end

	if arg_3_1 == "rouge_genius_overview" then
		arg_3_0._talentoverList = arg_3_2.configDict
	end

	if arg_3_1 == "rouge_genius_branchlight" then
		for iter_3_2, iter_3_3 in ipairs(arg_3_2.configList) do
			if iter_3_3.talent then
				if arg_3_0._talentBranchLightList[iter_3_3.talent] == nil then
					arg_3_0._talentBranchLightList[iter_3_3.talent] = {}
				end

				table.insert(arg_3_0._talentBranchLightList[iter_3_3.talent], iter_3_3)
			end
		end
	end
end

function var_0_0.getTalentOverConfigById(arg_4_0, arg_4_1)
	return arg_4_0._talentoverList[arg_4_1]
end

function var_0_0.getRougeTalentDict(arg_5_0, arg_5_1)
	return arg_5_0._talentDict[arg_5_1]
end

function var_0_0.getConfigByTalent(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._talentDict[arg_6_1][arg_6_2]
end

function var_0_0.getTalentNum(arg_7_0, arg_7_1)
	return #arg_7_0._talentDict[arg_7_1]
end

function var_0_0.getTalentBranchConfig(arg_8_0)
	return arg_8_0._talentBranchDict
end

function var_0_0.getBranchConfigListByTalent(arg_9_0, arg_9_1)
	return arg_9_0._talentBranchDict[arg_9_1]
end

function var_0_0.getBranchConfigByTalent(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._talentBranchDict[arg_10_1][arg_10_2]
end

function var_0_0.getBranchNumByTalent(arg_11_0, arg_11_1)
	return #arg_11_0._talentBranchDict[arg_11_1]
end

function var_0_0.getBranchConfigByID(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._talentBranchList[arg_12_1][arg_12_2]
end

function var_0_0.getBranchLightConfigByTalent(arg_13_0, arg_13_1)
	return arg_13_0._talentBranchLightList[arg_13_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
