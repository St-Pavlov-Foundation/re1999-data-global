module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameSceneContainer", package.seeall)

slot0 = class("Va3ChessGameSceneContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Va3ChessGameScene.New())

	return slot1
end

return slot0
