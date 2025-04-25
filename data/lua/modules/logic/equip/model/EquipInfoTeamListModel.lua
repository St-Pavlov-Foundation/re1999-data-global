module("modules.logic.equip.model.EquipInfoTeamListModel", package.seeall)

slot0 = class("EquipInfoTeamListModel", EquipInfoBaseListModel)

function slot0.onOpen(slot0, slot1, slot2)
	slot0.heroMo = slot1.heroMo

	slot0:initTeamEquipList(slot1, slot2)

	slot0.curGroupMO = slot1.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	slot0.maxHeroNum = slot1.maxHeroNum
	slot0.posIndex = slot1.posIndex

	if slot1 and slot1.heroMo and slot1.heroMo:isOtherPlayerHero() then
		slot0.otherPlayerHeroMo = slot1.heroMo
	end

	slot0:setCurrentSelectEquipMo(slot1.equipMo or slot0.equipMoList and slot0.equipMoList[1])
	slot0:initInTeamEquipUidToHero()
end

function slot0.initTeamEquipList(slot0, slot1, slot2)
	if (slot1.equipMo and slot1.equipMo.equipType) == EquipEnum.ClientEquipType.TrialHero then
		slot0.equipMoList = {
			slot1.equipMo
		}
	else
		slot0:initEquipList(slot2)
	end
end

function slot0.initEquipList(slot0, slot1)
	slot0.equipMoList = {}
	slot2 = slot1:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for slot6, slot7 in ipairs(EquipModel.instance:getEquips()) do
			if EquipHelper.isNormalEquip(slot7.config) then
				if slot2 then
					if slot1:checkIsIncludeTag(slot7.config) then
						table.insert(slot0.equipMoList, slot7)
					end
				else
					table.insert(slot0.equipMoList, slot7)
				end
			end
		end
	end

	for slot6, slot7 in ipairs(HeroGroupTrialModel.instance:getTrialEquipList()) do
		if slot2 then
			if slot1:checkIsIncludeTag(slot7.config) then
				table.insert(slot0.equipMoList, slot7)
			end
		else
			table.insert(slot0.equipMoList, slot7)
		end
	end

	slot0:resortEquip()
end

function slot0.initInTeamEquipUidToHero(slot0)
	slot0.equipUidToHeroMo = {}

	for slot5, slot6 in pairs(slot0.curGroupMO.equips) do
		if not slot0.maxHeroNum or slot5 + 1 <= slot0.maxHeroNum then
			if slot0.curGroupMO.heroList[slot5 + 1] and tonumber(slot7) < 0 then
				slot0.equipUidToHeroMo[slot6.equipUid[1]] = HeroGroupTrialModel.instance:getById(slot7)
			elseif slot0.otherPlayerHeroMo and slot0.otherPlayerHeroMo.uid == slot7 then
				slot0.equipUidToHeroMo[slot6.equipUid[1]] = slot0.otherPlayerHeroMo
			else
				slot0.equipUidToHeroMo[slot6.equipUid[1]] = HeroModel.instance:getById(slot7)
			end
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
