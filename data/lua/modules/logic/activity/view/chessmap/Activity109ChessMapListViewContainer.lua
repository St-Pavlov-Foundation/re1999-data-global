module("modules.logic.activity.view.chessmap.Activity109ChessMapListViewContainer", package.seeall)

slot0 = class("Activity109ChessMapListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity109ChessMapListView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
