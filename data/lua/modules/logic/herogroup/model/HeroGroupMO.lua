module("modules.logic.herogroup.model.HeroGroupMO", package.seeall)

slot0 = pureTable("HeroGroupMO")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.groupId = nil
	slot0.name = nil
	slot0.heroList = {}
	slot0.aidDict = nil
	slot0.trialDict = nil
	slot0.clothId = nil
	slot0.temp = false
	slot0.isReplay = false
	slot0.equips = {}
	slot0.activity104Equips = {}
	slot0.exInfos = {}
	slot0.assistBossId = nil
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.groupId
	slot0.groupId = slot1.groupId
	slot0.name = slot1.name
	slot0.clothId = slot1.clothId
	slot0.assistBossId = slot1.assistBossId
	slot0.heroList = {}
	slot2 = slot1.heroList and #slot1.heroList or 0

	for slot6 = 1, slot2 do
		table.insert(slot0.heroList, slot1.heroList[slot6])
	end

	for slot6 = slot2 + 1, ModuleEnum.MaxHeroCountInGroup do
		table.insert(slot0.heroList, "0")
	end

	if slot1.equips then
		if slot1.equips[0] then
			slot0:updatePosEquips(slot1.equips[0])
		end

		for slot6, slot7 in ipairs(slot1.equips) do
			slot0:updatePosEquips(slot7)
		end
	end

	if slot1.activity104Equips then
		if slot1.activity104Equips[0] then
			slot0:updateActivity104PosEquips(slot1.activity104Equips[0])
		end

		for slot6, slot7 in ipairs(slot1.activity104Equips) do
			slot0:updateActivity104PosEquips(slot7)
		end
	end
end

function slot0.initByFightGroup(slot0, slot1)
	slot0.id = 1
	slot0.groupId = 1
	slot0.clothId = slot1.clothId
	slot0.recordRound = slot1.recordRound
	slot0.heroList = {}
	slot0.replay_hero_data = {}
	slot2 = {}
	slot0.replay_equip_data = {}
	slot0.trialDict = {}
	slot0.aidDict = {}
	slot0.exInfos = {}
	slot0.replayAssistHeroUid = slot1.assistHeroUid
	slot0.replayAssistUserId = slot1.assistUserId
	slot0.assistBossId = slot1.assistBossId
	slot4 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot3]
	slot5 = slot4 and slot4.playerMax or ModuleEnum.HeroCountInGroup
	slot6 = string.splitToNumber(slot4.aid, "#") or {}

	if slot1.exInfos then
		for slot10, slot11 in ipairs(slot1.exInfos) do
			slot0.exInfos[slot10] = slot11
		end
	end

	for slot10, slot11 in ipairs(slot1.trialHeroList) do
		slot12 = lua_hero_trial.configDict[slot11.trialId][0]

		if slot11.pos < 0 then
			slot13 = slot5 - slot13
		end

		slot14 = tostring(slot12.heroId - 1099511627776.0)
		slot2[slot14] = slot13
		slot0.heroList[slot13] = slot14

		if ({
			heroUid = slot14,
			heroId = slot12.heroId,
			level = slot12.level,
			skin = slot12.skin
		}).skin == 0 then
			slot15.skin = lua_character.configDict[slot12.heroId].skinId
		end

		slot0.replay_hero_data[slot14] = slot15
		slot16 = slot13 - 1
		slot0.equips[slot16] = HeroGroupEquipMO.New()

		slot0.equips[slot16]:init({
			index = slot16,
			equipUid = {
				slot11.equipRecords[1].equipUid
			}
		})

		slot0.replay_equip_data[slot14] = {
			equipUid = slot11.equipRecords[1].equipUid,
			equipId = slot11.equipRecords[1].equipId,
			equipLv = slot11.equipRecords[1].equipLv,
			refineLv = slot11.equipRecords[1].refineLv
		}
		slot0.trialDict[slot13] = {
			slot11.trialId,
			0,
			slot13
		}
	end

	for slot10, slot11 in ipairs(slot1.heroList) do
		slot12 = slot11.heroUid
		slot13 = 1

		while slot0.heroList[slot13] do
			slot13 = slot13 + 1
		end

		slot0.heroList[slot13] = slot12
		slot2[slot12] = slot13
		slot0.replay_hero_data[slot12] = {
			heroUid = slot12,
			heroId = slot11.heroId,
			level = slot11.level,
			skin = slot11.skin
		}

		if tonumber(slot12) < 0 then
			slot0.aidDict[slot13] = slot6[-tonumber(slot12)]
		end
	end

	for slot10, slot11 in ipairs(slot1.subHeroList) do
		slot12 = slot11.heroUid
		slot13 = 1

		while slot0.heroList[slot13] do
			slot13 = slot13 + 1
		end

		slot0.heroList[slot13] = slot12
		slot2[slot12] = slot13
		slot0.replay_hero_data[slot12] = {
			heroUid = slot12,
			heroId = slot11.heroId,
			level = slot11.level,
			skin = slot11.skin
		}
	end

	slot0.replay_equip_data = {}

	for slot10, slot11 in ipairs(slot1.equips) do
		slot0.equips[slot2[slot11.heroUid] - 1] = HeroGroupEquipMO.New()

		if slot11.equipRecords[1] then
			slot0.equips[slot12]:init({
				index = slot12,
				equipUid = {
					slot13.equipUid
				}
			})

			slot0.replay_equip_data[slot11.heroUid] = {
				equipUid = slot13.equipUid,
				equipId = slot13.equipId,
				equipLv = slot13.equipLv,
				refineLv = slot13.refineLv
			}
		end
	end

	slot0.replay_activity104Equip_data = {}

	for slot10, slot11 in ipairs(slot1.activity104Equips) do
		slot12 = slot11.heroUid == "-100000" and 4 or slot2[slot11.heroUid] - 1
		slot0.activity104Equips[slot12] = HeroGroupActivity104EquipMo.New()

		slot0.activity104Equips[slot12]:setLimitNum(slot0._seasonCardMainNum, slot0._seasonCardNormalNum)

		if slot11.activity104EquipRecords[1] then
			slot14 = {}

			for slot18, slot19 in ipairs(slot11.activity104EquipRecords) do
				table.insert(slot14, slot19.equipUid)
			end

			slot0.activity104Equips[slot12]:init({
				index = slot12,
				equipUid = slot14
			})

			slot15 = {}

			for slot19, slot20 in ipairs(slot11.activity104EquipRecords) do
				table.insert(slot15, {
					equipUid = slot20.equipUid,
					equipId = slot20.equipId
				})
			end

			slot0.replay_activity104Equip_data[slot11.heroUid] = slot15
		else
			slot0.activity104Equips[slot12]:init({
				index = slot12,
				equipUid = {}
			})
		end
	end

	slot0.isReplay = true
end

function slot0.initByLocalData(slot0, slot1)
	slot0.id = 1
	slot0.groupId = 1
	slot0.name = ""
	slot0.heroList = {}
	slot0.aidDict = nil
	slot0.trialDict = {}
	slot0.clothId = slot1.clothId
	slot0.assistBossId = slot1.assistBossId
	slot0.temp = true
	slot0.isReplay = false
	slot0.equips = {}
	slot0.activity104Equips = {}
	slot4 = {}

	if not string.nilorempty((HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]).trialHeros) then
		slot4 = GameUtil.splitString2(slot3.trialHeros, true)
	end

	if ToughBattleModel.instance:getAddTrialHeros() then
		for slot9, slot10 in pairs(slot5) do
			table.insert(slot4, {
				slot10
			})
		end
	end

	for slot9 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot0.heroList[slot9] = slot1.heroList[slot9] or "0"
		slot0.equips[slot9 - 1] = HeroGroupEquipMO.New()

		slot0.equips[slot9 - 1]:init({
			index = slot9 - 1,
			equipUid = {
				slot1.equips[slot9] or "0"
			}
		})
		slot0:updateActivity104PosEquips({
			index = slot9 - 1,
			equipUid = slot1.activity104Equips and slot1.activity104Equips[slot9] or {}
		})

		if tonumber(slot0.heroList[slot9]) < 0 then
			slot10 = false

			for slot14, slot15 in pairs(slot4) do
				if lua_hero_trial.configDict[slot15[1]][slot15[2] or 0].heroId - 1099511627776.0 == tonumber(slot0.heroList[slot9]) then
					slot0.trialDict[slot9] = slot15
					slot10 = true

					break
				end
			end

			if not slot10 then
				slot0.heroList[slot9] = "0"
			end
		end
	end

	slot0:updateActivity104PosEquips({
		index = ModuleEnum.MaxHeroCountInGroup + 1 - 1,
		equipUid = slot1.activity104Equips and slot1.activity104Equips[slot6] or {}
	})

	if Activity104Model.instance:isSeasonChapter() and slot1.battleId ~= slot2 then
		for slot10, slot11 in ipairs(slot0.heroList) do
			if tonumber(slot11) < 0 then
				slot0.heroList[slot10] = tostring(0)
				slot0.trialDict[slot10] = nil
			end
		end
	end
end

function slot0.setTrials(slot0, slot1)
	if not slot0.trialDict then
		slot0.trialDict = {}
	end

	slot4 = {}

	if not string.nilorempty((HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]).trialHeros) then
		slot4 = GameUtil.splitString2(slot3.trialHeros, true)
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		if slot10[3] then
			if slot10[3] < 0 then
				slot11 = slot0._playerMax - slot11
			end

			slot0.trialDict[slot11] = slot10
			slot12 = lua_hero_trial.configDict[slot10[1]][slot10[2] or 0]
			slot0.heroList[slot11] = tostring(slot12.heroId - 1099511627776.0)
			slot5[slot12.heroId] = true

			if not slot1 and (slot12.act104EquipId1 > 0 or slot12.act104EquipId2 > 0) then
				slot0:updateActivity104PosEquips({
					index = slot11 - 1
				})
			end
		end
	end

	for slot9, slot10 in pairs(slot0.heroList) do
		if tonumber(slot10) > 0 and HeroModel.instance:getById(slot10) and slot5[slot11.heroId] then
			slot0.heroList[slot9] = "0"
		end
	end

	if not slot1 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not string.nilorempty(slot3.trialEquips) then
		slot10 = ModuleEnum.MaxHeroCountInGroup

		for slot10 = 1, math.min(#string.splitToNumber(slot3.trialEquips, "|"), slot10) do
			slot0:updatePosEquips({
				index = slot10 - 1,
				equipUid = {
					tostring(-slot6[slot10])
				}
			})
		end
	end

	if not slot1 and slot3.trialMainAct104EuqipId > 0 then
		slot0:updateActivity104PosEquips({
			index = ModuleEnum.MaxHeroCountInGroup,
			equipUid = {
				-slot3.trialMainAct104EuqipId
			}
		})
	end
end

function slot0.saveData(slot0)
	slot1 = HeroGroupModel.instance.battleId
	slot2 = {
		clothId = slot0.clothId,
		heroList = {},
		equips = {},
		activity104Equips = {},
		assistBossId = slot0.assistBossId
	}

	for slot6 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot2.heroList[slot6] = slot0.heroList[slot6]
		slot2.equips[slot6] = slot0.equips[slot6 - 1] and slot0.equips[slot6 - 1].equipUid[1]
		slot2.activity104Equips[slot6] = slot0.activity104Equips[slot6 - 1] and slot0.activity104Equips[slot6 - 1].equipUid
	end

	slot2.activity104Equips[slot3] = slot0.activity104Equips[ModuleEnum.MaxHeroCountInGroup + 1 - 1] and slot0.activity104Equips[slot3 - 1].equipUid
	slot2.battleId = slot1
	slot4 = nil

	PlayerPrefsHelper.setString((not Activity104Model.instance:isSeasonChapter() or Activity104Model.instance:getSeasonTrialPrefsKey()) and PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot1, cjson.encode(slot2))
end

function slot0.setTempName(slot0, slot1)
	slot0.name = slot1
end

function slot0.setTemp(slot0, slot1)
	slot0.temp = slot1
end

function slot0.replaceHeroList(slot0, slot1)
	slot0.heroList = {}
	slot0.aidDict = {}
	slot0.trialDict = {}

	for slot6 = 1, slot1 and #slot1 or 0 do
		table.insert(slot0.heroList, slot1[slot6].heroUid)

		if slot1[slot6].aid then
			slot0.aidDict[slot6] = slot1[slot6].aid
		end
	end

	slot0:_dropAidEquip()
end

function slot0._dropAidEquip(slot0)
	if slot0.aidDict then
		for slot4, slot5 in pairs(slot0.aidDict) do
			if slot5 > 0 then
				slot0:_setPosEquips(slot4 - 1, nil)
				slot0:updateActivity104PosEquips({
					index = slot4 - 1
				})
			end
		end
	end

	if slot0.trialDict then
		for slot4, slot5 in pairs(slot0.trialDict) do
			slot0:_setPosEquips(slot4 - 1, nil)
			slot0:updateActivity104PosEquips({
				index = slot4 - 1
			})
		end
	end
end

function slot0.replaceClothId(slot0, slot1)
	slot0.clothId = slot1
end

function slot0.getHeroByIndex(slot0, slot1)
	return slot0.heroList[slot1]
end

function slot0.getAllPosEquips(slot0)
	return slot0.equips
end

function slot0.getPosEquips(slot0, slot1)
	if not slot0.equips[slot1] then
		slot0:updatePosEquips({
			index = slot1
		})
	end

	return slot0.equips[slot1]
end

function slot0._setPosEquips(slot0, slot1, slot2)
	if slot2 == nil then
		HeroGroupEquipMO.New():init({
			index = slot1
		})
	end

	slot0.equips[slot1] = slot2
end

function slot0.updatePosEquips(slot0, slot1)
	for slot5 = 0, 3 do
		if slot0.equips[slot5] and slot6.equipUid and #slot6.equipUid > 0 and slot1.equipUid and #slot1.equipUid > 0 then
			for slot10 = 1, 1 do
				if slot6.equipUid[slot10] == slot1.equipUid[slot10] then
					slot6.equipUid[slot10] = "0"
				end
			end
		end
	end

	slot2 = HeroGroupEquipMO.New()

	slot2:init(slot1)

	slot0.equips[slot1.index] = slot2
end

function slot0.getAct104PosEquips(slot0, slot1)
	if not slot0.activity104Equips[slot1] then
		slot0:updateActivity104PosEquips({
			index = slot1
		})
	end

	return slot0.activity104Equips[slot1]
end

function slot0.updateActivity104PosEquips(slot0, slot1)
	slot2 = HeroGroupActivity104EquipMo.New()

	slot2:setLimitNum(slot0._seasonCardMainNum, slot0._seasonCardNormalNum)
	slot2:init(slot1)

	slot0.activity104Equips[slot1.index] = slot2
end

function slot0.checkAndPutOffEquip(slot0)
	if not slot0.equips then
		return
	end

	for slot4, slot5 in pairs(slot0.equips) do
		for slot9, slot10 in ipairs(slot5.equipUid) do
			if tonumber(slot10) > 0 then
				slot5.equipUid[slot9] = EquipModel.instance:getEquip(slot10) and slot10 or "0"
			end
		end
	end
end

function slot0.getAllHeroEquips(slot0)
	slot1 = {}
	slot2 = false
	slot4 = {}

	if FightModel.instance:getFightParam() and slot3.battleId > 0 and not string.nilorempty(lua_battle.configDict[slot3.battleId].trialEquips) then
		slot4 = string.splitToNumber(slot5.trialEquips, "|")
	end

	for slot8, slot9 in pairs(slot0.equips) do
		FightEquipMO.New().heroUid = slot0.heroList[slot8 + 1] or "0"

		for slot16, slot17 in ipairs(slot9.equipUid) do
			if tonumber(slot17) > 0 then
				slot9.equipUid[slot16] = EquipModel.instance:getEquip(slot17) and slot17 or "0"

				if not slot18 then
					slot2 = true
				end
			elseif lua_equip_trial.configDict[-tonumber(slot17)] and tabletool.indexOf(slot4, slot18) then
				slot9.equipUid[slot16] = slot17
			else
				slot9.equipUid[slot16] = "0"
			end
		end

		slot12.equipUid = slot9.equipUid

		table.insert(slot1, slot12)
	end

	return slot1, slot2
end

function slot0.getAllHeroActivity104Equips(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.activity104Equips) do
		if slot5 + 1 == 5 then
			FightEquipMO.New().heroUid = "-100000"
		else
			slot8.heroUid = slot0.heroList[slot7] or "0"
		end

		for slot12, slot13 in ipairs(slot6.equipUid) do
			if tonumber(slot13) > 0 then
				slot6.equipUid[slot12] = Activity104Model.instance:getItemIdByUid(slot13) and slot14 > 0 and slot13 or "0"
			end
		end

		slot8.equipUid = slot6.equipUid

		table.insert(slot1, slot8)
	end

	return slot1
end

function slot0.getEquipUidList(slot0)
	for slot5 = 1, ModuleEnum.MaxHeroCountInGroup do
		if slot0.equips[slot5 - 1] then
			-- Nothing
		else
			slot1[slot5] = 0
		end
	end

	return {
		[slot5] = slot6.equipUid and slot6.equipUid[1] or 0
	}
end

function slot0.initWithBattle(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0:init(slot1)

	slot0.battleHeroGroup = true
	slot0.aidDict = {}
	slot0.trialDict = {}

	if not slot5 then
		slot0._roleNum = slot3
		slot0._playerMax = math.min(slot4, slot3)
	end

	slot7 = ModuleEnum.MaxHeroCountInGroup
	slot8 = {}
	slot9 = {}
	slot10 = {}

	for slot14, slot15 in ipairs(slot6 or {}) do
		if slot15[3] then
			if slot15[3] < 0 then
				slot16 = slot0._playerMax - slot16
			end

			if slot0.heroList[slot16] then
				slot17 = lua_hero_trial.configDict[slot15[1]][slot15[2] or 0]

				if tonumber(slot0.heroList[slot16]) > 0 then
					table.insert(slot8, slot0.heroList[slot16])
					table.insert(slot9, slot0:getPosEquips(slot16 - 1))
				end

				slot0.heroList[slot16] = tostring(slot17.heroId - 1099511627776.0)
				slot0.trialDict[slot16] = slot15
				slot10[slot17.heroId] = true
			end
		end
	end

	for slot14 = 1, slot7 do
		if HeroModel.instance:getById(slot0.heroList[slot14]) and slot10[slot15.heroId] then
			slot0.heroList[slot14] = "0"
		end
	end

	for slot14 = 1, slot7 do
		for slot18 = 1, #slot2 do
			if lua_skin.configDict[lua_monster.configDict[tonumber(slot2[slot18])] and slot19.skinId] and slot20.characterId and slot0.heroList[slot14] and HeroModel.instance:getById(slot0.heroList[slot14]) and slot22.heroId == slot21 then
				if slot4 < slot14 or slot3 < slot14 or HeroGroupModel.instance:positionOpenCount() < slot14 then
					slot0.heroList[slot14] = "0"

					break
				end

				slot0.heroList[slot14] = tostring(-slot18)
				slot0.aidDict[slot14] = slot2[slot18]

				slot0:updatePosEquips({
					index = slot14 - 1
				})

				slot2[slot18] = nil

				break
			end
		end
	end

	for slot14 = slot7, 1, -1 do
		if slot3 < slot14 or HeroGroupModel.instance:positionOpenCount() < slot14 and not slot0.trialDict[slot14] then
			if slot0.heroList[slot14] and tonumber(slot0.heroList[slot14]) > 0 then
				table.insert(slot8, slot0.heroList[slot14])
				table.insert(slot9, slot0:getPosEquips(slot14 - 1))
			end

			slot0.heroList[slot14] = "0"

			if slot14 <= HeroGroupModel.instance:positionOpenCount() then
				slot0.aidDict[slot14] = -1
			end
		elseif slot4 < slot14 then
			-- Nothing
		elseif not slot0.heroList[slot14] or tonumber(slot0.heroList[slot14]) >= 0 and not slot0.trialDict[slot14] then
			for slot18 = 1, slot7 do
				if slot2[slot18] then
					if slot0.heroList[slot14] and tonumber(slot0.heroList[slot14]) > 0 then
						table.insert(slot8, slot0.heroList[slot14])
						table.insert(slot9, slot0:getPosEquips(slot14 - 1))
					end

					slot0.heroList[slot14] = tostring(-slot18)
					slot0.aidDict[slot14] = slot2[slot18]

					slot0:updatePosEquips({
						index = slot14 - 1
					})

					slot2[slot18] = nil

					break
				end
			end
		end
	end

	for slot14 = 1, slot7 do
		if #slot8 <= 0 then
			break
		end

		if slot14 <= slot3 and slot14 <= HeroGroupModel.instance:positionOpenCount() and (not slot0.heroList[slot14] or slot0.heroList[slot14] == "0" or slot0.heroList[slot14] == 0) then
			slot0.heroList[slot14] = slot8[#slot8]

			slot0:_setPosEquips(slot14 - 1, slot9[#slot9])
			table.remove(slot8, #slot8)
			table.remove(slot9, #slot9)
		end
	end

	slot0:_dropAidEquip()
end

function slot0._getHeroListBackup(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.heroList) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.getMainList(slot0)
	slot1 = {}
	slot2 = 0

	if slot0._playerMax then
		for slot6 = 1, slot0._playerMax do
			slot7 = slot0.heroList[slot6] or "0"

			table.insert(slot1, slot7)

			if slot7 ~= "0" and slot7 ~= 0 then
				slot2 = slot2 + 1
			end
		end
	else
		slot4 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot3]

		for slot9 = 1, slot4 and slot4.playerMax or ModuleEnum.HeroCountInGroup do
			slot10 = slot0.heroList[slot9] or "0"
			slot1[slot9] = slot10

			if slot10 ~= "0" and slot10 ~= 0 then
				slot2 = slot2 + 1
			end
		end
	end

	return slot1, slot2
end

function slot0.getSubList(slot0)
	slot1 = {}
	slot2 = 0

	if slot0._playerMax then
		for slot6 = 1, slot0._roleNum do
			if slot0._playerMax < slot6 then
				slot7 = slot0.heroList[slot6] or "0"

				table.insert(slot1, slot7)

				if slot7 ~= "0" and slot7 ~= 0 then
					slot2 = slot2 + 1
				end
			end
		end
	else
		slot4 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot3]

		for slot9 = (slot4 and slot4.playerMax or ModuleEnum.HeroCountInGroup) + 1, ModuleEnum.MaxHeroCountInGroup do
			slot10 = slot0.heroList[slot9] or "0"

			table.insert(slot1, slot10)

			if slot10 ~= "0" and slot10 ~= 0 then
				slot2 = slot2 + 1
			end
		end
	end

	return slot1, slot2
end

function slot0.isAidHero(slot0, slot1)
	slot1 = tonumber(slot1) or 0

	return slot1 < 0 and slot1 >= -ModuleEnum.MaxHeroCountInGroup
end

function slot0.clearAidHero(slot0)
	if slot0.heroList then
		for slot4, slot5 in ipairs(slot0.heroList) do
			if slot0:isAidHero(slot5) and (not slot0.aidDict or not slot0.aidDict[slot4]) then
				slot0.heroList[slot4] = tostring(0)
			end
		end
	end
end

function slot0.setSeasonCardLimit(slot0, slot1, slot2)
	slot0._seasonCardNormalNum = slot2
	slot0._seasonCardMainNum = slot1
end

function slot0.getSeasonCardLimit(slot0)
	return slot0._seasonCardMainNum, slot0._seasonCardNormalNum
end

function slot0.getAssistBossId(slot0)
	return slot0.assistBossId
end

function slot0.setAssistBossId(slot0, slot1)
	slot0.assistBossId = slot1
end

function slot0.replaceTowerHeroList(slot0, slot1)
	slot2 = {
		[slot1[slot9]] = slot9
	}

	for slot9 = 1, slot1 and #slot1 or 0 do
		if slot1[slot9] ~= tostring(0) then
			table.insert({}, slot1[slot9])
		end
	end

	if not slot0.heroList then
		slot0.heroList = {}
	end

	slot6 = {}

	for slot10 = 1, ModuleEnum.MaxHeroCountInGroup do
		if slot2[slot0.heroList[slot10] or slot4] then
			tabletool.removeValue(slot3, slot11)
		else
			slot0.heroList[slot10] = slot4
			slot6[slot10] = 1
		end
	end

	slot7 = {}

	for slot11, slot12 in pairs(slot6) do
		table.insert(slot7, slot11)
	end

	if #slot7 > 1 then
		table.sort(slot7)
	end

	for slot11, slot12 in ipairs(slot3) do
		slot0.heroList[slot7[slot11]] = slot12
	end
end

function slot0.checkAct183HeroList(slot0, slot1, slot2)
	if slot2 then
		for slot6, slot7 in ipairs(slot0.heroList) do
			if slot7 ~= "0" and HeroModel.instance:getById(slot7) and slot2:isHeroRepress(slot8.heroId) then
				slot0.heroList[slot6] = "0"
			end
		end
	end

	if slot1 > (slot0.heroList and #slot0.heroList or 0) then
		for slot7 = slot3 + 1, slot1 do
			table.insert(slot0.heroList, "0")
		end
	elseif slot1 < slot3 then
		logError("角色数量超过上限")
	end
end

return slot0
