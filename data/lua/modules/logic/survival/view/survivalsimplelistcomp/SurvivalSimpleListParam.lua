module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListParam", package.seeall)

local var_0_0 = pureTable("SurvivalSimpleListParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.cellClass = nil
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
end

return var_0_0
