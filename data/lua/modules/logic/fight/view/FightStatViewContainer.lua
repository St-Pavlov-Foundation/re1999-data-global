module("modules.logic.fight.view.FightStatViewContainer", package.seeall)

local var_0_0 = class("FightStatViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "view/scroll"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "view/scroll/item"
	var_1_0.cellClass = FightStatItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1660
	var_1_0.cellHeight = 146
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 6.5

	local var_1_1 = LuaListScrollView.New(FightStatModel.instance, var_1_0)

	arg_1_0.fightStatView = FightStatView.New()

	return {
		arg_1_0.fightStatView,
		var_1_1
	}
end

return var_0_0
