module("modules.logic.guide.controller.trigger.GuideTriggerEnterScene", package.seeall)

local var_0_0 = class("GuideTriggerEnterScene", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_1 == SceneType[arg_2_2]
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:checkStartGuide(arg_3_1)
end

return var_0_0
