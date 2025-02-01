module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainViewContainer", package.seeall)

slot0 = class("TianShiNaNaMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._mapViewScene = TianShiNaNaMainScene.New()

	return {
		slot0._mapViewScene,
		TianShiNaNaMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.TianShiNaNa
	})
end

function slot0.setVisibleInternal(slot0, slot1)
	slot0._mapViewScene:setSceneVisible(slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
