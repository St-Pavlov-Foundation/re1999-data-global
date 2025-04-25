module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleViewContainer", package.seeall)

slot0 = class("AutoChessPvpSettleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessPvpSettleView.New())

	return slot1
end

return slot0
