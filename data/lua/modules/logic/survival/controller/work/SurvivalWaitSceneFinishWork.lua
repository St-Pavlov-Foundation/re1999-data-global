module("modules.logic.survival.controller.work.SurvivalWaitSceneFinishWork", package.seeall)

local var_0_0 = class("SurvivalWaitSceneFinishWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.fastExecute then
		arg_1_0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(arg_1_0._delayCheckIsLoadingScene, arg_1_0, 1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
end

function var_0_0._delayCheckIsLoadingScene(arg_2_0)
	if not GameSceneMgr.instance:isLoading() then
		arg_2_0:onDone(true)
	end
end

function var_0_0._onEnterOneSceneFinish(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayCheckIsLoadingScene, arg_4_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_4_0._onEnterOneSceneFinish, arg_4_0)
end

return var_0_0
