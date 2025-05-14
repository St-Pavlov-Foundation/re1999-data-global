module("modules.logic.ressplit.work.ResSplitChapterWork", package.seeall)

local var_0_0 = class("ResSplitChapterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DungeonConfig.instance._episodeConfig.configDict

	arg_1_0:_buildMapData()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.type == DungeonEnum.EpisodeType.WeekWalk then
			-- block empty
		else
			local var_1_1 = DungeonConfig.instance:getBattleCo(iter_1_1.id)
			local var_1_2 = {}

			if var_1_1 then
				ResSplitHelper.checkConfigEmpty(string.format("Character:%d", var_1_1.id), "sceneIds", var_1_1.sceneIds)

				local var_1_3 = string.splitToNumber(var_1_1.sceneIds, "#")

				for iter_1_2, iter_1_3 in ipairs(var_1_3) do
					local var_1_4 = SceneConfig.instance:getSceneLevelCOs(iter_1_3)

					if var_1_4 then
						local var_1_5 = var_1_4[1].id

						table.insert(var_1_2, var_1_5)
					end
				end
			end

			local var_1_6 = ResSplitModel.instance:isExcludeChapter(iter_1_1.chapterId)

			if var_1_6 then
				-- block empty
			else
				ResSplitModel.instance:addIncludeStory(iter_1_1.beforeStory)

				local var_1_7 = string.split(iter_1_1.story, "#")

				if #var_1_7 == 3 then
					ResSplitModel.instance:addIncludeStory(tonumber(var_1_7[3]))
				end

				ResSplitModel.instance:addIncludeStory(iter_1_1.afterStory)

				if var_1_1 then
					arg_1_0:_getBattleMonsterSkins(var_1_1)
				end
			end

			arg_1_0:_addMapRes(iter_1_1, var_1_6)

			if not ResSplitEnum.SplitAllScene and var_1_1 then
				for iter_1_4, iter_1_5 in pairs(var_1_2) do
					arg_1_0:_addSceneRes(iter_1_5, var_1_6)
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._addSceneRes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = lua_scene_level.configDict[arg_2_1]

	ResSplitHelper.checkConfigEmpty(string.format("levelId:%d", arg_2_1), "resName", var_2_0.resName)

	local var_2_1 = ResUrl.getSceneRes(var_2_0.resName)

	if arg_2_2 then
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_2_1, true)
	else
		ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, var_2_1, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_2_1, false)
	end

	local var_2_2 = var_2_0.bgm
	local var_2_3 = ResSplitModel.instance.audioDic[var_2_2]

	if var_2_3 then
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, var_2_3.bankName, arg_2_2)
	end
end

function var_0_0._getBattleMonsterSkins(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = string.splitToNumber(arg_3_1.monsterGroupIds, "#")

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_1 = lua_monster_group.configDict[iter_3_1]

			if var_3_1 then
				local var_3_2 = string.splitToNumber(var_3_1.monster, "#")

				for iter_3_2, iter_3_3 in ipairs(var_3_2) do
					local var_3_3 = iter_3_3 and lua_monster.configDict[iter_3_3]

					if var_3_3 then
						ResSplitModel.instance:addIncludeSkin(var_3_3.skinId)

						local var_3_4 = FightHelper.buildSkills(iter_3_3)

						for iter_3_4, iter_3_5 in ipairs(var_3_4) do
							ResSplitModel.instance:addIncludeSkill(iter_3_5)
						end
					else
						logError(string.format("怪物不存在 battle_%d monsterGroup_%d monster_%d", arg_3_1.id, iter_3_1, iter_3_3))
					end
				end
			end
		end

		local var_3_5 = {}

		if not string.nilorempty(arg_3_1.aid) then
			var_3_5 = string.splitToNumber(arg_3_1.aid, "#")
		end

		for iter_3_6, iter_3_7 in ipairs(var_3_5) do
			local var_3_6 = iter_3_7 and lua_monster.configDict[iter_3_7]

			ResSplitModel.instance:addIncludeSkin(var_3_6.skinId)

			local var_3_7 = FightHelper.buildSkills(iter_3_7)

			for iter_3_8, iter_3_9 in ipairs(var_3_7) do
				ResSplitModel.instance:addIncludeSkill(iter_3_9)
			end
		end
	end
end

function var_0_0._buildMapData(arg_4_0)
	local var_4_0 = lua_chapter_map_element.configDict

	arg_4_0._mapElementResDic = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if arg_4_0._mapElementResDic[iter_4_1.mapId] == nil then
			arg_4_0._mapElementResDic[iter_4_1.mapId] = {}
		end

		if string.nilorempty(iter_4_1.res) == false then
			table.insert(arg_4_0._mapElementResDic[iter_4_1.mapId], iter_4_1.res)
		end

		if string.nilorempty(iter_4_1.effect) == false then
			table.insert(arg_4_0._mapElementResDic[iter_4_1.mapId], iter_4_1.effect)
		end
	end
end

function var_0_0._addMapRes(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = DungeonConfig.instance:getChapterMapCfg(arg_5_1.chapterId, arg_5_1.id)

	if var_5_0 then
		local var_5_1 = ResUrl.getDungeonMapRes(var_5_0.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_5_1, arg_5_2)
		arg_5_0:_addDependRes(var_5_1, arg_5_2, var_5_0.id)

		local var_5_2 = arg_5_0._mapElementResDic[var_5_0.id]

		if var_5_2 then
			for iter_5_0, iter_5_1 in ipairs(var_5_2) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, iter_5_1, arg_5_2)
				arg_5_0:_addDependRes(iter_5_1, arg_5_2, var_5_0.id)
			end
		end
	end
end

local var_0_1 = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function var_0_0._addDependRes(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_1 = SLFramework.FrameworkSettings.GetEditorResPath(arg_6_1)

	local var_6_0 = ZProj.AssetDatabaseHelper.GetDependencies(arg_6_1, true)

	for iter_6_0 = 0, var_6_0.Length - 1 do
		local var_6_1 = var_6_0[iter_6_0]
		local var_6_2 = string.match(var_6_1, ".+%.(%w+)$")

		if string.find(var_6_1, "_hddt") and var_0_1[var_6_2] then
			local var_6_3 = string.gsub(var_6_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_3, arg_6_2)
		end
	end
end

return var_0_0
