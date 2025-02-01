module("modules.logic.scene.GameSceneMgr", package.seeall)

slot0 = class("GameSceneMgr")

function slot0.ctor(slot0)
	slot0._curSceneType = nil
	slot0._curSceneId = nil
	slot0._preSceneType = nil
	slot0._preSceneId = nil
	slot0._preLevelId = nil
	slot0._nextSceneType = nil
	slot0._allScenes = {}
	slot0._allRootGo = nil
	slot0._isStarting = false
	slot0._isClosing = false
	slot0._startArgs = {}

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.init(slot0)
	slot0._allRootGo = CameraMgr.instance:getSceneRoot()
	slot1 = SceneMacro

	slot0:_addScenes()
end

function slot0._addScenes(slot0)
	slot0:_addSceneObj(SceneType.Main, MainScene)
	slot0:_addSceneObj(SceneType.Fight, FightScene)
	slot0:_addSceneObj(SceneType.Newbie, NewbieScene)
	slot0:_addSceneObj(SceneType.Room, RoomScene)
	slot0:_addSceneObj(SceneType.Explore, ExploreScene)
	slot0:_addSceneObj(SceneType.PushBox, PushBoxScene)
	slot0:_addSceneObj(SceneType.Cachot, CachotScene)
	slot0:_addSceneObj(SceneType.Rouge, RougeScene)
end

function slot0._addSceneObj(slot0, slot1, slot2)
	slot4 = slot2.New(gohelper.findChild(slot0._allRootGo, slot2.__cname) or gohelper.create3d(slot0._allRootGo, slot2.__cname))

	slot4:setOnPreparedCb(slot0.onScenePrepared, slot0)
	slot4:setOnPreparedOneCb(slot0.onScenePreparedOne, slot0)

	slot0._allScenes[slot1] = slot4
end

function slot0.getScene(slot0, slot1)
	return slot0._allScenes[slot1]
end

function slot0.getCurSceneType(slot0)
	return slot0._curSceneType
end

function slot0.getCurSceneId(slot0)
	return slot0._curSceneId
end

function slot0.getCurLevelId(slot0)
	if slot0:getCurScene() then
		return slot1:getCurLevelId()
	end
end

function slot0.getPreSceneType(slot0)
	return slot0._preSceneType
end

function slot0.getPreSceneId(slot0)
	return slot0._preSceneId
end

function slot0.getPreLevelId(slot0)
	return slot0._preLevelId
end

function slot0.setPrevScene(slot0, slot1, slot2, slot3)
	slot0._preSceneType = slot1
	slot0._preSceneId = slot2
	slot0._preLevelId = slot3
end

function slot0.getCurScene(slot0)
	return slot0._curSceneType and slot0._allScenes[slot0._curSceneType] or nil
end

function slot0.onScenePrepared(slot0)
	slot0._isStarting = false

	slot0:hideLoading()
	slot0:_runNextArgs()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, slot0)
	uv0.instance:dispatchEvent(slot0._curSceneType, slot0._curSceneId, 1)
	uv0.instance:dispatchEvent(SceneEventName.EnterSceneFinish, slot0._curSceneType, slot0._curSceneId)
end

function slot0.onScenePreparedOne(slot0)
end

function slot0._runNextArgs(slot0)
	if #slot0._startArgs > 0 then
		slot1 = slot0._startArgs[1]

		table.remove(slot0._startArgs, 1)
		slot0:startScene(slot1[1], slot1[2], slot1[3])
	end
end

function slot0.startSceneDefaultLevel(slot0, slot1, slot2, slot3, slot4)
	if SceneConfig.instance:getSceneLevelCOs(slot2) then
		slot0:startScene(slot1, slot2, slot5[1].id, slot3, slot4)
	else
		logError("scene config not exist, sceneId = " .. slot2)
	end
end

function slot0.startScene(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:useDefaultScene() and slot1 == SceneType.Fight then
		slot2 = 13101
		slot3 = 13101
	end

	if not slot4 and slot0._isStarting then
		table.insert(slot0._startArgs, {
			slot1,
			slot2,
			slot3
		})

		return
	end

	if not slot5 and slot0._curSceneType == slot1 and slot0._curSceneId == slot2 then
		slot0:_runNextArgs()

		return
	end

	slot0._nextSceneType = slot1

	slot0:showLoading(slot1)
	slot0:closeScene(slot1, slot2, slot3)

	if slot1 == SceneType.Main or slot1 == SceneType.Room or slot1 == SceneType.Explore or slot1 == SceneType.Cachot then
		TaskDispatcher.runDelay(slot0._onDelayStartScene, slot0, 1.467)
	else
		slot0._isStarting = true
		slot0._curSceneType = slot1
		slot0._curSceneId = slot2
		slot0._curSceneLevel = slot3

		TaskDispatcher.runDelay(slot0._onOtherDelayStartScene, slot0, 0.1)
	end
end

function slot0._onOtherDelayStartScene(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, slot0)
	slot0:getCurScene():onStart(slot0._curSceneId, slot0._curSceneLevel)
	uv0.instance:dispatchEvent(SceneEventName.EnterScene, slot0._curSceneType, slot0._curSceneId)
	logNormal(string.format("start scene: %s %d level_%d", SceneType.NameDict[slot0._curSceneType], slot0._curSceneId, slot0._curSceneLevel))
end

function slot0._onDelayStartScene(slot0)
	slot0._isStarting = true
	slot0._curSceneType = slot0._nextSceneType and slot0._nextSceneType or slot0._curSceneType
	slot0._nextSceneType = nil
	slot0._curSceneId = slot0._nextSceneId and slot0._nextSceneId or slot0._curSceneId
	slot0._nextSceneId = nil
	slot0._curSceneLevel = slot0._nextLevelId and slot0._nextLevelId or slot0._curSceneLevel
	slot0._nextLevelId = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, slot0)
	slot0:getCurScene():onStart(slot0._curSceneId, slot0._curSceneLevel)
	uv0.instance:dispatchEvent(SceneEventName.EnterScene, slot0._curSceneType, slot0._curSceneId)
	logNormal(string.format("start scene: %s %d level_%d", SceneType.NameDict[slot0._curSceneType], slot0._curSceneId, slot0._curSceneLevel))
end

function slot0.closeScene(slot0, slot1, slot2, slot3, slot4)
	TaskDispatcher.cancelTask(slot0._onDelayStartScene, slot0)
	TaskDispatcher.cancelTask(slot0._onOtherDelayStartScene, slot0)

	slot0._nextSceneType = slot1
	slot0._nextSceneId = slot2
	slot0._nextLevelId = slot3

	if not slot0._curSceneType or not slot0._curSceneId then
		return
	end

	slot0._isClosing = true
	slot0._preSceneType = slot0._curSceneType
	slot0._preSceneId = slot0._curSceneId
	slot0._preLevelId = slot0:getCurLevelId()

	if slot4 then
		TaskDispatcher.cancelTask(slot0._delayCloseScene, slot0)
		slot0:_delayCloseScene()
	elseif slot0._nextSceneType == SceneType.Main or slot0._nextSceneType == SceneType.Room or slot0._nextSceneType == SceneType.Explore or slot0._nextSceneType == SceneType.Cachot then
		TaskDispatcher.runDelay(slot0._delayCloseScene, slot0, 0.5)
	else
		TaskDispatcher.cancelTask(slot0._delayCloseScene, slot0)
		slot0:_delayCloseScene()
	end
end

function slot0._delayCloseScene(slot0)
	slot0:getCurScene():onClose()
	uv0.instance:dispatchEvent(slot0._curSceneType, slot0._curSceneId, 0)
	uv0.instance:dispatchEvent(SceneEventName.ExitScene, slot0._curSceneType, slot0._curSceneId, slot0._nextSceneType)
	logNormal(string.format("close scene: %s %d level_%d", SceneType.NameDict[slot0._preSceneType], slot0._preSceneId or -1, slot0._preLevelId or -1))

	slot0._curSceneType = nil
	slot0._curSceneId = nil
	slot0._isStarting = false
	slot0._isClosing = false
end

function slot0.showLoading(slot0, slot1)
	if not slot0._allScenes[slot1] then
		return
	end

	uv0.instance:dispatchEvent(SceneEventName.OpenLoading, slot1)
end

function slot0.hideLoading(slot0)
	uv0.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function slot0.isLoading(slot0)
	return slot0._isStarting
end

function slot0.isClosing(slot0)
	return slot0._isClosing
end

function slot0.isSpScene(slot0)
	if slot0:getCurScene() and slot1.level and slot1.level._sceneId and slot2 == 11501 then
		return true
	end
end

function slot0.isFightScene(slot0)
	return slot0:getCurSceneType() == SceneType.Fight
end

function slot0.isPushBoxScene(slot0)
	return slot0:getCurSceneType() == SceneType.PushBox
end

function slot0.getNextSceneType(slot0)
	return slot0._nextSceneType
end

function slot0.useDefaultScene(slot0)
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

slot0.instance = slot0.New()

return slot0
