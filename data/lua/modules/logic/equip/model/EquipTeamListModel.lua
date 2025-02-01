module("modules.logic.equip.model.EquipTeamListModel", package.seeall)

slot0 = class("EquipTeamListModel", ListScrollModel)
slot1 = 1
slot2 = 2
slot3 = 3

function slot0.onInit(slot0)
	slot0._levelAscend = false
	slot0._qualityAscend = false
	slot0._timeAscend = false
	slot0._btnTag = uv0
	slot0.isDown = false
end

function slot0.getHero(slot0)
	return slot0._heroMO
end

function slot0.getRequestData(slot0, slot1)
	return slot0:_getRequestData(slot0._posIndex, slot1)
end

function slot0.getRequestDataByTargetUid(slot0, slot1, slot2)
	if slot0:getEquipTeamPos(slot1) then
		return slot0:_getRequestData(slot3, slot2)
	end
end

function slot0._getRequestData(slot0, slot1, slot2)
	return slot0._curGroupMO.groupId, slot1, {
		slot2
	}
end

function slot0.openTeamEquip(slot0, slot1, slot2, slot3)
	slot0._curGroupMO = slot3 or HeroGroupModel.instance:getCurGroupMO()
	slot0._posIndex = slot1
	slot0._heroMO = slot2
end

function slot0.getCurPosIndex(slot0)
	return slot0._posIndex
end

function slot0.initInTeamEquips(slot0)
	slot0._allInTeamEquips = {}

	for slot5, slot6 in pairs(slot0._curGroupMO:getAllPosEquips()) do
		for slot10, slot11 in pairs(slot6.equipUid) do
			slot0._allInTeamEquips[slot11] = slot5
		end
	end
end

function slot0.getEquipTeamPos(slot0, slot1)
	return slot0._allInTeamEquips[slot1]
end

function slot0.equipInTeam(slot0, slot1)
	return slot0._allInTeamEquips[slot1] ~= nil
end

function slot0.getTeamEquip(slot0, slot1)
	return slot0._curGroupMO:getPosEquips(slot1 or slot0._posIndex).equipUid
end

function slot0.getCurGroupMo(slot0)
	return slot0._curGroupMO
end

function slot0.getBtnTag(slot0)
	return slot0._btnTag
end

function slot0.getRankState(slot0)
	return slot0._levelAscend and 1 or -1, slot0._qualityAscend and 1 or -1, slot0._timeAscend and 1 or -1
end

function slot0._sortByInTeam(slot0, slot1, slot2)
	if slot0:equipInTeam(slot1.uid) == slot0:equipInTeam(slot2.uid) then
		return nil
	end

	if slot3 then
		return true
	end

	return false
end

function slot0.setEquipList(slot0, slot1)
	if slot1 then
		slot0:initInTeamEquips()
	end

	slot0._equipList = {}

	for slot6, slot7 in ipairs(EquipModel.instance:getEquips()) do
		if EquipConfig.instance:getEquipCo(slot7.equipId) and slot8.isExpEquip ~= 1 and not EquipHelper.isRefineUniversalMaterials(slot7.equipId) then
			table.insert(slot0._equipList, slot7)
		end
	end

	if slot0._btnTag == uv0 then
		slot0:_sortByLevel()
	elseif slot0._btnTag == uv1 then
		slot0:_sortByQuality()
	elseif slot0._btnTag == uv2 then
		slot0:_sortByTime()
	end

	slot0:setList(slot0._equipList)
end

function slot0.sortByLevel(slot0)
	slot0._qualityAscend = false
	slot0._timeAscend = false

	if slot0._btnTag == uv0 then
		slot0._levelAscend = not slot0._levelAscend
	else
		slot0._btnTag = uv0
	end

	slot0:_sortByLevel()
	slot0:setList(slot0._equipList)
end

function slot0._sortByLevelFunc(slot0, slot1)
	if uv0.instance:_sortByInTeam(slot0, slot1) ~= nil then
		return slot2
	end

	if slot0.level ~= slot1.level then
		if uv0.instance._levelAscend then
			return slot0.level < slot1.level
		else
			return slot1.level < slot0.level
		end
	elseif slot0.config.rare ~= slot1.config.rare then
		return slot1.config.rare < slot0.config.rare
	else
		return slot1.id < slot0.id
	end
end

function slot0._sortByLevel(slot0)
	table.sort(slot0._equipList, uv0._sortByLevelFunc)
end

function slot0.sortByQuality(slot0)
	slot0._levelAscend = false
	slot0._timeAscend = false

	if slot0._btnTag == uv0 then
		slot0._qualityAscend = not slot0._qualityAscend
	else
		slot0._btnTag = uv0
	end

	slot0:_sortByQuality()
	slot0:setList(slot0._equipList)
end

function slot0._sortByQualityFunc(slot0, slot1)
	if uv0.instance:_sortByInTeam(slot0, slot1) ~= nil then
		return slot2
	end

	if slot0.config.rare ~= slot1.config.rare then
		if uv0.instance._qualityAscend then
			return slot0.config.rare < slot1.config.rare
		else
			return slot1.config.rare < slot0.config.rare
		end
	elseif slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	else
		return slot1.id < slot0.id
	end
end

function slot0._sortByQuality(slot0)
	table.sort(slot0._equipList, uv0._sortByQualityFunc)
end

function slot0.sortByTime(slot0)
	slot0._levelAscend = false
	slot0._qualityAscend = false

	if slot0._btnTag == uv0 then
		slot0._timeAscend = not slot0._timeAscend
	else
		slot0._btnTag = uv0
	end

	slot0:_sortByTime()
	slot0:setList(slot0._equipList)
end

function slot0._sortByTimeFunc(slot0, slot1)
	if uv0.instance:_sortByInTeam(slot0, slot1) ~= nil then
		return slot2
	end

	if slot0.id ~= slot1.id then
		if uv0.instance._timeAscend then
			return slot0.id < slot1.id
		else
			return slot1.id < slot0.id
		end
	elseif slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	else
		return slot1.config.rare < slot0.config.rare
	end
end

function slot0._sortByTime(slot0)
	table.sort(slot0._equipList, uv0._sortByTimeFunc)
end

function slot0.clearEquipList(slot0)
	slot0._equipList = nil

	slot0:clear()
end

function slot0.getEquipList(slot0)
	return slot0._equipList
end

slot0.instance = slot0.New()

return slot0
