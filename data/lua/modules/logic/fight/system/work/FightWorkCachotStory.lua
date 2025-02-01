module("modules.logic.fight.system.work.FightWorkCachotStory", package.seeall)

slot0 = class("FightWorkCachotStory", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = FightModel.instance:getRecordMO()
	slot3 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not V1a6_CachotModel.instance:getRogueInfo() then
		slot0:onDone(true)

		return
	end

	if slot2 and slot2.fightResult == FightEnum.FightResult.Succ and slot3 and slot3.type == DungeonEnum.EpisodeType.Cachot then
		if slot4.room == V1a6_CachotEnum.SecondLayerFirstRoom then
			if V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode3).value and slot5 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(slot5)) then
				StoryController.instance:registerCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
				StoryController.instance:playStory(tonumber(slot5), {
					mark = true,
					isReplay = false
				}, nil, slot0)
			else
				slot0:onDone(true)
			end
		else
			slot0:onDone(true)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onStoryFinish(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, slot0._onStoryFinish, slot0)
end

return slot0
