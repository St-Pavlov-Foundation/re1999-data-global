module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessResultViewContainer", package.seeall)

slot0 = class("AutoChessResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessResultView.New())

	return slot1
end

return slot0
