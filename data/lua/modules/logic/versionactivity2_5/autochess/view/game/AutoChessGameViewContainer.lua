module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameViewContainer", package.seeall)

slot0 = class("AutoChessGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessGameView.New())
	table.insert(slot1, AutoChessGameScene.New())

	return slot1
end

return slot0
