module("modules.logic.room.view.manufacture.RoomManufactureAddPopViewContainer", package.seeall)

local var_0_0 = class("RoomManufactureAddPopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "root/#go_addPop/#scroll_production"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "root/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	var_1_1.cellClass = RoomManufactureFormulaItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(ManufactureFormulaListModel.instance, var_1_1))

	arg_1_0._popView = RoomManufactureAddPopView.New()

	table.insert(var_1_0, arg_1_0._popView)

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	arg_2_0:startViewCloseBlock()
	arg_2_0._popView.animatorPlayer:Play(UIAnimationName.Close, arg_2_0.onPlayCloseTransitionFinish, arg_2_0)
end

return var_0_0
