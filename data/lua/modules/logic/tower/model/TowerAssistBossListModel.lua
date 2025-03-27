module("modules.logic.tower.model.TowerAssistBossListModel", package.seeall)

slot0 = class("TowerAssistBossListModel", ListScrollModel)

function slot0.initList(slot0)
	slot0.isFirstRefresh = true
end

function slot0.refreshList(slot0, slot1)
	slot0.isFromHeroGroup = slot1 and slot1.isFromHeroGroup
	slot0.bossId = slot1 and slot1.bossId
	slot0.towerType = slot1 and slot1.towerType
	slot0.towerId = slot1 and slot1.towerId

	if slot0.isFromHeroGroup then
		slot0.bossId = HeroGroupModel.instance:getCurGroupMO():getAssistBossId()

		if TowerModel.instance:isBossBan(slot0.bossId) or TowerModel.instance:isLimitTowerBossBan(slot0.towerType, slot0.towerId, slot0.bossId) then
			slot0.bossId = 0
		end
	end

	if slot0.isFirstRefresh then
		slot3 = {}

		if TowerConfig.instance:getAssistBossList() then
			for slot7, slot8 in ipairs(slot2) do
				if slot0:checkBossCanShow(slot8.bossId) then
					table.insert(slot3, slot0:buildBossData(slot8))
				end
			end
		end

		if #slot3 > 1 then
			if slot0.isFromHeroGroup then
				table.sort(slot3, SortUtil.tableKeyLower({
					"isBanOrder",
					"isSelectOrder",
					"isLock",
					"bossId"
				}))
			else
				table.sort(slot3, SortUtil.tableKeyLower({
					"isLock",
					"bossId"
				}))
			end
		end

		slot0:setList(slot3)
	else
		for slot6, slot7 in ipairs(slot0:getList()) do
			slot0:buildBossData(slot7.config, slot7)
		end

		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			if slot0:checkBossCanShow(slot8.bossId) then
				table.insert(slot3, slot8)
			end
		end

		slot0:setList(slot3)
	end

	slot0.isFirstRefresh = false
end

function slot0.checkBossCanShow(slot0, slot1)
	if not TowerModel.instance:isBossOpen(slot1) then
		return false
	end

	if slot0.towerType and slot0.towerType == TowerEnum.TowerType.Limited then
		if TowerConfig.instance:getTowerLimitedTimeCo(slot0.towerId) then
			for slot7, slot8 in ipairs(string.splitToNumber(slot2.bossPool, "#")) do
				if slot8 == slot1 then
					return true
				end
			end
		end

		return false
	end

	return true
end

function slot0.buildBossData(slot0, slot1, slot2)
	slot2 = slot2 or {}
	slot2.id = slot1.bossId
	slot2.config = slot1
	slot2.bossId = slot1.bossId
	slot2.bossInfo = TowerAssistBossModel.instance:getById(slot1.bossId)
	slot2.isLock = slot2.bossInfo == nil and 1 or 0
	slot2.isFromHeroGroup = slot0.isFromHeroGroup

	if slot0.isFromHeroGroup then
		slot2.isSelect = slot0.bossId == slot1.bossId

		if slot0.isFirstRefresh then
			slot2.isSelectOrder = slot2.isSelect and 0 or 1
		end

		slot2.isBanOrder = TowerModel.instance:isBossBan(slot1.bossId) and 1 or 0
	end

	slot2.isTowerOpen = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Boss, slot1.towerId, TowerEnum.TowerStatus.Open) ~= nil

	return slot2
end

slot0.instance = slot0.New()

return slot0
