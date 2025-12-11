module("modules.logic.herogroup.model.HeroGroupSnapshotMo", package.seeall)

local var_0_0 = pureTable("HeroGroupSnapshotMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.groupInfoDict = {}
	arg_1_0.groupInfoList = {}
	arg_1_0.selectIndex = 1
	arg_1_0.sortSubIds = {}
end

function var_0_0.updateSortSubIds(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(var_2_0, iter_2_1)
	end

	arg_2_0.sortSubIds = var_2_0
end

function var_0_0.getSortSubIds(arg_3_0)
	return arg_3_0.sortSubIds
end

function var_0_0.updateGroupInfoList(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	for iter_4_0 = 1, #arg_4_1 do
		arg_4_0:updateGroupInfo(arg_4_1[iter_4_0])
	end
end

function var_0_0.updateGroupInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.groupInfoDict[arg_5_1.groupId]

	if not var_5_0 then
		var_5_0 = HeroGroupMO.New()
		arg_5_0.groupInfoDict[arg_5_1.groupId] = var_5_0

		table.insert(arg_5_0.groupInfoList, var_5_0)
	end

	var_5_0:init(arg_5_1)
end

function var_0_0.updateGroupInfoByGroupId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.groupInfoDict[arg_6_2]

	if var_6_0 then
		var_6_0:init(arg_6_1)
	else
		logError(string.format("HeroGroupSnapshotMo:updateGroupInfoByGroupId error,groupId = %s", arg_6_2))
	end
end

function var_0_0.getHeroGroupSnapshotList(arg_7_0)
	return arg_7_0.groupInfoList
end

function var_0_0.getHeroGroupInfo(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or 1

	local var_8_0 = arg_8_0.groupInfoDict[arg_8_1]

	if var_8_0 == nil and arg_8_2 then
		var_8_0 = HeroGroupModel.instance:generateTempGroup(nil, nil, true)
		arg_8_0.groupInfoDict[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.removeHeroGroup(arg_9_0, arg_9_1)
	arg_9_0.groupInfoDict[arg_9_1] = nil
end

function var_0_0.addHeroGroup(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.groupInfoDict[arg_10_1] = arg_10_2
end

function var_0_0.setSelectIndex(arg_11_0, arg_11_1)
	if arg_11_0.selectIndex == arg_11_1 then
		return
	end

	arg_11_0.selectIndex = arg_11_1

	return true
end

function var_0_0.getSelectIndex(arg_12_0)
	return arg_12_0.selectIndex
end

return var_0_0
