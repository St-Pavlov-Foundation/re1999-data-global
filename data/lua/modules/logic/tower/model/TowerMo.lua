module("modules.logic.tower.model.TowerMo", package.seeall)

slot0 = pureTable("TowerMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
end

function slot0.updateInfo(slot0, slot1)
	slot0.type = slot1.type
	slot0.towerId = slot1.towerId
	slot0.passLayerId = slot1.passLayerId

	slot0:updateLayerInfos(slot1.layerNOs)
	slot0:updateLayerScore(slot1.layerNOs)
	slot0:updateHistoryHighScore(slot1.historyHighScore)
	slot0:updateOpenSpLayer(slot1.openSpLayerIds)
end

function slot0.updateOpenSpLayer(slot0, slot1)
	slot0.openSpLayerDict = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0.openSpLayerDict[slot1[slot5]] = 1
		end
	end
end

function slot0.isSpLayerOpen(slot0, slot1)
	return slot0.openSpLayerDict[slot1] ~= nil
end

function slot0.hasNewSpLayer(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot0.openSpLayerDict) do
		if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, slot0.towerId, slot1, TowerEnum.LockKey) == TowerEnum.LockKey then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.clearSpLayerNewTag(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot0.openSpLayerDict) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, slot0.towerId, slot1, TowerEnum.UnlockKey)
	end

	return slot2
end

function slot0.isLayerUnlock(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = TowerModel.instance:getEpisodeMoByTowerType(slot0.type)
	end

	if not slot2 then
		return false
	end

	if not slot2:getEpisodeConfig(slot0.towerId, slot1) then
		return false
	end

	return slot0:isLayerPass(slot3.preLayerId, slot2)
end

function slot0.isLayerPass(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = TowerModel.instance:getEpisodeMoByTowerType(slot0.type)
	end

	if not slot2 then
		return false
	end

	return slot2:getEpisodeIndex(slot0.towerId, slot1, true) <= slot2:getEpisodeIndex(slot0.towerId, slot0.passLayerId, true)
end

function slot0.updateLayerInfos(slot0, slot1)
	slot0.layerSubEpisodeMap = slot0.layerSubEpisodeMap or {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = {}

			for slot11 = 1, #slot6.episodeNOs do
				slot12 = TowerSubEpisodeMo.New()

				slot12:updateInfo(slot6.episodeNOs[slot11])
				table.insert(slot7, slot12)
			end

			slot0.layerSubEpisodeMap[slot6.layerId] = slot7
		end
	end
end

function slot0.resetLayerInfos(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1.episodeNOs do
		slot7 = TowerSubEpisodeMo.New()

		slot7:updateInfo(slot1.episodeNOs[slot6])
		table.insert(slot2, slot7)
	end

	slot0.layerSubEpisodeMap[slot1.layerId] = slot2
end

function slot0.resetLayerScore(slot0, slot1)
	if slot1 then
		slot0.layerScoreMap[slot1.layerId] = slot1.currHighScore
	end
end

function slot0.updateHistoryHighScore(slot0, slot1)
	slot0.historyHighScore = slot1
end

function slot0.getHistoryHighScore(slot0)
	return slot0.historyHighScore or 0
end

function slot0.updateLayerScore(slot0, slot1)
	slot0.layerScoreMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0.layerScoreMap[slot6.layerId] = slot6.currHighScore
		end
	end
end

function slot0.getLayerScore(slot0, slot1)
	return slot0.layerScoreMap[slot1] or 0
end

function slot0.getLayerSubEpisodeList(slot0, slot1, slot2)
	if not slot0.layerSubEpisodeMap[slot1] and not slot2 then
		logError("该层没有子关卡信息：" .. slot1)
	end

	return slot0.layerSubEpisodeMap[slot1]
end

function slot0.getSubEpisodeMoByEpisodeId(slot0, slot1)
	slot0.layerSubEpisodeMap = slot0.layerSubEpisodeMap or {}

	for slot5, slot6 in pairs(slot0.layerSubEpisodeMap) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.episodeId == slot1 then
				return slot11, slot5
			end
		end
	end
end

function slot0.getSubEpisodePassCount(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:getLayerSubEpisodeList(slot1, true) or {}) do
		if slot8.status == TowerEnum.PassEpisodeState.Pass then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getTaskGroupId(slot0)
	if TowerModel.instance:getTowerOpenInfo(slot0.type, slot0.towerId) == nil then
		return
	end

	return TowerConfig.instance:getBossTimeTowerConfig(slot0.towerId, slot1.round) and slot2.taskGroupId
end

function slot0.getBanHeroAndBoss(slot0, slot1, slot2, slot3)
	if slot0.type == TowerEnum.TowerType.Boss then
		return
	end

	if not slot0:getLayerSubEpisodeList(slot1, true) then
		return {}, {}
	end

	if slot0.type == TowerEnum.TowerType.Normal then
		if TowerConfig.instance:getPermanentEpisodeCo(slot1) and slot7.isElite == 1 then
			for slot11, slot12 in pairs(slot6) do
				slot12:getHeros(slot4)
				slot12:getAssistBossId(slot5)
			end
		end
	elseif TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		for slot11 = 1, 3 do
			if TowerConfig.instance:getTowerLimitedTimeCoList(slot7.towerId, slot11) then
				for slot16, slot17 in pairs(slot12) do
					if slot0:getLayerSubEpisodeList(slot17.layerId, true) then
						for slot21, slot22 in pairs(slot6) do
							slot22:getHeros(slot4)
							slot22:getAssistBossId(slot5)
						end
					end
				end
			end
		end
	end

	return slot4, slot5
end

function slot0.getBanAssistBosss(slot0, slot1)
	slot3 = {}

	if slot0:getLayerSubEpisodeList(slot1, true) then
		for slot7, slot8 in pairs(slot2) do
			slot8:getAssistBossId(slot3)
		end
	end

	return slot3
end

function slot0.isHeroGroupLock(slot0, slot1, slot2)
	if slot0.type == TowerEnum.TowerType.Boss then
		return false
	end

	slot3 = slot0:getLayerSubEpisodeList(slot1, true)

	if slot0.type == TowerEnum.TowerType.Normal then
		if TowerConfig.instance:getPermanentEpisodeCo(slot1) and slot4.isElite ~= 1 then
			return false
		end

		if slot3 then
			for slot8, slot9 in pairs(slot3) do
				if slot9.episodeId == slot2 then
					if slot9.status == 1 then
						return true, slot9.heroIds, slot9.assistBossId
					else
						return false
					end
				end
			end
		end

		return false
	end

	if slot3 then
		for slot7, slot8 in pairs(slot3) do
			if slot8.status == 1 then
				return true, slot8.heroIds, slot8.assistBossId
			end
		end
	end

	return false
end

return slot0
