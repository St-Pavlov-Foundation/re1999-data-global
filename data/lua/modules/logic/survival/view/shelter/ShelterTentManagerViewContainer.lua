module("modules.logic.survival.view.shelter.ShelterTentManagerViewContainer", package.seeall)

local var_0_0 = class("ShelterTentManagerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Panel/#go_SelectPanel/#scroll_List"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Panel/#go_SelectPanel/#scroll_List/Viewport/Content/#go_SmallItem"
	var_1_1.cellClass = ShelterTentManagerNpcItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 280
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterTentListModel.instance, var_1_1)
	arg_1_0.managerView = ShelterTentManagerView.New()

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, arg_1_0.managerView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(var_1_0, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "Panel/#go_topright"))

	return var_1_0
end

function var_0_0.refreshManagerSelectPanel(arg_2_0)
	if not arg_2_0.managerView then
		return
	end

	arg_2_0.managerView:refreshSelectPanel()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		local var_3_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_3_0
		}
	end
end

return var_0_0
