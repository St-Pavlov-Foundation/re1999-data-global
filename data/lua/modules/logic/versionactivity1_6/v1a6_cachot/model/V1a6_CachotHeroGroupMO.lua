module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupMO", package.seeall)

slot0 = pureTable("V1a6_CachotHeroGroupMO")

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
	slot0._maxHeroCount = V1a6_CachotEnum.MaxHeroCountInGroup
end

function slot0.setMaxHeroCount(slot0, slot1)
	slot0._maxHeroCount = slot1
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.groupId
	slot0.groupId = slot1.groupId
	slot0.name = slot1.name
	slot0.clothId = slot1.clothId
	slot0.heroList = {}
	slot2 = slot1.heroList and #slot1.heroList or 0

	for slot6 = 1, slot2 do
		table.insert(slot0.heroList, slot1.heroList[slot6])
	end

	for slot6 = slot2 + 1, slot0._maxHeroCount do
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
	slot0.heroList = {}
	slot0.replay_hero_data = {}
	slot2 = {}
	slot0.replay_equip_data = {}
	slot0.trialDict = {}
	slot0.exInfos = {}
	slot4 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot3]
	slot5 = slot4 and slot4.playerMax or V1a6_CachotEnum.HeroCountInGroup

	if slot1.exInfos then
		for slot9, slot10 in ipairs(slot1.exInfos) do
			slot0.exInfos[slot9] = slot10
		end
	end

	for slot9, slot10 in ipairs(slot1.trialHeroList) do
		slot11 = lua_hero_trial.configDict[slot10.trialId][0]

		if slot10.pos < 0 then
			slot12 = slot5 - slot12
		end

		slot13 = tostring(slot11.heroId - 1099511627776.0)
		slot2[slot13] = slot12
		slot0.heroList[slot12] = slot13

		if ({
			heroUid = slot13,
			heroId = slot11.heroId,
			level = slot11.level,
			skin = slot11.skin
		}).skin == 0 then
			slot14.skin = lua_character.configDict[slot11.heroId].skinId
		end

		slot0.replay_hero_data[slot13] = slot14
		slot15 = slot12 - 1
		slot0.equips[slot15] = HeroGroupEquipMO.New()

		slot0.equips[slot15]:init({
			index = slot15,
			equipUid = {
				slot10.equipRecords[1].equipUid
			}
		})

		slot0.replay_equip_data[slot13] = {
			equipUid = slot10.equipRecords[1].equipUid,
			equipId = slot10.equipRecords[1].equipId,
			equipLv = slot10.equipRecords[1].equipLv,
			refineLv = slot10.equipRecords[1].refineLv
		}
		slot0.trialDict[slot12] = {
			slot10.trialId,
			0,
			slot12
		}
	end

	for slot9, slot10 in ipairs(slot1.heroList) do
		slot11 = slot10.heroUid
		slot12 = 1

		while slot0.heroList[slot12] do
			slot12 = slot12 + 1
		end

		slot0.heroList[slot12] = slot11
		slot2[slot11] = slot12
		slot0.replay_hero_data[slot11] = {
			heroUid = slot11,
			heroId = slot10.heroId,
			level = slot10.level,
			skin = slot10.skin
		}
	end

	for slot9, slot10 in ipairs(slot1.subHeroList) do
		slot11 = slot10.heroUid
		slot12 = 1

		while slot0.heroList[slot12] do
			slot12 = slot12 + 1
		end

		slot0.heroList[slot12] = slot11
		slot2[slot11] = slot12
		slot0.replay_hero_data[slot11] = {
			heroUid = slot11,
			heroId = slot10.heroId,
			level = slot10.level,
			skin = slot10.skin
		}
	end

	slot0.replay_equip_data = {}

	for slot9, slot10 in ipairs(slot1.equips) do
		slot0.equips[slot2[slot10.heroUid] - 1] = HeroGroupEquipMO.New()

		if slot10.equipRecords[1] then
			slot0.equips[slot11]:init({
				index = slot11,
				equipUid = {
					slot12.equipUid
				}
			})

			slot0.replay_equip_data[slot10.heroUid] = {
				equipUid = slot12.equipUid,
				equipId = slot12.equipId,
				equipLv = slot12.equipLv,
				refineLv = slot12.refineLv
			}
		end
	end

	slot0.replay_activity104Equip_data = {}

	for slot9, slot10 in ipairs(slot1.activity104Equips) do
		slot0.activity104Equips[slot10.heroUid == "-100000" and 4 or slot2[slot10.heroUid] - 1] = HeroGroupActivity104EquipMo.New()

		if slot10.activity104EquipRecords[1] then
			slot13 = {}

			for slot17, slot18 in ipairs(slot10.activity104EquipRecords) do
				table.insert(slot13, slot18.equipUid)
			end

			slot0.activity104Equips[slot11]:init({
				index = slot11,
				equipUid = slot13
			})

			slot14 = {}

			for slot18, slot19 in ipairs(slot10.activity104EquipRecords) do
				table.insert(slot14, {
					equipUid = slot19.equipUid,
					equipId = slot19.equipId
				})
			end

			slot0.replay_activity104Equip_data[slot10.heroUid] = slot14
		else
			slot0.activity104Equips[slot11]:init({
				index = slot11,
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
	slot0.temp = true
	slot0.isReplay = false
	slot0.equips = {}
	slot0.activity104Equips = {}
	slot4 = {}

	if not string.nilorempty((HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]).trialHeros) then
		slot4 = GameUtil.splitString2(slot3.trialHeros, true)
	end

	for slot8 = 1, slot0._maxHeroCount do
		slot0.heroList[slot8] = slot1.heroList[slot8] or "0"
		slot0.equips[slot8 - 1] = HeroGroupEquipMO.New()

		slot0.equips[slot8 - 1]:init({
			index = slot8 - 1,
			equipUid = {
				slot1.equips[slot8] or "0"
			}
		})
		slot0:updateActivity104PosEquips({
			index = slot8 - 1,
			equipUid = slot1.activity104Equips and slot1.activity104Equips[slot8] or {}
		})

		if tonumber(slot0.heroList[slot8]) < 0 then
			for slot12, slot13 in pairs(slot4) do
				if lua_hero_trial.configDict[slot13[1]][slot13[2] or 0].heroId - 1099511627776.0 == tonumber(slot0.heroList[slot8]) then
					slot0.trialDict[slot8] = slot13

					break
				end
			end
		end
	end

	slot0:updateActivity104PosEquips({
		index = slot0._maxHeroCount + 1 - 1,
		equipUid = slot1.activity104Equips and slot1.activity104Equips[slot5] or {}
	})

	if Activity104Model.instance:isSeasonChapter() and slot1.battleId ~= slot2 then
		for slot9, slot10 in ipairs(slot0.heroList) do
			if tonumber(slot10) < 0 then
				slot0.heroList[slot9] = tostring(0)
				slot0.trialDict[slot9] = nil
			end
		end
	end
end

function slot0.setTrials(slot0, slot1)
	slot4 = {}

	if not string.nilorempty((HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]).trialHeros) then
		slot4 = GameUtil.splitString2(slot3.trialHeros, true)
	end

	for slot8, slot9 in pairs(slot4) do
		if slot9[3] then
			slot0.trialDict[slot9[3]] = slot9
			slot0.heroList[slot9[3]] = tostring(lua_hero_trial.configDict[slot9[1]][slot9[2] or 0].heroId - 1099511627776.0)

			if not slot1 and (slot10.act104EquipId1 > 0 or slot10.act104EquipId2 > 0) then
				slot0:updateActivity104PosEquips({
					index = slot9[3] - 1
				})
			end
		end
	end

	if not slot1 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not string.nilorempty(slot3.trialEquips) then
		slot9 = #string.splitToNumber(slot3.trialEquips, "|")

		for slot9 = 1, math.min(slot9, slot0._maxHeroCount) do
			slot0:updatePosEquips({
				index = slot9 - 1,
				equipUid = {
					tostring(-slot5[slot9])
				}
			})
		end
	end

	if not slot1 and slot3.trialMainAct104EuqipId > 0 then
		slot0:updateActivity104PosEquips({
			index = slot0._maxHeroCount,
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
		activity104Equips = {}
	}

	for slot6 = 1, slot0._maxHeroCount do
		slot2.heroList[slot6] = slot0.heroList[slot6]
		slot2.equips[slot6] = slot0.equips[slot6 - 1] and slot0.equips[slot6 - 1].equipUid[1]
		slot2.activity104Equips[slot6] = slot0.activity104Equips[slot6 - 1] and slot0.activity104Equips[slot6 - 1].equipUid
	end

	slot2.activity104Equips[slot3] = slot0.activity104Equips[slot0._maxHeroCount + 1 - 1] and slot0.activity104Equips[slot3 - 1].equipUid
	slot2.battleId = slot1
	slot4 = nil

	PlayerPrefsHelper.setString(Activity104Model.instance:isSeasonChapter() and PlayerPrefsKey.SeasonHeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) or PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot1, cjson.encode(slot2))
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
	for slot5 = 0, slot0._maxHeroCount - 1 do
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

	slot2:init(slot1)

	slot0.activity104Equips[slot1.index] = slot2
end

function slot0.getAllHeroEquips(slot0)
	slot1 = {}
	slot3 = {}

	if FightModel.instance:getFightParam() and slot2.battleId > 0 and not string.nilorempty(lua_battle.configDict[slot2.battleId].trialEquips) then
		slot3 = string.splitToNumber(slot4.trialEquips, "|")
	end

	for slot7, slot8 in pairs(slot0.equips) do
		FightEquipMO.New().heroUid = slot0.heroList[slot7 + 1] or "0"

		for slot15, slot16 in ipairs(slot8.equipUid) do
			if tonumber(slot16) > 0 then
				slot8.equipUid[slot15] = EquipModel.instance:getEquip(slot16) and slot16 or "0"
			elseif lua_equip_trial.configDict[-tonumber(slot16)] and tabletool.indexOf(slot3, slot17) then
				slot8.equipUid[slot15] = slot16
			else
				slot8.equipUid[slot15] = "0"
			end
		end

		slot11.equipUid = slot8.equipUid

		table.insert(slot1, slot11)
	end

	return slot1
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
	for slot5 = 1, slot0._maxHeroCount do
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

	slot7 = slot0._maxHeroCount
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in ipairs(slot6 or {}) do
		if slot14[3] then
			if slot14[3] < 0 then
				slot15 = slot0._playerMax - slot15
			end

			if slot0.heroList[slot15] then
				slot16 = lua_hero_trial.configDict[slot14[1]][slot14[2] or 0]

				if tonumber(slot0.heroList[slot15]) > 0 then
					table.insert(slot8, slot0.heroList[slot15])
					table.insert(slot9, slot0:getPosEquips(slot15 - 1))
				end

				slot0.heroList[slot15] = tostring(slot16.heroId - 1099511627776.0)
				slot0.trialDict[slot15] = slot14
			end
		end
	end

	for slot13 = 1, slot7 do
		for slot17 = 1, #slot2 do
			if lua_skin.configDict[lua_monster.configDict[tonumber(slot2[slot17])] and slot18.skinId] and slot19.characterId and slot0.heroList[slot13] and HeroModel.instance:getById(slot0.heroList[slot13]) and slot21.heroId == slot20 then
				if slot4 < slot13 or slot3 < slot13 or HeroGroupModel.instance:positionOpenCount() < slot13 then
					slot0.heroList[slot13] = "0"

					break
				end

				slot0.heroList[slot13] = tostring(-slot17)
				slot0.aidDict[slot13] = slot2[slot17]

				slot0:updatePosEquips({
					index = slot13 - 1
				})

				slot2[slot17] = nil

				break
			end
		end
	end

	for slot13 = slot7, 1, -1 do
		if slot3 < slot13 or HeroGroupModel.instance:positionOpenCount() < slot13 and not slot0.trialDict[slot13] then
			if slot0.heroList[slot13] and tonumber(slot0.heroList[slot13]) > 0 then
				table.insert(slot8, slot0.heroList[slot13])
				table.insert(slot9, slot0:getPosEquips(slot13 - 1))
			end

			slot0.heroList[slot13] = "0"

			if slot13 <= HeroGroupModel.instance:positionOpenCount() then
				slot0.aidDict[slot13] = -1
			end
		elseif slot4 < slot13 then
			-- Nothing
		elseif not slot0.heroList[slot13] or tonumber(slot0.heroList[slot13]) >= 0 and not slot0.trialDict[slot13] then
			for slot17 = 1, slot7 do
				if slot2[slot17] then
					if slot0.heroList[slot13] and tonumber(slot0.heroList[slot13]) > 0 then
						table.insert(slot8, slot0.heroList[slot13])
						table.insert(slot9, slot0:getPosEquips(slot13 - 1))
					end

					slot0.heroList[slot13] = tostring(-slot17)
					slot0.aidDict[slot13] = slot2[slot17]

					slot0:updatePosEquips({
						index = slot13 - 1
					})

					slot2[slot17] = nil

					break
				end
			end
		end
	end

	for slot13 = 1, slot7 do
		if #slot8 <= 0 then
			break
		end

		if slot13 <= slot3 and slot13 <= HeroGroupModel.instance:positionOpenCount() and (not slot0.heroList[slot13] or slot0.heroList[slot13] == "0" or slot0.heroList[slot13] == 0) then
			slot0.heroList[slot13] = slot8[#slot8]

			slot0:_setPosEquips(slot13 - 1, slot9[#slot9])
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

		for slot9 = 1, slot4 and slot4.playerMax or V1a6_CachotEnum.HeroCountInGroup do
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

		for slot9 = (slot4 and slot4.playerMax or V1a6_CachotEnum.HeroCountInGroup) + 1, slot0._maxHeroCount do
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

	return slot1 < 0 and slot1 >= -slot0._maxHeroCount
end

function slot0.clearAidHero(slot0)
	if slot0.heroList then
		for slot4, slot5 in ipairs(slot0.heroList) do
			if slot0:isAidHero(slot5) then
				slot0.heroList[slot4] = tostring(0)
			end
		end
	end
end

return slot0
