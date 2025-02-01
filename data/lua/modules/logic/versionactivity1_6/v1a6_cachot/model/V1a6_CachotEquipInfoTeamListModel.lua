module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotEquipInfoTeamListModel", package.seeall)

slot0 = class("V1a6_CachotEquipInfoTeamListModel", EquipInfoBaseListModel)

function slot0.setSeatLevel(slot0, slot1)
	slot0._seatLevel = slot1
end

function slot0.getSeatLevel(slot0)
	return slot0._seatLevel
end

function slot0.onOpen(slot0, slot1, slot2)
	slot0.viewParam = slot1

	slot0:initTeamEquipList(slot1, slot2)

	slot0.curGroupMO = slot1.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	slot0.posIndex = slot1.posIndex

	slot0:setCurrentSelectEquipMo(slot1.equipMo or slot0.equipMoList and slot0.equipMoList[1])
	slot0:initInTeamEquipUidToHero()
end

function slot0.initTeamEquipList(slot0, slot1, slot2)
	if slot1.equipMo and slot1.equipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		slot0.equipMoList = {
			slot1.equipMo
		}
	else
		slot0:initEquipList(slot2)
	end
end

function slot0.initEquipList(slot0, slot1)
	slot2 = {}

	if slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		for slot7, slot8 in ipairs(V1a6_CachotModel.instance:getTeamInfo().equipUids) do
			table.insert(slot2, EquipModel.instance:getEquip(slot8))
		end
	else
		slot2 = EquipModel.instance:getEquips()
	end

	slot0.equipMoList = {}
	slot3 = slot1:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for slot7, slot8 in ipairs(slot2) do
			if EquipHelper.isNormalEquip(slot8.config) then
				if slot3 then
					if slot1:checkIsIncludeTag(slot8.config) then
						table.insert(slot0.equipMoList, slot8)
					end
				else
					table.insert(slot0.equipMoList, slot8)
				end
			end
		end
	end

	slot0:resortEquip()
end

function slot0.initInTeamEquipUidToHero(slot0)
	slot0.equipUidToHeroMo = {}

	for slot5, slot6 in pairs(slot0.curGroupMO.equips) do
		if tonumber(slot0.curGroupMO.heroList[slot5 + 1]) < 0 then
			slot0.equipUidToHeroMo[slot6.equipUid[1]] = HeroGroupTrialModel.instance:getById(slot7)
		else
			slot0.equipUidToHeroMo[slot6.equipUid[1]] = HeroModel.instance:getById(slot7)
		end
	end
end

function slot0.getGroupCurrentPosEquip(slot0, slot1)
	return slot0.curGroupMO:getPosEquips(slot1 or slot0.posIndex).equipUid
end

function slot0.getCurrentPosIndex(slot0)
	return slot0.posIndex
end

function slot0.getRequestData(slot0, slot1, slot2)
	return slot0.curGroupMO.groupId, slot1, {
		slot2
	}
end

function slot0.getHeroMoByEquipUid(slot0, slot1)
	return slot0.equipUidToHeroMo and slot0.equipUidToHeroMo[slot1]
end

function slot0.clear(slot0)
	slot0:onInit()

	slot0.selectedEquipMo = nil
	slot0.curGroupMO = nil
	slot0.posIndex = nil
	slot0.equipUidToHeroMo = nil
end

slot0.instance = slot0.New()

return slot0
