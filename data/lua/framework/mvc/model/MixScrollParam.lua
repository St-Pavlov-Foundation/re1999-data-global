module("framework.mvc.model.MixScrollParam", package.seeall)

local var_0_0 = pureTable("MixScrollParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.scrollGOPath = nil
	arg_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0.prefabUrl = nil
	arg_1_0.cellClass = nil
	arg_1_0.scrollDir = ScrollEnum.ScrollDirH
	arg_1_0.emptyScrollParam = nil
	arg_1_0.startSpace = 0
	arg_1_0.endSpace = 0
end

return var_0_0
