module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsViewContainer", package.seeall)

local var_0_0 = class("RoleStoryDispatchTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Layout/left/#go_herocontainer/Mask/#scroll_hero"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Layout/left/#go_herocontainer/Mask/#scroll_hero/Viewport/Content/#go_heroitem"
	var_1_1.cellClass = RoleStoryDispatchLeftHeroItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 4
	var_1_1.cellWidth = 130
	var_1_1.cellHeight = 130
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 12
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryDispatchHeroListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, RoleStoryDispatchTipsView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	arg_2_0.currencyView = CurrencyView.New(var_2_0)
	arg_2_0.currencyView.foreHideBtn = true

	return {
		arg_2_0.currencyView
	}
end

return var_0_0
