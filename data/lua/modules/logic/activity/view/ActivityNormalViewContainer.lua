module("modules.logic.activity.view.ActivityNormalViewContainer", package.seeall)

local var_0_0 = class("ActivityNormalViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ActivityCategoryItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 300
	var_1_1.cellHeight = 125
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 9.8
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(ActivityNormalCategoryListModel.instance, var_1_1))
	table.insert(var_1_0, ActivityNormalView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Activity_close)
end

return var_0_0
