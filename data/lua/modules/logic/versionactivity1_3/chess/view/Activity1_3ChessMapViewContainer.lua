module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewContainer", package.seeall)

slot0 = class("Activity1_3ChessMapViewContainer", BaseViewContainer)
slot1 = "ChessMapViewColseBlockKey"
slot2 = 0.8
slot3 = 0.3

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapViewScene = Activity1_3ChessMapScene.New()
	slot0._mapView = Activity1_3ChessMapView.New()
	slot0._viewAnim = Activity1_3ChessMapViewAnim.New()
	slot0._viewAudio = Activity1_3ChessMapViewAudio.New()
	slot1[#slot1 + 1] = slot0._mapViewScene
	slot1[#slot1 + 1] = slot0._mapView
	slot1[#slot1 + 1] = slot0._viewAnim
	slot1[#slot1 + 1] = slot0._viewAudio
	slot1[#slot1 + 1] = TabViewGroup.New(1, "#go_BackBtns")

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot2
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	UIBlockMgr.instance:startBlock(uv0)
	slot0._mapView:playViewAnimation(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0._onDelayCloseView, slot0, uv1)
end

function slot0._onDelayCloseView(slot0)
	UIBlockMgr.instance:endBlock(uv0)
	slot0._viewAnim:closeThis()
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act304)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act304
	})
end

function slot0.switchStage(slot0, slot1)
	if slot0._mapViewScene then
		slot0._mapViewScene:switchStage(slot1)
	end
end

function slot0.playPathAnim(slot0)
	if slot0._viewAnim then
		slot0._viewAnim:playPathAnim()
	end
end

function slot0.showEnterSceneView(slot0, slot1)
	if slot0._mapViewScene then
		slot0._mapViewScene:playSceneEnterAni(slot1)
	end
end

function slot0._setVisible(slot0, slot1)
	BaseViewContainer._setVisible(slot0, slot1)

	if slot0._mapViewScene then
		slot0._mapViewScene:onSetVisible(slot1)

		if not Activity1_3ChessController.instance:isReviewStory() then
			slot0._mapViewScene:setSceneActive(slot1)
		end
	end

	if slot0._mapView then
		slot0._mapView:onSetVisible(slot1, slot2)

		if not slot2 and slot1 then
			slot0._mapView:playViewAnimation(UIAnimationName.Open)
		end
	end
end

return slot0
