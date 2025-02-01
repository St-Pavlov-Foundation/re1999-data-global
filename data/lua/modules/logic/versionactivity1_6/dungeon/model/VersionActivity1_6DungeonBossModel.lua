module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6DungeonBossModel", package.seeall)

slot0 = class("VersionActivity1_6DungeonBossModel", Activity149Model)
slot1 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "Score"

function slot0.onInit(slot0)
	uv0.super.onInit(slot0)

	slot0._receivedMsgInit = false
end

function slot0.reInit(slot0)
	uv0.super.reInit(slot0)
end

function slot0.isInBossFight(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	return slot0:checkBattleEpisodeType(DungeonEnum.EpisodeType.Act1_6DungeonBoss)
end

function slot0.checkBattleEpisodeType(slot0, slot1)
	if not DungeonModel.instance.curSendEpisodeId then
		return false
	end

	if not DungeonConfig.instance:getEpisodeCO(slot2) then
		return false
	end

	return slot3.type == slot1
end

function slot0.onReceiveInfos(slot0, slot1)
	uv0.super.onReceiveInfos(slot0, slot1)

	if not slot0._receivedMsgInit then
		slot0:applyPreScoreToCurScore()

		slot0._receivedMsgInit = true
	end
end

function slot0.getScorePrefValue(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv0)) or 0
end

function slot0.setScorePrefValue(slot0, slot1)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(uv0), slot1)
end

function slot0.SetOpenBossViewWithDailyBonus(slot0, slot1)
	slot0._getDailyBonus = slot1
end

function slot0.GetOpenBossViewWithDailyBonus(slot0)
	return slot0._getDailyBonus
end

slot0.instance = slot0.New()

return slot0
