module("framework.mvc.model.TreeScrollParam", package.seeall)

local var_0_0 = pureTable("TreeScrollParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.scrollGOPath = nil
	arg_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0.prefabUrls = nil
	arg_1_0.cellClass = nil
	arg_1_0.scrollDir = ScrollEnum.ScrollDirH
	arg_1_0.emptyScrollParam = nil
end

return var_0_0
