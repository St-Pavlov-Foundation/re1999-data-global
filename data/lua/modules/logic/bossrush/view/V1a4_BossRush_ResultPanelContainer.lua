module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelContainer", package.seeall)

local var_0_0 = class("V1a4_BossRush_ResultPanelContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()
	local var_1_1 = V1a4_BossRush_ResultPanelListModel.instance

	var_1_0.cellClass = V1a4_BossRush_ResultPanelItem
	var_1_0.scrollGOPath = "Root/Right/Slider/#go_Slider/#scroll_progress"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst"
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 200
	var_1_0.cellSpaceH = 150
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.endSpace = 150
	arg_1_0._listScrollParam = var_1_0
	arg_1_0._scrollView = LuaListScrollView.New(var_1_1, var_1_0)

	return {
		V1a4_BossRush_ResultPanel.New(),
		arg_1_0._scrollView
	}
end

function var_0_0.getListScrollParam(arg_2_0)
	return arg_2_0._listScrollParam
end

function var_0_0.getScrollView(arg_3_0)
	return arg_3_0._scrollView
end

function var_0_0.getCsListScroll(arg_4_0)
	return (arg_4_0:getScrollView():getCsListScroll())
end

function var_0_0.onContainerCloseFinish(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
end

return var_0_0
