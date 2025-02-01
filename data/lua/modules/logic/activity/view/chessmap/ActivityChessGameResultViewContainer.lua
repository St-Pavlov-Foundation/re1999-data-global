module("modules.logic.activity.view.chessmap.ActivityChessGameResultViewContainer", package.seeall)

slot0 = class("ActivityChessGameResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityChessGameResultView.New())

	return slot1
end

return slot0
