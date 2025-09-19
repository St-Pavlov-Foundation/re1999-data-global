module("modules.logic.survival.view.shelter.SurvivalNpcStationViewContainer", package.seeall)

local var_0_0 = class("SurvivalNpcStationViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Panel/Right/#scroll_List"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Panel/Right/#scroll_List/Viewport/Content/#go_Item"
	var_1_1.cellClass = SurvivalMonsterEventNpcItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 800
	var_1_1.cellHeight = 336
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterNpcMonsterListModel.instance, var_1_1)
	arg_1_0._survivalNpcStationView = SurvivalNpcStationView.New()

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, arg_1_0._survivalNpcStationView)

	return var_1_0
end

function var_0_0.refreshView(arg_2_0)
	if arg_2_0._survivalNpcStationView then
		arg_2_0._survivalNpcStationView:refreshView()
	end
end

return var_0_0
