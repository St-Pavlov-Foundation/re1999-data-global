module("framework.mvc.model.ListScrollParam", package.seeall)

local var_0_0 = pureTable("ListScrollParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.scrollGOPath = nil
	arg_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	arg_1_0.prefabUrl = nil
	arg_1_0.cellClass = nil
	arg_1_0.multiSelect = false
	arg_1_0.scrollDir = ScrollEnum.ScrollDirH
	arg_1_0.lineCount = 1
	arg_1_0.cellWidth = 100
	arg_1_0.cellHeight = 100
	arg_1_0.cellSpaceH = 0
	arg_1_0.cellSpaceV = 0
	arg_1_0.startSpace = 0
	arg_1_0.endSpace = 0
	arg_1_0.sortMode = ScrollEnum.ScrollSortNone
	arg_1_0.frameUpdateMs = 10
	arg_1_0.minUpdateCountInFrame = 1
	arg_1_0.emptyScrollParam = nil
end

return var_0_0
