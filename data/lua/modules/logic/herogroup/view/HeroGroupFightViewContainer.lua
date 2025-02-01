module("modules.logic.herogroup.view.HeroGroupFightViewContainer", package.seeall)

slot0 = class("HeroGroupFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	slot0:defineFightView()
	slot0:addFirstViews(slot1)
	slot0:addCommonViews(slot1)
	slot0:addLastViews(slot1)

	return slot1
end

function slot0.addFirstViews(slot0, slot1)
	table.insert(slot1, HeroGroupFightCleanView.New())
end

function slot0.defineFightView(slot0)
	slot0._heroGroupFightView = HeroGroupFightView.New()
	slot0._heroGroupFightListView = HeroGroupListView.New()
end

function slot0.addCommonViews(slot0, slot1)
	table.insert(slot1, slot0._heroGroupFightView)
	table.insert(slot1, HeroGroupAnimView.New())
	table.insert(slot1, slot0._heroGroupFightListView.New())
	table.insert(slot1, HeroGroupFightViewLevel.New())
	table.insert(slot1, HeroGroupFightViewRule.New())
	table.insert(slot1, HeroGroupInfoScrollView.New())
	table.insert(slot1, CheckActivityEndView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function slot0.addLastViews(slot0, slot1)
end

function slot0.getHeroGroupFightView(slot0)
	return slot0._heroGroupFightView
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			slot0:getHelpId() ~= nil
		}, slot2, slot0._closeCallback, nil, , slot0)

		slot0._navigateButtonsView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonsView
		}
	elseif slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	end
end

function slot0.getHelpId(slot0)
	slot1 = nil
	slot5 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId).type == DungeonEnum.ChapterType.Hard
	slot6 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	slot7 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		return HelpEnum.HelpId.Balance
	end

	if slot5 then
		if GuideModel.instance:isGuideFinish(slot7) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupHard) then
			slot1 = HelpEnum.HelpId.HeroGroupHard
		end
	elseif GuideModel.instance:isGuideFinish(slot6) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupNormal) then
		slot1 = HelpEnum.HelpId.HeroGroupNormal
	end

	return slot1
end

function slot0._closeCallback(slot0)
	slot0:closeThis()

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle(true)

		return
	end

	if slot0:handleVersionActivityCloseCall() then
		return
	end

	if DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	else
		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(slot1, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function slot0.handleVersionActivityCloseCall(slot0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function slot0.setNavigateOverrideClose(slot0, slot1, slot2)
	slot0._navigateButtonsView:setOverrideClose(slot1, slot2)
end

function slot0.defaultOverrideCloseCheck(slot0, slot1, slot2)
	if DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId).actId == VersionActivityEnum.ActivityId.Act109 then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot1, nil, , slot2)

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
