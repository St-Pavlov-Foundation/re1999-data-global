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
end

function var_0_0.getHeroGroupSnapshotList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getById(arg_5_1)

	return var_5_0 and var_5_0:getHeroGroupSnapshotList()
end

function var_0_0.getHeroGroupInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	return var_6_0 and var_6_0:getHeroGroupInfo(arg_6_2, arg_6_3)
end

function var_0_0.setParam(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = HeroGroupHandler.getSnapShot(arg_7_1)

	arg_7_0.curSnapshotId = var_7_0
	arg_7_0.curGroupIds = var_7_1
	arg_7_0.episodeId = arg_7_1
end

function var_0_0.getCurSnapshotId(arg_8_0)
	return arg_8_0.curSnapshotId
end

function var_0_0.getCurGroupId(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getSelectIndex(arg_9_1)

	return arg_9_0.curGroupIds[var_9_0]
end

function var_0_0.getCurGroup(arg_10_0)
	local var_10_0 = arg_10_0:getCurGroupId(arg_10_0.curSnapshotId)

	return (arg_10_0:getHeroGroupInfo(arg_10_0.curSnapshotId, var_10_0, true))
end

function var_0_0.getCurGroupList(arg_11_0)
	return (arg_11_0:getHeroGroupSnapshotList(arg_11_0.curSnapshotId))
end

function var_0_0.setSelectIndex(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 or arg_12_0.curSnapshotId

	if arg_12_1 == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_0.episodeId)
		local var_12_1 = var_12_0 and var_12_0.type or 0

		if arg_12_0.customSelectDict[var_12_1] == arg_12_2 then
			return false
		end

		arg_12_0.customSelectDict[var_12_1] = arg_12_2

		return true
	end

	local var_12_2 = arg_12_0:getById(arg_12_1)

	if var_12_2 then
		return var_12_2:setSelectIndex(arg_12_2)
	end
end

function var_0_0.getSelectIndex(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or arg_13_0.curSnapshotId

	if arg_13_1 == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		local var_13_0 = DungeonConfig.instance:getEpisodeCO(arg_13_0.episodeId)
		local var_13_1 = var_13_0 and var_13_0.type or 0

		if arg_13_0.customSelectDict[var_13_1] == nil then
			arg_13_0.customSelectDict[var_13_1] = 1
		end

		return arg_13_0.customSelectDict[var_13_1]
	end

	local var_13_2 = arg_13_0:getById(arg_13_1)

	if var_13_2 then
		return var_13_2:getSelectIndex()
	end
end

function var_0_0.getGroupName(arg_14_0)
	local var_14_0 = arg_14_0:getCurGroupId()
	local var_14_1 = arg_14_0:getHeroGroupInfo(arg_14_0.curSnapshotId, var_14_0)

	return var_14_1 and var_14_1.name
end

function var_0_0.setGroupName(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getHeroGroupInfo(arg_15_1, arg_15_2)

	if var_15_0 then
		var_15_0.name = arg_15_3
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
