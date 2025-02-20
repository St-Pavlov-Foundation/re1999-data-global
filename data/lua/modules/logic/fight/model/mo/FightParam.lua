module("modules.logic.fight.model.mo.FightParam", package.seeall)

slot0 = pureTable("FightParam")

function slot0.ctor(slot0)
	slot0.name = nil
	slot0.sceneId = nil
	slot0.levelId = nil
	slot0.sceneIds = nil
	slot0.levelIds = nil
	slot0.clothId = nil
	slot0.mySideUids = nil
	slot0.mySideSubUids = nil
	slot0.monsterGroupIds = nil
	slot0.episodeId = nil
	slot0.battleId = nil
	slot0.equips = nil
	slot0.isShowSettlement = true
	slot0.extraList = nil
	slot0.assistUserId = nil
	slot0.assistHeroUid = nil
	slot0.assistBossId = nil
	slot0.chapterId = nil
	slot0.episodeId = nil
	slot0.multiplication = nil
	slot0.preload = false
	slot0.adventure = nil
	slot0.isTestFight = false
	slot0.isReplay = false
end

function slot0.setAdventure(slot0, slot1)
	slot0.adventure = slot1
end

function slot0.setPreload(slot0)
	slot0.preload = true
end

function slot0.setDungeon(slot0, slot1, slot2, slot3)
	slot0.chapterId = slot1
	slot0.episodeId = slot2
	slot0.multiplication = slot3
end

function slot0.setShowSettlement(slot0, slot1)
	slot0.isShowSettlement = slot1
end

function slot0.setReqFightGroup(slot0, slot1)
	slot2 = slot1.fightGroup

	if slot1.isRestart then
		slot3 = FightModel.instance.last_fightGroup

		tabletool.addValues(slot2.heroList, slot3.heroList)
		tabletool.addValues(slot2.subHeroList, slot3.subHeroList)
		tabletool.addValues(slot2.equips, slot3.equips)
		tabletool.addValues(slot2.trialHeroList, slot3.trialHeroList)
		tabletool.addValues(slot2.activity104Equips, slot3.activity104Equips)
		tabletool.addValues(slot2.extraList, slot3.extraList)

		slot2.clothId = slot3.clothId
		slot2.assistHeroUid = slot3.assistHeroUid
		slot2.assistUserId = slot3.assistUserId

		return
	end

	if Activity104Model.instance:isSeasonChapter() or Activity104Model.instance:isSeasonGMChapter() then
		uv0.initFightGroup(slot2, slot0.clothId, slot0.mySideUids, slot0.mySideSubUids, slot0.equips, slot0.activity104Equips)
	elseif Season123Controller.sendEpisodeUseSeason123Equip() then
		uv0.initFightGroup(slot2, slot0.clothId, slot0.mySideUids, slot0.mySideSubUids, slot0.equips, slot0.activity104Equips)
	else
		uv0.initFightGroup(slot2, slot0.clothId, slot0.mySideUids, slot0.mySideSubUids, slot0.equips, nil, slot0.assistBossId)
	end

	tabletool.addValues(slot2.extraList, slot0.extraList)

	if slot0.assistHeroUid then
		slot2.assistHeroUid = slot0.assistHeroUid
	end

	if slot0.assistUserId then
		slot2.assistUserId = slot0.assistUserId
	end

	slot0.trialHeroList = slot2.trialHeroList
end

function slot0.initFightGroup(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 then
		slot0.clothId = slot1
	end

	if slot6 then
		slot0.assistBossId = slot6
	end

	slot7 = {}
	slot8 = slot2 and #slot2 or 0

	if slot2 then
		for slot12, slot13 in ipairs(slot2) do
			if tonumber(slot13) < 0 then
				if HeroGroupTrialModel.instance:getById(slot13) then
					slot7[slot12] = FightDef_pb.TrialHero()
					slot7[slot12].pos = slot12
					slot7[slot12].trialId = slot14.trialCo.id
				else
					table.insert(slot0.heroList, slot13)
				end
			else
				table.insert(slot0.heroList, slot13)
			end
		end
	end

	if slot3 then
		for slot12, slot13 in ipairs(slot3) do
			if tonumber(slot13) < 0 then
				if HeroGroupTrialModel.instance:getById(slot13) then
					slot7[slot12 + slot8] = FightDef_pb.TrialHero()
					slot7[slot12 + slot8].pos = -slot12
					slot7[slot12 + slot8].trialId = slot14.trialCo.id
				else
					table.insert(slot0.subHeroList, slot13)
				end
			else
				table.insert(slot0.subHeroList, slot13)
			end
		end
	end

	if slot4 then
		for slot12, slot13 in ipairs(slot4) do
			if slot7[slot12] then
				for slot17, slot18 in ipairs(slot13.equipUid) do
					table.insert(slot7[slot12].equipUid, slot18)
				end
			else
				FightDef_pb.FightEquip().heroUid = slot13.heroUid

				for slot18, slot19 in ipairs(slot13.equipUid) do
					table.insert(slot14.equipUid, slot19)
				end

				table.insert(slot0.equips, slot14)
			end
		end
	end

	if slot5 then
		for slot12, slot13 in ipairs(slot5) do
			FightDef_pb.FightEquip().heroUid = slot13.heroUid

			if slot13.equipUid then
				for slot18, slot19 in ipairs(slot13.equipUid) do
					table.insert(slot14.equipUid, slot19)

					if slot7[slot12] then
						table.insert(slot7[slot12].act104EquipUid, slot19)
					end
				end
			end

			table.insert(slot0.activity104Equips, slot14)
		end
	end

	for slot12, slot13 in pairs(slot7) do
		table.insert(slot0.trialHeroList, slot13)
	end
end

function slot0.setAssistHeroInfo(slot0, slot1, slot2)
	slot0.assistHeroUid = slot1
	slot0.assistUserId = slot2
end

function slot0.setMySide(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.clothId = slot1
	slot0.mySideUids = slot2
	slot0.mySideSubUids = slot3
	slot0.equips = slot4
	slot0.activity104Equips = slot5
	slot0.trialHeroList = slot6
	slot0.extraList = slot7
	slot0.assistBossId = slot8
end

function slot0.setEpisodeAndBattle(slot0, slot1, slot2)
	slot3 = DungeonConfig.instance:getEpisodeCO(slot1)
	slot0.name = slot3.name
	slot0.episodeId = slot1
	slot0.chapterId = slot3.chapterId

	slot0:setBattleId(slot2)
end

function slot0.setEpisodeId(slot0, slot1, slot2)
	slot3 = DungeonConfig.instance:getEpisodeCO(slot1)
	slot0.name = slot3.name
	slot0.episodeId = slot1
	slot0.chapterId = slot3.chapterId

	slot0:setBattleId(slot2 or DungeonConfig.instance:getEpisodeBattleId(slot1))
end

function slot0.setBattleId(slot0, slot1)
	slot0.battleId = slot1
	slot0.sceneIds, slot0.levelIds = FightHelper.buildSceneAndLevel(slot0.episodeId, slot1)
	slot3 = FightModel.instance:getCurWaveId()
	slot0.sceneId = slot0:getScene(slot3)
	slot0.levelId = slot0:getSceneLevel(slot3)
	slot0.monsterGroupIds = string.splitToNumber(lua_battle.configDict[slot1].monsterGroupIds, "#")
end

function slot0.getCurEpisodeConfig(slot0)
	return DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
end

function slot0.setSceneLevel(slot0, slot1)
	slot2 = lua_scene_level.configDict[slot1]
	slot0.levelIds = {
		slot1
	}
	slot0.sceneIds = {
		slot2.sceneId
	}
	slot0.sceneId = slot2.sceneId
	slot0.levelId = slot1
end

function slot0.getScene(slot0, slot1)
	if slot0.sceneIds and #slot0.sceneIds > 0 then
		if slot1 <= #slot0.sceneIds then
			return slot0.sceneIds[slot1]
		else
			return slot0.sceneIds[#slot0.sceneIds]
		end
	end
end

function slot0.getSceneLevel(slot0, slot1)
	if slot0.levelIds and #slot0.levelIds > 0 then
		if slot1 <= #slot0.levelIds then
			return slot0.levelIds[slot1]
		else
			return slot0.levelIds[#slot0.levelIds]
		end
	end

	return SceneConfig.instance:getSceneLevelCOs(slot0.sceneId)[1].id
end

function slot0.getAllHeroMoList(slot0)
	for slot5, slot6 in ipairs(slot0.mySideUids) do
		if HeroModel.instance:getById(slot6) then
			table.insert({}, slot7)
		end
	end

	for slot5, slot6 in ipairs(slot0.mySideSubUids) do
		if HeroModel.instance:getById(slot6) then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getMainHeroMoList(slot0)
	for slot5, slot6 in ipairs(slot0.mySideUids) do
		if HeroModel.instance:getById(slot6) then
			table.insert({}, slot7)
		end
	end

	if slot0.trialHeroList then
		for slot5, slot6 in ipairs(slot0.trialHeroList) do
			if slot6.pos > 0 then
				slot7 = HeroMo.New()

				slot7:initFromTrial(slot6.trialId)
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getSubHeroMoList(slot0)
	for slot5, slot6 in ipairs(slot0.mySideSubUids) do
		if HeroModel.instance:getById(slot6) then
			table.insert({}, slot7)
		end
	end

	if slot0.trialHeroList then
		for slot5, slot6 in ipairs(slot0.trialHeroList) do
			if slot6.pos < 0 then
				slot7 = HeroMo.New()

				slot7:initFromTrial(slot6.trialId)
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getEquipMoList(slot0)
	for slot5, slot6 in ipairs(slot0.equips) do
		table.insert({}, EquipModel.instance:getEquip(slot6.equipUid[1]))
	end

	if slot0.trialHeroList then
		for slot5, slot6 in ipairs(slot0.trialHeroList) do
			if lua_hero_trial.configDict[slot6.trialId][0] and slot7.equipId > 0 then
				slot8 = EquipMO.New()

				slot8:initByTrialCO(slot7)
				table.insert(slot1, slot8)
			end
		end
	end

	return slot1
end

function slot0.getHeroEquipMoList(slot0)
	slot1 = {}
	slot2 = {
		[slot7.heroUid] = EquipModel.instance:getEquip(slot7.equipUid[1])
	}

	for slot6, slot7 in ipairs(slot0.equips) do
		-- Nothing
	end

	for slot6, slot7 in ipairs(slot0.mySideUids) do
		if HeroModel.instance:getById(slot7) then
			table.insert(slot1, {
				heroMo = slot8,
				equipMo = slot2[slot8.uid]
			})
		end
	end

	for slot6, slot7 in ipairs(slot0.mySideSubUids) do
		if HeroModel.instance:getById(slot7) then
			table.insert(slot1, {
				heroMo = slot8,
				equipMo = slot2[slot8.uid]
			})
		end
	end

	if slot0.trialHeroList then
		for slot6, slot7 in ipairs(slot0.trialHeroList) do
			if lua_hero_trial.configDict[slot7.trialId][0] and slot8.equipId > 0 then
				slot9 = EquipMO.New()

				slot9:initByTrialCO(slot8)

				slot10 = HeroMo.New()

				slot10:initFromTrial(slot7.trialId)
				table.insert(slot1, {
					heroMo = slot10,
					equipMo = slot9
				})
			end
		end
	end

	return slot1
end

function slot0.getHeroEquipMoListWithTrial(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {
		[slot8.heroUid] = EquipModel.instance:getEquip(slot8.equipUid[1])
	}

	for slot7, slot8 in ipairs(slot0.equips) do
		-- Nothing
	end

	for slot7, slot8 in ipairs(slot0.mySideUids) do
		if HeroModel.instance:getById(slot8) or FightHelper.getAssitHeroInfoByUid(slot8) then
			table.insert(slot1, {
				heroMo = slot9,
				equipMo = slot3[slot8]
			})
		end
	end

	for slot7, slot8 in ipairs(slot0.mySideSubUids) do
		if HeroModel.instance:getById(slot8) or FightHelper.getAssitHeroInfoByUid(slot8, true) then
			table.insert(slot2, {
				heroMo = slot9,
				equipMo = slot3[slot8]
			})
		end
	end

	if slot0.trialHeroList then
		for slot7, slot8 in ipairs(slot0.trialHeroList) do
			if lua_hero_trial.configDict[slot8.trialId][0] and slot9.equipId > 0 then
				slot10 = EquipMO.New()

				slot10:initByTrialCO(slot9)

				slot11 = HeroMo.New()

				slot11:initFromTrial(slot8.trialId)

				if slot8.pos > 0 then
					table.insert(slot1, {
						heroMo = slot11,
						equipMo = slot10
					})
				else
					table.insert(slot2, slot12)
				end
			end
		end
	end

	return slot1, slot2
end

return slot0
