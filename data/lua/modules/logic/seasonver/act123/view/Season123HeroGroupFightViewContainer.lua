module("modules.logic.seasonver.act123.view.Season123HeroGroupFightViewContainer", package.seeall)

slot0 = class("Season123HeroGroupFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123HeroGroupFightView.New(),
		Season123HeroGroupListView.New(),
		Season123HeroGroupFightViewRule.New(),
		Season123HeroGroupMainCardView.New(),
		Season123HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function slot0.getSeasonHeroGroupFightView(slot0)
	return slot0._views[1]
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.SeasonHerogroup, slot0._closeCallback, nil, , slot0)

		slot0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_7HerogroupHelp)
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

	MainController.instance:enterMainScene(true, false)
end

function slot0.handleVersionActivityCloseCall(slot0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return slot0
