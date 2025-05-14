module("modules.logic.guide.controller.trigger.GuideTriggerEnterEpisode", package.seeall)

local var_0_0 = class("GuideTriggerEnterEpisode", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_1 == tonumber(arg_2_2)
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == SceneType.Fight then
		local var_3_0 = FightModel.instance:getFightParam()

		if var_3_0.episodeId then
			arg_3_0:checkStartGuide(var_3_0.episodeId)
		end
	end
end

return var_0_0
