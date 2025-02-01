module("modules.logic.rouge.view.RougeHeroGroupEditViewContainer", package.seeall)

slot0 = class("RougeHeroGroupEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = RougeHeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 450
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return {
		RougeHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(RougeHeroGroupEditListModel.instance, slot1, {
			[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
		}),
		slot0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getQuickEditScroll(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = RougeHeroGroupQuickEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 450
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(RougeHeroGroupQuickEditListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)
	slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeInitTeamViewHelp)

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	FightAudioMgr.instance:init()
end

function slot0.onContainerOpen(slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)
end

function slot0.checkSelectHeroResult(slot0)
	slot0:_modifyHeroGroup()
end

function slot0.getQuickSelectHeroList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(RougeHeroGroupQuickEditListModel.instance:getHeroUids()) do
		if HeroModel.instance:getById(slot7) then
			table.insert(slot1, slot8.heroId)
		end
	end

	return slot1
end

function slot0._modifyHeroGroup(slot0)
	if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		if slot0.viewParam.selectHeroCallback then
			slot2(slot0.viewParam.selectHeroCallbackTarget, slot0:getQuickSelectHeroList())
		end
	end
end

function slot0._onSelectEnd(slot0)
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function slot0.onContainerClose(slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)
end

function slot0._checkClose(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_closeHeroGroupEditView()

		if uv0.viewParam.selectHeroCallback then
			slot0(uv0.viewParam.selectHeroCallbackTarget)
		end
	end)
end

function slot0._closeHeroGroupEditView(slot0)
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function slot0._overrideClose(slot0)
	if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		slot0:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.RougeHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
	end
end

function slot0._setHomeBtnVisible(slot0, slot1)
	slot0._navigateButtonView:setParam({
		true,
		false,
		true
	})
end

return slot0
