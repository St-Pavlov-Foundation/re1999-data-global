module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewContainer", package.seeall)

slot0 = class("JiaLaBoNaMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapViewScene = JiaLaBoNaMapScene.New()
	slot0._viewAnim = JiaLaBoNaMapViewAnim.New()

	table.insert(slot1, slot0._mapViewScene)
	table.insert(slot1, JiaLaBoNaMapView.New())
	table.insert(slot1, slot0._viewAnim)
	table.insert(slot1, JiaLaBoNaMapViewAudio.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonsView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonsView
		}
	end
end

slot0.UI_COLSE_BLOCK_KEY = "JiaLaBoNaMapViewContainer_COLSE_BLOCK_KEY"

function slot0._overrideCloseFunc(slot0)
	UIBlockMgr.instance:startBlock(uv0.UI_COLSE_BLOCK_KEY)
	slot0._viewAnim:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0._onDelayCloseView, slot0, JiaLaBoNaEnum.AnimatorTime.MapViewClose)
end

function slot0._onDelayCloseView(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_COLSE_BLOCK_KEY)
	slot0._viewAnim:closeThis()
end

function slot0.switchPage(slot0, slot1, slot2)
	if slot0._mapViewScene then
		slot0._mapViewScene:switchPage(slot1)

		if not string.nilorempty(slot2) then
			slot0._mapViewScene:playSceneAnim(slot2)
		end
	end
end

function slot0.refreshInteract(slot0, slot1)
	if slot0._mapViewScene then
		slot0._mapViewScene:refreshInteract(slot1)
	end
end

function slot0._setVisible(slot0, slot1)
	uv0.super._setVisible(slot0, slot1)

	if slot0._mapViewScene then
		if not ViewMgr.instance:isOpen(ViewName.JiaLaBoNaStoryView) or slot1 then
			slot0._mapViewScene:setSceneActive(slot1)
		end

		if slot0._lastMapViewSceneVisible ~= slot1 then
			slot0._lastMapViewSceneVisible = slot1

			if slot1 and not slot2 then
				slot0._mapViewScene:playSceneAnim(UIAnimationName.Open)
				slot0._viewAnim:playViewAnimator(UIAnimationName.Open)
			end
		end
	end
end

function slot0.switchScene(slot0, slot1)
	if slot0._viewAnim then
		slot0._viewAnim:switchScene(slot1)
	end
end

function slot0.playPathAnim(slot0)
	if slot0._viewAnim then
		slot0._viewAnim:playPathAnim()
	end
end

function slot0.refreshPathPoin(slot0)
	if slot0._viewAnim then
		slot0._viewAnim:refreshPathPoin()
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act306)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act306
	})
end

return slot0
