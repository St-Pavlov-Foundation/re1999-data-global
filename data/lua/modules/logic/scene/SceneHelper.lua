module("modules.logic.scene.SceneHelper", package.seeall)

slot0 = class("SceneHelper")

function slot0.waitSceneDone(slot0, slot1, slot2, slot3, slot4)
	slot0.currSceneType = slot1
	slot0.callback = slot2
	slot0.callbackObj = slot3
	slot0.param = slot4

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0.onEnterSceneFinish, slot0)
	TaskDispatcher.runDelay(slot0._overtime, slot0, 10)
end

function slot0.onEnterSceneFinish(slot0, slot1)
	if slot1 ~= slot0.currSceneType then
		return
	end

	slot0:clearWork()

	if slot0.callback then
		slot0.callback(slot0.callbackObj, slot0.param)
	end
end

function slot0._overtime(slot0)
	logError("等待加载场景超时了.. " .. tostring(slot0.currSceneType))
	slot0:clearWork()

	if slot0.callback then
		slot0.callback(slot0.callbackObj, slot0.param)
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0.onEnterSceneFinish, slot0)
	TaskDispatcher.cancelTask(slot0._overtime, slot0)
end

slot0.instance = slot0.New()

return slot0
