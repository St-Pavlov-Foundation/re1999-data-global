module("modules.logic.rouge.view.RougeHeroGroupFightViewLevel", package.seeall)

slot0 = class("RougeHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function slot0._btnenemyOnClick(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		EnemyInfoController.instance:openWeekWalkEnemyInfoView(WeekWalkModel.instance:getCurMapId(), slot0._battleId)

		return
	elseif slot1.type == DungeonEnum.EpisodeType.Cachot then
		-- Nothing
	elseif slot1.type == DungeonEnum.EpisodeType.BossRush then
		slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(slot0._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(BossRushConfig.instance:getActivityId(), slot3, slot4)

		return
	end

	if slot0._fixHpRate then
		EnemyInfoController.instance:openRougeEnemyInfoView(slot0._battleId, 1 + tonumber(slot0._fixHpRate))

		return
	end

	RougeRpc.instance:sendRougeMonsterFixAttrRequest(RougeConfig1.instance:season(), slot0._onGetFixAttrRequest, slot0)
end

function slot0._onGetFixAttrRequest(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0._fixHpRate = slot3.fixHpRate

	EnemyInfoController.instance:openRougeEnemyInfoView(slot0._battleId, 1 + tonumber(slot0._fixHpRate))
end

return slot0
