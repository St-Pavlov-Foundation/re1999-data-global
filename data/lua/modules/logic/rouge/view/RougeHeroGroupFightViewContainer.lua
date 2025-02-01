module("modules.logic.rouge.view.RougeHeroGroupFightViewContainer", package.seeall)

slot0 = class("RougeHeroGroupFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._heroGroupFightView = RougeHeroGroupFightView.New()
	slot0._heroGroupLayoutView = HeroGroupFightLayoutView.New()

	return {
		slot0._heroGroupLayoutView,
		slot0._heroGroupFightView,
		HeroGroupAnimView.New(),
		RougeHeroGroupListView.New(),
		RougeHeroGroupFightViewLevel.New(),
		RougeHeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		RougeHeroGroupFightMiscView.New(),
		RougeBaseDLCViewComp.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

function slot0.getHeroGroupFightView(slot0)
	return slot0._heroGroupFightView
end

function slot0.beforeEnterFight(slot0)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			not slot0:_checkHideHomeBtn(),
			slot0:getHelpId() ~= nil
		}, slot2, slot0._closeCallback, nil, , slot0)

		slot0._navigateButtonsView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonsView
		}
	elseif slot1 == 2 then
		return {
			CurrencyView.New(slot0:_checkHidePowerCurrencyBtn() and {} or {
				CurrencyEnum.CurrencyType.Power
			})
		}
	end
end

function slot0.getHelpId(slot0)
	return HelpEnum.HelpId.RougeHeroGroupFightViewHelp
end

function slot0._closeCallback(slot0)
	slot0._manualClose = true

	slot0:closeThis()
end

function slot0.onContainerCloseFinish(slot0)
	if slot0._manualClose then
		RougeController.instance:enterRouge()
	end
end

function slot0.handleVersionActivityCloseCall(slot0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function slot0._checkHideHomeBtn(slot0)
	return true
end

slot0._hideHomeBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function slot0.checkShowHomeByEpisodeType(slot0)
	return uv0._hideHomeBtnEpisodeType[DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type]
end

function slot0._checkHidePowerCurrencyBtn(slot0)
	return slot0:checkHidePowerCurrencyBtnByEpisodeType()
end

slot0._hidePowerCurrencyBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function slot0.checkHidePowerCurrencyBtnByEpisodeType(slot0)
	return uv0._hidePowerCurrencyBtnEpisodeType[DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type]
end

function slot0.setNavigateOverrideClose(slot0, slot1, slot2)
	slot0._navigateButtonsView:setOverrideClose(slot1, slot2)
end

function slot0.defaultOverrideCloseCheck(slot0, slot1, slot2)
	if DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId).actId == VersionActivityEnum.ActivityId.Act109 then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0(uv1)
		end)

		return false
	end

	return true
end

function slot0.onContainerInit(slot0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, slot0.refreshHelpBtnIcon, slot0)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function slot0.onContainerDestroy(slot0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, slot0.refreshHelpBtnIcon, slot0)
end

function slot0.refreshHelpBtnIcon(slot0)
	slot0._navigateButtonsView:changerHelpId(slot0:getHelpId())
end

return slot0
