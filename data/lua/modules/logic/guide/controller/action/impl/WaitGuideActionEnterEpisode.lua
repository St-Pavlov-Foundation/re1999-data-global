module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterEpisode", package.seeall)

local var_0_0 = class("WaitGuideActionEnterEpisode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._episodeId = tonumber(arg_1_0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._checkInEpisode, arg_1_0)
	arg_1_0:_checkInEpisode(GameSceneMgr.instance:getCurSceneType(), nil)
end

function var_0_0._checkInEpisode(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == SceneType.Fight then
		local var_2_0 = FightModel.instance:getFightParam()

		if not arg_2_0._episodeId or arg_2_0._episodeId == var_2_0.episodeId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_2_0._checkInEpisode, arg_2_0)
			arg_2_0:onDone(true)
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_3_0._checkInEpisode, arg_3_0)
end

return var_0_0
