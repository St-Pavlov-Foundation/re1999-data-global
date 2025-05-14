module("framework.mvc.model.CircleScrollParam", package.seeall)

local var_0_0 = pureTable("CircleScrollParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.scrollGOPath = nil
	arg_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0.prefabUrl = nil
	arg_1_0.cellClass = nil
	arg_1_0.scrollDir = ScrollEnum.ScrollDirH
	arg_1_0.rotateDir = ScrollEnum.ScrollRotateCW
	arg_1_0.circleCellCount = 0
	arg_1_0.scrollRadius = nil
	arg_1_0.cellRadius = nil
	arg_1_0.firstDegree = nil
	arg_1_0.isLoop = false
	arg_1_0.emptyScrollParam = nil
end

return var_0_0
