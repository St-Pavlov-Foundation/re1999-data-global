module("modules.logic.player.view.PlayerChangeBgListViewContainer", package.seeall)

slot0 = class("PlayerChangeBgListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PlayerChangeBgListView.New()
	}
end

return slot0
