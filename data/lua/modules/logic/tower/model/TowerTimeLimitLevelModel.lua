module("modules.logic.tower.model.TowerTimeLimitLevelModel", package.seeall)

slot0 = class("TowerTimeLimitLevelModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()

	slot0.entranceDifficultyMap = {}
end

function slot0.reInit(slot0)
	slot0.curSelectEntrance = 0
end

function slot0.cleanData(slot0)
	slot0:reInit()
end

function slot0.initDifficultyMulti(slot0)
	slot0.difficultyMultiMap = {}

	for slot5, slot6 in ipairs({
		TowerEnum.ConstId.TimeLimitEasyMulti,
		TowerEnum.ConstId.TimeLimitNormalMulti,
		TowerEnum.ConstId.TimeLimitHardMulti
	}) do
		slot0.difficultyMultiMap[slot5] = TowerConfig.instance:getTowerConstConfig(slot6)
	end
end

function slot0.getDifficultyMulti(slot0, slot1)
	return slot0.difficultyMultiMap[slot1]
end

function slot0.setCurSelectEntrance(slot0, slot1)
	slot0.curSelectEntrance = slot1
end

function slot0.getCurOpenTimeLimitTower(slot0)
	for slot5, slot6 in pairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Limited) or {}) do
		if slot6.status == TowerEnum.TowerStatus.Open then
			return slot6
		end
	end
end

function slot0.getEntranceBossUsedMap(slot0, slot1)
	for slot7 = 1, 3 do
	end

	return {
		[slot7] = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, slot1):getLayerSubEpisodeList(TowerConfig.instance:getTowerLimitedTimeCoList(slot1, slot7)[1].layerId) and slot10[1].assistBossId or 0
	}
end

function slot0.localSaveKey(slot0)
	return TowerEnum.LocalPrefsKey.LastEntranceDifficulty
end

function slot0.initEntranceDifficulty(slot0, slot1)
	for slot5 = 1, 3 do
		slot0.entranceDifficultyMap[slot5] = slot0:getLastEntranceDifficulty(slot5, slot1)
	end
end

function slot0.getEntranceDifficulty(slot0, slot1)
	return slot0.entranceDifficultyMap[slot1]
end

function slot0.setEntranceDifficulty(slot0, slot1, slot2)
	slot0.entranceDifficultyMap[slot1] = slot2
end

function slot0.getLastEntranceDifficulty(slot0, slot1, slot2)
	return TowerModel.instance:getLocalPrefsState(slot0:localSaveKey(), slot1, slot2, TowerEnum.Difficulty.Easy)
end

function slot0.saveLastEntranceDifficulty(slot0, slot1)
	for slot5 = 1, 3 do
		TowerModel.instance:setLocalPrefsState(slot0:localSaveKey(), slot5, slot1, slot0.entranceDifficultyMap[slot5])
	end
end

function slot0.getHistoryHighScore(slot0)
	if not slot0:getCurOpenTimeLimitTower() then
		return 0
	end

	return TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, slot1 and slot1.towerId or 1):getHistoryHighScore()
end

slot0.instance = slot0.New()

return slot0
