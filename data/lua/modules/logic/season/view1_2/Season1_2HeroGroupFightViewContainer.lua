module("modules.logic.season.view1_2.Season1_2HeroGroupFightViewContainer", package.seeall)

slot0 = class("Season1_2HeroGroupFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_2HeroGroupFightView.New(),
		Season1_2HeroGroupListView.New(),
		Season1_2HeroGroupFightViewRule.New(),
		Season1_2HeroFightViewLevel.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function slot0.getSeason1_2HeroGroupFightView(slot0)
	return slot0._views[1]
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season1_2HerogroupHelp, slot0._closeCallback, nil, , slot0)

		slot0._navigateButtonsView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0._closeCallback(slot0)
	slot0:closeThis()

	if slot0:handleVersionActivityCloseCall() then
		return
	end

	if DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreChapter(slot2.chapterId)
	else
		MainController.instance:enterMainScene(true, false)
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
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0(uv1)
		end)

		return false
	end

	return true
end

return slot0
