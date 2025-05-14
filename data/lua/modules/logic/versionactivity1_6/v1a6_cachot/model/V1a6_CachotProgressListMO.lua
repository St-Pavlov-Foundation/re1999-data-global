module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListMO", package.seeall)

local var_0_0 = pureTable("V1a6_CachotProgressListMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.index = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0.isLocked = arg_1_3
end

function var_0_0.getLineWidth(arg_2_0)
	if not arg_2_0.isLocked then
		return V1a6_CachotEnum.UnLockedRewardItemWidth
	end

	local var_2_0 = V1a6_CachotProgressListModel.instance._scrollViews
	local var_2_1 = var_2_0 and var_2_0[1]
	local var_2_2 = 0

	if var_2_1 then
		local var_2_3 = var_2_1:getCsScroll()

		var_2_2 = recthelper.getWidth(var_2_3.transform)
	end

	local var_2_4 = V1a6_CachotEnum.LockedRewardItemWidth
	local var_2_5 = (arg_2_0.index - 1) * V1a6_CachotEnum.UnLockedRewardItemWidth - var_2_2

	if var_2_5 < 0 then
		var_2_4 = math.abs(var_2_5)
	end

	return var_2_4
end

function var_0_0.computeLockedItemWidth(arg_3_0)
	return
end

return var_0_0
