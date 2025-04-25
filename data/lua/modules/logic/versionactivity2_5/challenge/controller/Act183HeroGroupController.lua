module("modules.logic.versionactivity2_5.challenge.controller.Act183HeroGroupController", package.seeall)

slot0 = class("Act183HeroGroupController", BaseController)
slot1 = {
	[Act183Enum.EpisodeType.Boss] = ModuleEnum.HeroGroupSnapshotType.Act183Boss,
	[Act183Enum.EpisodeType.Sub] = ModuleEnum.HeroGroupSnapshotType.Act183Normal
}

function slot0.enterFight(slot0, slot1, slot2, slot3)
	slot0._episodeId = slot1
	slot0._readyUseBadgeNum = slot2

	if not uv0[Act183Helper.getEpisodeType(slot1)] then
		logError("未处理关卡类型 episodeType = " .. tostring(slot4))

		return
	end

	Act183Model.instance:recordEpisodeSelectConditions(slot3)
	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(slot5, slot0._enterFight, slot0)
end

function slot0._enterFight(slot0)
	if not DungeonConfig.instance:getEpisodeCO(slot0._episodeId) then
		logError(string.format("关卡配置不存在 episodeId = %s", slot0._episodeId))

		return
	end

	DungeonFightController.instance:enterFight(slot1.chapterId, slot0._episodeId)
	Act183Model.instance:recordEpisodeReadyUseBadgeNum(slot0._readyUseBadgeNum)
end

function slot0.saveGroupData(slot0, slot1, slot2, slot3, slot4, slot5)
	FightParam.initFightGroup(HeroGroupModule_pb.SetHeroGroupSnapshotRequest().fightGroup, slot1.clothId, slot0:getMainList(slot1), slot1:getSubList(), slot1:getAllHeroEquips(), slot1:getAllHeroActivity104Equips(), slot1:getAssistBossId())

	slot7 = ModuleEnum.HeroGroupSnapshotType.Common
	slot8 = 1

	if slot2 == ModuleEnum.HeroGroupType.General then
		slot7 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		slot8 = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if slot7 and slot8 then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(slot7, slot8, slot6, slot4, slot5)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", slot7, slot8))
	end
end

function slot0.getMainList(slot0, slot1)
	slot2 = {}
	slot3 = 0
	slot5 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot4]

	for slot10 = 1, slot5 and slot5.playerMax or ModuleEnum.HeroCountInGroup do
		if tonumber(slot1.heroList[slot10] or "0") < 0 then
			slot11 = "0"
		end

		slot2[slot10] = slot11

		if slot11 ~= "0" and slot11 ~= 0 then
			slot3 = slot3 + 1
		end
	end

	return slot2, slot3
end

slot0.instance = slot0.New()

return slot0
