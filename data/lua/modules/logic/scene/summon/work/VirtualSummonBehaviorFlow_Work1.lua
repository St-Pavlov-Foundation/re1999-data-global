module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_Work1", package.seeall)

local var_0_0 = class("VirtualSummonBehaviorFlow_Work1", VirtualSummonBehaviorFlow_WorkBase)

function var_0_0._heroIdList(arg_1_0)
	return arg_1_0.root:heroIdList()
end

function var_0_0._backToMainSceneCallBack(arg_2_0)
	return arg_2_0.root:backToMainSceneCallBack() or function()
		return
	end
end

local var_0_1 = "SummonController-doVirtualSummonBehavior"

function var_0_0.onStart(arg_4_0, arg_4_1)
	arg_4_0:clearWork()
	arg_4_0:startBlock(var_0_1)
	VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, arg_4_0._onSummonPreloadFinish, arg_4_0)
	SummonController.instance:doVirtualSummonBehavior(arg_4_0:_heroIdList(), true, true, arg_4_0._onCloseSommonScene, arg_4_0, true)
	TaskDispatcher.runDelay(arg_4_0._onFirstLoadSceneBlock, arg_4_0, 0.5)
end

function var_0_0._onFirstLoadSceneBlock(arg_5_0)
	SummonController.instance:onFirstLoadSceneBlock()
	TaskDispatcher.cancelTask(arg_5_0.onDone, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.onDone, arg_5_0, 5)
end

function var_0_0._onSummonPreloadFinish(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onDone, arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onDone, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onFirstLoadSceneBlock, arg_7_0)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, arg_7_0._onSummonPreloadFinish, arg_7_0)
	arg_7_0:endBlock(var_0_1)
end

function var_0_0._onCloseSommonScene(arg_8_0)
	local var_8_0 = SceneType.Main
	local var_8_1 = arg_8_0:_backToMainSceneCallBack()

	SummonController.instance:setSummonEndOpenCallBack()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)

	if GameSceneMgr.instance:getCurSceneType() ~= var_8_0 then
		SceneHelper.instance:waitSceneDone(var_8_0, var_8_1)
	else
		var_8_1()
	end
end

return var_0_0
