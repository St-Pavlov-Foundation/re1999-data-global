module("modules.logic.ressplit.controller.ResSplitHelper", package.seeall)

slot0 = _M

function slot0.init()
end

function slot0.createExcludeConfig()
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot11, slot12 in pairs(ResSplitConfig.instance:getAppIncludeConfig()) do
		for slot16, slot17 in pairs(slot12.character) do
			slot1[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.chapter) do
			slot2[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.story) do
			slot3[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.guide) do
			slot4[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.video) do
			slot5[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.path) do
			slot6[slot17] = true
		end

		for slot16, slot17 in pairs(slot12.seasonIds) do
			slot7[slot17] = true
		end
	end

	uv0._buildMapData()
	ResSplitModel.instance:init(slot1, slot2, AudioConfig.instance:getAudioCO(), slot3, slot4, slot5, slot6, slot7)

	slot9 = FlowSequence.New()

	slot9:addWork(ResSplitUIWork.New())
	slot9:addWork(ResSplitSeasonWork.New())
	slot9:addWork(ResSplitRoleStoryWork.New())
	slot9:addWork(ResSplitChapterWork.New())
	slot9:addWork(ResSplitWeekWalkWork.New())
	slot9:addWork(ResSplitCharacterWork.New())
	slot9:addWork(ResSplitStoryWork.New())
	slot9:addWork(ResSplitRoomWork.New())
	slot9:addWork(ResSplitSceneWork.New())
	slot9:addWork(ResSplitSkillWork.New())
	slot9:addWork(ResSplitAudioWemWork.New())
	slot9:addWork(ResSplitSpecialWork.New())
	slot9:addWork(ResSplitExportWork.New())
	slot9:start()
end

function slot0.checkConfigEmpty(slot0, slot1, slot2)
	if string.nilorempty(slot2) then
		logError("config Empty", slot0, slot1)
	end
end

function slot0.addEpisodeRes(slot0)
	if DungeonConfig.instance._episodeConfig.configDict[slot0] then
		slot3 = {}

		if DungeonConfig.instance:getBattleCo(slot1.id) then
			uv0.checkConfigEmpty(string.format("Character:%d", slot2.id), "sceneIds", slot2.sceneIds)

			for slot8, slot9 in ipairs(string.splitToNumber(slot2.sceneIds, "#")) do
				if SceneConfig.instance:getSceneLevelCOs(slot9) then
					table.insert(slot3, slot10[1].id)
				end
			end
		end

		if not false then
			ResSplitModel.instance:addIncludeStory(slot1.beforeStory)

			if #string.split(slot1.story, "#") == 3 then
				ResSplitModel.instance:addIncludeStory(tonumber(slot5[3]))
			end

			ResSplitModel.instance:addIncludeStory(slot1.afterStory)

			if slot2 then
				uv0.addBattleMonsterSkins(slot2)
			end
		end

		uv0.addMapRes(slot1, slot4)

		if not ResSplitEnum.SplitAllScene and slot2 then
			for slot8, slot9 in pairs(slot3) do
				uv0.addSceneRes(slot9, slot4)
			end
		end
	end
end

function slot0.addMapRes(slot0, slot1)
	if DungeonConfig.instance:getChapterMapCfg(slot0.chapterId, slot0.id) then
		slot3 = ResUrl.getDungeonMapRes(slot2.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot3, slot1)
		uv0._addDependRes(slot3, slot1, slot2.id)

		if uv0._mapElementResDic[slot2.id] then
			for slot8, slot9 in ipairs(slot4) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot9, slot1)
				uv0._addDependRes(slot9, slot1, slot2.id)
			end
		end
	end
end

function slot0.addSceneRes(slot0, slot1)
	slot2 = lua_scene_level.configDict[slot0]

	uv0.checkConfigEmpty(string.format("levelId:%d", slot0), "resName", slot2.resName)

	if slot1 then
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, ResUrl.getSceneRes(slot2.resName), true)
	else
		ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, slot3, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, slot3, false)
	end

	if ResSplitModel.instance.audioDic[slot2.bgm] then
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, slot5.bankName, slot1)
	end
end

function slot0.addBattleMonsterSkins(slot0)
	if slot0 then
		for slot5, slot6 in ipairs(string.splitToNumber(slot0.monsterGroupIds, "#")) do
			for slot12, slot13 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot6].monster, "#")) do
				ResSplitModel.instance:addIncludeSkin((slot13 and lua_monster.configDict[slot13]).skinId)

				for slot19, slot20 in ipairs(FightHelper.buildSkills(slot13)) do
					ResSplitModel.instance:addIncludeSkill(slot20)
				end
			end
		end

		slot2 = {}

		if not string.nilorempty(slot0.aid) then
			slot2 = string.splitToNumber(slot0.aid, "#")
		end

		for slot6, slot7 in ipairs(slot2) do
			ResSplitModel.instance:addIncludeSkin((slot7 and lua_monster.configDict[slot7]).skinId)

			for slot13, slot14 in ipairs(FightHelper.buildSkills(slot7)) do
				ResSplitModel.instance:addIncludeSkill(slot14)
			end
		end
	end
end

slot0._DependResExtDic = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function slot0._addDependRes(slot0, slot1, slot2)
	for slot7 = 0, ZProj.AssetDatabaseHelper.GetDependencies(SLFramework.FrameworkSettings.GetEditorResPath(slot0), true).Length - 1 do
		slot8 = slot3[slot7]

		if string.find(slot8, "scenes/m_s08_hddt/") and uv0._DependResExtDic[string.match(slot8, ".+%.(%w+)$")] then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, string.gsub(slot8, SLFramework.FrameworkSettings.AssetRootDir .. "/", ""), slot1)
		end
	end
end

function slot0._buildMapData()
	uv0._mapElementResDic = {}

	for slot4, slot5 in pairs(lua_chapter_map_element.configDict) do
		if uv0._mapElementResDic[slot5.mapId] == nil then
			uv0._mapElementResDic[slot5.mapId] = {}
		end

		if string.nilorempty(slot5.res) == false then
			table.insert(uv0._mapElementResDic[slot5.mapId], slot5.res)
		end

		if string.nilorempty(slot5.effect) == false then
			table.insert(uv0._mapElementResDic[slot5.mapId], slot5.effect)
		end
	end
end

return slot0
