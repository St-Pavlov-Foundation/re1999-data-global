module("modules.logic.equip.model.EquipChooseListModel", package.seeall)

slot0 = class("EquipChooseListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}
	slot0._maxCount = EquipEnum.StrengthenMaxCount
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initEquipMo(slot0, slot1, slot2)
	slot0._targetMO = slot1
	slot0._config = slot0._targetMO.config

	if slot2 then
		slot0:resetSortStatus()
	end
end

function slot0.updateStrengthenList(slot0)
	slot0:initEquipList()
	slot0:_onChooseChange()
end

function slot0.updateStrengthenListAndRefresh(slot0)
	slot0:updateStrengthenList()
	slot0:setEquipList()
end

function slot0.initEquipList(slot0, slot1, slot2)
	slot0.filterMo = slot1
	slot0._equipList = {}

	slot0:getEquipList(slot0._equipList, slot2)
	slot0:filterEquip()
	slot0:filterStrengthen(slot0._equipList)
end

function slot0.filterEquip(slot0)
	if not slot0.filterMo then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0._equipList) do
		if slot6.config and slot0.filterMo:checkIsIncludeTag(slot6.config) then
			table.insert(slot1, slot6)
		end
	end

	slot0._equipList = slot1
end

function slot0.getEquipList(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(EquipModel.instance:getEquips()) do
		if not slot9._chooseNum then
			slot9._chooseNum = 0
		end

		if not slot2 then
			slot9._chooseNum = 0
		end

		if slot9.config and slot9.id ~= slot0._targetMO.id and not EquipHelper.isSpRefineEquip(slot10) and slot9.equipId ~= EquipConfig.instance:getEquipUniversalId() then
			if slot3 then
				if slot10.rare < slot3 then
					table.insert(slot1, slot9)
				end
			else
				table.insert(slot1, slot9)
			end
		end
	end
end

function slot0.setEquipList(slot0)
	slot0:setList(slot0._equipList)
end

function slot0.resetSelectedEquip(slot0)
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}

	slot0:_onChooseChange()
end

function slot0.getChooseNum(slot0)
	if not slot0._chooseEquipList then
		return 0
	end

	for slot5, slot6 in ipairs(slot0._chooseEquipList) do
		slot1 = slot1 + slot6._chooseNum
	end

	return slot1
end

function slot0.getChooseEquipsNum(slot0)
	return slot0._chooseEquipList and #slot0._chooseEquipList or 0
end

function slot0._selectEquip(slot0, slot1)
	if slot1.count <= slot1._chooseNum then
		return EquipEnum.ChooseEquipStatus.BeyondEquipHadNum
	end

	if slot1._chooseNum <= 0 and slot0._maxCount <= slot0:getChooseEquipsNum() then
		return EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip
	end

	if EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._targetMO) <= EquipConfig.instance:getStrengthenToLv(slot0._config.rare, slot0._targetMO.level, slot0._targetMO.exp + (slot0:calcStrengthen() or 0)) then
		return EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience
	end

	if slot1._chooseNum == 0 then
		table.insert(slot0._chooseEquipList, slot1)
	end

	slot1._chooseNum = slot1._chooseNum + 1
	slot0._chooseEquipDic[slot1.id] = true

	return EquipEnum.ChooseEquipStatus.Success
end

function slot0.selectEquip(slot0, slot1)
	if slot0.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	if slot0:_selectEquip(slot1) == EquipEnum.ChooseEquipStatus.Success then
		slot0:_onChooseChange()
	end

	return slot2
end

function slot0.deselectEquip(slot0, slot1)
	if slot0.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	if not slot1._chooseNum or slot1._chooseNum <= 0 then
		return EquipEnum.ChooseEquipStatus.ReduceNotSelectedEquip
	end

	slot1._chooseNum = slot1._chooseNum - 1

	if slot1._chooseNum == 0 then
		for slot5, slot6 in ipairs(slot0._chooseEquipList) do
			if slot6.id == slot1.id then
				slot1._isBreak = false
				slot1._canBreak = nil

				table.remove(slot0._chooseEquipList, slot5)

				break
			end
		end
	end

	slot0._chooseEquipDic[slot1.id] = slot1._chooseNum > 0

	slot0:_onChooseChange()

	return EquipEnum.ChooseEquipStatus.Success
end

function slot0.calcStrengthen(slot0)
	if not slot0._targetMO then
		return 0
	end

	for slot5, slot6 in ipairs(slot0._chooseEquipList) do
		for slot10 = 1, slot6._chooseNum do
			slot1 = slot1 + EquipConfig.instance:getIncrementalExp(slot6)
		end
	end

	return slot1
end

function slot0._onChooseChange(slot0)
	EquipSelectedListModel.instance:updateList(slot0._chooseEquipList)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseChange)
end

function slot0.getChooseEquipList(slot0)
	return slot0._chooseEquipList
end

function slot0.isChoose(slot0, slot1)
	return slot0._chooseEquipDic[slot1.id]
end

function slot0.canBreak(slot0, slot1)
	return EquipConfig.instance:canBreak(slot0._targetMO, slot1)
end

function slot0._sortNormalEquip(slot0, slot1)
	if slot0.config.rare ~= slot1.config.rare then
		return slot0.config.rare < slot1.config.rare
	else
		return slot0.id < slot1.id
	end
end

function slot0.canFastAdd(slot0, slot1)
	if slot1.isLock then
		return false
	end

	if slot0.equipUidToHeroMo and slot0.equipUidToHeroMo[slot1.uid] then
		return false
	end

	if slot1.level > 1 or slot1.refineLv > 1 then
		return false
	end

	return true
end

function slot0.onlyAddExpEquip(slot0, slot1, slot2)
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}

	for slot6, slot7 in ipairs(slot1) do
		if EquipEnum.StrengthenMaxCount < slot6 then
			break
		end

		if slot2 <= slot7.count * EquipConfig.instance:getOneLevelEquipProduceExp(slot7.equipId) then
			slot0:addEquipMo(slot7, Mathf.Ceil(slot2 / slot8))

			break
		end

		slot2 = slot2 - slot9

		slot0:addEquipMo(slot7, slot7.count)
	end
end

function slot0.onlyAddNormalEquip(slot0, slot1, slot2)
	slot3 = 0
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}

	for slot7, slot8 in ipairs(slot1) do
		if EquipEnum.StrengthenMaxCount < slot7 then
			break
		end

		slot0:addEquipMo(slot8, 1)

		if slot2 <= slot3 + EquipConfig.instance:getOneLevelEquipProduceExp(slot8.config.rare) then
			break
		end
	end
end

function slot0.mixtureExpAndNormalEquip(slot0, slot1, slot2, slot3)
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}

	if slot3 <= EquipConfig.instance:getOneLevelEquipProduceExp(slot1[1].equipId) then
		slot0:addEquipMo(slot4, 1)

		return
	end

	for slot11, slot12 in ipairs(slot2) do
		slot0:addEquipMo(slot12, 1)

		if EquipEnum.StrengthenMaxCount - 1 <= 0 + 1 or slot3 - slot5 - EquipConfig.instance:getOneLevelEquipProduceExp(slot12.config.rare) <= 0 then
			break
		end
	end

	slot8 = 0

	if slot3 > 0 then
		slot3 = slot3 + slot5

		for slot12, slot13 in ipairs(slot1) do
			slot6 = slot6 + 1
			slot8 = slot8 + 1

			if slot3 <= slot13.count * EquipConfig.instance:getOneLevelEquipProduceExp(slot13.equipId) then
				slot0:addEquipMo(slot13, Mathf.Ceil(slot3 / slot14), slot8)

				break
			end

			slot0:addEquipMo(slot13, slot13.count, slot8)

			slot3 = slot3 - slot15

			if EquipEnum.StrengthenMaxCount <= slot6 then
				break
			end
		end
	else
		slot0:addEquipMo(slot4, 1, 1)
	end
end

function slot0.addEquipMo(slot0, slot1, slot2, slot3)
	slot1._chooseNum = slot2
	slot0._chooseEquipDic[slot1.id] = true

	if not tabletool.indexOf(slot0._chooseEquipList, slot1) then
		if slot3 then
			table.insert(slot0._chooseEquipList, slot3, slot1)
		else
			table.insert(slot0._chooseEquipList, slot1)
		end
	end
end

function slot0.fastAddEquip(slot0)
	if EquipConfig.instance:getNeedExpToMaxLevel(slot0._targetMO) <= 0 then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return
	end

	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}
	slot2 = {}

	slot0:getEquipList(slot2, false, slot0:getFilterRare())

	slot4 = {}
	slot5 = true

	for slot9, slot10 in ipairs(slot2) do
		if EquipHelper.isExpEquip(slot10.config) then
			table.insert({}, slot10)

			slot5 = false
		elseif EquipHelper.isNormalEquip(slot10.config) and slot0:canFastAdd(slot10) then
			table.insert(slot4, slot10)

			slot5 = false
		end
	end

	if slot5 then
		slot0:refreshEquip()
		GameFacade.showToast(ToastEnum.NoFastEquips)

		return
	end

	slot7 = #slot4

	if #slot3 ~= 0 then
		table.sort(slot3, function (slot0, slot1)
			return slot0.config.rare < slot1.config.rare
		end)
	end

	if slot7 ~= 0 then
		table.sort(slot4, uv0._sortNormalEquip)
	end

	if slot7 == 0 then
		slot0:onlyAddExpEquip(slot3, slot1)
	elseif slot6 == 0 then
		slot0:onlyAddNormalEquip(slot4, slot1)
	else
		slot0:mixtureExpAndNormalEquip(slot3, slot4, slot1)
	end

	slot0:refreshEquip()
end

function slot0.refreshEquip(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	slot0:_onChooseChange()
	slot0:setList(slot0._equipList)

	slot1 = {}

	for slot5, slot6 in ipairs(slot0._chooseEquipList) do
		table.insert(slot1, slot6.uid)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, slot1)
end

function slot0._sortNormal(slot0, slot1)
	if uv0.instance:sortChoose(slot0, slot1) == nil then
		slot3 = slot2:sortSame(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortQuality(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortExp(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortLevel(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortId(slot0, slot1)
	end

	return slot3
end

function slot0._sortMaxLevel(slot0, slot1)
	if uv0.instance:sortChoose(slot0, slot1) == nil then
		slot3 = slot2:sortLevel(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortId(slot0, slot1)
	end

	return slot3
end

function slot0._sortMaxBreak(slot0, slot1)
	if uv0.instance:sortChoose(slot0, slot1) == nil then
		slot3 = slot2:sortQuality(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortExp(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortLevel(slot0, slot1)
	end

	if slot3 == nil then
		slot3 = slot2:sortId(slot0, slot1)
	end

	return slot3
end

function slot0.filterStrengthen(slot0, slot1)
	if slot0._btnTag == 1 then
		table.sort(slot1, EquipHelper.sortByLevelFuncChooseListModel)
	else
		table.sort(slot1, EquipHelper.sortByQualityFuncChooseListModel)
	end
end

function slot0.sortId(slot0, slot1, slot2)
	if slot1.config.id == slot2.config.id then
		return false
	end

	return slot3 < slot4
end

function slot0.sortLevel(slot0, slot1, slot2)
	if slot1.level == slot2.level then
		return nil
	end

	if slot0._levelAscend then
		return slot3 < slot4
	else
		return slot4 < slot3
	end
end

function slot0.sortExp(slot0, slot1, slot2)
	if slot1.config.isExpEquip == slot2.config.isExpEquip then
		return nil
	end

	return slot4 < slot3
end

function slot0.sortQuality(slot0, slot1, slot2)
	if slot1.config.rare == slot2.config.rare then
		return nil
	end

	if slot0._qualityAscend then
		return slot3 < slot4
	else
		return slot4 < slot3
	end
end

function slot0.sortSame(slot0, slot1, slot2)
	if slot1.config.id == slot0._config.id and slot2.config.id == slot0._config.id then
		return nil
	end

	if slot3 then
		return true
	end

	if slot4 then
		return false
	end
end

function slot0.sortChoose(slot0, slot1, slot2)
	if slot0._chooseEquipDic[slot1.id] and slot0._chooseEquipDic[slot2.id] then
		return nil
	end

	if slot3 then
		return true
	end

	if slot4 then
		return false
	end
end

function slot0.getBtnTag(slot0)
	return slot0._btnTag
end

function slot0.getRankState(slot0)
	return slot0._levelAscend and 1 or -1, slot0._qualityAscend and 1 or -1
end

function slot0.sordByLevel(slot0)
	slot0:resetQualitySortStatus()

	if slot0._btnTag == 1 then
		slot0._levelAscend = not slot0._levelAscend
	else
		slot0._btnTag = 1
	end

	slot0:filterStrengthen(slot0._equipList)
	slot0:setList(slot0._equipList)
end

function slot0.sordByQuality(slot0)
	slot0:resetLevelSortStatus()

	if slot0._btnTag == 2 then
		slot0._qualityAscend = not slot0._qualityAscend
	else
		slot0._btnTag = 2
	end

	slot0:filterStrengthen(slot0._equipList)
	slot0:setList(slot0._equipList)
end

function slot0.clearEquipList(slot0)
	for slot5, slot6 in ipairs(EquipModel.instance:getEquips()) do
		slot6._canBreak = nil
		slot6._isBreak = nil
	end

	slot0._equipList = {}
	slot0._chooseEquipDic = {}
	slot0._chooseEquipList = {}
	slot0._targetMO = nil
end

function slot0.equipInTeam(slot0, slot1)
	if not slot0._allInTeamEquips then
		slot0._allInTeamEquips = {}

		if HeroGroupModel.instance:getCurGroupMO() then
			for slot7, slot8 in pairs(slot2:getAllPosEquips()) do
				for slot12, slot13 in pairs(slot8.equipUid) do
					if not slot0._allInTeamEquips[slot13] then
						slot0._allInTeamEquips[slot13] = {}
					end

					table.insert(slot14, {
						1,
						slot7 + 1
					})
				end
			end
		end
	end

	return slot0._allInTeamEquips[slot1]
end

function slot0.clearTeamInfo(slot0)
	slot0._allInTeamEquips = nil
end

function slot0.openEquipView(slot0)
	slot0.equipUidToHeroMo = {}
	slot0.equipUidToInGroup = {}
	slot1 = HeroGroupModel.instance:getMainGroupMo()

	for slot7, slot8 in pairs(slot1:getAllPosEquips()) do
		slot0.equipUidToHeroMo[slot8.equipUid[1]] = HeroModel.instance:getById(slot1.heroList[slot7 + 1])
		slot0.equipUidToInGroup[slot8.equipUid[1]] = true
	end

	slot0:resetSortStatus()
end

function slot0.getHeroMoByEquipUid(slot0, slot1)
	return slot0.equipUidToHeroMo and slot0.equipUidToHeroMo[slot1]
end

function slot0.isInGroup(slot0, slot1)
	return slot0.equipUidToInGroup and slot0.equipUidToInGroup[slot1]
end

function slot0.resetSortStatus(slot0)
	slot0._btnTag = 1

	slot0:resetLevelSortStatus()
	slot0:resetQualitySortStatus()
end

function slot0.resetLevelSortStatus(slot0)
	slot0._levelAscend = false
end

function slot0.resetQualitySortStatus(slot0)
	slot0._qualityAscend = false
end

function slot0.getFilterRare(slot0)
	if not slot0.filterRare then
		slot0.filterRare = EquipConfig.instance:getMinFilterRare()
	end

	logNormal("EquipChooseListModel : get filter rare : " .. tostring(slot0.filterRare))

	return slot0.filterRare
end

function slot0.setFilterRare(slot0, slot1)
	logNormal("EquipChooseListModel : set filter rare : " .. tostring(slot1))

	slot0.filterRare = slot1
end

function slot0.setIsLock(slot0, slot1)
	slot0.isLock = slot1
end

function slot0.clear(slot0)
	slot0.equipUidToHeroMo = {}
	slot0.equipUidToInGroup = {}
end

slot0.instance = slot0.New()

return slot0
