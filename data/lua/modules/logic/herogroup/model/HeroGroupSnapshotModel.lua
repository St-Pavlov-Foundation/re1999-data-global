module("modules.logic.herogroup.model.HeroGroupSnapshotModel", package.seeall)

local var_0_0 = class("HeroGroupSnapshotModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.curSnapshotId = nil
	arg_2_0.curGroupIds = nil
	arg_2_0.customSelectDict = {}
end

function var_0_0.onReceiveGetHeroGroupSnapshotListReply(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	for iter_3_0 = 1, #arg_3_1.heroGroupSnapshots do
		arg_3_0:updateHeroGroupSnapshot(arg_3_1.heroGroupSnapshots[iter_3_0])
	end
end

function var_0_0.updateHeroGroupSnapshot(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getById(arg_4_1.snapshotId)

	if not var_4_0 then
		var_4_0 = HeroGroupSnapshotMo.New()

		var_4_0:init(arg_4_1.snapshotId)
		arg_4_0:addAtLast(var_4_0)
	end

	var_4_0:updateGroupInfoList(arg_4_1.heroGroupSnapshots)
	var_4_0:updateSortSubIds(arg_4_1.sortSubIds)
end

function var_0_0.updateSortSubIds(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getById(arg_5_1)

	return var_5_0 and var_5_0:updateSortSubIds(arg_5_2)
end

function var_0_0.getSortSubIds(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	return var_6_0 and var_6_0:getSortSubIds() or {}
end

function var_0_0.getHeroGroupSnapshotList(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	return var_7_0 and var_7_0:getHeroGroupSnapshotList()
end

function var_0_0.getHeroGroupInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getById(arg_8_1)

	return var_8_0 and var_8_0:getHeroGroupInfo(arg_8_2, arg_8_3)
end

function var_0_0.updateHeroGroupInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:getById(arg_9_1)

	return var_9_0 and var_9_0:updateGroupInfoByGroupId(arg_9_3, arg_9_2)
end

function var_0_0.removeHeroGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getById(arg_10_1)

	return var_10_0 and var_10_0:removeHeroGroup(arg_10_2)
end

function var_0_0.addHeroGroup(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getById(arg_11_1)

	return var_11_0 and var_11_0:addHeroGroup(arg_11_2, arg_11_3)
end

function var_0_0.getHeroGroupName(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getHeroGroupInfo(arg_12_1, arg_12_2)

	return var_12_0 and var_12_0.name
end

function var_0_0.setHeroGroupName(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getHeroGroupInfo(arg_13_1, arg_13_2)

	if var_13_0 then
		var_13_0.name = arg_13_3
	end
end

function var_0_0.setParam(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = HeroGroupHandler.getSnapShot(arg_14_1)

	arg_14_0.curSnapshotId = var_14_0
	arg_14_0.curGroupIds = var_14_1
	arg_14_0.episodeId = arg_14_1
end

function var_0_0.getCurSnapshotId(arg_15_0)
	return arg_15_0.curSnapshotId
end

function var_0_0.getCurGroupId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getSelectIndex(arg_16_1)

	arg_16_1 = arg_16_1 or arg_16_0.curSnapshotId

	if HeroGroupPresetController.snapshotUsePreset(arg_16_1) then
		return var_16_0
	end

	return arg_16_0.curGroupIds[var_16_0]
end

function var_0_0.getCurGroup(arg_17_0)
	local var_17_0 = arg_17_0:getCurGroupId(arg_17_0.curSnapshotId)

	return (arg_17_0:getHeroGroupInfo(arg_17_0.curSnapshotId, var_17_0, true))
end

function var_0_0.getCurGroupList(arg_18_0)
	return (arg_18_0:getHeroGroupSnapshotList(arg_18_0.curSnapshotId))
end

function var_0_0.setSelectIndex(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or arg_19_0.curSnapshotId

	if arg_19_1 == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local var_19_0 = DungeonConfig.instance:getEpisodeCO(arg_19_0.episodeId)
		local var_19_1 = var_19_0 and var_19_0.type or 0

		if arg_19_0.customSelectDict[var_19_1] == arg_19_2 then
			return false
		end

		arg_19_0.customSelectDict[var_19_1] = arg_19_2

		return true
	end

	local var_19_2 = arg_19_0:getById(arg_19_1)

	if var_19_2 then
		return var_19_2:setSelectIndex(arg_19_2)
	end
end

function var_0_0.getSelectIndex(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or arg_20_0.curSnapshotId

	if arg_20_1 == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local var_20_0 = DungeonConfig.instance:getEpisodeCO(arg_20_0.episodeId)
		local var_20_1 = var_20_0 and var_20_0.type or 0

		if arg_20_0.customSelectDict[var_20_1] == nil then
			arg_20_0.customSelectDict[var_20_1] = 1
		end

		local var_20_2 = arg_20_0.customSelectDict[var_20_1]

		if HeroGroupPresetController.snapshotUsePreset(arg_20_1) then
			var_20_2 = HeroGroupPresetHeroGroupSelectIndexController.instance:getSnapshotTypeSelectedIndex(arg_20_1, var_20_2)
		end

		return var_20_2
	end

	local var_20_3 = arg_20_0:getById(arg_20_1)

	if var_20_3 then
		return var_20_3:getSelectIndex()
	end
end

function var_0_0.getGroupName(arg_21_0)
	local var_21_0 = arg_21_0:getCurGroupId()
	local var_21_1 = arg_21_0:getHeroGroupInfo(arg_21_0.curSnapshotId, var_21_0)

	return var_21_1 and var_21_1.name
end

function var_0_0.setGroupName(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:getHeroGroupInfo(arg_22_1, arg_22_2)

	if var_22_0 then
		var_22_0.name = arg_22_3
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
