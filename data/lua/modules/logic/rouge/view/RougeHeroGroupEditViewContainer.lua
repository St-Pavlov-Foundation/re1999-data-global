module("modules.logic.rouge.view.RougeHeroGroupEditViewContainer", package.seeall)

local var_0_0 = class("RougeHeroGroupEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = RougeHeroGroupEditItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 450
	var_1_0.cellSpaceH = 12
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 37

	local var_1_1 = {}

	for iter_1_0 = 1, 15 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.03
	end

	return {
		RougeHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(RougeHeroGroupEditListModel.instance, var_1_0, var_1_1),
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
	var_2_0.cellClass = RougeHeroGroupQuickEditItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 5
	var_2_0.cellWidth = 200
	var_2_0.cellHeight = 450
	var_2_0.cellSpaceH = 12
	var_2_0.cellSpaceV = 10
	var_2_0.startSpace = 37

	local var_2_1 = {}

	for iter_2_0 = 1, 15 do
		var_2_1[iter_2_0] = math.ceil((iter_2_0 - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RougeHeroGroupQuickEditListModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	arg_3_0._navigateButtonView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)
	arg_3_0._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeInitTeamViewHelp)

	return {
		arg_3_0._navigateButtonView
	}
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	FightAudioMgr.instance:init()
end

function var_0_0.onContainerOpen(arg_5_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, arg_5_0._modifyHeroGroup, arg_5_0)
end

function var_0_0.checkSelectHeroResult(arg_6_0)
	arg_6_0:_modifyHeroGroup()
end

function var_0_0.getQuickSelectHeroList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = RougeHeroGroupQuickEditListModel.instance:getHeroUids()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = HeroModel.instance:getById(iter_7_1)

		if var_7_2 then
			table.insert(var_7_0, var_7_2.heroId)
		end
	end

	return var_7_0
end

function var_0_0._modifyHeroGroup(arg_8_0)
	if arg_8_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		local var_8_0 = arg_8_0:getQuickSelectHeroList()
		local var_8_1 = arg_8_0.viewParam.selectHeroCallback
		local var_8_2 = arg_8_0.viewParam.selectHeroCallbackTarget

		if var_8_1 then
			var_8_1(var_8_2, var_8_0)
		end
	end
end

function var_0_0._onSelectEnd(arg_9_0)
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function var_0_0.onContainerClose(arg_10_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_10_0._modifyHeroGroup, arg_10_0)
end

function var_0_0._checkClose(arg_11_0)
	local function var_11_0()
		arg_11_0:_closeHeroGroupEditView()

		local var_12_0 = arg_11_0.viewParam.selectHeroCallback
		local var_12_1 = arg_11_0.viewParam.selectHeroCallbackTarget

		if var_12_0 then
			var_12_0(var_12_1)
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, var_11_0)
end

function var_0_0._closeHeroGroupEditView(arg_13_0)
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function var_0_0._overrideClose(arg_14_0)
	if arg_14_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		arg_14_0:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.RougeHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
	end
end

function var_0_0._setHomeBtnVisible(arg_15_0, arg_15_1)
	arg_15_1 = false

	arg_15_0._navigateButtonView:setParam({
		true,
		arg_15_1,
		true
	})
end

return var_0_0
