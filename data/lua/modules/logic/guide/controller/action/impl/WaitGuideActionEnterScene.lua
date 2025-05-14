module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterScene", package.seeall)

local var_0_0 = class("WaitGuideActionEnterScene", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._sceneType = SceneType[arg_1_0.actionParam]

	if GameSceneMgr.instance:getCurSceneType() == arg_1_0._sceneType and not GameSceneMgr.instance:isLoading() then
		arg_1_0:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(arg_1_0._sceneType, arg_1_0._onEnterScene, arg_1_0)
	end
end

function var_0_0._onEnterScene(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == 1 then
		GameSceneMgr.instance:unregisterCallback(arg_2_0._sceneType, arg_2_0._onEnterScene, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	GameSceneMgr.instance:unregisterCallback(arg_3_0._sceneType, arg_3_0._onEnterScene, arg_3_0)
end

return var_0_0
