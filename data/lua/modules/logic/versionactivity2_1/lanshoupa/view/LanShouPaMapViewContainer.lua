module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewContainer", package.seeall)

slot0 = class("LanShouPaMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapViewScene = LanShouPaMapScene.New()

	table.insert(slot1, slot0._mapViewScene)
	table.insert(slot1, LanShouPaMapView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

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

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_1Enum.ActivityId.LanShouPa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_1Enum.ActivityId.LanShouPa
	})
end

function slot0.setVisibleInternal(slot0, slot1)
	slot0._mapViewScene:setSceneVisible(slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
