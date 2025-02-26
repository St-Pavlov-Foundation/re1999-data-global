module("modules.logic.ressplit.work.ResSplitChapterWork", package.seeall)

slot0 = class("ResSplitChapterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0:_buildMapData()

	for slot6, slot7 in pairs(DungeonConfig.instance._episodeConfig.configDict) do
		if slot7.type ~= DungeonEnum.EpisodeType.WeekWalk then
			slot9 = {}

			if DungeonConfig.instance:getBattleCo(slot7.id) then
				ResSplitHelper.checkConfigEmpty(string.format("Character:%d", slot8.id), "sceneIds", slot8.sceneIds)

				for slot14, slot15 in ipairs(string.splitToNumber(slot8.sceneIds, "#")) do
					if SceneConfig.instance:getSceneLevelCOs(slot15) then
						table.insert(slot9, slot16[1].id)
					end
				end
			end

			if not ResSplitModel.instance:isExcludeChapter(slot7.chapterId) then
				ResSplitModel.instance:addIncludeStory(slot7.beforeStory)

				if #string.split(slot7.story, "#") == 3 then
					ResSplitModel.instance:addIncludeStory(tonumber(slot11[3]))
				end

				ResSplitModel.instance:addIncludeStory(slot7.afterStory)

				if slot8 then
					slot0:_getBattleMonsterSkins(slot8)
				end
			end

			slot0:_addMapRes(slot7, slot10)

			if not ResSplitEnum.SplitAllScene and slot8 then
				for slot14, slot15 in pairs(slot9) do
					slot0:_addSceneRes(slot15, slot10)
				end
			end
		end
	end

	slot0:onDone(true)
end

function slot0._addSceneRes(slot0, slot1, slot2)
	slot3 = lua_scene_level.configDict[slot1]

	ResSplitHelper.checkConfigEmpty(string.format("levelId:%d", slot1), "resName", slot3.resName)

	if slot2 then
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, ResUrl.getSceneRes(slot3.resName), true)
	else
		ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, slot4, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, slot4, false)
	end

	if ResSplitModel.instance.audioDic[slot3.bgm] then
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, slot6.bankName, slot2)
	end
end

function slot0._getBattleMonsterSkins(slot0, slot1)
	if slot1 then
		for slot6, slot7 in ipairs(string.splitToNumber(slot1.monsterGroupIds, "#")) do
			if lua_monster_group.configDict[slot7] then
				for slot13, slot14 in ipairs(string.splitToNumber(slot8.monster, "#")) do
					if slot14 and lua_monster.configDict[slot14] then
						ResSplitModel.instance:addIncludeSkin(slot15.skinId)

						for slot20, slot21 in ipairs(FightHelper.buildSkills(slot14)) do
							ResSplitModel.instance:addIncludeSkill(slot21)
						end
					else
						logError(string.format("怪物不存在 battle_%d monsterGroup_%d monster_%d", slot1.id, slot7, slot14))
					end
				end
			end
		end

		slot3 = {}

		if not string.nilorempty(slot1.aid) then
			slot3 = string.splitToNumber(slot1.aid, "#")
		end

		for slot7, slot8 in ipairs(slot3) do
			ResSplitModel.instance:addIncludeSkin((slot8 and lua_monster.configDict[slot8]).skinId)

			for slot14, slot15 in ipairs(FightHelper.buildSkills(slot8)) do
				ResSplitModel.instance:addIncludeSkill(slot15)
			end
		end
	end
end

function slot0._buildMapData(slot0)
	slot0._mapElementResDic = {}

	for slot5, slot6 in pairs(lua_chapter_map_element.configDict) do
		if slot0._mapElementResDic[slot6.mapId] == nil then
			slot0._mapElementResDic[slot6.mapId] = {}
		end

		if string.nilorempty(slot6.res) == false then
			table.insert(slot0._mapElementResDic[slot6.mapId], slot6.res)
		end

		if string.nilorempty(slot6.effect) == false then
			table.insert(slot0._mapElementResDic[slot6.mapId], slot6.effect)
		end
	end
end

function slot0._addMapRes(slot0, slot1, slot2)
	if DungeonConfig.instance:getChapterMapCfg(slot1.chapterId, slot1.id) then
		slot4 = ResUrl.getDungeonMapRes(slot3.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot4, slot2)
		slot0:_addDependRes(slot4, slot2, slot3.id)

		if slot0._mapElementResDic[slot3.id] then
			for slot9, slot10 in ipairs(slot5) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot10, slot2)
				slot0:_addDependRes(slot10, slot2, slot3.id)
			end
		end
	end
end

slot1 = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function slot0._addDependRes(slot0, slot1, slot2, slot3)
	for slot8 = 0, ZProj.AssetDatabaseHelper.GetDependencies(SLFramework.FrameworkSettings.GetEditorResPath(slot1), true).Length - 1 do
		slot9 = slot4[slot8]

		if string.find(slot9, "_hddt") and uv0[string.match(slot9, ".+%.(%w+)$")] then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, string.gsub(slot9, SLFramework.FrameworkSettings.AssetRootDir .. "/", ""), slot2)
		end
	end
end

return slot0
