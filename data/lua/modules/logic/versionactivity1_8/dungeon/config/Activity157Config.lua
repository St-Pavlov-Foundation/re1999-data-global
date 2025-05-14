module("modules.logic.versionactivity1_8.dungeon.config.Activity157Config", package.seeall)

local var_0_0 = class("Activity157Config", BaseConfig)

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0 < arg_1_1
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity157_const",
		"activity157_factory_component",
		"activity157_mission",
		"activity157_mission_group",
		"activity157_repair_map"
	}
end

function var_0_0.onInit(arg_3_0)
	arg_3_0.actId2MissionGroupDict = {}
	arg_3_0.actId2ElementDict = {}
	arg_3_0.actId2missionGroupTree = {}
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "activity157_mission" then
		arg_4_0:initMissionCfg(arg_4_2)
	end
end

function var_0_0.initMissionCfg(arg_5_0, arg_5_1)
	arg_5_0.actId2MissionGroupDict = {}
	arg_5_0.actId2ElementDict = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1.configDict) do
		local var_5_0 = arg_5_0.actId2MissionGroupDict[iter_5_0]

		if not var_5_0 then
			var_5_0 = {}
			arg_5_0.actId2MissionGroupDict[iter_5_0] = var_5_0
		end

		local var_5_1 = arg_5_0.actId2ElementDict[iter_5_0]

		if not var_5_1 then
			var_5_1 = {}
			arg_5_0.actId2ElementDict[iter_5_0] = var_5_1
		end

		local var_5_2 = {}

		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			local var_5_3 = iter_5_3.groupId
			local var_5_4 = var_5_0[var_5_3]

			if not var_5_4 then
				var_5_4 = {}
				var_5_0[var_5_3] = var_5_4
			end

			var_5_1[iter_5_3.elementId] = iter_5_2
			var_5_2[iter_5_2] = iter_5_3.order
			var_5_4[#var_5_4 + 1] = iter_5_2
		end

		for iter_5_4, iter_5_5 in pairs(var_5_0) do
			table.sort(iter_5_5, function(arg_6_0, arg_6_1)
				local var_6_0 = var_5_2[arg_6_0] or 0
				local var_6_1 = var_5_2[arg_6_1] or 0

				if var_6_0 ~= var_6_1 then
					return var_6_0 < var_6_1
				end

				return arg_6_0 < arg_6_1
			end)
		end
	end
end

function var_0_0.initMissionGroupTree(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}

	arg_7_0.actId2missionGroupTree[arg_7_1] = var_7_0

	local var_7_1 = arg_7_0:getAllMissionGroupIdList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = {}

		var_7_0[iter_7_1] = var_7_2

		local var_7_3 = arg_7_0:getAct157MissionList(arg_7_1, iter_7_1)

		for iter_7_2, iter_7_3 in ipairs(var_7_3) do
			local var_7_4
			local var_7_5 = arg_7_0:getMissionElementId(arg_7_1, iter_7_3)
			local var_7_6 = var_7_5 and DungeonConfig.instance:getChapterMapElement(var_7_5)
			local var_7_7 = var_7_6 and var_7_6.condition

			if not string.nilorempty(var_7_7) then
				local var_7_8, var_7_9 = string.match(var_7_7, "(ChapterMapElement=)(%d+)")
				local var_7_10 = var_7_9 and tonumber(var_7_9)

				var_7_4 = arg_7_0:getMissionIdByElementId(arg_7_1, var_7_10)
			end

			var_7_2[iter_7_3] = var_7_4
		end
	end
end

local function var_0_2(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if arg_8_0 and arg_8_1 then
		local var_8_1 = lua_activity157_const.configDict[arg_8_0]

		var_8_0 = var_8_1 and var_8_1[arg_8_1]
	end

	if not var_8_0 and arg_8_2 then
		logError(string.format("Activity157Config:getAct157ConstCfg error, cfg is nil, actId:%s  id:%s", arg_8_0, arg_8_1))
	end

	return var_8_0
end

function var_0_0.getAct157Const(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0
	local var_9_1 = var_0_2(arg_9_1, arg_9_2, true)

	if var_9_1 then
		var_9_0 = var_9_1.value
	end

	return var_9_0
end

function var_0_0.getAct157FactoryProductCapacity(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = arg_10_0:getAct157Const(arg_10_1, arg_10_2)
	local var_10_2 = var_10_1 and string.splitToNumber(var_10_1, "#")
	local var_10_3 = var_10_2 and var_10_2[1]
	local var_10_4 = var_10_2 and var_10_2[2]

	if var_10_3 and var_10_4 then
		var_10_0 = var_10_3 * var_10_4
	end

	return var_10_0
end

function var_0_0.getAct157CompositeFormula(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = Activity157Enum.ConstId.FactoryCompositeFormula
	local var_11_2 = arg_11_0:getAct157Const(arg_11_1, var_11_1)

	return (ItemModel.instance:getItemDataListByConfigStr(var_11_2))
end

local function var_0_3(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	arg_12_1 = tonumber(arg_12_1)

	if arg_12_0 and arg_12_1 then
		local var_12_1 = lua_activity157_factory_component.configDict[arg_12_0]

		var_12_0 = var_12_1 and var_12_1[arg_12_1]
	end

	if not var_12_0 and arg_12_2 then
		logError(string.format("Activity157Config:getAct157FactoryComponentCfg error, cfg is nil, actId:%s  id:%s", arg_12_0, arg_12_1))
	end

	return var_12_0
end

function var_0_0.getComponentUnlockCondition(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1
	local var_13_2
	local var_13_3 = var_0_3(arg_13_1, arg_13_2, true)

	if var_13_3 then
		local var_13_4 = var_13_3.unlockCondition
		local var_13_5 = string.splitToNumber(var_13_4, "#")

		var_13_0 = var_13_5[1]
		var_13_1 = var_13_5[2]
		var_13_2 = var_13_5[3]
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.getPreComponentId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 0
	local var_14_1 = var_0_3(arg_14_1, arg_14_2, true)

	if var_14_1 then
		var_14_0 = var_14_1.preComponentId
	end

	return var_14_0
end

function var_0_0.getComponentReward(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0
	local var_15_1 = var_0_3(arg_15_1, arg_15_2, true)

	if var_15_1 then
		var_15_0 = var_15_1.bonusForShow
	end

	return var_15_0
end

function var_0_0.getComponentBonusBuildingLevel(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 1
	local var_16_1 = var_0_3(arg_16_1, arg_16_2, true)

	if var_16_1 then
		var_16_0 = tonumber(var_16_1.bonusBuildingLevel)
	end

	return var_16_0
end

function var_0_0.getComponentIdList(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if lua_activity157_factory_component then
		local var_17_1 = lua_activity157_factory_component.configDict[arg_17_1]

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			var_17_0[#var_17_0 + 1] = iter_17_0
		end
	end

	table.sort(var_17_0, var_0_1)

	return var_17_0
end

local function var_0_4(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_0 and arg_18_1 then
		local var_18_1 = lua_activity157_repair_map.configDict[arg_18_0]

		var_18_0 = var_18_1 and var_18_1[arg_18_1]
	end

	if not var_18_0 and arg_18_2 then
		logError(string.format("Activity157Config:getAct157RepairMapCfg error, cfg is nil, actId:%s  id:%s", arg_18_0, arg_18_1))
	end

	return var_18_0
end

function var_0_0.getAct157RepairMapTitleTip(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = ""
	local var_19_1 = var_0_4(arg_19_1, arg_19_2, true)

	if var_19_1 then
		var_19_0 = var_19_1.titleTip
	end

	return var_19_0
end

function var_0_0.getAct157RepairMapTilebase(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1 = var_0_4(arg_20_1, arg_20_2, true)

	if var_20_1 then
		var_20_0 = var_20_1.tilebase
	end

	return var_20_0
end

function var_0_0.getAct157RepairMapObjects(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1 = var_0_4(arg_21_1, arg_21_2, true)

	if var_21_1 then
		var_21_0 = var_21_1.objects
	end

	return var_21_0
end

local function var_0_5(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if arg_22_0 and arg_22_1 then
		local var_22_1 = lua_activity157_mission_group.configDict[arg_22_0]

		var_22_0 = var_22_1 and var_22_1[arg_22_1]
	end

	if not var_22_0 and arg_22_2 then
		logError(string.format("Activity157Config:getAct157MissionGroupCfg error, cfg is nil, actId:%s  id:%s", arg_22_0, arg_22_1))
	end

	return var_22_0
end

function var_0_0.getMissionGroupType(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0
	local var_23_1 = var_0_5(arg_23_1, arg_23_2, true)

	if var_23_1 then
		var_23_0 = var_23_1.type
	end

	return var_23_0
end

function var_0_0.getAllMissionGroupIdList(arg_24_0, arg_24_1)
	local var_24_0 = {}
	local var_24_1

	if arg_24_1 then
		var_24_1 = lua_activity157_mission_group.configDict[arg_24_1]
	end

	if var_24_1 then
		for iter_24_0, iter_24_1 in pairs(var_24_1) do
			var_24_0[#var_24_0 + 1] = iter_24_0
		end
	else
		logError(string.format("Activity157Config:getAllMissionGroupIdList error, cfg is nil, actId:%s ", arg_24_1))
	end

	table.sort(var_24_0, var_0_1)

	return var_24_0
end

function var_0_0.getRootMissionId(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0
	local var_25_1 = arg_25_0.actId2MissionGroupDict[arg_25_1]

	if var_25_1 and arg_25_2 then
		local var_25_2 = var_25_1[arg_25_2]

		if var_25_2 then
			var_25_0 = var_25_2[1]
		end
	end

	return var_25_0
end

function var_0_0.getAct157MissionList(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {}

	if not arg_26_1 or not arg_26_2 then
		return var_26_0
	end

	local var_26_1 = arg_26_0.actId2MissionGroupDict[arg_26_1]

	if var_26_1 then
		local var_26_2 = var_26_1[arg_26_2] or {}

		for iter_26_0, iter_26_1 in ipairs(var_26_2) do
			var_26_0[#var_26_0 + 1] = iter_26_1
		end
	end

	return var_26_0
end

function var_0_0.isSideMissionGroup(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = true
	local var_27_1 = arg_27_0:getMissionGroupType(arg_27_1, arg_27_2)

	if var_27_1 then
		var_27_0 = var_27_1 == Activity157Enum.MissionType.SideMission
	end

	return var_27_0
end

function var_0_0.getLeafMission(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = {}

	if not arg_28_1 or not arg_28_2 then
		return var_28_0
	end

	local var_28_1 = arg_28_0.actId2MissionGroupDict[arg_28_1]

	if var_28_1 and arg_28_2 then
		local var_28_2 = var_28_1[arg_28_2] or {}

		for iter_28_0, iter_28_1 in ipairs(var_28_2) do
			local var_28_3 = arg_28_0:getAct157ChildMissionList(arg_28_1, iter_28_1)

			if not var_28_3 or #var_28_3 <= 0 then
				var_28_0[#var_28_0] = iter_28_1
			end
		end
	end

	return var_28_0
end

function var_0_0.getMapName(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = ""
	local var_29_1 = var_0_5(arg_29_1, arg_29_2, true)

	if var_29_1 then
		var_29_0 = var_29_1.mapName
	end

	return var_29_0
end

local function var_0_6(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0

	if arg_30_0 and arg_30_1 then
		local var_30_1 = lua_activity157_mission.configDict[arg_30_0]

		var_30_0 = var_30_1 and var_30_1[arg_30_1]
	end

	if not var_30_0 and arg_30_2 then
		logError(string.format("Activity157Config:getAct157MissionCfg error, cfg is nil, actId:%s  id:%s", arg_30_0, arg_30_1))
	end

	return var_30_0
end

function var_0_0.getAct157MissionPos(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0
	local var_31_1 = var_0_6(arg_31_1, arg_31_2, true)

	if var_31_1 then
		var_31_0 = string.splitToNumber(var_31_1.pos, "#")
	end

	return var_31_0
end

function var_0_0.getAct157MissionOrder(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = 0
	local var_32_1 = var_0_6(arg_32_1, arg_32_2, true)

	if var_32_1 then
		var_32_0 = var_32_1.order
	end

	return var_32_0
end

function var_0_0.getMissionElementId(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0
	local var_33_1 = var_0_6(arg_33_1, arg_33_2, true)

	if var_33_1 then
		var_33_0 = var_33_1.elementId
	end

	return var_33_0
end

function var_0_0.getAct157MissionStoryId(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0
	local var_34_1 = var_0_6(arg_34_1, arg_34_2, true)

	if var_34_1 then
		var_34_0 = var_34_1.storyId
	end

	return var_34_0
end

function var_0_0.getMissionGroup(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0
	local var_35_1 = var_0_6(arg_35_1, arg_35_2, true)

	if var_35_1 then
		var_35_0 = var_35_1.groupId
	end

	return var_35_0
end

function var_0_0.isRootMission(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = false
	local var_36_1 = arg_36_0:getMissionGroup(arg_36_1, arg_36_2)
	local var_36_2 = arg_36_0:getRootMissionId(arg_36_1, var_36_1)

	if arg_36_2 then
		var_36_0 = arg_36_2 == var_36_2
	end

	return var_36_0
end

function var_0_0.isSideMission(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:getMissionGroup(arg_37_1, arg_37_2)

	return (arg_37_0:isSideMissionGroup(arg_37_1, var_37_0))
end

function var_0_0.getLineResPath(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = ""
	local var_38_1 = var_0_6(arg_38_1, arg_38_2, true)

	if var_38_1 then
		local var_38_2 = var_38_1.linePrefab

		if not string.nilorempty(var_38_2) then
			var_38_0 = string.format("%s_mapline", var_38_2)
		end
	end

	return var_38_0
end

function var_0_0.getMissionIdByElementId(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0

	if arg_39_1 and arg_39_2 then
		var_39_0 = (arg_39_0.actId2ElementDict[arg_39_1] or {})[arg_39_2]
	end

	return var_39_0
end

function var_0_0.getAct157ParentMissionId(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0

	if not arg_40_1 or not arg_40_2 then
		return var_40_0
	end

	if not arg_40_0.actId2missionGroupTree or not arg_40_0.actId2missionGroupTree[arg_40_1] then
		arg_40_0:initMissionGroupTree(arg_40_1)
	end

	local var_40_1 = arg_40_0.actId2missionGroupTree[arg_40_1]
	local var_40_2 = arg_40_0:getMissionGroup(arg_40_1, arg_40_2)

	if var_40_2 then
		var_40_0 = (var_40_1[var_40_2] or {})[arg_40_2]
	end

	return var_40_0
end

function var_0_0.getAct157ChildMissionList(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}

	if not arg_41_1 or not arg_41_2 then
		return var_41_0
	end

	if not arg_41_0.actId2missionGroupTree or not arg_41_0.actId2missionGroupTree[arg_41_1] then
		arg_41_0:initMissionGroupTree(arg_41_1)
	end

	local var_41_1 = arg_41_0.actId2missionGroupTree[arg_41_1]
	local var_41_2 = arg_41_0:getMissionGroup(arg_41_1, arg_41_2)

	if var_41_2 then
		local var_41_3 = var_41_1[var_41_2] or {}

		for iter_41_0, iter_41_1 in pairs(var_41_3) do
			if iter_41_1 == arg_41_2 then
				var_41_0[#var_41_0 + 1] = iter_41_0
			end
		end
	end

	return var_41_0
end

function var_0_0.getMissionArea(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = ""
	local var_42_1 = var_0_6(arg_42_1, arg_42_2, true)

	if var_42_1 then
		var_42_0 = var_42_1.area
	end

	return var_42_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
