module("modules.logic.survival.view.shelter.ShelterRestManagerViewContainer", package.seeall)

local var_0_0 = class("ShelterRestManagerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Panel/Right/#go_Rest/Scroll View"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = ShelterRestHeroItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 240
	var_1_1.cellHeight = 600
	var_1_1.cellSpaceH = 30
	var_1_1.startSpace = 10
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterRestListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, ShelterRestManagerView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(var_1_0, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "Panel/#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

return var_0_0
