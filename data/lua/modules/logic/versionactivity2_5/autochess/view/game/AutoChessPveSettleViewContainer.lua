module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveSettleViewContainer", package.seeall)

slot0 = class("AutoChessPveSettleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessPveSettleView.New())

	return slot1
end

return slot0
