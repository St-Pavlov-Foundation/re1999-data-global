module("modules.logic.herogroup.model.HeroGroupSnapshotMo", package.seeall)

local var_0_0 = pureTable("HeroGroupSnapshotMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.groupInfoDict = {}
	arg_1_0.groupInfoList = {}
	arg_1_0.selectIndex = 1
end

function var_0_0.updateGroupInfoList(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	for iter_2_0 = 1, #arg_2_1 do
		arg_2_0:updateGroupInfo(arg_2_1[iter_2_0])
	end
end

function var_0_0.updateGroupInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.groupInfoDict[arg_3_1.groupId]

	if not var_3_0 then
		var_3_0 = HeroGroupMO.New()
		arg_3_0.groupInfoDict[arg_3_1.groupId] = var_3_0

		table.insert(arg_3_0.groupInfoList, var_3_0)
	end

	var_3_0:init(arg_3_1)
end

function var_0_0.getHeroGroupSnapshotList(arg_4_0)
	return arg_4_0.groupInfoList
end

function var_0_0.getHeroGroupInfo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.groupInfoDict[arg_5_1]

	if var_5_0 == nil and arg_5_2 then
		var_5_0 = HeroGroupModel.instance:generateTempGroup(nil, nil, true)
		arg_5_0.groupInfoDict[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.setSelectIndex(arg_6_0, arg_6_1)
	if arg_6_0.selectIndex == arg_6_1 then
		return
	end

	arg_6_0.selectIndex = arg_6_1

	return true
end

function var_0_0.getSelectIndex(arg_7_0)
	return arg_7_0.selectIndex
end

return var_0_0
