module("modules.logic.scene.summon.VirtualSummonScene", package.seeall)

slot0 = class("VirtualSummonScene")

function slot0.ctor(slot0)
	slot0._curSceneType = SceneType.Summon
	slot0._curSceneId = SummonEnum.SummonSceneId

	if SceneConfig.instance:getSceneLevelCOs(slot0._curSceneId) and #slot1 > 0 then
		slot0._curLevelId = slot1[1].id
	else
		logError("levelID Error in SummonScene : " .. tostring(slot0._curSceneId))
	end

	slot0._isOpenImmediately = false
	slot0._isOpen = false
	slot0.charGoPath = SummonController.getCharScenePrefabPath()

	slot0:checkInitLoader()

	slot0._sceneObj = SummonSceneShell.New()

	slot0._sceneObj:init(slot0._curSceneId, slot0._curSceneLevel)
end

function slot0.createLoader(slot0, slot1, slot2)
	slot3 = SummonLoader.New()
	slot4 = {}

	for slot8, slot9 in pairs(slot1) do
		table.insert(slot4, slot9)
	end

	table.insert(slot4, slot2)
	slot3:init(slot4)
	slot3:setLoadOneItemCallback(slot0.onLoadOneCallback, slot0)
	slot3:setLoadFinishCallback(slot0.onLoadAllCompleted, slot0)

	return slot3
end

function slot0.checkInitLoader(slot0)
	if not slot0._loaderChar then
		slot1 = tabletool.copy(SummonEnum.SummonCharPreloadPath)

		if SummonConfig.instance:isLuckyBagPoolExist() then
			slot0:addUrlToPreloadMap(slot1, SummonEnum.SummonLuckyBagPreloadPath)
		end

		slot0._loaderChar = slot0:createLoader(slot1, slot0.charGoPath)
		slot0._isCharLoaded = false
	end
end

function slot0.addUrlToPreloadMap(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		slot1[slot6] = slot7
	end
end

function slot0.checkNeedLoad(slot0, slot1, slot2)
	if slot1 then
		if slot0._loaderChar ~= nil then
			slot0._loaderChar:checkStartLoad(slot2)
		end
	else
		logError("other loader is not implement!")
	end
end

function slot0.onLoadOneCallback(slot0, slot1, slot2)
	if slot1 == slot0.charGoPath then
		slot0:getSummonScene().selector:initCharSceneGo(slot2)
	else
		SummonEffectPool.onEffectPreload(slot2)
	end
end

function slot0.onLoadAllCompleted(slot0, slot1)
	if slot1 == slot0._loaderChar then
		slot0._isCharLoaded = true
	end

	slot0:dispatchEvent(SummonSceneEvent.OnPreloadFinish, slot2)
end

function slot0.onEnterScene(slot0)
end

function slot0.onCloseFullView(slot0, slot1, slot2)
	if GameSceneMgr.instance:getCurScene() and not gohelper.isNil(slot3:getSceneContainerGO()) then
		gohelper.setActive(slot3:getSceneContainerGO(), false)
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.SummonView and slot0:isOpen() then
		slot0:close(true)
	end
end

function slot0.onClickHome(slot0)
	slot0:close(true)
end

function slot0.openSummonScene(slot0, slot1)
	if slot0._isOpen then
		return
	end

	slot0._isOpen = true
	slot0._isOpenImmediately = slot1

	slot0:checkInitRootGO()
	slot0:checkInitLoader()
	gohelper.setActive(slot0:getRootGO(), true)
	slot0:getSummonScene():onStart(slot0._curSceneId, slot0._curLevelId)

	if slot0._isOpenImmediately then
		slot0._loaderChar:checkStartLoad(true)
	end

	if GameSceneMgr.instance:getCurScene() and not gohelper.isNil(slot3:getSceneContainerGO()) then
		gohelper.setActive(slot3:getSceneContainerGO(), false)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, slot0.onCloseFullView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	NavigateMgr.instance:registerCallback(NavigateEvent.ClickHome, slot0.onClickHome, slot0)
	slot0._sceneObj.director:registerCallback(SummonSceneEvent.OnEnterScene, slot0.onEnterScene, slot0)
	slot0:checkCloseOldSceneUI()
end

function slot0.close(slot0, slot1)
	if not slot0._isOpen then
		return
	end

	logNormal("VirtualSummonScene close")

	slot0._isOpen = false
	slot0._isOpenImmediately = false

	if slot1 then
		slot0:release()
	else
		slot0:hide()
	end

	slot0:checkResumeMainScene()
	MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, true)
end

function slot0.checkCloseOldSceneUI(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, false)
	else
		ViewMgr.instance:closeAllViews({
			ViewName.SummonADView,
			ViewName.SummonView
		})
	end
end

function slot0.checkResumeMainScene(slot0)
	slot1 = GameSceneMgr.instance:getCurScene()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		slot2 = GameSceneMgr.instance:getCurScene()

		slot2.camera:resetParam()
		slot2.camera:applyDirectly()
	end

	if slot1 and not gohelper.isNil(slot1:getSceneContainerGO()) then
		gohelper.setActive(slot1:getSceneContainerGO(), true)
	end
end

function slot0.checkInitRootGO(slot0)
	if gohelper.isNil(slot0._rootGO) then
		slot0._rootGO = gohelper.create3d(CameraMgr.instance:getSceneRoot(), "VirtualSummonScene")
	end
end

function slot0.getSummonScene(slot0)
	return slot0._sceneObj
end

function slot0.getRootGO(slot0)
	return slot0._rootGO
end

function slot0.isOpenImmediately(slot0)
	return slot0._isOpenImmediately
end

function slot0.isOpen(slot0)
	return slot0._isOpen
end

function slot0.isABLoaded(slot0, slot1)
	if slot1 then
		return slot0._isCharLoaded
	end

	return false
end

function slot0.hide(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0.onCloseFullView, slot0)
	slot0._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, slot0.onEnterScene, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, slot0.onClickHome, slot0)
	gohelper.setActive(slot0:getRootGO(), false)
	slot0:getSummonScene():onHide()
end

function slot0.release(slot0)
	slot0:getSummonScene():onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0.onCloseFullView, slot0)
	slot0._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, slot0.onEnterScene, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, slot0.onClickHome, slot0)

	slot0._isCharLoaded = false

	SummonEffectPool.dispose()
	slot0._loaderChar:dispose()

	slot0._loaderChar = nil

	gohelper.destroy(slot0._rootGO)

	slot0._rootGO = nil
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
