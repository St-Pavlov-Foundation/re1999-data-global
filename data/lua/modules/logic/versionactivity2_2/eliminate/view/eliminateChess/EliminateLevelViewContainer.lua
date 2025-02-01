module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelViewContainer", package.seeall)

slot0 = class("EliminateLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._sceneView = EliminateSceneView.New()
	slot0._teamChessView = EliminateTeamChessView.New()
	slot0._eliminateView = EliminateView.New()
	slot0._eliminateLevelView = EliminateLevelView.New()

	return {
		slot0._sceneView,
		slot0._teamChessView,
		slot0._eliminateView,
		slot0._eliminateLevelView
	}
end

function slot0.setTeamChessViewParent(slot0, slot1, slot2)
	slot0._eliminateLevelView:setParent(slot1, slot2)
end

function slot0.setTeamChessTipViewParent(slot0, slot1, slot2)
	slot0._teamChessView:setTipViewParent(slot1, slot2)
end

function slot0.setVisibleInternal(slot0, slot1)
	if slot0._sceneView ~= nil then
		slot0._sceneView:setSceneVisible(slot1)
		uv0.super.setVisibleInternal(slot0, slot1)
	end
end

function slot0.onContainerOpenFinish(slot0)
end

return slot0
