module("modules.logic.versionactivity2_5.autochess.view.AutoChessRankUpViewContainer", package.seeall)

slot0 = class("AutoChessRankUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessRankUpView.New())

	return slot1
end

return slot0
