module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterChapter", package.seeall)

local var_0_0 = class("WaitGuideActionEnterChapter", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0.chapterId = tonumber(arg_1_0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._checkInEpisode, arg_1_0)
	arg_1_0:_checkInEpisode(GameSceneMgr.instance:getCurSceneType(), nil)
end

function var_0_0._checkInEpisode(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == SceneType.Fight then
		local var_2_0 = FightModel.instance:getFightParam()

		if not var_2_0 then
			arg_2_0:onDone(true)

			return
		end

		local var_2_1 = DungeonConfig.instance:getEpisodeCO(var_2_0.episodeId)

		if not var_2_1 then
			arg_2_0:onDone(true)

			return
		end

		if not arg_2_0.chapterId or arg_2_0.chapterId == var_2_1.chapterId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_2_0._checkInEpisode, arg_2_0)
			arg_2_0:onDone(true)
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_3_0._checkInEpisode, arg_3_0)
end

return var_0_0
