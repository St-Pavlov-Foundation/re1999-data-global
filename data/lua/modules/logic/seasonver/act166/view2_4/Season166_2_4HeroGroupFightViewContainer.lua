module("modules.logic.seasonver.act166.view2_4.Season166_2_4HeroGroupFightViewContainer", package.seeall)

slot0 = class("Season166_2_4HeroGroupFightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season166HeroGroupFightLayoutView.New(),
		Season166_2_4HeroGroupFightView.New(),
		Season166HeroGroupListView.New(),
		Season166HeroGroupFightViewRule.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, slot0._closeCallback, nil, , slot0)

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
