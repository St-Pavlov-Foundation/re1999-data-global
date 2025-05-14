module("modules.logic.scene.SceneHelper", package.seeall)

local var_0_0 = class("SceneHelper")

function var_0_0.waitSceneDone(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.currSceneType = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.callbackObj = arg_1_3
	arg_1_0.param = arg_1_4

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0.onEnterSceneFinish, arg_1_0)
	TaskDispatcher.runDelay(arg_1_0._overtime, arg_1_0, 10)
end

function var_0_0.onEnterSceneFinish(arg_2_0, arg_2_1)
	if arg_2_1 ~= arg_2_0.currSceneType then
		return
	end

	arg_2_0:clearWork()

	if arg_2_0.callback then
		arg_2_0.callback(arg_2_0.callbackObj, arg_2_0.param)
	end
end

function var_0_0._overtime(arg_3_0)
	logError("等待加载场景超时了.. " .. tostring(arg_3_0.currSceneType))
	arg_3_0:clearWork()

	if arg_3_0.callback then
		arg_3_0.callback(arg_3_0.callbackObj, arg_3_0.param)
	end
end

function var_0_0.clearWork(arg_4_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_4_0.onEnterSceneFinish, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._overtime, arg_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
