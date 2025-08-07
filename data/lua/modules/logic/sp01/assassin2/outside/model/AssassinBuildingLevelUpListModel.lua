module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingLevelUpListModel", package.seeall)

local var_0_0 = class("AssassinBuildingLevelUpListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1

	local var_1_0 = {}
	local var_1_1 = AssassinConfig.instance:getBuildingTypeDict(arg_1_1)

	for iter_1_0, iter_1_1 in pairs(var_1_1 or {}) do
		table.insert(var_1_0, iter_1_1)
	end

	table.sort(var_1_0, arg_1_0._buildingSortFunc)
	arg_1_0:setList(var_1_0)
end

function var_0_0._buildingSortFunc(arg_2_0, arg_2_1)
	return arg_2_0.level < arg_2_1.level
end

function var_0_0.markNeedPlayOpenAnimItemCount(arg_3_0, arg_3_1)
	arg_3_0._needPlayOpenAnimItemCount = arg_3_1 or 0
end

function var_0_0.getNeedPlayOpenAnimItemCount(arg_4_0)
	return arg_4_0._needPlayOpenAnimItemCount or 0
end

function var_0_0.onItemPlayOpenAnimDone(arg_5_0)
	arg_5_0._needPlayOpenAnimItemCount = arg_5_0._needPlayOpenAnimItemCount - 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
