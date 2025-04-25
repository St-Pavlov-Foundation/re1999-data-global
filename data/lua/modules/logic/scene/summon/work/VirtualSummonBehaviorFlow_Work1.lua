module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_Work1", package.seeall)

slot0 = class("VirtualSummonBehaviorFlow_Work1", VirtualSummonBehaviorFlow_WorkBase)

function slot0._heroIdList(slot0)
	return slot0.root:heroIdList()
end

function slot0._backToMainSceneCallBack(slot0)
	return slot0.root:backToMainSceneCallBack() or function ()
	end
end

slot1 = "SummonController-doVirtualSummonBehavior"

function slot0.onStart(slot0, slot1)
	slot0:clearWork()
	slot0:startBlock(uv0)
	VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, slot0._onSummonPreloadFinish, slot0)
	SummonController.instance:doVirtualSummonBehavior(slot0:_heroIdList(), true, true, slot0._onCloseSommonScene, slot0, true)
	TaskDispatcher.runDelay(slot0._onFirstLoadSceneBlock, slot0, 0.5)
end

function slot0._onFirstLoadSceneBlock(slot0)
	SummonController.instance:onFirstLoadSceneBlock()
	TaskDispatcher.cancelTask(slot0.onDone, slot0)
	TaskDispatcher.runDelay(slot0.onDone, slot0, 5)
end

function slot0._onSummonPreloadFinish(slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)
	TaskDispatcher.cancelTask(slot0._onFirstLoadSceneBlock, slot0)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, slot0._onSummonPreloadFinish, slot0)
	slot0:endBlock(uv0)
end

function slot0._onCloseSommonScene(slot0)
	SummonController.instance:setSummonEndOpenCallBack()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		SceneHelper.instance:waitSceneDone(slot1, slot0:_backToMainSceneCallBack())
	else
		slot2()
	end
end

return slot0
