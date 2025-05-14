module("modules.logic.activity.view.ActivityBeginnerViewContainer", package.seeall)

local var_0_0 = class("ActivityBeginnerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_category/#scroll_categoryitem"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ActivityCategoryItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 405
	var_1_1.cellHeight = 125
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 9.8
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(ActivityBeginnerCategoryListModel.instance, var_1_1))
	table.insert(var_1_0, ActivityBeginnerView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigationView
	}
end

local var_0_1 = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = HelpEnum.HelpId.ActivityWarmUp
}

function var_0_0.refreshHelp(arg_3_0, arg_3_1)
	if arg_3_0.navigationView then
		local var_3_0 = var_0_1[arg_3_1]

		if var_3_0 then
			arg_3_0.navigationView:setHelpId(var_3_0)
		else
			arg_3_0.navigationView:hideHelpIcon()
		end
	end
end

function var_0_0.hideHelp(arg_4_0)
	if arg_4_0.navigationView then
		arg_4_0.navigationView:hideHelpIcon()
	end
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_common_pause)
end

return var_0_0
