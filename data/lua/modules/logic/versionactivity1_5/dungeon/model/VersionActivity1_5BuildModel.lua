module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5BuildModel", package.seeall)

local var_0_0 = class("VersionActivity1_5BuildModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initBuildInfoList(arg_3_0, arg_3_1)
	arg_3_0.selectBuildList = {}
	arg_3_0.selectTypeList = {
		0,
		0,
		0
	}
	arg_3_0.hadBuildList = {}
	arg_3_0.buildGroupHadBuildCount = {
		0,
		0,
		0
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.selectIds) do
		table.insert(arg_3_0.selectBuildList, iter_3_1)
	end

	arg_3_0:updateSelectTypeList()

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.ownBuildingIds) do
		table.insert(arg_3_0.hadBuildList, iter_3_3)
	end

	arg_3_0:updateGroupHadBuildCount()

	arg_3_0.hasGainedReward = arg_3_1.gainedReward
end

function var_0_0.addHadBuild(arg_4_0, arg_4_1)
	if tabletool.indexOf(arg_4_0.hadBuildList, arg_4_1) then
		return
	end

	table.insert(arg_4_0.hadBuildList, arg_4_1)
	arg_4_0:updateGroupHadBuildCount()

	local var_4_0 = VersionActivity1_5DungeonConfig.instance:getBuildCo(arg_4_1)

	arg_4_0:setSelectBuildId(var_4_0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, arg_4_1)
end

function var_0_0.updateSelectBuild(arg_5_0, arg_5_1)
	tabletool.clear(arg_5_0.selectBuildList)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(arg_5_0.selectBuildList, iter_5_1)
	end

	arg_5_0:updateSelectTypeList()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateSelectBuild)
end

function var_0_0.updateGainedReward(arg_6_0, arg_6_1)
	arg_6_0.hasGainedReward = arg_6_1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward)
end

function var_0_0.updateSelectTypeList(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.selectTypeList do
		arg_7_0.selectTypeList[iter_7_0] = 0
	end

	for iter_7_1, iter_7_2 in ipairs(arg_7_0.selectBuildList) do
		if arg_7_0:checkBuildIdIsSelect(iter_7_2) then
			local var_7_0 = VersionActivity1_5DungeonConfig.instance:getBuildCo(iter_7_2)

			arg_7_0.selectTypeList[var_7_0.group] = var_7_0.type
		end
	end
end

function var_0_0.checkBuildIdIsSelect(arg_8_0, arg_8_1)
	return tabletool.indexOf(arg_8_0.selectBuildList, arg_8_1)
end

function var_0_0.checkBuildIsHad(arg_9_0, arg_9_1)
	return tabletool.indexOf(arg_9_0.hadBuildList, arg_9_1)
end

function var_0_0.updateGroupHadBuildCount(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.buildGroupHadBuildCount do
		arg_10_0.buildGroupHadBuildCount[iter_10_0] = 0
	end

	for iter_10_1, iter_10_2 in ipairs(arg_10_0.hadBuildList) do
		local var_10_0 = VersionActivity1_5DungeonConfig.instance:getBuildCo(iter_10_2).group

		arg_10_0.buildGroupHadBuildCount[var_10_0] = arg_10_0.buildGroupHadBuildCount[var_10_0] + 1
	end
end

function var_0_0.getCanBuildCount(arg_11_0, arg_11_1)
	return arg_11_0.buildGroupHadBuildCount[arg_11_1]
end

function var_0_0.getSelectBuildIdList(arg_12_0)
	return arg_12_0.selectBuildList
end

function var_0_0.getSelectType(arg_13_0, arg_13_1)
	return arg_13_0.selectTypeList[arg_13_1]
end

function var_0_0.getSelectTypeList(arg_14_0)
	return arg_14_0.selectTypeList
end

function var_0_0.setSelectBuildId(arg_15_0, arg_15_1)
	arg_15_0.selectTypeList[arg_15_1.group] = arg_15_1.type

	tabletool.clear(arg_15_0.selectBuildList)

	for iter_15_0, iter_15_1 in pairs(arg_15_0.selectTypeList) do
		if iter_15_1 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			arg_15_1 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(iter_15_0, iter_15_1)

			table.insert(arg_15_0.selectBuildList, arg_15_1.id)
		end
	end
end

function var_0_0.getHadBuildCount(arg_16_0)
	return #arg_16_0.hadBuildList
end

function var_0_0.getBuildCoByGroupIndex(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getSelectType(arg_17_1)

	if var_17_0 == VersionActivity1_5DungeonEnum.BuildType.None then
		return nil
	end

	return VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(arg_17_1, var_17_0)
end

function var_0_0.getTextByType(arg_18_0, arg_18_1)
	local var_18_0 = VersionActivity1_5DungeonEnum.BuildType2TextColor[arg_18_0] or VersionActivity1_5DungeonEnum.BuildType2TextColor[VersionActivity1_5DungeonEnum.BuildType.None]

	return string.format("<color=%s>%s</color>", var_18_0, arg_18_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
