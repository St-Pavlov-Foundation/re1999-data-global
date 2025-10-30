module("modules.common.global.screen.GameFullViewState", package.seeall)

local var_0_0 = class("GameFullViewState")

function var_0_0.ctor(arg_1_0)
	arg_1_0:addConstEvents()

	arg_1_0._sceneRootGO = nil
	arg_1_0._ignoreViewNames = {}
	arg_1_0._ignoreViewNames[ViewName.SettingsView] = true
	arg_1_0._ignoreViewNames[ViewName.GMPostProcessView] = true
	arg_1_0._ignoreViewNames[ViewName.StoryBackgroundView] = true
	arg_1_0._ignoreViewNames[ViewName.V1a6_CachotCollectionSelectView] = true
	arg_1_0._ignoreSceneTypes = {}
	arg_1_0._ignoreSceneTypes[SceneType.Summon] = true
	arg_1_0._ignoreSceneTypes[SceneType.Explore] = true
	arg_1_0._callGCViews = {}
	arg_1_0._banGcKey = {}
end

function var_0_0.addConstEvents(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, arg_2_0._onOpenFullView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_2_0._onCloseFullView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_2_0._reOpenWhileOpen, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyFullViewFinish, arg_2_0._onFullViewDestroy, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onPlayViewAnim, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onPlayViewAnim, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onPlayViewAnimFinish, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onPlayViewAnimFinish, arg_2_0)
	GameGCMgr.instance:registerCallback(GameGCEvent.OnFullGC, arg_2_0._onFullGC, arg_2_0)
	GameGCMgr.instance:registerCallback(GameGCEvent.SetBanGc, arg_2_0._onSetBanGC, arg_2_0)
end

function var_0_0._onFullViewDestroy(arg_3_0, arg_3_1)
	arg_3_0._callGCViews[arg_3_1] = true

	arg_3_0:_delayGC()
end

function var_0_0._onPlayViewAnim(arg_4_0, arg_4_1)
	arg_4_0._callGCViews[arg_4_1] = nil

	arg_4_0:_cancelGCTask()
end

function var_0_0._onPlayViewAnimFinish(arg_5_0)
	if arg_5_0:_needGC() then
		arg_5_0:_delayGC()
	end
end

function var_0_0._onFullGC(arg_6_0)
	tabletool.clear(arg_6_0._callGCViews)
	arg_6_0:_cancelGCTask()
end

function var_0_0._onSetBanGC(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 then
		arg_7_0._banGcKey[arg_7_1] = true
	else
		arg_7_0._banGcKey[arg_7_1] = nil
	end
end

function var_0_0._delayGC(arg_8_0)
	arg_8_0:_cancelGCTask()
	TaskDispatcher.runDelay(arg_8_0._gc, arg_8_0, 1.5)
end

function var_0_0._cancelGCTask(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._gc, arg_9_0)
end

function var_0_0._gc(arg_10_0)
	if next(arg_10_0._banGcKey) then
		return
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_10_0)
end

function var_0_0._needGC(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._callGCViews) do
		return true
	end
end

function var_0_0._onOpenFullView(arg_12_0, arg_12_1)
	if arg_12_0._ignoreViewNames[arg_12_1] then
		return
	end

	local var_12_0 = GameSceneMgr.instance:getCurScene()

	if not var_12_0 then
		return
	end

	local var_12_1 = GameSceneMgr.instance:getCurSceneType()

	if not var_12_1 or arg_12_0._ignoreSceneTypes[var_12_1] then
		return
	end

	local var_12_2 = var_12_0:getSceneContainerGO()

	if arg_12_0._sceneRootGO and var_12_2 ~= arg_12_0._sceneRootGO then
		gohelper.setActive(arg_12_0._sceneRootGO, true)
	end

	arg_12_0._sceneRootGO = var_12_2

	gohelper.setActive(arg_12_0._sceneRootGO, false)
	CameraMgr.instance:setSceneCameraActive(false, "fullviewstate")

	if var_12_1 == SceneType.Fight then
		CameraMgr.instance:setVirtualCameraChildActive(false, "light")
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SceneGoChangeVisible, false)
end

function var_0_0.forceSceneCameraActive(arg_13_0, arg_13_1)
	local var_13_0 = GameSceneMgr.instance:getCurScene()
	local var_13_1 = var_13_0 and var_13_0:getSceneContainerGO()

	gohelper.setActive(var_13_1, arg_13_1)
	CameraMgr.instance:setSceneCameraActive(arg_13_1, "fullviewstate")
end

function var_0_0._onCloseFullView(arg_14_0, arg_14_1)
	if arg_14_0._ignoreViewNames[arg_14_1] then
		return
	end

	if not arg_14_0:_hasOpenFullView() then
		gohelper.setActive(arg_14_0._sceneRootGO, true)
		CameraMgr.instance:setSceneCameraActive(true, "fullviewstate")

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			CameraMgr.instance:setVirtualCameraChildActive(true, "light")
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.SceneGoChangeVisible, true)
	end
end

function var_0_0._hasOpenFullView(arg_15_0)
	local var_15_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if ViewMgr.instance:isFull(iter_15_1) and not arg_15_0._ignoreViewNames[iter_15_1] then
			local var_15_1 = ViewMgr.instance:getContainer(iter_15_1)

			if var_15_1 and var_15_1:isOpenFinish() then
				return true
			end
		end
	end

	return false
end

function var_0_0.getOpenFullViewNames(arg_16_0)
	local var_16_0 = ""
	local var_16_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if ViewMgr.instance:isFull(iter_16_1) and not arg_16_0._ignoreViewNames[iter_16_1] then
			var_16_0 = var_16_0 .. iter_16_1 .. ","
		end
	end

	return var_16_0
end

function var_0_0._reOpenWhileOpen(arg_17_0, arg_17_1)
	if ViewMgr.instance:isFull(arg_17_1) then
		arg_17_0:_onOpenFullView(arg_17_1)
	end
end

return var_0_0
