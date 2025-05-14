module("modules.logic.herogroup.view.HeroGroupEditViewContainer", package.seeall)

local var_0_0 = class("HeroGroupEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = HeroGroupEditItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 440
	var_1_0.cellSpaceH = 12
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 37

	local var_1_1 = {}

	for iter_1_0 = 1, 15 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.03
	end

	return {
		HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupEditListModel.instance, var_1_0, var_1_1),
		arg_1_0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.getQuickEditScroll(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[2]
	var_2_0.cellClass = HeroGroupQuickEditItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 5
	var_2_0.cellWidth = 200
	var_2_0.cellHeight = 440
	var_2_0.cellSpaceH = 12
	var_2_0.cellSpaceV = 10
	var_2_0.startSpace = 37

	local var_2_1 = {}

	for iter_2_0 = 1, 15 do
		var_2_1[iter_2_0] = math.ceil((iter_2_0 - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(HeroGroupQuickEditListModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	arg_3_0._navigateButtonView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)

	return {
		arg_3_0._navigateButtonView
	}
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

function var_0_0._overrideClose(arg_5_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.HeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.HeroGroupEditView, nil, true)
	end
end

function var_0_0._setHomeBtnVisible(arg_6_0, arg_6_1)
	arg_6_0._navigateButtonView:setParam({
		true,
		arg_6_1,
		false
	})
end

return var_0_0
