﻿module("modules.logic.herogroup.model.HeroGroupMO", package.seeall)

local var_0_0 = pureTable("HeroGroupMO")

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
	arg_1_0.assistBossId = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.groupId
	arg_2_0.groupId = arg_2_1.groupId
	arg_2_0.name = arg_2_1.name
	arg_2_0.clothId = arg_2_1.clothId
	arg_2_0.assistBossId = arg_2_1.assistBossId
	arg_2_0.heroList = {}
	arg_2_0.trialDict = {}

	local var_2_0 = arg_2_1.heroList and #arg_2_1.heroList or 0

	for iter_2_0 = 1, var_2_0 do
		table.insert(arg_2_0.heroList, arg_2_1.heroList[iter_2_0])
	end

	for iter_2_1 = var_2_0 + 1, ModuleEnum.MaxHeroCountInGroup do
		table.insert(arg_2_0.heroList, "0")
	end

	if arg_2_1.equips then
		if arg_2_1.equips[0] then
			arg_2_0:updatePosEquips(arg_2_1.equips[0])
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_1.equips) do
			arg_2_0:updatePosEquips(iter_2_3)
		end
	end

	if arg_2_1.activity104Equips then
		if arg_2_1.activity104Equips[0] then
			arg_2_0:updateActivity104PosEquips(arg_2_1.activity104Equips[0])
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_1.activity104Equips) do
			arg_2_0:updateActivity104PosEquips(iter_2_5)
		end
	end
end

function var_0_0.initByFightGroup(arg_3_0, arg_3_1)
	arg_3_0.id = 1
	arg_3_0.groupId = 1
	arg_3_0.clothId = arg_3_1.clothId
	arg_3_0.recordRound = arg_3_1.recordRound
	arg_3_0.heroList = {}
	arg_3_0.replay_hero_data = {}

	local var_3_0 = {}

	arg_3_0.replay_equip_data = {}
	arg_3_0.trialDict = {}
	arg_3_0.aidDict = {}
	arg_3_0.exInfos = {}
	arg_3_0.replayAssistHeroUid = arg_3_1.assistHeroUid
	arg_3_0.replayAssistUserId = arg_3_1.assistUserId
	arg_3_0.assistBossId = arg_3_1.assistBossId

	local var_3_1 = HeroGroupModel.instance.battleId
	local var_3_2 = var_3_1 and lua_battle.configDict[var_3_1]
	local var_3_3 = var_3_2 and var_3_2.playerMax or ModuleEnum.HeroCountInGroup
	local var_3_4 = string.splitToNumber(var_3_2.aid, "#") or {}

	if arg_3_1.exInfos then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.exInfos) do
			arg_3_0.exInfos[iter_3_0] = iter_3_1
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.trialHeroList) do
		local var_3_5 = lua_hero_trial.configDict[iter_3_3.trialId][0]
		local var_3_6 = iter_3_3.pos

		if var_3_6 < 0 then
			var_3_6 = var_3_3 - var_3_6
		end

		local var_3_7 = tostring(tonumber(var_3_5.id .. "." .. var_3_5.trialTemplate) - 1099511627776)

		var_3_0[var_3_7] = var_3_6
		arg_3_0.heroList[var_3_6] = var_3_7

		local var_3_8 = {
			heroUid = var_3_7,
			heroId = var_3_5.heroId,
			level = var_3_5.level,
			skin = var_3_5.skin
		}

		if var_3_8.skin == 0 then
			var_3_8.skin = lua_character.configDict[var_3_5.heroId].skinId
		end

		arg_3_0.replay_hero_data[var_3_7] = var_3_8

		local var_3_9 = var_3_6 - 1

		arg_3_0.equips[var_3_9] = HeroGroupEquipMO.New()

		arg_3_0.equips[var_3_9]:init({
			index = var_3_9,
			equipUid = {
				iter_3_3.equipRecords[1].equipUid
			}
		})

		local var_3_10 = {
			equipUid = iter_3_3.equipRecords[1].equipUid,
			equipId = iter_3_3.equipRecords[1].equipId,
			equipLv = iter_3_3.equipRecords[1].equipLv,
			refineLv = iter_3_3.equipRecords[1].refineLv
		}

		arg_3_0.replay_equip_data[var_3_7] = var_3_10
		arg_3_0.trialDict[var_3_6] = {
			iter_3_3.trialId,
			0,
			var_3_6
		}
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.heroList) do
		local var_3_11 = iter_3_5.heroUid
		local var_3_12 = 1

		while arg_3_0.heroList[var_3_12] do
			var_3_12 = var_3_12 + 1
		end

		arg_3_0.heroList[var_3_12] = var_3_11
		var_3_0[var_3_11] = var_3_12

		local var_3_13 = {
			heroUid = var_3_11,
			heroId = iter_3_5.heroId,
			level = iter_3_5.level,
			skin = iter_3_5.skin
		}

		arg_3_0.replay_hero_data[var_3_11] = var_3_13

		if tonumber(var_3_11) < 0 then
			arg_3_0.aidDict[var_3_12] = var_3_4[-tonumber(var_3_11)]
		end
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.subHeroList) do
		local var_3_14 = iter_3_7.heroUid
		local var_3_15 = 1

		while arg_3_0.heroList[var_3_15] do
			var_3_15 = var_3_15 + 1
		end

		arg_3_0.heroList[var_3_15] = var_3_14
		var_3_0[var_3_14] = var_3_15

		local var_3_16 = {
			heroUid = var_3_14,
			heroId = iter_3_7.heroId,
			level = iter_3_7.level,
			skin = iter_3_7.skin
		}

		arg_3_0.replay_hero_data[var_3_14] = var_3_16
	end

	arg_3_0.replay_equip_data = {}

	for iter_3_8, iter_3_9 in ipairs(arg_3_1.equips) do
		local var_3_17 = var_3_0[iter_3_9.heroUid] - 1

		arg_3_0.equips[var_3_17] = HeroGroupEquipMO.New()

		local var_3_18 = iter_3_9.equipRecords[1]

		if var_3_18 then
			arg_3_0.equips[var_3_17]:init({
				index = var_3_17,
				equipUid = {
					var_3_18.equipUid
				}
			})

			local var_3_19 = {
				equipUid = var_3_18.equipUid,
				equipId = var_3_18.equipId,
				equipLv = var_3_18.equipLv,
				refineLv = var_3_18.refineLv
			}

			arg_3_0.replay_equip_data[iter_3_9.heroUid] = var_3_19
		end
	end

	arg_3_0.replay_activity104Equip_data = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.activity104Equips) do
		local var_3_20 = iter_3_11.heroUid == "-100000" and 4 or var_3_0[iter_3_11.heroUid] - 1

		arg_3_0.activity104Equips[var_3_20] = HeroGroupActivity104EquipMo.New()

		arg_3_0.activity104Equips[var_3_20]:setLimitNum(arg_3_0._seasonCardMainNum, arg_3_0._seasonCardNormalNum)

		if iter_3_11.activity104EquipRecords[1] then
			local var_3_21 = {}

			for iter_3_12, iter_3_13 in ipairs(iter_3_11.activity104EquipRecords) do
				table.insert(var_3_21, iter_3_13.equipUid)
			end

			arg_3_0.activity104Equips[var_3_20]:init({
				index = var_3_20,
				equipUid = var_3_21
			})

			local var_3_22 = {}

			for iter_3_14, iter_3_15 in ipairs(iter_3_11.activity104EquipRecords) do
				local var_3_23 = {
					equipUid = iter_3_15.equipUid,
					equipId = iter_3_15.equipId
				}

				table.insert(var_3_22, var_3_23)
			end

			arg_3_0.replay_activity104Equip_data[iter_3_11.heroUid] = var_3_22
		else
			arg_3_0.activity104Equips[var_3_20]:init({
				index = var_3_20,
				equipUid = {}
			})
		end
	end

	arg_3_0.isReplay = true
end

function var_0_0.initByLocalData(arg_4_0, arg_4_1)
	arg_4_0.id = 1
	arg_4_0.groupId = 1
	arg_4_0.name = ""
	arg_4_0.heroList = {}
	arg_4_0.aidDict = nil
	arg_4_0.trialDict = {}
	arg_4_0.clothId = arg_4_1.clothId
	arg_4_0.assistBossId = arg_4_1.assistBossId
	arg_4_0.temp = true
	arg_4_0.isReplay = false
	arg_4_0.equips = {}
	arg_4_0.activity104Equips = {}

	local var_4_0 = arg_4_1.version or HeroGroupEnum.saveOldVersion
	local var_4_1 = HeroGroupModel.instance.battleId
	local var_4_2

	var_4_2 = var_4_1 and lua_battle.configDict[var_4_1]

	local var_4_3 = {}
	local var_4_4 = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

	if not string.nilorempty(var_4_4) then
		var_4_3 = GameUtil.splitString2(var_4_4, true)
	end

	local var_4_5 = ToughBattleModel.instance:getAddTrialHeros()

	if var_4_5 then
		for iter_4_0, iter_4_1 in pairs(var_4_5) do
			table.insert(var_4_3, {
				iter_4_1
			})
		end
	end

	for iter_4_2 = 1, ModuleEnum.MaxHeroCountInGroup do
		arg_4_0.heroList[iter_4_2] = arg_4_1.heroList[iter_4_2] or "0"
		arg_4_0.equips[iter_4_2 - 1] = HeroGroupEquipMO.New()

		arg_4_0.equips[iter_4_2 - 1]:init({
			index = iter_4_2 - 1,
			equipUid = {
				arg_4_1.equips[iter_4_2] or "0"
			}
		})
		arg_4_0:updateActivity104PosEquips({
			index = iter_4_2 - 1,
			equipUid = arg_4_1.activity104Equips and arg_4_1.activity104Equips[iter_4_2] or {}
		})

		if tonumber(arg_4_0.heroList[iter_4_2]) < 0 then
			local var_4_6 = false

			for iter_4_3, iter_4_4 in pairs(var_4_3) do
				local var_4_7 = lua_hero_trial.configDict[iter_4_4[1]][iter_4_4[2] or 0]
				local var_4_8 = tonumber(var_4_7.id .. "." .. var_4_7.trialTemplate) - 1099511627776

				if var_4_0 == HeroGroupEnum.saveOldVersion then
					var_4_8 = var_4_7.heroId - 1099511627776
				end

				if var_4_8 == tonumber(arg_4_0.heroList[iter_4_2]) then
					if var_4_0 == HeroGroupEnum.saveOldVersion then
						arg_4_0.heroList[iter_4_2] = tostring(tonumber(var_4_7.id .. "." .. var_4_7.trialTemplate) - 1099511627776)
					end

					arg_4_0.trialDict[iter_4_2] = iter_4_4
					var_4_6 = true

					break
				end
			end

			if not var_4_6 then
				arg_4_0.heroList[iter_4_2] = "0"
			end
		end
	end

	local var_4_9 = ModuleEnum.MaxHeroCountInGroup + 1

	arg_4_0:updateActivity104PosEquips({
		index = var_4_9 - 1,
		equipUid = arg_4_1.activity104Equips and arg_4_1.activity104Equips[var_4_9] or {}
	})

	if Activity104Model.instance:isSeasonChapter() and arg_4_1.battleId ~= var_4_1 then
		for iter_4_5, iter_4_6 in ipairs(arg_4_0.heroList) do
			if tonumber(iter_4_6) < 0 then
				arg_4_0.heroList[iter_4_5] = tostring(0)
				arg_4_0.trialDict[iter_4_5] = nil
			end
		end
	end
end

function var_0_0.setTrials(arg_5_0, arg_5_1)
	if not arg_5_0.trialDict then
		arg_5_0.trialDict = {}
	end

	local var_5_0 = HeroGroupModel.instance.battleId
	local var_5_1 = var_5_0 and lua_battle.configDict[var_5_0]
	local var_5_2 = {}
	local var_5_3 = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

	if not string.nilorempty(var_5_3) then
		var_5_2 = GameUtil.splitString2(var_5_3, true)
	end

	local var_5_4 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_2) do
		if iter_5_1[3] then
			local var_5_5 = iter_5_1[3]

			if var_5_5 < 0 then
				var_5_5 = arg_5_0._playerMax - var_5_5
			end

			arg_5_0.trialDict[var_5_5] = iter_5_1

			local var_5_6 = lua_hero_trial.configDict[iter_5_1[1]][iter_5_1[2] or 0]

			arg_5_0.heroList[var_5_5] = tostring(tonumber(var_5_6.id .. "." .. var_5_6.trialTemplate) - 1099511627776)
			var_5_4[var_5_6.heroId] = true

			if not arg_5_1 and (var_5_6.act104EquipId1 > 0 or var_5_6.act104EquipId2 > 0) then
				arg_5_0:updateActivity104PosEquips({
					index = var_5_5 - 1
				})
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.heroList) do
		if tonumber(iter_5_3) > 0 then
			local var_5_7 = HeroModel.instance:getById(iter_5_3)

			if var_5_7 and var_5_4[var_5_7.heroId] then
				arg_5_0.heroList[iter_5_2] = "0"
			end
		end
	end

	if not arg_5_1 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not string.nilorempty(var_5_1.trialEquips) then
		local var_5_8 = string.splitToNumber(var_5_1.trialEquips, "|")

		for iter_5_4 = 1, math.min(#var_5_8, ModuleEnum.MaxHeroCountInGroup) do
			arg_5_0:updatePosEquips({
				index = iter_5_4 - 1,
				equipUid = {
					tostring(-var_5_8[iter_5_4])
				}
			})
		end
	end

	if not arg_5_1 and var_5_1.trialMainAct104EuqipId > 0 then
		arg_5_0:updateActivity104PosEquips({
			index = ModuleEnum.MaxHeroCountInGroup,
			equipUid = {
				-var_5_1.trialMainAct104EuqipId
			}
		})
	end
end

function var_0_0.saveData(arg_6_0)
	local var_6_0 = HeroGroupModel.instance.battleId
	local var_6_1 = {
		clothId = arg_6_0.clothId,
		heroList = {},
		equips = {},
		activity104Equips = {},
		assistBossId = arg_6_0.assistBossId
	}

	for iter_6_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		var_6_1.heroList[iter_6_0] = arg_6_0.heroList[iter_6_0]
		var_6_1.equips[iter_6_0] = arg_6_0.equips[iter_6_0 - 1] and arg_6_0.equips[iter_6_0 - 1].equipUid[1]
		var_6_1.activity104Equips[iter_6_0] = arg_6_0.activity104Equips[iter_6_0 - 1] and arg_6_0.activity104Equips[iter_6_0 - 1].equipUid
	end

	local var_6_2 = ModuleEnum.MaxHeroCountInGroup + 1

	var_6_1.activity104Equips[var_6_2] = arg_6_0.activity104Equips[var_6_2 - 1] and arg_6_0.activity104Equips[var_6_2 - 1].equipUid
	var_6_1.battleId = var_6_0
	var_6_1.version = HeroGroupEnum.saveTrialVersion

	local var_6_3

	if Activity104Model.instance:isSeasonChapter() then
		var_6_3 = Activity104Model.instance:getSeasonTrialPrefsKey()
	else
		var_6_3 = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_6_0
	end

	PlayerPrefsHelper.setString(var_6_3, cjson.encode(var_6_1))
end

function var_0_0.setTempName(arg_7_0, arg_7_1)
	arg_7_0.name = arg_7_1
end

function var_0_0.setTemp(arg_8_0, arg_8_1)
	arg_8_0.temp = arg_8_1
end

function var_0_0.replaceHeroList(arg_9_0, arg_9_1)
	arg_9_0.heroList = {}
	arg_9_0.aidDict = {}
	arg_9_0.trialDict = {}

	local var_9_0 = arg_9_1 and #arg_9_1 or 0

	for iter_9_0 = 1, var_9_0 do
		table.insert(arg_9_0.heroList, arg_9_1[iter_9_0].heroUid)

		if arg_9_1[iter_9_0].aid then
			arg_9_0.aidDict[iter_9_0] = arg_9_1[iter_9_0].aid
		end
	end

	arg_9_0:_dropAidEquip()
end

function var_0_0._dropAidEquip(arg_10_0)
	if arg_10_0.aidDict then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.aidDict) do
			if iter_10_1 > 0 then
				arg_10_0:_setPosEquips(iter_10_0 - 1, nil)
				arg_10_0:updateActivity104PosEquips({
					index = iter_10_0 - 1
				})
			end
		end
	end

	if arg_10_0.trialDict then
		for iter_10_2, iter_10_3 in pairs(arg_10_0.trialDict) do
			arg_10_0:_setPosEquips(iter_10_2 - 1, nil)
			arg_10_0:updateActivity104PosEquips({
				index = iter_10_2 - 1
			})
		end
	end
end

function var_0_0.replaceClothId(arg_11_0, arg_11_1)
	arg_11_0.clothId = arg_11_1
end

function var_0_0.getHeroByIndex(arg_12_0, arg_12_1)
	return arg_12_0.heroList[arg_12_1]
end

function var_0_0.getAllPosEquips(arg_13_0)
	return arg_13_0.equips
end

function var_0_0.getPosEquips(arg_14_0, arg_14_1)
	if not arg_14_0.equips[arg_14_1] then
		arg_14_0:updatePosEquips({
			index = arg_14_1
		})
	end

	return arg_14_0.equips[arg_14_1]
end

function var_0_0._setPosEquips(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == nil then
		arg_15_2 = HeroGroupEquipMO.New()

		arg_15_2:init({
			index = arg_15_1
		})
	end

	arg_15_0.equips[arg_15_1] = arg_15_2
end

function var_0_0.updatePosEquips(arg_16_0, arg_16_1)
	for iter_16_0 = 0, 3 do
		local var_16_0 = arg_16_0.equips[iter_16_0]

		if var_16_0 and var_16_0.equipUid and #var_16_0.equipUid > 0 and arg_16_1.equipUid and #arg_16_1.equipUid > 0 then
			for iter_16_1 = 1, 1 do
				if var_16_0.equipUid[iter_16_1] == arg_16_1.equipUid[iter_16_1] then
					var_16_0.equipUid[iter_16_1] = "0"
				end
			end
		end
	end

	local var_16_1 = HeroGroupEquipMO.New()

	var_16_1:init(arg_16_1)

	arg_16_0.equips[arg_16_1.index] = var_16_1
end

function var_0_0.getAct104PosEquips(arg_17_0, arg_17_1)
	if not arg_17_0.activity104Equips[arg_17_1] then
		arg_17_0:updateActivity104PosEquips({
			index = arg_17_1
		})
	end

	return arg_17_0.activity104Equips[arg_17_1]
end

function var_0_0.updateActivity104PosEquips(arg_18_0, arg_18_1)
	local var_18_0 = HeroGroupActivity104EquipMo.New()

	var_18_0:setLimitNum(arg_18_0._seasonCardMainNum, arg_18_0._seasonCardNormalNum)
	var_18_0:init(arg_18_1)

	arg_18_0.activity104Equips[arg_18_1.index] = var_18_0
end

function var_0_0.checkAndPutOffEquip(arg_19_0)
	if not arg_19_0.equips then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.equips) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1.equipUid) do
			if tonumber(iter_19_3) > 0 then
				local var_19_0 = EquipModel.instance:getEquip(iter_19_3)

				iter_19_1.equipUid[iter_19_2] = var_19_0 and iter_19_3 or "0"
			end
		end
	end
end

function var_0_0.getAllHeroEquips(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = false
	local var_20_2 = FightModel.instance:getFightParam()
	local var_20_3 = {}

	if var_20_2 and var_20_2.battleId > 0 then
		local var_20_4 = lua_battle.configDict[var_20_2.battleId]

		if not string.nilorempty(var_20_4.trialEquips) then
			var_20_3 = string.splitToNumber(var_20_4.trialEquips, "|")
		end
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.equips) do
		local var_20_5 = iter_20_0 + 1
		local var_20_6

		var_20_6.heroUid, var_20_6 = arg_20_0.heroList[var_20_5] or "0", FightEquipMO.New()

		for iter_20_2, iter_20_3 in ipairs(iter_20_1.equipUid) do
			if tonumber(iter_20_3) > 0 then
				local var_20_7 = EquipModel.instance:getEquip(iter_20_3)

				iter_20_1.equipUid[iter_20_2] = var_20_7 and iter_20_3 or "0"

				if not var_20_7 then
					var_20_1 = true
				end
			else
				local var_20_8 = -tonumber(iter_20_3)

				if lua_equip_trial.configDict[var_20_8] and tabletool.indexOf(var_20_3, var_20_8) then
					iter_20_1.equipUid[iter_20_2] = iter_20_3
				else
					iter_20_1.equipUid[iter_20_2] = "0"
				end
			end
		end

		var_20_6.equipUid = iter_20_1.equipUid

		table.insert(var_20_0, var_20_6)
	end

	return var_20_0, var_20_1
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

	for iter_22_0 = 1, ModuleEnum.MaxHeroCountInGroup do
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

	local var_23_0 = ModuleEnum.MaxHeroCountInGroup
	local var_23_1 = {}
	local var_23_2 = {}
	local var_23_3 = {}

	arg_23_6 = arg_23_6 or {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_6) do
		if iter_23_1[3] then
			local var_23_4 = iter_23_1[3]

			if var_23_4 < 0 then
				var_23_4 = arg_23_0._playerMax - var_23_4
			end

			if arg_23_0.heroList[var_23_4] then
				local var_23_5 = lua_hero_trial.configDict[iter_23_1[1]][iter_23_1[2] or 0]

				if tonumber(arg_23_0.heroList[var_23_4]) > 0 then
					table.insert(var_23_1, arg_23_0.heroList[var_23_4])
					table.insert(var_23_2, arg_23_0:getPosEquips(var_23_4 - 1))
				end

				arg_23_0.heroList[var_23_4] = tostring(tonumber(var_23_5.id .. "." .. var_23_5.trialTemplate) - 1099511627776)
				arg_23_0.trialDict[var_23_4] = iter_23_1
				var_23_3[var_23_5.heroId] = true
			end
		end
	end

	for iter_23_2 = 1, var_23_0 do
		local var_23_6 = HeroModel.instance:getById(arg_23_0.heroList[iter_23_2])

		if var_23_6 and var_23_3[var_23_6.heroId] then
			arg_23_0.heroList[iter_23_2] = "0"
		end
	end

	for iter_23_3 = 1, var_23_0 do
		for iter_23_4 = 1, #arg_23_2 do
			local var_23_7 = lua_monster.configDict[tonumber(arg_23_2[iter_23_4])]
			local var_23_8 = lua_skin.configDict[var_23_7 and var_23_7.skinId]
			local var_23_9 = var_23_8 and var_23_8.characterId

			if var_23_9 then
				local var_23_10 = arg_23_0.heroList[iter_23_3] and HeroModel.instance:getById(arg_23_0.heroList[iter_23_3])

				if var_23_10 and var_23_10.heroId == var_23_9 then
					if arg_23_4 < iter_23_3 or arg_23_3 < iter_23_3 or iter_23_3 > HeroGroupModel.instance:positionOpenCount() then
						arg_23_0.heroList[iter_23_3] = "0"

						break
					end

					arg_23_0.heroList[iter_23_3] = tostring(-iter_23_4)
					arg_23_0.aidDict[iter_23_3] = arg_23_2[iter_23_4]

					arg_23_0:updatePosEquips({
						index = iter_23_3 - 1
					})

					arg_23_2[iter_23_4] = nil

					break
				end
			end
		end
	end

	for iter_23_5 = var_23_0, 1, -1 do
		if arg_23_3 < iter_23_5 or iter_23_5 > HeroGroupModel.instance:positionOpenCount() and not arg_23_0.trialDict[iter_23_5] then
			if arg_23_0.heroList[iter_23_5] and tonumber(arg_23_0.heroList[iter_23_5]) > 0 then
				table.insert(var_23_1, arg_23_0.heroList[iter_23_5])
				table.insert(var_23_2, arg_23_0:getPosEquips(iter_23_5 - 1))
			end

			arg_23_0.heroList[iter_23_5] = "0"

			if iter_23_5 <= HeroGroupModel.instance:positionOpenCount() then
				arg_23_0.aidDict[iter_23_5] = -1
			end
		elseif arg_23_4 < iter_23_5 then
			-- block empty
		elseif not arg_23_0.heroList[iter_23_5] or tonumber(arg_23_0.heroList[iter_23_5]) >= 0 and not arg_23_0.trialDict[iter_23_5] then
			for iter_23_6 = 1, var_23_0 do
				if arg_23_2[iter_23_6] then
					if arg_23_0.heroList[iter_23_5] and tonumber(arg_23_0.heroList[iter_23_5]) > 0 then
						table.insert(var_23_1, arg_23_0.heroList[iter_23_5])
						table.insert(var_23_2, arg_23_0:getPosEquips(iter_23_5 - 1))
					end

					arg_23_0.heroList[iter_23_5] = tostring(-iter_23_6)
					arg_23_0.aidDict[iter_23_5] = arg_23_2[iter_23_6]

					arg_23_0:updatePosEquips({
						index = iter_23_5 - 1
					})

					arg_23_2[iter_23_6] = nil

					break
				end
			end
		end
	end

	for iter_23_7 = 1, var_23_0 do
		if #var_23_1 <= 0 then
			break
		end

		if iter_23_7 <= arg_23_3 and iter_23_7 <= HeroGroupModel.instance:positionOpenCount() and (not arg_23_0.heroList[iter_23_7] or arg_23_0.heroList[iter_23_7] == "0" or arg_23_0.heroList[iter_23_7] == 0) then
			arg_23_0.heroList[iter_23_7] = var_23_1[#var_23_1]

			arg_23_0:_setPosEquips(iter_23_7 - 1, var_23_2[#var_23_2])
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
		local var_25_5 = var_25_4 and var_25_4.playerMax or ModuleEnum.HeroCountInGroup

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

		for iter_26_1 = (var_26_4 and var_26_4.playerMax or ModuleEnum.HeroCountInGroup) + 1, ModuleEnum.MaxHeroCountInGroup do
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

	local var_27_0 = ModuleEnum.MaxHeroCountInGroup

	return arg_27_1 < 0 and arg_27_1 >= -var_27_0
end

function var_0_0.clearAidHero(arg_28_0)
	if arg_28_0.heroList then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.heroList) do
			if arg_28_0:isAidHero(iter_28_1) and (not arg_28_0.aidDict or not arg_28_0.aidDict[iter_28_0]) then
				arg_28_0.heroList[iter_28_0] = tostring(0)
			end
		end
	end
end

function var_0_0.setSeasonCardLimit(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0._seasonCardMainNum, arg_29_0._seasonCardNormalNum = arg_29_1, arg_29_2
end

function var_0_0.getSeasonCardLimit(arg_30_0)
	return arg_30_0._seasonCardMainNum, arg_30_0._seasonCardNormalNum
end

function var_0_0.getAssistBossId(arg_31_0)
	return arg_31_0.assistBossId
end

function var_0_0.setAssistBossId(arg_32_0, arg_32_1)
	arg_32_0.assistBossId = arg_32_1
end

function var_0_0.replaceTowerHeroList(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}
	local var_33_2 = tostring(0)
	local var_33_3 = arg_33_1 and #arg_33_1 or 0

	for iter_33_0 = 1, var_33_3 do
		local var_33_4 = arg_33_1[iter_33_0].heroUid

		var_33_0[var_33_4] = arg_33_1[iter_33_0].equipUid

		if var_33_4 ~= var_33_2 then
			table.insert(var_33_1, var_33_4)
		end
	end

	if not arg_33_0.heroList then
		arg_33_0.heroList = {}
	end

	local var_33_5 = {}

	for iter_33_1 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_33_6 = arg_33_0.heroList[iter_33_1] or var_33_2

		if var_33_0[var_33_6] then
			tabletool.removeValue(var_33_1, var_33_6)
		else
			arg_33_0.heroList[iter_33_1] = var_33_2
			var_33_5[iter_33_1] = 1
		end
	end

	local var_33_7 = {}

	for iter_33_2, iter_33_3 in pairs(var_33_5) do
		table.insert(var_33_7, iter_33_2)
	end

	if #var_33_7 > 1 then
		table.sort(var_33_7)
	end

	for iter_33_4, iter_33_5 in ipairs(var_33_1) do
		local var_33_8 = var_33_7[iter_33_4]

		arg_33_0.heroList[var_33_8] = iter_33_5
	end

	arg_33_0.equips = {}

	for iter_33_6 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_33_9 = var_33_0[arg_33_0.heroList[iter_33_6] or var_33_2]

		if var_33_9 then
			local var_33_10 = iter_33_6 - 1

			arg_33_0.equips[var_33_10] = HeroGroupEquipMO.New()

			arg_33_0.equips[var_33_10]:init({
				index = var_33_10,
				equipUid = var_33_9
			})
		end
	end

	arg_33_0.trialDict = {}

	for iter_33_7, iter_33_8 in ipairs(arg_33_0.heroList) do
		if tonumber(iter_33_8) < 0 then
			local var_33_11 = HeroGroupTrialModel.instance:getById(iter_33_8)

			if var_33_11 then
				arg_33_0.trialDict[iter_33_7] = {
					var_33_11.trialCo.id,
					0
				}
			else
				arg_33_0.heroList[iter_33_7] = "0"
			end
		end
	end
end

function var_0_0.checkAct183HeroList(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_2 then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0.heroList) do
			if iter_34_1 ~= "0" then
				local var_34_0 = HeroModel.instance:getById(iter_34_1)

				if var_34_0 and arg_34_2:isHeroRepress(var_34_0.heroId) then
					arg_34_0.heroList[iter_34_0] = "0"
				end
			end
		end
	end

	local var_34_1 = arg_34_0.heroList and #arg_34_0.heroList or 0

	if var_34_1 < arg_34_1 then
		for iter_34_2 = var_34_1 + 1, arg_34_1 do
			table.insert(arg_34_0.heroList, "0")
		end
	elseif arg_34_1 < var_34_1 then
		logError("角色数量超过上限")
	end
end

return var_0_0
