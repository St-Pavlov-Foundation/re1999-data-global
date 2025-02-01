module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditViewContainer", package.seeall)

slot0 = class("V1a6_CachotHeroGroupEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = V1a6_CachotHeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return {
		V1a6_CachotHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(V1a6_CachotHeroGroupEditListModel.instance, slot1, {
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
	slot1.cellClass = V1a6_CachotHeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(HeroGroupQuickEditListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.Cachot1_6HeroGroupHelp)

	slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)

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

function slot0._modifyHeroGroup(slot0)
	if slot0.viewParam.selectHeroFromEvent then
		if not HeroModel.instance:getById(tostring(V1a6_CachotHeroSingleGroupModel.instance:getList()[1].heroUid)) then
			return
		end

		RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventMo.eventId, slot4.heroId, slot0._onSelectEnd, slot0)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectHero, slot4)
	end
end

function slot0._onSelectEnd(slot0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function slot0.onContainerClose(slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)
end

function slot0._checkClose(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_sendEndEventRequest()
	end)
end

function slot0._sendEndEventRequest(slot0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventMo.eventId, slot0._closeHeroGroupEditView, slot0)
end

function slot0._closeHeroGroupEditView(slot0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function slot0._overrideClose(slot0)
	if slot0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		slot0:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.V1a6_CachotHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
	end
end

function slot0._setHomeBtnVisible(slot0, slot1)
	slot0._navigateButtonView:setParam({
		true,
		slot1,
		true
	})
end

return slot0
