module("modules.common.global.screen.GameFullViewState", package.seeall)

slot0 = class("GameFullViewState")

function slot0.ctor(slot0)
	slot0:addConstEvents()

	slot0._sceneRootGO = nil
	slot0._ignoreViewNames = {
		[ViewName.SettingsView] = true,
		[ViewName.GMPostProcessView] = true,
		[ViewName.StoryBackgroundView] = true,
		[ViewName.V1a6_CachotCollectionSelectView] = true
	}
	slot0._ignoreSceneTypes = {
		[SceneType.Summon] = true,
		[SceneType.Explore] = true
	}
	slot0._callGCViews = {}
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._reOpenWhileOpen, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyFullViewFinish, slot0._onFullViewDestroy, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onPlayViewAnim, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onPlayViewAnim, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onPlayViewAnimFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onPlayViewAnimFinish, slot0)
	GameGCMgr.instance:registerCallback(GameGCEvent.OnFullGC, slot0._onFullGC, slot0)
end

function slot0._onFullViewDestroy(slot0, slot1)
	slot0._callGCViews[slot1] = true

	slot0:_delayGC()
end

function slot0._onPlayViewAnim(slot0, slot1)
	slot0._callGCViews[slot1] = nil

	slot0:_cancelGCTask()
end

function slot0._onPlayViewAnimFinish(slot0)
	if slot0:_needGC() then
		slot0:_delayGC()
	end
end

function slot0._onFullGC(slot0)
	tabletool.clear(slot0._callGCViews)
	slot0:_cancelGCTask()
end

function slot0._delayGC(slot0)
	slot0:_cancelGCTask()
	TaskDispatcher.runDelay(slot0._gc, slot0, 1.5)
end

function slot0._cancelGCTask(slot0)
	TaskDispatcher.cancelTask(slot0._gc, slot0)
end

function slot0._gc(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
end

function slot0._needGC(slot0)
	for slot4, slot5 in pairs(slot0._callGCViews) do
		return true
	end
end

function slot0._onOpenFullView(slot0, slot1)
	if slot0._ignoreViewNames[slot1] then
		return
	end

	if not GameSceneMgr.instance:getCurScene() then
		return
	end

	if not GameSceneMgr.instance:getCurSceneType() or slot0._ignoreSceneTypes[slot3] then
		return
	end

	slot4 = slot2:getSceneContainerGO()

	if slot0._sceneRootGO and slot4 ~= slot0._sceneRootGO then
		gohelper.setActive(slot0._sceneRootGO, true)
	end

	slot0._sceneRootGO = slot4

	gohelper.setActive(slot0._sceneRootGO, false)
	CameraMgr.instance:setSceneCameraActive(false, "fullviewstate")

	if slot3 == SceneType.Fight then
		CameraMgr.instance:setVirtualCameraChildActive(false, "light")
	end
end

function slot0.forceSceneCameraActive(slot0, slot1)
	gohelper.setActive(GameSceneMgr.instance:getCurScene() and slot2:getSceneContainerGO(), slot1)
	CameraMgr.instance:setSceneCameraActive(slot1, "fullviewstate")
end

function slot0._onCloseFullView(slot0, slot1)
	if slot0._ignoreViewNames[slot1] then
		return
	end

	if not slot0:_hasOpenFullView() then
		gohelper.setActive(slot0._sceneRootGO, true)
		CameraMgr.instance:setSceneCameraActive(true, "fullviewstate")

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			CameraMgr.instance:setVirtualCameraChildActive(true, "light")
		end
	end
end

function slot0._hasOpenFullView(slot0)
	for slot5, slot6 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if ViewMgr.instance:isFull(slot6) and not slot0._ignoreViewNames[slot6] and ViewMgr.instance:getContainer(slot6) and slot7:isOpenFinish() then
			return true
		end
	end

	return false
end

function slot0.getOpenFullViewNames(slot0)
	for slot6, slot7 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if ViewMgr.instance:isFull(slot7) and not slot0._ignoreViewNames[slot7] then
			slot1 = "" .. slot7 .. ","
		end
	end

	return slot1
end

function slot0._reOpenWhileOpen(slot0, slot1)
	if ViewMgr.instance:isFull(slot1) then
		slot0:_onOpenFullView(slot1)
	end
end

return slot0
