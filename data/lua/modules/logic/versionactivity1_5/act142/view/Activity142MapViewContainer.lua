module("modules.logic.versionactivity1_5.act142.view.Activity142MapViewContainer", package.seeall)

slot0 = class("Activity142MapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapView = Activity142MapView.New()
	slot1[#slot1 + 1] = slot0._mapView
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
	slot0._mapView:playViewAnimation(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
	TaskDispatcher.runDelay(slot0._onDelayCloseView, slot0, Activity142Enum.CLOSE_MAP_VIEW_TIME)
end

function slot0._onDelayCloseView(slot0)
	slot0:closeThis()
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Activity142)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Activity142
	})
end

function slot0._setVisible(slot0, slot1)
	BaseViewContainer._setVisible(slot0, slot1)

	if not slot0._mapView then
		return
	end

	slot0._mapView:onSetVisible(slot1)

	if slot1 then
		slot0._mapView:playViewAnimation(UIAnimationName.Open)
	end
end

return slot0
