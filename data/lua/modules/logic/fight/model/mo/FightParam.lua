module("modules.logic.fight.model.mo.FightParam", package.seeall)

local var_0_0 = pureTable("FightParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.name = nil
	arg_1_0.sceneId = nil
	arg_1_0.levelId = nil
	arg_1_0.sceneIds = nil
	arg_1_0.levelIds = nil
	arg_1_0.clothId = nil
	arg_1_0.mySideUids = nil
	arg_1_0.mySideSubUids = nil
	arg_1_0.monsterGroupIds = nil
	arg_1_0.episodeId = nil
	arg_1_0.battleId = nil
	arg_1_0.equips = nil
	arg_1_0.isShowSettlement = true
	arg_1_0.extraList = nil
	arg_1_0.assistUserId = nil
	arg_1_0.assistHeroUid = nil
	arg_1_0.assistBossId = nil
	arg_1_0.chapterId = nil
	arg_1_0.episodeId = nil
	arg_1_0.multiplication = nil
	arg_1_0.preload = false
	arg_1_0.adventure = nil
	arg_1_0.isTestFight = false
	arg_1_0.isReplay = false
end

function var_0_0.setAdventure(arg_2_0, arg_2_1)
	arg_2_0.adventure = arg_2_1
end

function var_0_0.setPreload(arg_3_0)
	arg_3_0.preload = true
end

function var_0_0.setDungeon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.chapterId = arg_4_1
	arg_4_0.episodeId = arg_4_2
	arg_4_0.multiplication = arg_4_3
end

function var_0_0.setShowSettlement(arg_5_0, arg_5_1)
	arg_5_0.isShowSettlement = arg_5_1
end

function var_0_0.setReqFightGroup(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.fightGroup

	if arg_6_1.isRestart then
		local var_6_1 = FightModel.instance.last_fightGroup

		tabletool.addValues(var_6_0.heroList, var_6_1.heroList)
		tabletool.addValues(var_6_0.subHeroList, var_6_1.subHeroList)
		tabletool.addValues(var_6_0.equips, var_6_1.equips)
		tabletool.addValues(var_6_0.trialHeroList, var_6_1.trialHeroList)
		tabletool.addValues(var_6_0.activity104Equips, var_6_1.activity104Equips)
		tabletool.addValues(var_6_0.extraList, var_6_1.extraList)

		var_6_0.clothId = var_6_1.clothId
		var_6_0.assistHeroUid = var_6_1.assistHeroUid
		var_6_0.assistUserId = var_6_1.assistUserId

		if var_6_1.assistBossId then
			var_6_0.assistBossId = var_6_1.assistBossId
		end

		return
	end

	if Activity104Model.instance:isSeasonChapter() or Activity104Model.instance:isSeasonGMChapter() then
		var_0_0.initFightGroup(var_6_0, arg_6_0.clothId, arg_6_0.mySideUids, arg_6_0.mySideSubUids, arg_6_0.equips, arg_6_0.activity104Equips)
	elseif Season123Controller.sendEpisodeUseSeason123Equip() then
		var_0_0.initFightGroup(var_6_0, arg_6_0.clothId, arg_6_0.mySideUids, arg_6_0.mySideSubUids, arg_6_0.equips, arg_6_0.activity104Equips)
	else
		var_0_0.initFightGroup(var_6_0, arg_6_0.clothId, arg_6_0.mySideUids, arg_6_0.mySideSubUids, arg_6_0.equips, nil, arg_6_0.assistBossId)
	end

	tabletool.addValues(var_6_0.extraList, arg_6_0.extraList)

	if arg_6_0.assistHeroUid then
		var_6_0.assistHeroUid = arg_6_0.assistHeroUid
	end

	if arg_6_0.assistUserId then
		var_6_0.assistUserId = arg_6_0.assistUserId
	end

	arg_6_0.trialHeroList = var_6_0.trialHeroList
end

function var_0_0.initFightGroup(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	if arg_7_1 then
		arg_7_0.clothId = arg_7_1
	end

	if arg_7_6 then
		arg_7_0.assistBossId = arg_7_6
	end

	local var_7_0 = {}
	local var_7_1 = arg_7_2 and #arg_7_2 or 0

	if arg_7_2 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			if tonumber(iter_7_1) < 0 then
				local var_7_2 = HeroGroupTrialModel.instance:getById(iter_7_1)

				if var_7_2 then
					var_7_0[iter_7_0] = FightDef_pb.TrialHero()
					var_7_0[iter_7_0].pos = iter_7_0
					var_7_0[iter_7_0].trialId = var_7_2.trialCo.id
				else
					table.insert(arg_7_0.heroList, iter_7_1)
				end
			else
				table.insert(arg_7_0.heroList, iter_7_1)
			end
		end
	end

	if arg_7_3 then
		for iter_7_2, iter_7_3 in ipairs(arg_7_3) do
			if tonumber(iter_7_3) < 0 then
				local var_7_3 = HeroGroupTrialModel.instance:getById(iter_7_3)

				if var_7_3 then
					var_7_0[iter_7_2 + var_7_1] = FightDef_pb.TrialHero()
					var_7_0[iter_7_2 + var_7_1].pos = -iter_7_2
					var_7_0[iter_7_2 + var_7_1].trialId = var_7_3.trialCo.id
				else
					table.insert(arg_7_0.subHeroList, iter_7_3)
				end
			else
				table.insert(arg_7_0.subHeroList, iter_7_3)
			end
		end
	end

	if arg_7_4 then
		for iter_7_4, iter_7_5 in ipairs(arg_7_4) do
			if var_7_0[iter_7_4] then
				for iter_7_6, iter_7_7 in ipairs(iter_7_5.equipUid) do
					table.insert(var_7_0[iter_7_4].equipUid, iter_7_7)
				end
			else
				local var_7_4 = FightDef_pb.FightEquip()

				var_7_4.heroUid = iter_7_5.heroUid

				for iter_7_8, iter_7_9 in ipairs(iter_7_5.equipUid) do
					table.insert(var_7_4.equipUid, iter_7_9)
				end

				table.insert(arg_7_0.equips, var_7_4)
			end
		end
	end

	if arg_7_5 then
		for iter_7_10, iter_7_11 in ipairs(arg_7_5) do
			local var_7_5 = FightDef_pb.FightEquip()

			var_7_5.heroUid = iter_7_11.heroUid

			if iter_7_11.equipUid then
				for iter_7_12, iter_7_13 in ipairs(iter_7_11.equipUid) do
					table.insert(var_7_5.equipUid, iter_7_13)

					if var_7_0[iter_7_10] then
						table.insert(var_7_0[iter_7_10].act104EquipUid, iter_7_13)
					end
				end
			end

			table.insert(arg_7_0.activity104Equips, var_7_5)
		end
	end

	for iter_7_14, iter_7_15 in pairs(var_7_0) do
		table.insert(arg_7_0.trialHeroList, iter_7_15)
	end
end

function var_0_0.setAssistHeroInfo(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.assistHeroUid = arg_8_1
	arg_8_0.assistUserId = arg_8_2
end

function var_0_0.setMySide(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
	arg_9_0.clothId = arg_9_1
	arg_9_0.mySideUids = arg_9_2
	arg_9_0.mySideSubUids = arg_9_3
	arg_9_0.equips = arg_9_4
	arg_9_0.activity104Equips = arg_9_5
	arg_9_0.trialHeroList = arg_9_6
	arg_9_0.extraList = arg_9_7
	arg_9_0.assistBossId = arg_9_8
end

function var_0_0.setEpisodeAndBattle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_1)

	arg_10_0.name = var_10_0.name
	arg_10_0.episodeId = arg_10_1
	arg_10_0.chapterId = var_10_0.chapterId

	arg_10_0:setBattleId(arg_10_2)
end

function var_0_0.setEpisodeId(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or DungeonConfig.instance:getEpisodeBattleId(arg_11_1)

	local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_1)

	arg_11_0.name = var_11_0.name
	arg_11_0.episodeId = arg_11_1
	arg_11_0.chapterId = var_11_0.chapterId

	arg_11_0:setBattleId(arg_11_2)
end

function var_0_0.setBattleId(arg_12_0, arg_12_1)
	arg_12_0.battleId = arg_12_1

	local var_12_0 = lua_battle.configDict[arg_12_1]

	arg_12_0.sceneIds, arg_12_0.levelIds = FightHelper.buildSceneAndLevel(arg_12_0.episodeId, arg_12_1)

	local var_12_1 = FightModel.instance:getCurWaveId()

	arg_12_0.sceneId = arg_12_0:getScene(var_12_1)
	arg_12_0.levelId = arg_12_0:getSceneLevel(var_12_1)
	arg_12_0.monsterGroupIds = string.splitToNumber(var_12_0.monsterGroupIds, "#")
end

function var_0_0.getCurEpisodeConfig(arg_13_0)
	return DungeonConfig.instance:getEpisodeCO(arg_13_0.episodeId)
end

function var_0_0.setSceneLevel(arg_14_0, arg_14_1)
	local var_14_0 = lua_scene_level.configDict[arg_14_1]

	arg_14_0.levelIds = {
		arg_14_1
	}
	arg_14_0.sceneIds = {
		var_14_0.sceneId
	}
	arg_14_0.sceneId = var_14_0.sceneId
	arg_14_0.levelId = arg_14_1
end

function var_0_0.getScene(arg_15_0, arg_15_1)
	if arg_15_0.sceneIds and #arg_15_0.sceneIds > 0 then
		if arg_15_1 <= #arg_15_0.sceneIds then
			return arg_15_0.sceneIds[arg_15_1]
		else
			return arg_15_0.sceneIds[#arg_15_0.sceneIds]
		end
	end
end

function var_0_0.getSceneLevel(arg_16_0, arg_16_1)
	if arg_16_0.levelIds and #arg_16_0.levelIds > 0 then
		if arg_16_1 <= #arg_16_0.levelIds then
			return arg_16_0.levelIds[arg_16_1]
		else
			return arg_16_0.levelIds[#arg_16_0.levelIds]
		end
	end

	return SceneConfig.instance:getSceneLevelCOs(arg_16_0.sceneId)[1].id
end

function var_0_0.getAllHeroMoList(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.mySideUids) do
		local var_17_1 = HeroModel.instance:getById(iter_17_1)

		if var_17_1 then
			table.insert(var_17_0, var_17_1)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.mySideSubUids) do
		local var_17_2 = HeroModel.instance:getById(iter_17_3)

		if var_17_2 then
			table.insert(var_17_0, var_17_2)
		end
	end

	return var_17_0
end

function var_0_0.getMainHeroMoList(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.mySideUids) do
		local var_18_1 = HeroModel.instance:getById(iter_18_1)

		if var_18_1 then
			table.insert(var_18_0, var_18_1)
		end
	end

	if arg_18_0.trialHeroList then
		for iter_18_2, iter_18_3 in ipairs(arg_18_0.trialHeroList) do
			if iter_18_3.pos > 0 then
				local var_18_2 = HeroMo.New()

				var_18_2:initFromTrial(iter_18_3.trialId)
				table.insert(var_18_0, var_18_2)
			end
		end
	end

	return var_18_0
end

function var_0_0.getSubHeroMoList(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.mySideSubUids) do
		local var_19_1 = HeroModel.instance:getById(iter_19_1)

		if var_19_1 then
			table.insert(var_19_0, var_19_1)
		end
	end

	if arg_19_0.trialHeroList then
		for iter_19_2, iter_19_3 in ipairs(arg_19_0.trialHeroList) do
			if iter_19_3.pos < 0 then
				local var_19_2 = HeroMo.New()

				var_19_2:initFromTrial(iter_19_3.trialId)
				table.insert(var_19_0, var_19_2)
			end
		end
	end

	return var_19_0
end

function var_0_0.getEquipMoList(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.equips) do
		table.insert(var_20_0, EquipModel.instance:getEquip(iter_20_1.equipUid[1]))
	end

	if arg_20_0.trialHeroList then
		for iter_20_2, iter_20_3 in ipairs(arg_20_0.trialHeroList) do
			local var_20_1 = lua_hero_trial.configDict[iter_20_3.trialId][0]

			if var_20_1 and var_20_1.equipId > 0 then
				local var_20_2 = EquipMO.New()

				var_20_2:initByTrialCO(var_20_1)
				table.insert(var_20_0, var_20_2)
			end
		end
	end

	return var_20_0
end

function var_0_0.getHeroEquipMoList(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.equips) do
		local var_21_2 = iter_21_1.heroUid
		local var_21_3 = iter_21_1.equipUid[1]

		var_21_1[var_21_2] = EquipModel.instance:getEquip(var_21_3)
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.mySideUids) do
		local var_21_4 = HeroModel.instance:getById(iter_21_3)

		if var_21_4 then
			local var_21_5 = var_21_4.uid

			table.insert(var_21_0, {
				heroMo = var_21_4,
				equipMo = var_21_1[var_21_5]
			})
		end
	end

	for iter_21_4, iter_21_5 in ipairs(arg_21_0.mySideSubUids) do
		local var_21_6 = HeroModel.instance:getById(iter_21_5)

		if var_21_6 then
			local var_21_7 = var_21_6.uid

			table.insert(var_21_0, {
				heroMo = var_21_6,
				equipMo = var_21_1[var_21_7]
			})
		end
	end

	if arg_21_0.trialHeroList then
		for iter_21_6, iter_21_7 in ipairs(arg_21_0.trialHeroList) do
			local var_21_8 = lua_hero_trial.configDict[iter_21_7.trialId][0]

			if var_21_8 and var_21_8.equipId > 0 then
				local var_21_9 = EquipMO.New()

				var_21_9:initByTrialCO(var_21_8)

				local var_21_10 = HeroMo.New()

				var_21_10:initFromTrial(iter_21_7.trialId)
				table.insert(var_21_0, {
					heroMo = var_21_10,
					equipMo = var_21_9
				})
			end
		end
	end

	return var_21_0
end

function var_0_0.getHeroEquipMoListWithTrial(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = {}
	local var_22_2 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.equips) do
		local var_22_3 = iter_22_1.heroUid
		local var_22_4 = iter_22_1.equipUid[1]

		var_22_2[var_22_3] = EquipModel.instance:getEquip(var_22_4)
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.mySideUids) do
		local var_22_5 = HeroModel.instance:getById(iter_22_3) or FightHelper.getAssitHeroInfoByUid(iter_22_3)

		if var_22_5 then
			table.insert(var_22_0, {
				heroMo = var_22_5,
				equipMo = var_22_2[iter_22_3]
			})
		end
	end

	for iter_22_4, iter_22_5 in ipairs(arg_22_0.mySideSubUids) do
		local var_22_6 = HeroModel.instance:getById(iter_22_5) or FightHelper.getAssitHeroInfoByUid(iter_22_5, true)

		if var_22_6 then
			table.insert(var_22_1, {
				heroMo = var_22_6,
				equipMo = var_22_2[iter_22_5]
			})
		end
	end

	if arg_22_0.trialHeroList then
		for iter_22_6, iter_22_7 in ipairs(arg_22_0.trialHeroList) do
			local var_22_7 = lua_hero_trial.configDict[iter_22_7.trialId][0]

			if var_22_7 and var_22_7.equipId > 0 then
				local var_22_8 = EquipMO.New()

				var_22_8:initByTrialCO(var_22_7)

				local var_22_9 = HeroMo.New()

				var_22_9:initFromTrial(iter_22_7.trialId)

				local var_22_10 = {
					heroMo = var_22_9,
					equipMo = var_22_8
				}

				if iter_22_7.pos > 0 then
					table.insert(var_22_0, var_22_10)
				else
					table.insert(var_22_1, var_22_10)
				end
			end
		end
	end

	return var_22_0, var_22_1
end

function var_0_0.initTowerFightGroup(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7)
	if arg_23_1 then
		arg_23_0.clothId = arg_23_1
	end

	if arg_23_6 then
		arg_23_0.assistBossId = arg_23_6
	end

	if arg_23_2 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
			if tonumber(iter_23_1) < 0 then
				local var_23_0 = HeroGroupTrialModel.instance:getById(iter_23_1)

				if var_23_0 then
					local var_23_1 = var_23_0.trialCo.id > 0 and tostring(-var_23_0.trialCo.id) or "0"

					table.insert(arg_23_0.heroList, var_23_1)
				elseif arg_23_7 then
					table.insert(arg_23_0.heroList, iter_23_1)
				end
			else
				table.insert(arg_23_0.heroList, iter_23_1)
			end
		end
	end

	if arg_23_3 then
		for iter_23_2, iter_23_3 in ipairs(arg_23_3) do
			if tonumber(iter_23_3) < 0 then
				local var_23_2 = HeroGroupTrialModel.instance:getById(iter_23_3)

				if var_23_2 then
					local var_23_3 = var_23_2.trialCo.id > 0 and tostring(-var_23_2.trialCo.id) or "0"

					table.insert(arg_23_0.subHeroList, var_23_3)
				end
			else
				table.insert(arg_23_0.subHeroList, iter_23_3)
			end
		end
	end

	if arg_23_4 then
		for iter_23_4, iter_23_5 in ipairs(arg_23_4) do
			local var_23_4 = FightDef_pb.FightEquip()

			if tonumber(iter_23_5.heroUid) < 0 then
				local var_23_5 = HeroGroupTrialModel.instance:getById(iter_23_5.heroUid)

				var_23_4.heroUid = var_23_5 and var_23_5.trialCo.id > 0 and tostring(-var_23_5.trialCo.id) or "0"
			else
				var_23_4.heroUid = iter_23_5.heroUid
			end

			for iter_23_6, iter_23_7 in ipairs(iter_23_5.equipUid) do
				table.insert(var_23_4.equipUid, iter_23_7)
			end

			table.insert(arg_23_0.equips, var_23_4)
		end
	end

	if arg_23_5 then
		for iter_23_8, iter_23_9 in ipairs(arg_23_5) do
			local var_23_6 = FightDef_pb.FightEquip()

			if tonumber(iter_23_9.heroUid) < 0 then
				local var_23_7 = HeroGroupTrialModel.instance:getById(iter_23_9.heroUid)

				var_23_6.heroUid = var_23_7 and var_23_7.trialCo.id > 0 and tostring(-var_23_7.trialCo.id) or "0"
			else
				var_23_6.heroUid = iter_23_9.heroUid
			end

			if iter_23_9.equipUid then
				for iter_23_10, iter_23_11 in ipairs(iter_23_9.equipUid) do
					table.insert(var_23_6.equipUid, iter_23_11)
				end
			end

			table.insert(arg_23_0.activity104Equips, var_23_6)
		end
	end
end

function var_0_0.getHeroEquipAndTrialMoList(arg_24_0, arg_24_1)
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.equips) do
		local var_24_2 = iter_24_1.heroUid
		local var_24_3 = iter_24_1.equipUid[1]

		var_24_1[var_24_2] = EquipModel.instance:getEquip(var_24_3)
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_0.mySideUids) do
		local var_24_4 = HeroModel.instance:getById(iter_24_3)

		if var_24_4 then
			local var_24_5 = var_24_4.uid

			table.insert(var_24_0, {
				heroMo = var_24_4,
				equipMo = var_24_1[var_24_5]
			})
		else
			table.insert(var_24_0, {})
		end
	end

	for iter_24_4, iter_24_5 in ipairs(arg_24_0.mySideSubUids) do
		local var_24_6 = HeroModel.instance:getById(iter_24_5)

		if var_24_6 then
			local var_24_7 = var_24_6.uid

			table.insert(var_24_0, {
				heroMo = var_24_6,
				equipMo = var_24_1[var_24_7]
			})
		else
			table.insert(var_24_0, {})
		end
	end

	if arg_24_0.trialHeroList then
		for iter_24_6, iter_24_7 in ipairs(arg_24_0.trialHeroList) do
			local var_24_8 = lua_hero_trial.configDict[iter_24_7.trialId][0]

			if var_24_8 and var_24_8.equipId > 0 then
				local var_24_9 = EquipMO.New()

				var_24_9:initByTrialCO(var_24_8)

				local var_24_10 = HeroMo.New()

				var_24_10:initFromTrial(iter_24_7.trialId)
				table.insert(var_24_0, iter_24_7.pos, {
					heroMo = var_24_10,
					equipMo = var_24_9
				})
			end
		end
	end

	for iter_24_8 = #var_24_0, 1, -1 do
		if var_24_0[iter_24_8].heroMo == nil and arg_24_1 then
			table.remove(var_24_0, iter_24_8)
		end
	end

	return var_24_0
end

return var_0_0
