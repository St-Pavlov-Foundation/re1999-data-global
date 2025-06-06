﻿module("modules.logic.seasonver.act123.view2_1.Season123_2_1PickAssistViewContainer", package.seeall)

local var_0_0 = class("Season123_2_1PickAssistViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.viewOpenAnimTime = 0.4
	arg_1_0.scrollView = arg_1_0:instantiateListScrollView()

	return {
		Season123_2_1PickAssistView.New(),
		arg_1_0.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function var_0_0.instantiateListScrollView(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#scroll_selection"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season123_2_1PickAssistItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 6
	var_2_0.cellWidth = 296
	var_2_0.cellHeight = 636

	local var_2_1 = {}

	for iter_2_0 = 1, 15 do
		var_2_1[iter_2_0] = math.ceil((iter_2_0 - 1) % 6) * 0.03 + arg_2_0.viewOpenAnimTime
	end

	return LuaListScrollViewWithAnimator.New(Season123PickAssistListModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	end
end

return var_0_0
