module("modules.logic.season.config.SeasonConfig", package.seeall)

local var_0_0 = class("SeasonConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity104_episode",
		"activity104_const",
		"activity104_retail",
		"activity104_special",
		"activity104_equip",
		"activity104_equip_attr",
		"activity104_equip_tag",
		"activity104_trial",
		"activity104_story",
		"activity104_retail_new"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity104_episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "activity104_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity104_retail" then
		arg_3_0._retailConfig = arg_3_2
	elseif arg_3_1 == "activity104_special" then
		arg_3_0._specialConfig = arg_3_2
	elseif arg_3_1 == "activity104_equip" then
		arg_3_0._equipConfig = arg_3_2

		arg_3_0:preprocessEquip()
	elseif arg_3_1 == "activity104_equip_tag" then
		arg_3_0._equipTagConfig = arg_3_2
	elseif arg_3_1 == "activity104_equip_attr" then
		arg_3_0._equipAttrConfig = arg_3_2
	elseif arg_3_1 == "activity104_equip_attr" then
		arg_3_0._equipAttrConfig = arg_3_2
	elseif arg_3_1 == "activity104_trial" then
		arg_3_0._trialConfig = arg_3_2
	elseif arg_3_1 == "activity104_story" then
		arg_3_0._storyConfig = arg_3_2
	elseif arg_3_1 == "activity104_retail_new" then
		arg_3_0._retailNewConfig = arg_3_2
	end
end

function var_0_0.getTrialConfig(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0._trialConfig.configDict[arg_4_1] and arg_4_0._trialConfig.configDict[arg_4_1][arg_4_2]
end

function var_0_0.getTrialCount(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._trialConfig.configDict[arg_5_1]

	return tabletool.len(var_5_0)
end

function var_0_0.preprocessEquip(arg_6_0)
	arg_6_0._equipIsOptionalDict = {}
	arg_6_0._equipIsOptionalList = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._equipConfig.configList) do
		if iter_6_1.isOptional == 1 then
			arg_6_0._equipIsOptionalDict[iter_6_1.equipId] = true

			table.insert(arg_6_0._equipIsOptionalList, iter_6_1)
		end
	end
end

function var_0_0.getSeasonEpisodeCos(arg_7_0, arg_7_1)
	return arg_7_0._episodeConfig.configDict[arg_7_1]
end

function var_0_0.getSeasonEpisodeCo(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._episodeConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getSeasonConstCo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._constConfig.configDict[arg_9_1]
	local var_9_1 = var_9_0 and var_9_0[arg_9_2]

	if not var_9_1 then
		logError(string.format("const no exist seasonid:%s constid:%s", arg_9_1, arg_9_2))
	end

	return var_9_1
end

function var_0_0.getSeasonRetailCos(arg_10_0, arg_10_1)
	return arg_10_0._retailConfig.configDict[arg_10_1]
end

function var_0_0.getSeasonRetailCo(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._retailConfig.configDict[arg_11_1][arg_11_2]
end

function var_0_0.getSeasonSpecialCos(arg_12_0, arg_12_1)
	return arg_12_0._specialConfig.configDict[arg_12_1]
end

function var_0_0.getSeasonSpecialCo(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._specialConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.getSeasonEquipCos(arg_14_0)
	return arg_14_0._equipConfig.configDict
end

function var_0_0.getSeasonEquipCo(arg_15_0, arg_15_1)
	return arg_15_0._equipConfig.configDict[arg_15_1]
end

function var_0_0.getSeasonOptionalEquipCos(arg_16_0)
	return arg_16_0._equipIsOptionalList
end

function var_0_0.getSeasonTagDict(arg_17_0, arg_17_1)
	return arg_17_0._equipTagConfig.configDict[arg_17_1]
end

function var_0_0.getSeasonTagDesc(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getSeasonTagDict(arg_18_1)
	local var_18_1 = var_18_0 and var_18_0[arg_18_2]

	if not var_18_1 then
		logError(string.format("not tag config seasonId:%s tagId:%s", arg_18_1, arg_18_2))
	end

	return var_18_1
end

function var_0_0.getEquipIsOptional(arg_19_0, arg_19_1)
	return arg_19_0._equipIsOptionalDict[arg_19_1]
end

function var_0_0.getEquipCoByCondition(arg_20_0, arg_20_1)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._equipConfig.configList) do
		if arg_20_1(iter_20_1) then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0_0.getSeasonEquipAttrCo(arg_21_0, arg_21_1)
	return arg_21_0._equipAttrConfig.configDict[arg_21_1]
end

function var_0_0.getConfigByEpisodeId(arg_22_0, arg_22_1)
	arg_22_0:_initEpisodeId2Config()

	return arg_22_0._episodeId2Config and arg_22_0._episodeId2Config[arg_22_1]
end

function var_0_0._initEpisodeId2Config(arg_23_0)
	if arg_23_0._episodeId2Config then
		return
	end

	arg_23_0._episodeId2Config = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0._episodeConfig.configDict) do
		arg_23_0._episodeId2Config[iter_23_1.episodeId] = iter_23_1
	end
end

function var_0_0.getStoryIds(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getSeasonConstCo(arg_24_1, Activity104Enum.ConstEnum.SeasonOpenStorys)

	return {
		var_24_0.value1
	}
end

function var_0_0.getRetailTicket(arg_25_0, arg_25_1)
	return arg_25_0:getSeasonConstCo(arg_25_1, Activity104Enum.ConstEnum.RetailTicket).value1
end

function var_0_0.getRuleTips(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getSeasonConstCo(arg_26_1, Activity104Enum.ConstEnum.RuleTips)

	return (string.splitToNumber(var_26_0.value2, "#"))
end

function var_0_0.isExistInRuleTips(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0._ruleDict then
		arg_27_0._ruleDict = {}
	end

	if not arg_27_0._ruleDict[arg_27_1] then
		arg_27_0._ruleDict[arg_27_1] = {}

		local var_27_0 = arg_27_0:getRuleTips(arg_27_1)

		if var_27_0 then
			for iter_27_0, iter_27_1 in pairs(var_27_0) do
				arg_27_0._ruleDict[arg_27_1][iter_27_1] = true
			end
		end
	end

	return arg_27_0._ruleDict[arg_27_1][arg_27_2] ~= nil
end

function var_0_0.filterRule(arg_28_0, arg_28_1)
	local var_28_0 = {}

	if arg_28_1 then
		local var_28_1 = Activity104Model.instance:getCurSeasonId()

		for iter_28_0, iter_28_1 in pairs(arg_28_1) do
			if not arg_28_0:isExistInRuleTips(var_28_1, iter_28_1[2]) then
				table.insert(var_28_0, iter_28_1)
			end
		end
	end

	return var_28_0
end

function var_0_0.getAllStoryCo(arg_29_0, arg_29_1)
	return arg_29_0._storyConfig.configDict[arg_29_1]
end

function var_0_0.getStoryConfig(arg_30_0, arg_30_1, arg_30_2)
	return arg_30_0._storyConfig.configDict[arg_30_1][arg_30_2]
end

function var_0_0.getSeasonConstStr(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getSeasonConstCo(arg_31_1, arg_31_2)

	if not var_31_0 then
		return
	end

	return var_31_0.value2
end

function var_0_0.getSeasonConstLangStr(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getSeasonConstCo(arg_32_1, arg_32_2)

	if not var_32_0 then
		return
	end

	return var_32_0.value3
end

function var_0_0.getSeasonRetailEpisodeCo(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0._retailNewConfig.configDict[arg_33_1][arg_33_2]

	if not var_33_0 then
		logError(string.format("not retail config seasonId:%s episodeId:%s", arg_33_1, arg_33_2))
	end

	return var_33_0
end

function var_0_0.getSeasonRetailEpisodes(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._retailNewConfig.configDict[arg_34_1]

	if not var_34_0 then
		logError(string.format("not retail episodelist seasonId:%s", arg_34_1))
	end

	return var_34_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
