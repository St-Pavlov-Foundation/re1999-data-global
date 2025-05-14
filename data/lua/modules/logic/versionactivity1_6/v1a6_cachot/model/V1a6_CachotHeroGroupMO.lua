module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupMO", package.seeall)

local var_0_0 = pureTable("V1a6_CachotHeroGroupMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.groupId = nil
	arg_1_0.name = nil
	arg_1_0.heroList = {}
	arg_1_0.aidDict = nil
	arg_1_0.trialDict = nil
	arg_1_0.clothId = nil
	arg_1_0.temp = false
	arg_1_0.isReplay = false
	arg_1_0.equips = {}
	arg_1_0.activity104Equips = {}
	arg_1_0.exInfos = {}
	arg_1_0._maxHeroCount = V1a6_CachotEnum.MaxHeroCountInGroup
end

function var_0_0.setMaxHeroCount(arg_2_0, arg_2_1)
	arg_2_0._maxHeroCount = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.groupId
	arg_3_0.groupId = arg_3_1.groupId
	arg_3_0.name = arg_3_1.name
	arg_3_0.clothId = arg_3_1.clothId
	arg_3_0.heroList = {}

	local var_3_0 = arg_3_1.heroList and #arg_3_1.heroList or 0

	for iter_3_0 = 1, var_3_0 do
		table.insert(arg_3_0.heroList, arg_3_1.heroList[iter_3_0])
	end

	for iter_3_1 = var_3_0 + 1, arg_3_0._maxHeroCount do
		table.insert(arg_3_0.heroList, "0")
	end

	if arg_3_1.equips then
		if arg_3_1.equips[0] then
			arg_3_0:updatePosEquips(arg_3_1.equips[0])
		end

		for iter_3_2, iter_3_3 in ipairs(arg_3_1.equips) do
			arg_3_0:updatePosEquips(iter_3_3)
		end
	end

	if arg_3_1.activity104Equips then
		if arg_3_1.activity104Equips[0] then
			arg_3_0:updateActivity104PosEquips(arg_3_1.activity104Equips[0])
		end

		for iter_3_4, iter_3_5 in ipairs(arg_3_1.activity104Equips) do
			arg_3_0:updateActivity104PosEquips(iter_3_5)
		end
	end
end

function var_0_0.initByFightGroup(arg_4_0, arg_4_1)
	arg_4_0.id = 1
	arg_4_0.groupId = 1
	arg_4_0.clothId = arg_4_1.clothId
	arg_4_0.heroList = {}
	arg_4_0.replay_hero_data = {}

	local var_4_0 = {}

	arg_4_0.replay_equip_data = {}
	arg_4_0.trialDict = {}
	arg_4_0.exInfos = {}

	local var_4_1 = HeroGroupModel.instance.battleId
	local var_4_2 = var_4_1 and lua_battle.configDict[var_4_1]
	local var_4_3 = var_4_2 and var_4_2.playerMax or V1a6_CachotEnum.HeroCountInGroup

	if arg_4_1.exInfos then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.exInfos) do
			arg_4_0.exInfos[iter_4_0] = iter_4_1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.trialHeroList) do
		local var_4_4 = lua_hero_trial.configDict[iter_4_3.trialId][0]
		local var_4_5 = iter_4_3.pos

		if var_4_5 < 0 then
			var_4_5 = var_4_3 - var_4_5
		end

		local var_4_6 = tostring(var_4_4.heroId - 1099511627776)

		var_4_0[var_4_6] = var_4_5
		arg_4_0.heroList[var_4_5] = var_4_6

		local var_4_7 = {
			heroUid = var_4_6,
			heroId = var_4_4.heroId,
			level = var_4_4.level,
			skin = var_4_4.skin
		}

		if var_4_7.skin == 0 then
			var_4_7.skin = lua_character.configDict[var_4_4.heroId].skinId
		end

		arg_4_0.replay_hero_data[var_4_6] = var_4_7

		local var_4_8 = var_4_5 - 1

		arg_4_0.equips[var_4_8] = HeroGroupEquipMO.New()

		arg_4_0.equips[var_4_8]:init({
			index = var_4_8,
			equipUid = {
				iter_4_3.equipRecords[1].equipUid
			}
		})

		local var_4_9 = {
			equipUid = iter_4_3.equipRecords[1].equipUid,
			equipId = iter_4_3.equipRecords[1].equipId,
			equipLv = iter_4_3.equipRecords[1].equipLv,
			refineLv = iter_4_3.equipRecords[1].refineLv
		}

		arg_4_0.replay_equip_data[var_4_6] = var_4_9
		arg_4_0.trialDict[var_4_5] = {
			iter_4_3.trialId,
			0,
			var_4_5
		}
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.heroList) do
		local var_4_10 = iter_4_5.heroUid
		local var_4_11 = 1

		while arg_4_0.heroList[var_4_11] do
			var_4_11 = var_4_11 + 1
		end

		arg_4_0.heroList[var_4_11] = var_4_10
		var_4_0[var_4_10] = var_4_11

		local var_4_12 = {
			heroUid = var_4_10,
			heroId = iter_4_5.heroId,
			level = iter_4_5.level,
			skin = iter_4_5.skin
		}

		arg_4_0.replay_hero_data[var_4_10] = var_4_12
	end

	for iter_4_6, iter_4_7 in ipairs(arg_4_1.subHeroList) do
		local var_4_13 = iter_4_7.heroUid
		local var_4_14 = 1

		while arg_4_0.heroList[var_4_14] do
			var_4_14 = var_4_14 + 1
		end

		arg_4_0.heroList[var_4_14] = var_4_13
		var_4_0[var_4_13] = var_4_14

		local var_4_15 = {
			heroUid = var_4_13,
			heroId = iter_4_7.heroId,
			level = iter_4_7.level,
			skin = iter_4_7.skin
		}

		arg_4_0.replay_hero_data[var_4_13] = var_4_15
	end

	arg_4_0.replay_equip_data = {}

	for iter_4_8, iter_4_9 in ipairs(arg_4_1.equips) do
		local var_4_16 = var_4_0[iter_4_9.heroUid] - 1

		arg_4_0.equips[var_4_16] = HeroGroupEquipMO.New()

		local var_4_17 = iter_4_9.equipRecords[1]

		if var_4_17 then
			arg_4_0.equips[var_4_16]:init({
				index = var_4_16,
				equipUid = {
					var_4_17.equipUid
				}
			})

			local var_4_18 = {
				equipUid = var_4_17.equipUid,
				equipId = var_4_17.equipId,
				equipLv = var_4_17.equipLv,
				refineLv = var_4_17.refineLv
			}

			arg_4_0.replay_equip_data[iter_4_9.heroUid] = var_4_18
		end
	end

	arg_4_0.replay_activity104Equip_data = {}

	for iter_4_10, iter_4_11 in ipairs(arg_4_1.activity104Equips) do
		local var_4_19 = iter_4_11.heroUid == "-100000" and 4 or var_4_0[iter_4_11.heroUid] - 1

		arg_4_0.activity104Equips[var_4_19] = HeroGroupActivity104EquipMo.New()

		if iter_4_11.activity104EquipRecords[1] then
			local var_4_20 = {}

			for iter_4_12, iter_4_13 in ipairs(iter_4_11.activity104EquipRecords) do
				table.insert(var_4_20, iter_4_13.equipUid)
			end

			arg_4_0.activity104Equips[var_4_19]:init({
				index = var_4_19,
				equipUid = var_4_20
			})

			local var_4_21 = {}

			for iter_4_14, iter_4_15 in ipairs(iter_4_11.activity104EquipRecords) do
				local var_4_22 = {
					equipUid = iter_4_15.equipUid,
					equipId = iter_4_15.equipId
				}

				table.insert(var_4_21, var_4_22)
			end

			arg_4_0.replay_activity104Equip_data[iter_4_11.heroUid] = var_4_21
		else
			arg_4_0.activity104Equips[var_4_19]:init({
				index = var_4_19,
				equipUid = {}
			})
		end
	end

	arg_4_0.isReplay = true
end

function var_0_0.initByLocalData(arg_5_0, arg_5_1)
	arg_5_0.id = 1
	arg_5_0.groupId = 1
	arg_5_0.name = ""
	arg_5_0.heroList = {}
	arg_5_0.aidDict = nil
	arg_5_0.trialDict = {}
	arg_5_0.clothId = arg_5_1.clothId
	arg_5_0.temp = true
	arg_5_0.isReplay = false
	arg_5_0.equips = {}
	arg_5_0.activity104Equips = {}

	local var_5_0 = HeroGroupModel.instance.battleId
	local var_5_1 = var_5_0 and lua_battle.configDict[var_5_0]
	local var_5_2 = {}

	if not string.nilorempty(var_5_1.trialHeros) then
		var_5_2 = GameUtil.splitString2(var_5_1.trialHeros, true)
	end

	for iter_5_0 = 1, arg_5_0._maxHeroCount do
		arg_5_0.heroList[iter_5_0] = arg_5_1.heroList[iter_5_0] or "0"
		arg_5_0.equips[iter_5_0 - 1] = HeroGroupEquipMO.New()

		arg_5_0.equips[iter_5_0 - 1]:init({
			index = iter_5_0 - 1,
			equipUid = {
				arg_5_1.equips[iter_5_0] or "0"
			}
		})
		arg_5_0:updateActivity104PosEquips({
			index = iter_5_0 - 1,
			equipUid = arg_5_1.activity104Equips and arg_5_1.activity104Equips[iter_5_0] or {}
		})

		if tonumber(arg_5_0.heroList[iter_5_0]) < 0 then
			for iter_5_1, iter_5_2 in pairs(var_5_2) do
				if lua_hero_trial.configDict[iter_5_2[1]][iter_5_2[2] or 0].heroId - 1099511627776 == tonumber(arg_5_0.heroList[iter_5_0]) then
					arg_5_0.trialDict[iter_5_0] = iter_5_2

					break
				end
			end
		end
	end

	local var_5_3 = arg_5_0._maxHeroCount + 1

	arg_5_0:updateActivity104PosEquips({
		index = var_5_3 - 1,
		equipUid = arg_5_1.activity104Equips and arg_5_1.activity104Equips[var_5_3] or {}
	})

	if Activity104Model.instance:isSeasonChapter() and arg_5_1.battleId ~= var_5_0 then
		for iter_5_3, iter_5_4 in ipairs(arg_5_0.heroList) do
			if tonumber(iter_5_4) < 0 then
				arg_5_0.heroList[iter_5_3] = tostring(0)
				arg_5_0.trialDict[iter_5_3] = nil
			end
		end
	end
end

function var_0_0.setTrials(arg_6_0, arg_6_1)
	local var_6_0 = HeroGroupModel.instance.battleId
	local var_6_1 = var_6_0 and lua_battle.configDict[var_6_0]
	local var_6_2 = {}

	if not string.nilorempty(var_6_1.trialHeros) then
		var_6_2 = GameUtil.splitString2(var_6_1.trialHeros, true)
	end

	for iter_6_0, iter_6_1 in pairs(var_6_2) do
		if iter_6_1[3] then
			arg_6_0.trialDict[iter_6_1[3]] = iter_6_1

			local var_6_3 = lua_hero_trial.configDict[iter_6_1[1]][iter_6_1[2] or 0]

			arg_6_0.heroList[iter_6_1[3]] = tostring(var_6_3.heroId - 1099511627776)

			if not arg_6_1 and (var_6_3.act104EquipId1 > 0 or var_6_3.act104EquipId2 > 0) then
				arg_6_0:updateActivity104PosEquips({
					index = iter_6_1[3] - 1
				})
			end
		end
	end

	if not arg_6_1 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not string.nilorempty(var_6_1.trialEquips) then
		local var_6_4 = string.splitToNumber(var_6_1.trialEquips, "|")

		for iter_6_2 = 1, math.min(#var_6_4, arg_6_0._maxHeroCount) do
			arg_6_0:updatePosEquips({
				index = iter_6_2 - 1,
				equipUid = {
					tostring(-var_6_4[iter_6_2])
				}
			})
		end
	end

	if not arg_6_1 and var_6_1.trialMainAct104EuqipId > 0 then
		arg_6_0:updateActivity104PosEquips({
			index = arg_6_0._maxHeroCount,
			equipUid = {
				-var_6_1.trialMainAct104EuqipId
			}
		})
	end
end

function var_0_0.saveData(arg_7_0)
	local var_7_0 = HeroGroupModel.instance.battleId
	local var_7_1 = {
		clothId = arg_7_0.clothId,
		heroList = {},
		equips = {},
		activity104Equips = {}
	}

	for iter_7_0 = 1, arg_7_0._maxHeroCount do
		var_7_1.heroList[iter_7_0] = arg_7_0.heroList[iter_7_0]
		var_7_1.equips[iter_7_0] = arg_7_0.equips[iter_7_0 - 1] and arg_7_0.equips[iter_7_0 - 1].equipUid[1]
		var_7_1.activity104Equips[iter_7_0] = arg_7_0.activity104Equips[iter_7_0 - 1] and arg_7_0.activity104Equips[iter_7_0 - 1].equipUid
	end

	local var_7_2 = arg_7_0._maxHeroCount + 1

	var_7_1.activity104Equips[var_7_2] = arg_7_0.activity104Equips[var_7_2 - 1] and arg_7_0.activity104Equips[var_7_2 - 1].equipUid
	var_7_1.battleId = var_7_0

	local var_7_3

	if Activity104Model.instance:isSeasonChapter() then
		var_7_3 = PlayerPrefsKey.SeasonHeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId())
	else
		var_7_3 = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_7_0
	end

	PlayerPrefsHelper.setString(var_7_3, cjson.encode(var_7_1))
end

function var_0_0.setTempName(arg_8_0, arg_8_1)
	arg_8_0.name = arg_8_1
end

function var_0_0.setTemp(arg_9_0, arg_9_1)
	arg_9_0.temp = arg_9_1
end

function var_0_0.replaceHeroList(arg_10_0, arg_10_1)
	arg_10_0.heroList = {}
	arg_10_0.aidDict = {}
	arg_10_0.trialDict = {}

	local var_10_0 = arg_10_1 and #arg_10_1 or 0

	for iter_10_0 = 1, var_10_0 do
		table.insert(arg_10_0.heroList, arg_10_1[iter_10_0].heroUid)

		if arg_10_1[iter_10_0].aid then
			arg_10_0.aidDict[iter_10_0] = arg_10_1[iter_10_0].aid
		end
	end

	arg_10_0:_dropAidEquip()
end

function var_0_0._dropAidEquip(arg_11_0)
	if arg_11_0.aidDict then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.aidDict) do
			if iter_11_1 > 0 then
				arg_11_0:_setPosEquips(iter_11_0 - 1, nil)
				arg_11_0:updateActivity104PosEquips({
					index = iter_11_0 - 1
				})
			end
		end
	end

	if arg_11_0.trialDict then
		for iter_11_2, iter_11_3 in pairs(arg_11_0.trialDict) do
			arg_11_0:_setPosEquips(iter_11_2 - 1, nil)
			arg_11_0:updateActivity104PosEquips({
				index = iter_11_2 - 1
			})
		end
	end
end

function var_0_0.replaceClothId(arg_12_0, arg_12_1)
	arg_12_0.clothId = arg_12_1
end

function var_0_0.getHeroByIndex(arg_13_0, arg_13_1)
	return arg_13_0.heroList[arg_13_1]
end

function var_0_0.getAllPosEquips(arg_14_0)
	return arg_14_0.equips
end

function var_0_0.getPosEquips(arg_15_0, arg_15_1)
	if not arg_15_0.equips[arg_15_1] then
		arg_15_0:updatePosEquips({
			index = arg_15_1
		})
	end

	return arg_15_0.equips[arg_15_1]
end

function var_0_0._setPosEquips(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == nil then
		arg_16_2 = HeroGroupEquipMO.New()

		arg_16_2:init({
			index = arg_16_1
		})
	end

	arg_16_0.equips[arg_16_1] = arg_16_2
end

function var_0_0.updatePosEquips(arg_17_0, arg_17_1)
	for iter_17_0 = 0, arg_17_0._maxHeroCount - 1 do
		local var_17_0 = arg_17_0.equips[iter_17_0]

		if var_17_0 and var_17_0.equipUid and #var_17_0.equipUid > 0 and arg_17_1.equipUid and #arg_17_1.equipUid > 0 then
			for iter_17_1 = 1, 1 do
				if var_17_0.equipUid[iter_17_1] == arg_17_1.equipUid[iter_17_1] then
					var_17_0.equipUid[iter_17_1] = "0"
				end
			end
		end
	end

	local var_17_1 = HeroGroupEquipMO.New()

	var_17_1:init(arg_17_1)

	arg_17_0.equips[arg_17_1.index] = var_17_1
end

function var_0_0.getAct104PosEquips(arg_18_0, arg_18_1)
	if not arg_18_0.activity104Equips[arg_18_1] then
		arg_18_0:updateActivity104PosEquips({
			index = arg_18_1
		})
	end

	return arg_18_0.activity104Equips[arg_18_1]
end

function var_0_0.updateActivity104PosEquips(arg_19_0, arg_19_1)
	local var_19_0 = HeroGroupActivity104EquipMo.New()

	var_19_0:init(arg_19_1)

	arg_19_0.activity104Equips[arg_19_1.index] = var_19_0
end

function var_0_0.getAllHeroEquips(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = FightModel.instance:getFightParam()
	local var_20_2 = {}

	if var_20_1 and var_20_1.battleId > 0 then
		local var_20_3 = lua_battle.configDict[var_20_1.battleId]

		if not string.nilorempty(var_20_3.trialEquips) then
			var_20_2 = string.splitToNumber(var_20_3.trialEquips, "|")
		end
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.equips) do
		local var_20_4 = iter_20_0 + 1
		local var_20_5

		var_20_5.heroUid, var_20_5 = arg_20_0.heroList[var_20_4] or "0", FightEquipMO.New()

		for iter_20_2, iter_20_3 in ipairs(iter_20_1.equipUid) do
			if tonumber(iter_20_3) > 0 then
				local var_20_6 = EquipModel.instance:getEquip(iter_20_3)

				iter_20_1.equipUid[iter_20_2] = var_20_6 and iter_20_3 or "0"
			else
				local var_20_7 = -tonumber(iter_20_3)

				if lua_equip_trial.configDict[var_20_7] and tabletool.indexOf(var_20_2, var_20_7) then
					iter_20_1.equipUid[iter_20_2] = iter_20_3
				else
					iter_20_1.equipUid[iter_20_2] = "0"
				end
			end
		end

		var_20_5.equipUid = iter_20_1.equipUid

		table.insert(var_20_0, var_20_5)
	end

	return var_20_0
end

function var_0_0.getAllHeroActivity104Equips(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.activity104Equips) do
		local var_21_1 = iter_21_0 + 1
		local var_21_2 = FightEquipMO.New()

		if var_21_1 == 5 then
			var_21_2.heroUid = "-100000"
		else
			var_21_2.heroUid = arg_21_0.heroList[var_21_1] or "0"
		end

		for iter_21_2, iter_21_3 in ipairs(iter_21_1.equipUid) do
			if tonumber(iter_21_3) > 0 then
				local var_21_3 = Activity104Model.instance:getItemIdByUid(iter_21_3)

				iter_21_1.equipUid[iter_21_2] = var_21_3 and var_21_3 > 0 and iter_21_3 or "0"
			end
		end

		var_21_2.equipUid = iter_21_1.equipUid

		table.insert(var_21_0, var_21_2)
	end

	return var_21_0
end

function var_0_0.getEquipUidList(arg_22_0)
	local var_22_0 = {}

	for iter_22_0 = 1, arg_22_0._maxHeroCount do
		local var_22_1 = arg_22_0.equips[iter_22_0 - 1]

		if var_22_1 then
			var_22_0[iter_22_0] = var_22_1.equipUid and var_22_1.equipUid[1] or 0
		else
			var_22_0[iter_22_0] = 0
		end
	end

	return var_22_0
end

function var_0_0.initWithBattle(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	arg_23_4 = math.min(arg_23_4, arg_23_3)

	arg_23_0:init(arg_23_1)

	arg_23_0.battleHeroGroup = true
	arg_23_0.aidDict = {}
	arg_23_0.trialDict = {}

	if not arg_23_5 then
		arg_23_0._roleNum = arg_23_3
		arg_23_0._playerMax = arg_23_4
	end

	local var_23_0 = arg_23_0._maxHeroCount
	local var_23_1 = {}
	local var_23_2 = {}

	arg_23_6 = arg_23_6 or {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_6) do
		if iter_23_1[3] then
			local var_23_3 = iter_23_1[3]

			if var_23_3 < 0 then
				var_23_3 = arg_23_0._playerMax - var_23_3
			end

			if arg_23_0.heroList[var_23_3] then
				local var_23_4 = lua_hero_trial.configDict[iter_23_1[1]][iter_23_1[2] or 0]

				if tonumber(arg_23_0.heroList[var_23_3]) > 0 then
					table.insert(var_23_1, arg_23_0.heroList[var_23_3])
					table.insert(var_23_2, arg_23_0:getPosEquips(var_23_3 - 1))
				end

				arg_23_0.heroList[var_23_3] = tostring(var_23_4.heroId - 1099511627776)
				arg_23_0.trialDict[var_23_3] = iter_23_1
			end
		end
	end

	for iter_23_2 = 1, var_23_0 do
		for iter_23_3 = 1, #arg_23_2 do
			local var_23_5 = lua_monster.configDict[tonumber(arg_23_2[iter_23_3])]
			local var_23_6 = lua_skin.configDict[var_23_5 and var_23_5.skinId]
			local var_23_7 = var_23_6 and var_23_6.characterId

			if var_23_7 then
				local var_23_8 = arg_23_0.heroList[iter_23_2] and HeroModel.instance:getById(arg_23_0.heroList[iter_23_2])

				if var_23_8 and var_23_8.heroId == var_23_7 then
					if arg_23_4 < iter_23_2 or arg_23_3 < iter_23_2 or iter_23_2 > HeroGroupModel.instance:positionOpenCount() then
						arg_23_0.heroList[iter_23_2] = "0"

						break
					end

					arg_23_0.heroList[iter_23_2] = tostring(-iter_23_3)
					arg_23_0.aidDict[iter_23_2] = arg_23_2[iter_23_3]

					arg_23_0:updatePosEquips({
						index = iter_23_2 - 1
					})

					arg_23_2[iter_23_3] = nil

					break
				end
			end
		end
	end

	for iter_23_4 = var_23_0, 1, -1 do
		if arg_23_3 < iter_23_4 or iter_23_4 > HeroGroupModel.instance:positionOpenCount() and not arg_23_0.trialDict[iter_23_4] then
			if arg_23_0.heroList[iter_23_4] and tonumber(arg_23_0.heroList[iter_23_4]) > 0 then
				table.insert(var_23_1, arg_23_0.heroList[iter_23_4])
				table.insert(var_23_2, arg_23_0:getPosEquips(iter_23_4 - 1))
			end

			arg_23_0.heroList[iter_23_4] = "0"

			if iter_23_4 <= HeroGroupModel.instance:positionOpenCount() then
				arg_23_0.aidDict[iter_23_4] = -1
			end
		elseif arg_23_4 < iter_23_4 then
			-- block empty
		elseif not arg_23_0.heroList[iter_23_4] or tonumber(arg_23_0.heroList[iter_23_4]) >= 0 and not arg_23_0.trialDict[iter_23_4] then
			for iter_23_5 = 1, var_23_0 do
				if arg_23_2[iter_23_5] then
					if arg_23_0.heroList[iter_23_4] and tonumber(arg_23_0.heroList[iter_23_4]) > 0 then
						table.insert(var_23_1, arg_23_0.heroList[iter_23_4])
						table.insert(var_23_2, arg_23_0:getPosEquips(iter_23_4 - 1))
					end

					arg_23_0.heroList[iter_23_4] = tostring(-iter_23_5)
					arg_23_0.aidDict[iter_23_4] = arg_23_2[iter_23_5]

					arg_23_0:updatePosEquips({
						index = iter_23_4 - 1
					})

					arg_23_2[iter_23_5] = nil

					break
				end
			end
		end
	end

	for iter_23_6 = 1, var_23_0 do
		if #var_23_1 <= 0 then
			break
		end

		if iter_23_6 <= arg_23_3 and iter_23_6 <= HeroGroupModel.instance:positionOpenCount() and (not arg_23_0.heroList[iter_23_6] or arg_23_0.heroList[iter_23_6] == "0" or arg_23_0.heroList[iter_23_6] == 0) then
			arg_23_0.heroList[iter_23_6] = var_23_1[#var_23_1]

			arg_23_0:_setPosEquips(iter_23_6 - 1, var_23_2[#var_23_2])
			table.remove(var_23_1, #var_23_1)
			table.remove(var_23_2, #var_23_2)
		end
	end

	arg_23_0:_dropAidEquip()
end

function var_0_0._getHeroListBackup(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.heroList) do
		table.insert(var_24_0, iter_24_1)
	end

	return var_24_0
end

function var_0_0.getMainList(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = 0

	if arg_25_0._playerMax then
		for iter_25_0 = 1, arg_25_0._playerMax do
			local var_25_2 = arg_25_0.heroList[iter_25_0] or "0"

			table.insert(var_25_0, var_25_2)

			if var_25_2 ~= "0" and var_25_2 ~= 0 then
				var_25_1 = var_25_1 + 1
			end
		end
	else
		local var_25_3 = HeroGroupModel.instance.battleId
		local var_25_4 = var_25_3 and lua_battle.configDict[var_25_3]
		local var_25_5 = var_25_4 and var_25_4.playerMax or V1a6_CachotEnum.HeroCountInGroup

		for iter_25_1 = 1, var_25_5 do
			local var_25_6 = arg_25_0.heroList[iter_25_1] or "0"

			var_25_0[iter_25_1] = var_25_6

			if var_25_6 ~= "0" and var_25_6 ~= 0 then
				var_25_1 = var_25_1 + 1
			end
		end
	end

	return var_25_0, var_25_1
end

function var_0_0.getSubList(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = 0

	if arg_26_0._playerMax then
		for iter_26_0 = 1, arg_26_0._roleNum do
			if iter_26_0 > arg_26_0._playerMax then
				local var_26_2 = arg_26_0.heroList[iter_26_0] or "0"

				table.insert(var_26_0, var_26_2)

				if var_26_2 ~= "0" and var_26_2 ~= 0 then
					var_26_1 = var_26_1 + 1
				end
			end
		end
	else
		local var_26_3 = HeroGroupModel.instance.battleId
		local var_26_4 = var_26_3 and lua_battle.configDict[var_26_3]

		for iter_26_1 = (var_26_4 and var_26_4.playerMax or V1a6_CachotEnum.HeroCountInGroup) + 1, arg_26_0._maxHeroCount do
			local var_26_5 = arg_26_0.heroList[iter_26_1] or "0"

			table.insert(var_26_0, var_26_5)

			if var_26_5 ~= "0" and var_26_5 ~= 0 then
				var_26_1 = var_26_1 + 1
			end
		end
	end

	return var_26_0, var_26_1
end

function var_0_0.isAidHero(arg_27_0, arg_27_1)
	arg_27_1 = tonumber(arg_27_1) or 0

	local var_27_0 = arg_27_0._maxHeroCount

	return arg_27_1 < 0 and arg_27_1 >= -var_27_0
end

function var_0_0.clearAidHero(arg_28_0)
	if arg_28_0.heroList then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.heroList) do
			if arg_28_0:isAidHero(iter_28_1) then
				arg_28_0.heroList[iter_28_0] = tostring(0)
			end
		end
	end
end

return var_0_0
