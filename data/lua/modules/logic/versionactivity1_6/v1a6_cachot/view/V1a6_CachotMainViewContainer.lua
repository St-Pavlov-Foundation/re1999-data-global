module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainViewContainer", package.seeall)

slot0 = class("V1a6_CachotMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._guideDragTip = V1a6_CachotGuideDragTip.New()

	return {
		V1a6_CachotMainView.New(),
		V1a6_CachotPlayCtrlView.New(),
		slot0._guideDragTip,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	slot2:setOverrideClose(slot0._onCloseClick, slot0)
	slot2:setOverrideHome(slot0._onHomeClick, slot0)
	slot2:setCloseCheck(slot0._navCloseCheck, slot0)

	return {
		slot2
	}
end

function slot0._navCloseCheck(slot0)
	return not (slot0._guideDragTip and slot0._guideDragTip:isShowDragTip())
end

function slot0._onCloseClick(slot0)
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , V1a6_CachotEnum.ActivityId)
	end)
end

function slot0._onHomeClick(slot0)
	MainController.instance:enterMainScene()
end

return slot0
