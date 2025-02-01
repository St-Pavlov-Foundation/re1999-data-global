module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapViewContainer", package.seeall)

slot0 = class("AiZiLaMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapView = AiZiLaMapView.New()

	table.insert(slot1, slot0._mapView)
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

slot0.UI_COLSE_BLOCK_KEY = "AiZiLaMapViewContainer_COLSE_BLOCK_KEY"

function slot0._overrideCloseFunc(slot0)
	AiZiLaHelper.startBlock(uv0.UI_COLSE_BLOCK_KEY)
	slot0._mapView:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0._onDelayCloseView, slot0, AiZiLaEnum.AnimatorTime.MapViewClose)
end

function slot0._onDelayCloseView(slot0)
	AiZiLaHelper.endBlock(uv0.UI_COLSE_BLOCK_KEY)
	slot0:closeThis()
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.AiZiLa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

return slot0
