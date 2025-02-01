module("modules.logic.scene.explore.comp.ExploreStatComp", package.seeall)

slot0 = class("ExploreStatComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0._beginTime = UnityEngine.Time.realtimeSinceStartup
	slot0._isExit = false
	slot3 = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance.mapId)
	slot0._episodeId = slot3.episodeId
	slot0._chapterId = slot3.chapterId
end

function slot0.onTriggerSpike(slot0, slot1)
	slot0:_onExitStat("人物返回出生点", tostring(slot1))
end

function slot0.onTriggerExit(slot0, slot1)
	slot0._isExit = true

	slot0:_onExitStat("成功", tostring(slot1))
end

function slot0.onTriggerEggs(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.click_eggs_option, {
		[StatEnum.EventProperties.Dialogue_id] = slot1,
		[StatEnum.EventProperties.eggs_name] = slot2
	})
end

function slot0._onExitStat(slot0, slot1, slot2)
	slot3 = UnityEngine.Time.realtimeSinceStartup - slot0._beginTime
	slot4 = tostring(slot0._episodeId)
	slot5 = ExploreModel.instance:getChallengeCount() + 1
	slot6, slot7, slot8 = ExploreSimpleModel.instance:getCoinCountByMapId(ExploreModel.instance.mapId)
	slot9 = slot2 or "主动退出"
	slot10 = ExploreHelper.getKeyXY(ExploreMapModel.instance:getHeroPos())
	slot11 = {}

	if ExploreSimpleModel.instance:getChapterMo(slot0._chapterId) and lua_explore_story.configDict[slot0._chapterId] then
		for slot17 in pairs(slot12.archiveIds) do
			table.insert(slot11, slot13[slot17].title)
		end
	end

	StatController.instance:track(StatEnum.EventName.Exit_backroom, {
		[StatEnum.EventProperties.UseTime] = slot3,
		[StatEnum.EventProperties.EpisodeId] = slot4,
		[StatEnum.EventProperties.ChallengesNum] = slot5,
		[StatEnum.EventProperties.collected_treasure] = slot6,
		[StatEnum.EventProperties.collected_gold] = slot7,
		[StatEnum.EventProperties.collected_purplecoin] = slot8,
		[StatEnum.EventProperties.Result] = slot1,
		[StatEnum.EventProperties.FailReason] = slot9,
		[StatEnum.EventProperties.coordinate] = slot10,
		[StatEnum.EventProperties.story_fragment_name] = slot11
	})
end

function slot0.onSceneClose(slot0)
	if not slot0._isExit then
		slot0:_onExitStat("主动中断")
	end
end

return slot0
