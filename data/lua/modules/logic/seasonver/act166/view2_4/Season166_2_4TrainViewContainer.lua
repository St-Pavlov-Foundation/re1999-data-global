module("modules.logic.seasonver.act166.view2_4.Season166_2_4TrainViewContainer", package.seeall)

slot0 = class("Season166_2_4TrainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166TrainView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, Season166WordEffectView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			slot0.navigateView
		}
	end
end

function slot0.setOverrideCloseClick(slot0, slot1, slot2)
	slot0.navigateView:setOverrideClose(slot1, slot2)
end

return slot0
