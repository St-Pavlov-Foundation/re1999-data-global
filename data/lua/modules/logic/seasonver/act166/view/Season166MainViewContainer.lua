module("modules.logic.seasonver.act166.view.Season166MainViewContainer", package.seeall)

slot0 = class("Season166MainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.Season166MainSceneView = Season166MainSceneView.New()

	table.insert(slot1, slot0.Season166MainSceneView)
	table.insert(slot1, Season166MainView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			slot0.navigateView
		}
	end
end

function slot0.getMainSceneView(slot0)
	return slot0.Season166MainSceneView
end

function slot0.setOverrideCloseClick(slot0, slot1, slot2)
	slot0.navigateView:setOverrideClose(slot1, slot2)
end

function slot0.setHelpBtnShowState(slot0, slot1)
	slot0.navigateView:setHelpVisible(slot1)
end

return slot0
