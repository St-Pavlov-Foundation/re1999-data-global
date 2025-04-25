module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderShowViewContainer", package.seeall)

slot0 = class("AutoChessLeaderShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessLeaderShowView.New())

	return slot1
end

return slot0
