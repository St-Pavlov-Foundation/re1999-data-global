module("modules.logic.activity.view.chessmap.ActivityChessGameRewardViewContainer", package.seeall)

slot0 = class("ActivityChessGameRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityChessGameRewardView.New())

	return slot1
end

return slot0
