module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallInfoViewContainer", package.seeall)

slot0 = class("AutoChessMallInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessMallInfoView.New())

	return slot1
end

return slot0
