module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderNextViewContainer", package.seeall)

slot0 = class("AutoChessLeaderNextViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessLeaderNextView.New())

	return slot1
end

return slot0
