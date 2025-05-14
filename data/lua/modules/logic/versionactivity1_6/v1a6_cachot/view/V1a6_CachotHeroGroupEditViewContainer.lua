module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = V1a6_CachotHeroGroupEditItem
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
		V1a6_CachotHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(V1a6_CachotHeroGroupEditListModel.instance, var_1_0, var_1_1),
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
	var_2_0.cellClass = V1a6_CachotHeroGroupEditItem
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
		true
	}, HelpEnum.HelpId.Cachot1_6HeroGroupHelp)

	arg_3_0._navigateButtonView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)

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

function var_0_0._modifyHeroGroup(arg_6_0)
	if arg_6_0.viewParam.selectHeroFromEvent then
		local var_6_0 = V1a6_CachotHeroSingleGroupModel.instance:getList()[1].heroUid
		local var_6_1 = HeroModel.instance:getById(tostring(var_6_0))

		if not var_6_1 then
			return
		end

		RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventMo.eventId, var_6_1.heroId, arg_6_0._onSelectEnd, arg_6_0)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectHero, var_6_1)
	end
end

function var_0_0._onSelectEnd(arg_7_0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function var_0_0.onContainerClose(arg_8_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_8_0._modifyHeroGroup, arg_8_0)
end

function var_0_0._checkClose(arg_9_0)
	local function var_9_0()
		arg_9_0:_sendEndEventRequest()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, var_9_0)
end

function var_0_0._sendEndEventRequest(arg_11_0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_11_0.viewParam.eventMo.eventId, arg_11_0._closeHeroGroupEditView, arg_11_0)
end

function var_0_0._closeHeroGroupEditView(arg_12_0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function var_0_0._overrideClose(arg_13_0)
	if arg_13_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		arg_13_0:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.V1a6_CachotHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
	end
end

function var_0_0._setHomeBtnVisible(arg_14_0, arg_14_1)
	arg_14_0._navigateButtonView:setParam({
		true,
		arg_14_1,
		true
	})
end

return var_0_0
