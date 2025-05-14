module("framework.mvc.model.EmptyScrollParam", package.seeall)

local var_0_0 = class("EmptyScrollParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0.prefabUrl = nil
	arg_1_0.parentPath = nil
	arg_1_0.handleClass = BaseEmptyScrollHandler
	arg_1_0.params = nil
end

function var_0_0.setFromView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	arg_2_0.prefabUrl = arg_2_1
	arg_2_0.handleClass = arg_2_2 or BaseEmptyScrollHandler
	arg_2_0.params = arg_2_3
end

function var_0_0.setFromRes(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_3_0.prefabUrl = arg_3_1
	arg_3_0.parentPath = arg_3_2
	arg_3_0.handleClass = arg_3_3 or BaseEmptyScrollHandler
	arg_3_0.params = arg_3_4
end

return var_0_0
