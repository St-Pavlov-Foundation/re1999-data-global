module("modules.logic.tower.view.permanenttower.TowerPermanentViewContainer", package.seeall)

local var_0_0 = class("TowerPermanentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._scrollListView = LuaMixScrollView.New(TowerPermanentModel.instance, arg_1_0:getListContentParam())

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, arg_1_0._scrollListView)

	arg_1_0.TowerPermanentPoolView = TowerPermanentPoolView.New()

	table.insert(var_1_0, TowerPermanentView.New())

	arg_1_0.TowerPermanentInfoView = TowerPermanentInfoView.New()

	table.insert(var_1_0, arg_1_0.TowerPermanentPoolView)
	table.insert(var_1_0, arg_1_0.TowerPermanentInfoView)

	return var_1_0
end

function var_0_0.getListContentParam(arg_2_0)
	local var_2_0 = MixScrollParam.New()

	var_2_0.scrollGOPath = "Left/#scroll_category"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_2_0.prefabUrl = "Left/#scroll_category/Viewport/#go_Content/#go_item"
	var_2_0.cellClass = TowerPermanentItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV

	return var_2_0
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerPermanent)

		return {
			arg_3_0.navigateView
		}
	end
end

function var_0_0.getTowerPermanentPoolView(arg_4_0)
	return arg_4_0.TowerPermanentPoolView
end

function var_0_0.getTowerPermanentInfoView(arg_5_0)
	return arg_5_0.TowerPermanentInfoView
end

return var_0_0
