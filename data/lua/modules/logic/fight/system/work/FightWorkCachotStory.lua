module("modules.logic.fight.system.work.FightWorkCachotStory", package.seeall)

local var_0_0 = class("FightWorkCachotStory", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = FightModel.instance:getRecordMO()
	local var_1_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_1_2 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_1_2 then
		arg_1_0:onDone(true)

		return
	end

	if var_1_0 and var_1_0.fightResult == FightEnum.FightResult.Succ and var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.Cachot then
		if var_1_2.room == V1a6_CachotEnum.SecondLayerFirstRoom then
			local var_1_3 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode3).value
			local var_1_4 = {}

			var_1_4.mark = true
			var_1_4.isReplay = false

			if var_1_3 and var_1_3 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(var_1_3)) then
				StoryController.instance:registerCallback(StoryEvent.AllStepFinished, arg_1_0._onStoryFinish, arg_1_0)
				StoryController.instance:playStory(tonumber(var_1_3), var_1_4, nil, arg_1_0)
			else
				arg_1_0:onDone(true)
			end
		else
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onStoryFinish(arg_2_0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, arg_2_0._onStoryFinish, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, arg_3_0._onStoryFinish, arg_3_0)
end

return var_0_0
