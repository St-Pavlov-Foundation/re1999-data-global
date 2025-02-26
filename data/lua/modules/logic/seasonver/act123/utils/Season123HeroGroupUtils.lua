module("modules.logic.seasonver.act123.utils.Season123HeroGroupUtils", package.seeall)

slot0 = class("Season123HeroGroupUtils")

function slot0.buildSnapshotHeroGroups(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		HeroGroupMO.New():setSeasonCardLimit(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)

		if slot6.heroList == nil or #slot6.heroList <= 0 then
			if not uv0.checkFirstCopyHeroGroup(slot6, slot7) then
				uv0.createEmptyGroup(slot6, slot7)
			end
		else
			slot7:init(slot6)
		end

		uv0.formation104Equips(slot7)

		slot1[slot6.groupId] = slot7
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.groupId < slot1.groupId
	end)

	return slot1
end

function slot0.checkFirstCopyHeroGroup(slot0, slot1)
	if slot0.groupId == 1 and HeroGroupModel.instance:getById(1) then
		slot1.id = slot0.groupId
		slot1.groupId = slot0.groupId
		slot1.name = slot2.name
		slot1.heroList = {
			Activity123Enum.EmptyUid,
			Activity123Enum.EmptyUid,
			Activity123Enum.EmptyUid,
			Activity123Enum.EmptyUid
		}
		slot1.aidDict = LuaUtil.deepCopy(slot2.aidDict)
		slot1.clothId = slot2.clothId
		slot1.equips = LuaUtil.deepCopy(slot2.equips)
		slot1.activity104Equips = LuaUtil.deepCopy(slot2.activity104Equips)

		uv0.formation104Equips(slot1)

		return true
	end

	return false
end

function slot0.formation104Equips(slot0)
	if not slot0.activity104Equips then
		slot0.activity104Equips = {}
	end

	for slot4 = 0, Activity123Enum.MainCharPos do
		if not slot0.activity104Equips[slot4] then
			slot0:updateActivity104PosEquips({
				index = slot4
			})
		end
	end

	for slot4, slot5 in pairs(slot0.activity104Equips) do
		slot5:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		uv0.formationSingle104Equips(slot5, slot4 < ModuleEnum.MaxHeroCountInGroup and Activity123Enum.HeroCardNum or Activity123Enum.MainCardNum)
	end
end

function slot0.formationSingle104Equips(slot0, slot1)
	for slot5, slot6 in pairs(slot0.equipUid) do
		if slot1 < slot5 then
			slot0.equipUid[slot5] = nil
		end
	end

	for slot5 = 1, slot1 do
		if slot0.equipUid[slot5] == nil then
			slot0.equipUid[slot5] = Activity123Enum.EmptyUid
		end
	end
end

function slot0.createEmptyGroup(slot0, slot1)
	slot1.id = slot0.groupId
	slot1.groupId = slot0.groupId
	slot1.name = ""
	slot1.heroList = {
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid
	}

	if HeroGroupModel.instance:getById(1) then
		slot1.clothId = slot2.clothId
	end

	slot1.equips = {}

	for slot6 = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		slot7 = HeroGroupEquipMO.New()

		slot7:init({
			index = slot6,
			equipUid = {
				Activity123Enum.EmptyUid
			}
		})

		slot1.equips[slot6] = slot7
	end

	slot1.activity104Equips = {}

	for slot7 = 0, ModuleEnum.MaxHeroCountInGroup do
		slot8 = HeroGroupActivity104EquipMo.New()

		slot8:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		slot8:init({
			index = slot7,
			equipUid = {
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid
			}
		})

		slot1.activity104Equips[slot7] = slot8
	end
end

function slot0.swapHeroItem(slot0, slot1)
	logNormal(string.format("swap hero pos %s to %s", slot0, slot1))

	slot2 = HeroGroupModel.instance:getCurGroupMO()
	slot3 = slot0 - 1
	slot4 = slot1 - 1
	slot2.equips[slot3].equipUid = {
		slot2:getPosEquips(slot4).equipUid[1]
	}
	slot2.equips[slot4].equipUid = {
		slot2:getPosEquips(slot3).equipUid[1]
	}
	slot2.activity104Equips[slot3].equipUid = slot2:getAct104PosEquips(slot4).equipUid
	slot2.activity104Equips[slot4].equipUid = slot2:getAct104PosEquips(slot3).equipUid
	slot2.heroList[slot3 + 1] = slot2.heroList[slot4 + 1]
	slot2.heroList[slot4 + 1] = slot2.heroList[slot3 + 1]
end

function slot0.syncHeroGroupFromFightGroup(slot0, slot1)
	slot0.heroList = {}

	for slot5, slot6 in ipairs(slot1.heroList) do
		table.insert(slot0.heroList, slot6)
	end

	for slot5, slot6 in ipairs(slot1.subHeroList) do
		table.insert(slot0.heroList, slot6)
	end

	slot0.clothId = slot1.clothId
	slot0.equips = {}

	for slot5, slot6 in ipairs(slot1.equips) do
		if slot0.equips[slot5 - 1] == nil then
			slot0.equips[slot7] = HeroGroupEquipMO.New()
		end

		slot0.equips[slot7]:init({
			index = slot7,
			equipUid = slot6.equipUid
		})
	end

	slot0.activity104Equips = {}

	for slot5, slot6 in ipairs(slot1.activity104Equips) do
		if slot0.activity104Equips[slot5 - 1] == nil then
			slot0.activity104Equips[slot7] = HeroGroupActivity104EquipMo.New()

			slot0.activity104Equips[slot7]:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		end

		slot0.activity104Equips[slot7]:init({
			index = slot7,
			equipUid = slot6.equipUid
		})
	end
end

function slot0.getHeroGroupEquipCardId(slot0, slot1, slot2, slot3)
	if not slot0.heroGroupSnapshot[slot1] then
		return
	end

	if not slot4.activity104Equips[slot3] then
		return
	end

	if slot0:getItemIdByUid(slot5.equipUid[slot2]) ~= nil then
		return slot7, slot6
	elseif slot6 ~= "0" then
		logError(string.format("can't find season123 item, itemUid = %s", slot6))
	end

	return 0
end

function slot0.processFightGroupAssistHero(slot0, slot1, slot2)
	if slot0 ~= ModuleEnum.HeroGroupType.Season123 then
		return
	end

	if Season123Model.instance:getBattleContext() then
		slot4, slot5 = Season123Model.instance:getAssistData(slot3.actId, slot3.stage)
		slot6, slot7 = nil

		if slot4 and slot5 and slot4.uid ~= "0" then
			slot7 = slot5.userId
			slot6 = slot4.uid
		end

		if slot6 and slot6 ~= "0" then
			slot8 = false

			for slot12 = 1, #slot1.heroList do
				if slot6 == slot1.heroList[slot12] then
					slot1.assistHeroUid = slot6
					slot1.assistUserId = slot7
					slot8 = true
				end
			end

			if not slot8 then
				for slot12 = 1, #slot1.subHeroList do
					if slot6 == slot1.subHeroList[slot12] then
						slot1.assistHeroUid = slot6
						slot1.assistUserId = slot7
						slot8 = true
					end
				end
			end
		end
	end
end

function slot0.cleanAllHeroGroup(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0) then
		return
	end

	for slot6, slot7 in pairs(slot2.heroGroupSnapshot) do
		uv0.cleanHeroGroup(slot7, slot1)
	end
end

function slot0.cleanHeroGroup(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroList) do
		slot0.heroList[slot5] = Activity123Enum.EmptyUid
	end

	for slot5 = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		for slot10, slot11 in pairs(slot0.equips[slot5].equipUid) do
			slot6.equipUid[slot10] = Activity123Enum.EmptyUid
		end
	end

	for slot6 = 0, ModuleEnum.MaxHeroCountInGroup do
		for slot11, slot12 in pairs(slot0.activity104Equips[slot6].equipUid) do
			if slot7.index == slot2 and slot1 then
				slot7.equipUid[slot11] = slot1[slot11] or Activity123Enum.EmptyUid
			else
				slot7.equipUid[slot11] = Activity123Enum.EmptyUid
			end
		end
	end

	uv0.formation104Equips(slot0)
end

function slot0.getAllHeroActivity123Equips(slot0)
	slot1 = {}
	slot4 = Season123Model.instance:getActInfo(Season123Model.instance:getBattleContext() and slot2.actId)

	for slot8, slot9 in pairs(slot0.activity104Equips) do
		if slot8 + 1 == Season123EquipItemListModel.MainCharPos + 1 then
			FightEquipMO.New().heroUid = "-100000"
		else
			slot11.heroUid = slot0.heroList[slot10] or Activity123Enum.EmptyUid
		end

		for slot15, slot16 in ipairs(slot9.equipUid) do
			if slot16 and slot16 ~= Activity123Enum.EmptyUid then
				if slot4 then
					slot9.equipUid[slot15] = slot4:getItemIdByUid(slot16) and slot17 > 0 and slot16 or Activity123Enum.EmptyUid
				else
					slot9.equipUid[slot15] = Activity123Enum.EmptyUid
				end
			end
		end

		slot11.equipUid = slot9.equipUid

		table.insert(slot1, slot11)
	end

	return slot1
end

function slot0.fiterFightCardDataList(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	if slot1 then
		slot6 = FightModel.instance:getBattleId() and lua_battle.configDict[slot5]

		for slot11, slot12 in ipairs(slot1) do
			if slot12.pos < 0 then
				slot13 = (slot6 and slot6.playerMax or ModuleEnum.HeroCountInGroup) - slot13
			end

			slot4[slot13] = slot12.trialId
		end
	end

	slot8 = slot0

	uv0.fiterFightCardData(Season123EquipItemListModel.TotalEquipPos, slot3, slot8, nil, slot2)

	for slot8 = 1, Season123EquipItemListModel.TotalEquipPos - 1 do
		uv0.fiterFightCardData(slot8, slot3, slot0, slot4, slot2)
	end

	return slot3
end

function slot0.fiterFightCardData(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot3 and slot3[slot0]
	slot7 = slot2 and slot2[slot0] and slot2[slot0].heroUid

	if slot0 - 1 == Season123EquipItemListModel.MainCharPos then
		slot7 = nil
	end

	if (not slot7 or slot7 == Season123EquipItemListModel.EmptyUid) and slot5 ~= Season123EquipItemListModel.MainCharPos then
		return
	end

	slot9 = Season123EquipItemListModel.instance:getEquipMaxCount(slot5)
	slot10 = 1

	if not Season123Model.instance:getActInfo(slot4) then
		return
	end

	for slot15 = 1, slot9 do
		slot17 = nil

		if slot2 and slot2[slot0] and slot2[slot0].equipUid and slot2[slot0].equipUid[slot15] then
			slot17 = slot11:getItemIdByUid(slot16)
		end

		if not slot17 or slot17 == 0 then
			if slot6 then
				slot17 = HeroConfig.instance:getTrial104Equip(slot15, slot6)
			elseif slot5 == Season123EquipItemListModel.MainCharPos then
				slot19 = FightModel.instance:getBattleId() and lua_battle.configDict[slot18]
				slot17 = slot19 and slot19.trialMainAct104EuqipId
			end
		end

		if slot17 and slot17 > 0 then
			table.insert(slot1, {
				equipId = slot17,
				heroUid = slot7,
				trialId = slot6,
				count = slot10 + 1
			})
		end
	end
end

function slot0.getUnlockIndexSlot(slot0)
	if slot0 >= 1 and slot0 <= 4 then
		return 1
	end

	if slot0 >= 5 and slot0 <= 8 then
		return 2
	end

	if slot0 >= 9 then
		return 3
	end

	return 0
end

function slot0.getUnlockSlotSet(slot0)
	if not Season123Model.instance:getActInfo(slot0) then
		return {}
	end

	return tabletool.copy(slot1.unlockIndexSet)
end

function slot0.setHpBar(slot0, slot1)
	if slot1 >= 0.69 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0, "#63955C")
	elseif slot1 >= 0.3 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0, "#E99B56")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0, "#BF2E11")
	end
end

return slot0
