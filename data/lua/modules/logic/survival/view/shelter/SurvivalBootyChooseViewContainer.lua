module("modules.logic.survival.view.shelter.SurvivalBootyChooseViewContainer", package.seeall)

local var_0_0 = class("SurvivalBootyChooseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "Panel/#go_npcselect/#scroll_List"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem"
	var_1_0.cellClass = SurvivalBootyChooseNpcItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 280
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterChooseNpcListModel.instance, var_1_0)
	arg_1_0._survivalBootyChooseView = SurvivalBootyChooseView.New()

	return {
		arg_1_0._survivalBootyChooseView,
		arg_1_0.scrollView
	}
end

function var_0_0.refreshNpcChooseView(arg_2_0)
	if arg_2_0._survivalBootyChooseView then
		arg_2_0._survivalBootyChooseView:_refreshNpcSelectPanel()
	end
end

return var_0_0
