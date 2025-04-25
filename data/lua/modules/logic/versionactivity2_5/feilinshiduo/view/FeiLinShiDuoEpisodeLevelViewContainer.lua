module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeLevelViewContainer", package.seeall)

slot0 = class("FeiLinShiDuoEpisodeLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FeiLinShiDuoEpisodeLevelView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
