module("modules.common.work.OpenSceneWork", package.seeall)

slot0 = class("OpenSceneWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.sceneType = slot1
	slot0.sceneId = slot2
	slot0.levelId = slot3
	slot0.forceStarting = slot4
	slot0.forceSceneType = slot5
end

function slot0.onStart(slot0)
	GameSceneMgr.instance:startScene(slot0.sceneType, slot0.sceneId, slot0.levelId, slot0.forceStarting, slot0.forceSceneType)
	GameSceneMgr.instance:registerCallback(slot0.sceneType, slot0.onSceneLoadDone, slot0)
end

function slot0.onSceneLoadDone(slot0)
	GameSceneMgr.instance:unregisterCallback(slot0.sceneType, slot0.onSceneLoadDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(slot0.sceneType, slot0.onSceneLoadDone, slot0)
end

return slot0
