module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationViewContainer", package.seeall)

local var_0_0 = class("HeroInvitationViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Right/#scroll_RoleList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = HeroInvitationItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 204
	var_1_1.cellHeight = 528
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(HeroInvitationListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, HeroInvitationView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		var_2_0
	}
end

function var_0_0.getScrollView(arg_3_0)
	return arg_3_0.scrollView
end

return var_0_0
