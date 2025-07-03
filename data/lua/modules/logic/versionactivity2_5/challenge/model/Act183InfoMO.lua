module("modules.logic.versionactivity2_5.challenge.model.Act183InfoMO", package.seeall)

local var_0_0 = pureTable("Act183InfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:_onGetGroupListInfo(arg_1_1.groupList)
	arg_1_0:_onGetBadgeNum(arg_1_1.badgeNum)

	arg_1_0._params = arg_1_1.params
end

function var_0_0._onGetGroupListInfo(arg_2_0, arg_2_1)
	arg_2_0._groupList = {}
	arg_2_0._groupMap = {}
	arg_2_0._groupTypeMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = Act183GroupEpisodeMO.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0._groupList, var_2_0)

		local var_2_1 = var_2_0:getGroupId()

		arg_2_0._groupMap[var_2_1] = var_2_0

		local var_2_2 = var_2_0:getGroupType()

		arg_2_0._groupTypeMap[var_2_2] = arg_2_0._groupTypeMap[var_2_2] or {}

		table.insert(arg_2_0._groupTypeMap[var_2_2], var_2_0)
	end

	table.sort(arg_2_0._groupList, arg_2_0._sortGroupMoById)

	for iter_2_2, iter_2_3 in pairs(arg_2_0._groupTypeMap) do
		table.sort(iter_2_3, arg_2_0._sortGroupMoById)
	end
end

function var_0_0._sortGroupMoById(arg_3_0, arg_3_1)
	return arg_3_0:getGroupId() < arg_3_1:getGroupId()
end

function var_0_0._onGetBadgeNum(arg_4_0, arg_4_1)
	arg_4_0._badgeNum = arg_4_1 or 0
	arg_4_0._unlockSupportHeros = {}
	arg_4_0._unlockSupportHeroIds = {}

	local var_4_0 = Act183Model.instance:getActivityId()
	local var_4_1 = Act183Helper.getUnlockSupportHeroIds(var_4_0, arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = HeroMo.New()

		var_4_2:initFromTrial(iter_4_1)
		table.insert(arg_4_0._unlockSupportHeros, var_4_2)
		table.insert(arg_4_0._unlockSupportHeroIds, iter_4_1)
	end
end

function var_0_0.getGroupEpisodes(arg_5_0)
	return arg_5_0._groupList
end

function var_0_0.getBadgeNum(arg_6_0)
	return arg_6_0._badgeNum
end

function var_0_0.updateBadgeNum(arg_7_0, arg_7_1)
	arg_7_0:_onGetBadgeNum(arg_7_1)
end

function var_0_0.getGroupEpisodeMos(arg_8_0, arg_8_1)
	return arg_8_0._groupTypeMap[arg_8_1]
end

function var_0_0.getGroupEpisodeMo(arg_9_0, arg_9_1)
	if arg_9_1 then
		return arg_9_0._groupMap and arg_9_0._groupMap[arg_9_1]
	end
end

function var_0_0.getUnlockSupportHeros(arg_10_0)
	return arg_10_0._unlockSupportHeros
end

function var_0_0.getUnlockSupportHeroIds(arg_11_0)
	return arg_11_0._unlockSupportHeroIds
end

function var_0_0.updateGroupMo(arg_12_0, arg_12_1)
	local var_12_0 = Act183GroupEpisodeMO.New()

	var_12_0:init(arg_12_1)

	local var_12_1 = var_12_0:getGroupId()
	local var_12_2 = arg_12_0:getGroupEpisodeMo(var_12_1)

	if var_12_2 then
		var_12_2:init(arg_12_1)
	end

	return var_12_2
end

return var_0_0
