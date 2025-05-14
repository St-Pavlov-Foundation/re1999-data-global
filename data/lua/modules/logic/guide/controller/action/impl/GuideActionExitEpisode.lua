module("modules.logic.guide.controller.action.impl.GuideActionExitEpisode", package.seeall)

local var_0_0 = class("GuideActionExitEpisode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
		FightController.instance:exitFightScene()
	else
		logError("not in episode, guide_" .. arg_1_0.guideId .. "_" .. arg_1_0.stepId)
		arg_1_0:onDone(true)
	end
end

return var_0_0
