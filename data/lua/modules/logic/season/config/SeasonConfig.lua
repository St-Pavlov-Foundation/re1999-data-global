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
		"activity104_trial"
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
	end
end

function var_0_0.getTrialConfig(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0._trialConfig.configDict[arg_4_1] and arg_4_0._trialConfig.configDict[arg_4_1][arg_4_2]
end

function var_0_0.preprocessEquip(arg_5_0)
	arg_5_0._equipIsOptionalDict = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._equipConfig.configList) do
		if iter_5_1.isOptional == 1 then
			arg_5_0._equipIsOptionalDict[iter_5_1.equipId] = true
		end
	end
end

function var_0_0.getSeasonEpisodeCos(arg_6_0, arg_6_1)
	return arg_6_0._episodeConfig.configDict[arg_6_1]
end

function var_0_0.getSeasonEpisodeCo(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._episodeConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getSeasonConstCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._constConfig.configDict[arg_8_1]
	local var_8_1 = var_8_0 and var_8_0[arg_8_2]

	if not var_8_1 then
		logError(string.format("const no exist seasonid:%s constid:%s", arg_8_1, arg_8_2))
	end

	return var_8_1
end

function var_0_0.getSeasonRetailCos(arg_9_0, arg_9_1)
	return arg_9_0._retailConfig.configDict[arg_9_1]
end

function var_0_0.getSeasonRetailCo(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._retailConfig.configDict[arg_10_1][arg_10_2]
end

function var_0_0.getSeasonSpecialCos(arg_11_0, arg_11_1)
	return arg_11_0._specialConfig.configDict[arg_11_1]
end

function var_0_0.getSeasonSpecialCo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._specialConfig.configDict[arg_12_1][arg_12_2]
end

function var_0_0.getSeasonEquipCos(arg_13_0)
	return arg_13_0._equipConfig.configDict
end

function var_0_0.getSeasonEquipCo(arg_14_0, arg_14_1)
	return arg_14_0._equipConfig.configDict[arg_14_1]
end

function var_0_0.getSeasonOptionalEquipCos(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0._equipConfig.configDict) do
		if iter_15_1.isOptional == 1 then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_0.getSeasonTagDict(arg_16_0, arg_16_1)
	return arg_16_0._equipTagConfig.configDict[arg_16_1]
end

function var_0_0.getSeasonTagDesc(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getSeasonTagDict(arg_17_1)
	local var_17_1 = var_17_0 and var_17_0[arg_17_2]

	if not var_17_1 then
		logError(string.format("not tag config seasonId:%s tagId:%s", arg_17_1, arg_17_2))
	end

	return var_17_1
end

function var_0_0.getEquipIsOptional(arg_18_0, arg_18_1)
	return arg_18_0._equipIsOptionalDict[arg_18_1]
end

function var_0_0.getEquipCoByCondition(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._equipConfig.configList) do
		if arg_19_1(iter_19_1) then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.getSeasonEquipAttrCo(arg_20_0, arg_20_1)
	return arg_20_0._equipAttrConfig.configDict[arg_20_1]
end

function var_0_0.getConfigByEpisodeId(arg_21_0, arg_21_1)
	arg_21_0:_initEpisodeId2Config()

	return arg_21_0._episodeId2Config and arg_21_0._episodeId2Config[arg_21_1]
end

function var_0_0._initEpisodeId2Config(arg_22_0)
	if arg_22_0._episodeId2Config then
		return
	end

	arg_22_0._episodeId2Config = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0._episodeConfig.configDict) do
		arg_22_0._episodeId2Config[iter_22_1.episodeId] = iter_22_1
	end
end

function var_0_0.getStoryIds(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getSeasonConstCo(arg_23_1, Activity104Enum.ConstEnum.SeasonOpenStorys)

	return {
		var_23_0.value1
	}
end

function var_0_0.getRetailTicket(arg_24_0, arg_24_1)
	return arg_24_0:getSeasonConstCo(arg_24_1, Activity104Enum.ConstEnum.RetailTicket).value1
end

function var_0_0.getRuleTips(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getSeasonConstCo(arg_25_1, Activity104Enum.ConstEnum.RuleTips)

	return (string.splitToNumber(var_25_0.value2, "#"))
end

function var_0_0.isExistInRuleTips(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0._ruleDict then
		arg_26_0._ruleDict = {}
	end

	if not arg_26_0._ruleDict[arg_26_1] then
		arg_26_0._ruleDict[arg_26_1] = {}

		local var_26_0 = arg_26_0:getRuleTips(arg_26_1)

		if var_26_0 then
			for iter_26_0, iter_26_1 in pairs(var_26_0) do
				arg_26_0._ruleDict[arg_26_1][iter_26_1] = true
			end
		end
	end

	return arg_26_0._ruleDict[arg_26_1][arg_26_2] ~= nil
end

function var_0_0.filterRule(arg_27_0, arg_27_1)
	local var_27_0 = {}

	if arg_27_1 then
		local var_27_1 = Activity104Model.instance:getCurSeasonId()

		for iter_27_0, iter_27_1 in pairs(arg_27_1) do
			if not arg_27_0:isExistInRuleTips(var_27_1, iter_27_1[2]) then
				table.insert(var_27_0, iter_27_1)
			end
		end
	end

	return var_27_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
