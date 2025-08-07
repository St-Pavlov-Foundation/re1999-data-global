local var_0_0 = class("OdysseyConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"odyssey_const",
		"odyssey_map",
		"odyssey_element",
		"odyssey_option_element",
		"odyssey_option",
		"odyssey_dialog_element",
		"odyssey_fight_element",
		"odyssey_map_task",
		"odyssey_drop",
		"odyssey_religion",
		"odyssey_religion_clue",
		"odyssey_item",
		"odyssey_level_suppress",
		"odyssey_equip_suit",
		"odyssey_equip_suit_effect",
		"odyssey_talent",
		"odyssey_level",
		"odyssey_myth",
		"odyssey_task",
		"odyssey_fight_task_desc"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "odyssey_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "odyssey_map" then
		arg_3_0._mapConfig = arg_3_2
	elseif arg_3_1 == "odyssey_element" then
		arg_3_0._elementConfig = arg_3_2
		arg_3_0._mapElementDict = {}
		arg_3_0._mapElementList = {}

		arg_3_0:buildMapElementConfig()
	elseif arg_3_1 == "odyssey_option_element" then
		arg_3_0._optionElementConfig = arg_3_2
	elseif arg_3_1 == "odyssey_option" then
		arg_3_0._optionConfig = arg_3_2
		arg_3_0._dataBaseOptionDict = {}

		arg_3_0:buildDataBaseOptionConfig()
	elseif arg_3_1 == "odyssey_dialog_element" then
		arg_3_0._dialogElementConfig = arg_3_2
	elseif arg_3_1 == "odyssey_fight_element" then
		arg_3_0._fightElementConfig = arg_3_2
	elseif arg_3_1 == "odyssey_map_task" then
		arg_3_0._mapTaskConfig = arg_3_2
	elseif arg_3_1 == "odyssey_drop" then
		arg_3_0._dropConfig = arg_3_2
	elseif arg_3_1 == "odyssey_religion" then
		arg_3_0._religionConfig = arg_3_2
	elseif arg_3_1 == "odyssey_religion_clue" then
		arg_3_0._religionClueConfig = arg_3_2
	elseif arg_3_1 == "odyssey_item" then
		arg_3_0._itemConfig = arg_3_2
	elseif arg_3_1 == "odyssey_level" then
		arg_3_0._levelConfig = arg_3_2
	elseif arg_3_1 == "odyssey_level_suppress" then
		arg_3_0._levelSuppressConfig = arg_3_2
	elseif arg_3_1 == "odyssey_equip_suit" then
		arg_3_0._equipSuitConfig = arg_3_2
	elseif arg_3_1 == "odyssey_equip_suit_effect" then
		arg_3_0._equipSuitEffectConfig = arg_3_2
		arg_3_0._suitAllEffectList = {}
	elseif arg_3_1 == "odyssey_talent" then
		arg_3_0._talentConfig = arg_3_2
		arg_3_0._talentAllEffectList = {}
		arg_3_0._talentTypeCoList = {}
		arg_3_0._talentNodePreCoList = {}

		arg_3_0:buildTalentCoList()
	elseif arg_3_1 == "odyssey_myth" then
		arg_3_0._mythConfig = arg_3_2
	elseif arg_3_1 == "odyssey_task" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "odyssey_fight_task_desc" then
		arg_3_0._fightTaskDescConfig = arg_3_2
	end
end

function var_0_0.getConstConfig(arg_4_0, arg_4_1)
	return arg_4_0._constConfig.configDict[arg_4_1]
end

function var_0_0.buildMapElementConfig(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._elementConfig.configList) do
		local var_5_0 = arg_5_0._mapElementDict[iter_5_1.mapId]

		if not var_5_0 then
			var_5_0 = {}
			arg_5_0._mapElementDict[iter_5_1.mapId] = var_5_0
			arg_5_0._mapElementList[iter_5_1.mapId] = {}
		end

		if not var_5_0[iter_5_1.id] then
			var_5_0[iter_5_1.id] = iter_5_1

			table.insert(arg_5_0._mapElementList[iter_5_1.mapId], iter_5_1)
		end
	end
end

function var_0_0.getDungeonMapConfig(arg_6_0, arg_6_1)
	return arg_6_0._mapConfig.configDict[arg_6_1]
end

function var_0_0.getAllDungeonMapCoList(arg_7_0)
	return arg_7_0._mapConfig.configList
end

function var_0_0.getMapAllElementCoList(arg_8_0, arg_8_1)
	return arg_8_0._mapElementList[arg_8_1]
end

function var_0_0.getElementConfig(arg_9_0, arg_9_1)
	return arg_9_0._elementConfig.configDict[arg_9_1]
end

function var_0_0.getAllElementCoList(arg_10_0)
	return arg_10_0._elementConfig.configList
end

function var_0_0.getMainTaskConfig(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mapTaskConfig.configList) do
		local var_11_0 = string.splitToNumber(iter_11_1.elementList, "#")

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			if iter_11_3 == arg_11_1 then
				return iter_11_1
			end
		end
	end
end

function var_0_0.getMapTaskCo(arg_12_0, arg_12_1)
	return arg_12_0._mapTaskConfig.configDict[arg_12_1]
end

function var_0_0.getDialogConfig(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._dialogElementConfig.configDict[arg_13_1] and arg_13_0._dialogElementConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.buildDataBaseOptionConfig(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._optionConfig.configList) do
		if iter_14_1.dataBase > 0 then
			arg_14_0._dataBaseOptionDict[iter_14_1.dataBase] = iter_14_1
		end
	end
end

function var_0_0.getOptionConfig(arg_15_0, arg_15_1)
	return arg_15_0._optionConfig.configDict[arg_15_1]
end

function var_0_0.checkIsOptionDataBase(arg_16_0, arg_16_1)
	return arg_16_0._dataBaseOptionDict[arg_16_1]
end

function var_0_0.getElementFightConfig(arg_17_0, arg_17_1)
	return arg_17_0._fightElementConfig.configDict[arg_17_1]
end

function var_0_0.getElemenetOptionConfig(arg_18_0, arg_18_1)
	return arg_18_0._optionElementConfig.configDict[arg_18_1]
end

function var_0_0.getItemConfig(arg_19_0, arg_19_1)
	return arg_19_0._itemConfig.configDict[arg_19_1]
end

function var_0_0.getItemConfigList(arg_20_0)
	return arg_20_0._itemConfig.configList
end

function var_0_0.getEquipSuitConfig(arg_21_0, arg_21_1)
	return arg_21_0._equipSuitConfig.configDict[arg_21_1]
end

function var_0_0.getEquipSuitConfigList(arg_22_0)
	return arg_22_0._equipSuitConfig.configList
end

function var_0_0.getLevelSuppressConfig(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0._levelSuppressConfig.configList) do
		if iter_23_1.levelDifference == arg_23_1 then
			return iter_23_1
		end
	end
end

function var_0_0.getLevelConfig(arg_24_0, arg_24_1)
	return arg_24_0._levelConfig.configDict[arg_24_1]
end

function var_0_0.getLevelConfigList(arg_25_0)
	return arg_25_0._levelConfig.configList
end

function var_0_0.getEquipDropConfig(arg_26_0, arg_26_1)
	return arg_26_0._dropConfig.configDict[arg_26_1]
end

function var_0_0.getEquipSuitAllEffect(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._suitAllEffectList[arg_27_1]

	if not var_27_0 then
		if not arg_27_0._equipSuitEffectConfig.configDict[arg_27_1] then
			return nil
		end

		var_27_0 = tabletool.copy(arg_27_0._equipSuitEffectConfig.configDict[arg_27_1])

		table.sort(var_27_0, function(arg_28_0, arg_28_1)
			return arg_28_0.level < arg_28_1.level
		end)

		arg_27_0._suitAllEffectList[arg_27_1] = var_27_0
	end

	return var_27_0
end

function var_0_0.getEquipSuitEffectConfig(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_0._equipSuitEffectConfig.configDict[arg_29_1] and arg_29_0._equipSuitEffectConfig.configDict[arg_29_1][arg_29_2]
end

function var_0_0.getTalentConfig(arg_30_0, arg_30_1, arg_30_2)
	return arg_30_0._talentConfig.configDict[arg_30_1] and arg_30_0._talentConfig.configDict[arg_30_1][arg_30_2]
end

function var_0_0.buildTalentCoList(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._talentConfig.configList) do
		if not arg_31_0._talentAllEffectList[iter_31_1.nodeId] then
			local var_31_0 = tabletool.copy(arg_31_0._talentConfig.configDict[iter_31_1.nodeId])

			table.sort(var_31_0, function(arg_32_0, arg_32_1)
				return arg_32_0.level < arg_32_1.level
			end)

			arg_31_0._talentAllEffectList[iter_31_1.nodeId] = var_31_0

			if not arg_31_0._talentTypeCoList[iter_31_1.type] then
				arg_31_0._talentTypeCoList[iter_31_1.type] = {}
			end

			table.insert(arg_31_0._talentTypeCoList[iter_31_1.type], iter_31_1)
		end
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0._talentTypeCoList) do
		table.sort(iter_31_3, function(arg_33_0, arg_33_1)
			return arg_33_0.nodeId < arg_33_1.nodeId
		end)
	end
end

function var_0_0.getAllTalentEffectConfigByNodeId(arg_34_0, arg_34_1)
	return arg_34_0._talentAllEffectList[arg_34_1]
end

function var_0_0.getAllTalentConfigByType(arg_35_0, arg_35_1)
	return arg_35_0._talentTypeCoList[arg_35_1]
end

function var_0_0.getTalentParentNodeConfig(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._talentNodePreCoList[arg_36_1]

	if not var_36_0 then
		local var_36_1 = arg_36_0:getAllTalentEffectConfigByNodeId(arg_36_1)[1].unlockCondition

		if string.nilorempty(var_36_1) then
			return nil
		end

		local var_36_2 = GameUtil.splitString2(var_36_1)

		for iter_36_0, iter_36_1 in ipairs(var_36_2) do
			if iter_36_1[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
				local var_36_3 = tonumber(iter_36_1[2])

				var_36_0 = arg_36_0:getTalentConfig(var_36_3, 1)

				break
			end
		end

		arg_36_0._talentNodePreCoList[arg_36_1] = var_36_0
	end

	return var_36_0
end

function var_0_0.getFightElementCoListByType(arg_37_0, arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0._fightElementConfig.configList) do
		if iter_37_1.type == arg_37_1 then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_0.getMythConfig(arg_38_0, arg_38_1)
	return arg_38_0._mythConfig.configDict[arg_38_1]
end

function var_0_0.getMythConfigList(arg_39_0)
	return arg_39_0._mythConfig.configList
end

function var_0_0.getReligionConfig(arg_40_0, arg_40_1)
	return arg_40_0._religionConfig.configDict[arg_40_1]
end

function var_0_0.getReligionConfigList(arg_41_0)
	return arg_41_0._religionConfig.configList
end

function var_0_0.getReligionClueConfig(arg_42_0, arg_42_1)
	return arg_42_0._religionClueConfig.configDict[arg_42_1]
end

function var_0_0.getTaskConfig(arg_43_0, arg_43_1)
	return arg_43_0._taskConfig.configDict[arg_43_1]
end

function var_0_0.getBigRewardTaskConfig(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0._taskConfig.configList) do
		if iter_44_1.isKeyReward == 1 then
			return iter_44_1
		end
	end
end

function var_0_0.getFightTaskDescConfig(arg_45_0, arg_45_1)
	return arg_45_0._fightTaskDescConfig.configDict[arg_45_1]
end

function var_0_0.getMythConfigByElementId(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0._mythConfig.configList) do
		if iter_46_1.elementId == arg_46_1 then
			return iter_46_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
