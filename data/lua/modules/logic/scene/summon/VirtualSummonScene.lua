module("modules.logic.scene.summon.VirtualSummonScene", package.seeall)

local var_0_0 = class("VirtualSummonScene")

function var_0_0.ctor(arg_1_0)
	arg_1_0._curSceneType = SceneType.Summon
	arg_1_0._curSceneId = SummonEnum.SummonSceneId

	local var_1_0 = SceneConfig.instance:getSceneLevelCOs(arg_1_0._curSceneId)

	if var_1_0 and #var_1_0 > 0 then
		arg_1_0._curLevelId = var_1_0[1].id
	else
		logError("levelID Error in SummonScene : " .. tostring(arg_1_0._curSceneId))
	end

	arg_1_0._isOpenImmediately = false
	arg_1_0._isOpen = false
	arg_1_0.charGoPath = SummonController.getCharScenePrefabPath()

	arg_1_0:checkInitLoader()

	arg_1_0._sceneObj = SummonSceneShell.New()

	arg_1_0._sceneObj:init(arg_1_0._curSceneId, arg_1_0._curSceneLevel)
end

function var_0_0.createLoader(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = SummonLoader.New()
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		table.insert(var_2_1, iter_2_1)
	end

	table.insert(var_2_1, arg_2_2)
	var_2_0:init(var_2_1)
	var_2_0:setLoadOneItemCallback(arg_2_0.onLoadOneCallback, arg_2_0)
	var_2_0:setLoadFinishCallback(arg_2_0.onLoadAllCompleted, arg_2_0)

	return var_2_0
end

function var_0_0.checkInitLoader(arg_3_0)
	if not arg_3_0._loaderChar then
		local var_3_0 = tabletool.copy(SummonEnum.SummonCharPreloadPath)

		if SummonConfig.instance:isLuckyBagPoolExist() then
			arg_3_0:addUrlToPreloadMap(var_3_0, SummonEnum.SummonLuckyBagPreloadPath)
		end

		arg_3_0._loaderChar = arg_3_0:createLoader(var_3_0, arg_3_0.charGoPath)
		arg_3_0._isCharLoaded = false
	end
end

function var_0_0.addUrlToPreloadMap(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(arg_4_2) do
		arg_4_1[iter_4_0] = iter_4_1
	end
end

function var_0_0.checkNeedLoad(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 then
		if arg_5_0._loaderChar ~= nil then
			arg_5_0._loaderChar:checkStartLoad(arg_5_2)
		end
	else
		logError("other loader is not implement!")
	end
end

function var_0_0.onLoadOneCallback(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == arg_6_0.charGoPath then
		arg_6_0:getSummonScene().selector:initCharSceneGo(arg_6_2)
	else
		SummonEffectPool.onEffectPreload(arg_6_2)
	end
end

function var_0_0.onLoadAllCompleted(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 == arg_7_0._loaderChar

	if var_7_0 then
		arg_7_0._isCharLoaded = true
	end

	arg_7_0:dispatchEvent(SummonSceneEvent.OnPreloadFinish, var_7_0)
end

function var_0_0.onEnterScene(arg_8_0)
	return
end

function var_0_0.onCloseFullView(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = GameSceneMgr.instance:getCurScene()

	if var_9_0 and not gohelper.isNil(var_9_0:getSceneContainerGO()) then
		gohelper.setActive(var_9_0:getSceneContainerGO(), false)
	end
end

function var_0_0.onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.SummonView and arg_10_0:isOpen() then
		arg_10_0:close(true)
	end
end

function var_0_0.onClickHome(arg_11_0)
	arg_11_0:close(true)
end

function var_0_0.openSummonScene(arg_12_0, arg_12_1)
	if arg_12_0._isOpen then
		return
	end

	arg_12_0._isOpen = true
	arg_12_0._isOpenImmediately = arg_12_1

	arg_12_0:checkInitRootGO()
	arg_12_0:checkInitLoader()
	gohelper.setActive(arg_12_0:getRootGO(), true)
	arg_12_0:getSummonScene():onStart(arg_12_0._curSceneId, arg_12_0._curLevelId)

	if arg_12_0._isOpenImmediately then
		arg_12_0._loaderChar:checkStartLoad(true)
	end

	local var_12_0 = GameSceneMgr.instance:getCurScene()

	if var_12_0 and not gohelper.isNil(var_12_0:getSceneContainerGO()) then
		gohelper.setActive(var_12_0:getSceneContainerGO(), false)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_12_0.onCloseFullView, arg_12_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_12_0.onCloseView, arg_12_0)
	NavigateMgr.instance:registerCallback(NavigateEvent.ClickHome, arg_12_0.onClickHome, arg_12_0)
	arg_12_0._sceneObj.director:registerCallback(SummonSceneEvent.OnEnterScene, arg_12_0.onEnterScene, arg_12_0)
	arg_12_0:checkCloseOldSceneUI()
end

function var_0_0.close(arg_13_0, arg_13_1)
	if not arg_13_0._isOpen then
		return
	end

	logNormal("VirtualSummonScene close")

	arg_13_0._isOpen = false
	arg_13_0._isOpenImmediately = false

	if arg_13_1 then
		arg_13_0:release()
	else
		arg_13_0:hide()
	end

	arg_13_0:checkResumeMainScene()
	MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, true)
end

function var_0_0.checkCloseOldSceneUI(arg_14_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, false)
	else
		ViewMgr.instance:closeAllViews({
			ViewName.SummonADView,
			ViewName.SummonView
		})
	end
end

function var_0_0.checkResumeMainScene(arg_15_0)
	local var_15_0 = GameSceneMgr.instance:getCurScene()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		local var_15_1 = GameSceneMgr.instance:getCurScene()

		var_15_1.camera:resetParam()
		var_15_1.camera:applyDirectly()
	end

	if var_15_0 and not gohelper.isNil(var_15_0:getSceneContainerGO()) then
		gohelper.setActive(var_15_0:getSceneContainerGO(), true)
	end
end

function var_0_0.checkInitRootGO(arg_16_0)
	if gohelper.isNil(arg_16_0._rootGO) then
		arg_16_0._rootGO = gohelper.create3d(CameraMgr.instance:getSceneRoot(), "VirtualSummonScene")
	end
end

function var_0_0.getSummonScene(arg_17_0)
	return arg_17_0._sceneObj
end

function var_0_0.getRootGO(arg_18_0)
	return arg_18_0._rootGO
end

function var_0_0.isOpenImmediately(arg_19_0)
	return arg_19_0._isOpenImmediately
end

function var_0_0.isOpen(arg_20_0)
	return arg_20_0._isOpen
end

function var_0_0.isABLoaded(arg_21_0, arg_21_1)
	if arg_21_1 then
		return arg_21_0._isCharLoaded
	end

	return false
end

function var_0_0.hide(arg_22_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_22_0.onCloseFullView, arg_22_0)
	arg_22_0._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, arg_22_0.onEnterScene, arg_22_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_22_0.onCloseView, arg_22_0)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, arg_22_0.onClickHome, arg_22_0)

	local var_22_0 = arg_22_0:getRootGO()

	gohelper.setActive(var_22_0, false)
	arg_22_0:getSummonScene():onHide()
end

function var_0_0.release(arg_23_0)
	arg_23_0:getSummonScene():onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_23_0.onCloseFullView, arg_23_0)
	arg_23_0._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, arg_23_0.onEnterScene, arg_23_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_23_0.onCloseView, arg_23_0)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, arg_23_0.onClickHome, arg_23_0)

	arg_23_0._isCharLoaded = false

	SummonEffectPool.dispose()
	arg_23_0._loaderChar:dispose()

	arg_23_0._loaderChar = nil

	gohelper.destroy(arg_23_0._rootGO)

	arg_23_0._rootGO = nil
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
