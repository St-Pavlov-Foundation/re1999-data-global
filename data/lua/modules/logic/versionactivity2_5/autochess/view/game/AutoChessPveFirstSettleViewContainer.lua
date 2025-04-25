module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveFirstSettleViewContainer", package.seeall)

slot0 = class("AutoChessPveFirstSettleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessPveFirstSettleView.New())

	return slot1
end

return slot0
