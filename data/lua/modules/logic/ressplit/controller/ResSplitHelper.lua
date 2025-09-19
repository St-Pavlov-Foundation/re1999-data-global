module("modules.logic.ressplit.controller.ResSplitHelper", package.seeall)

local var_0_0 = _M

function var_0_0.init()
	return
end

function var_0_0.createExcludeConfig()
	local var_2_0 = ResSplitConfig.instance:getAppIncludeConfig()
	local var_2_1 = {}
	local var_2_2 = {}
	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = {}
	local var_2_6 = {}
	local var_2_7 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1.character) do
			var_2_1[iter_2_3] = true
		end

		for iter_2_4, iter_2_5 in pairs(iter_2_1.chapter) do
			var_2_2[iter_2_5] = true
		end

		for iter_2_6, iter_2_7 in pairs(iter_2_1.story) do
			var_2_3[iter_2_7] = true
		end

		for iter_2_8, iter_2_9 in pairs(iter_2_1.guide) do
			var_2_4[iter_2_9] = true
		end

		for iter_2_10, iter_2_11 in pairs(iter_2_1.video) do
			var_2_5[iter_2_11] = true
		end

		for iter_2_12, iter_2_13 in pairs(iter_2_1.path) do
			var_2_6[iter_2_13] = true
		end

		for iter_2_14, iter_2_15 in pairs(iter_2_1.seasonIds) do
			var_2_7[iter_2_15] = true
		end
	end

	local var_2_8 = AudioConfig.instance:getAudioCO()

	var_0_0._buildMapData()
	ResSplitModel.instance:init(var_2_1, var_2_2, var_2_8, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7)

	local var_2_9 = FlowSequence.New()

	var_2_9:addWork(ResSplitUIWork.New())
	var_2_9:addWork(ResSplitSeasonWork.New())
	var_2_9:addWork(ResSplitRoleStoryWork.New())
	var_2_9:addWork(ResSplitChapterWork.New())
	var_2_9:addWork(ResSplitWeekWalkWork.New())
	var_2_9:addWork(ResSplitCharacterWork.New())
	var_2_9:addWork(ResSplitStoryWork.New())
	var_2_9:addWork(ResSplitRoomWork.New())
	var_2_9:addWork(ResSplitSceneWork.New())
	var_2_9:addWork(ResSplitSkillWork.New())
	var_2_9:addWork(ResSplitAudioWemWork.New())
	var_2_9:addWork(ResSplitSpecialWork.New())
	var_2_9:addWork(ResSplitExportWork.New())
	var_2_9:start()
end

function var_0_0.checkConfigEmpty(arg_3_0, arg_3_1, arg_3_2)
	if string.nilorempty(arg_3_2) then
		logError("config Empty", arg_3_0, arg_3_1)
	end
end

function var_0_0.addEpisodeRes(arg_4_0)
	local var_4_0 = DungeonConfig.instance._episodeConfig.configDict[arg_4_0]

	if var_4_0 then
		local var_4_1 = DungeonConfig.instance:getBattleCo(var_4_0.id)
		local var_4_2 = {}

		if var_4_1 then
			var_0_0.checkConfigEmpty(string.format("Character:%d", var_4_1.id), "sceneIds", var_4_1.sceneIds)

			local var_4_3 = string.splitToNumber(var_4_1.sceneIds, "#")

			for iter_4_0, iter_4_1 in ipairs(var_4_3) do
				local var_4_4 = SceneConfig.instance:getSceneLevelCOs(iter_4_1)

				if var_4_4 then
					local var_4_5 = var_4_4[1].id

					table.insert(var_4_2, var_4_5)
				end
			end
		end

		local var_4_6 = false

		if var_4_6 then
			-- block empty
		else
			ResSplitModel.instance:addIncludeStory(var_4_0.beforeStory)

			local var_4_7 = string.split(var_4_0.story, "#")

			if #var_4_7 == 3 then
				ResSplitModel.instance:addIncludeStory(tonumber(var_4_7[3]))
			end

			ResSplitModel.instance:addIncludeStory(var_4_0.afterStory)

			if var_4_1 then
				var_0_0.addBattleMonsterSkins(var_4_1)
			end
		end

		var_0_0.addMapRes(var_4_0, var_4_6)

		if not ResSplitEnum.SplitAllScene and var_4_1 then
			for iter_4_2, iter_4_3 in pairs(var_4_2) do
				var_0_0.addSceneRes(iter_4_3, var_4_6)
			end
		end
	end
end

function var_0_0.addMapRes(arg_5_0, arg_5_1)
	local var_5_0 = DungeonMapEpisodeItem.getMap(arg_5_0)

	if var_5_0 then
		local var_5_1 = ResUrl.getDungeonMapRes(var_5_0.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_5_1, arg_5_1)
		var_0_0._addDependRes(var_5_1, arg_5_1, var_5_0.id)

		local var_5_2 = var_0_0._mapElementResDic[var_5_0.id]

		if var_5_2 then
			for iter_5_0, iter_5_1 in ipairs(var_5_2) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, iter_5_1, arg_5_1)
				var_0_0._addDependRes(iter_5_1, arg_5_1, var_5_0.id)
			end
		end

		local var_5_3 = var_0_0._mapElementFragmentDic[var_5_0.id]

		if var_5_3 then
			for iter_5_2, iter_5_3 in pairs(var_5_3) do
				local var_5_4 = lua_chapter_map_fragment.configDict[iter_5_2]

				if not string.nilorempty(var_5_4.res) then
					local var_5_5 = ResUrl.getDungeonFragmentIcon(var_5_4.res)

					ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_5_5, arg_5_1)
				end
			end
		end
	end
end

function var_0_0.addSceneRes(arg_6_0, arg_6_1)
	local var_6_0 = lua_scene_level.configDict[arg_6_0]

	var_0_0.checkConfigEmpty(string.format("levelId:%d", arg_6_0), "resName", var_6_0.resName)

	local var_6_1 = ResUrl.getSceneRes(var_6_0.resName)

	if arg_6_1 then
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_6_1, true)
	else
		ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, var_6_1, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_6_1, false)
	end

	local var_6_2 = var_6_0.bgm
	local var_6_3 = ResSplitModel.instance.audioDic[var_6_2]

	if var_6_3 then
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, var_6_3.bankName, arg_6_1)
	end
end

function var_0_0.addBattleMonsterSkins(arg_7_0)
	if arg_7_0 then
		local var_7_0 = string.splitToNumber(arg_7_0.monsterGroupIds, "#")

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			local var_7_1 = lua_monster_group.configDict[iter_7_1]
			local var_7_2 = string.splitToNumber(var_7_1.monster, "#")

			for iter_7_2, iter_7_3 in ipairs(var_7_2) do
				local var_7_3 = iter_7_3 and lua_monster.configDict[iter_7_3]

				ResSplitModel.instance:addIncludeSkin(var_7_3.skinId)

				local var_7_4 = FightHelper.buildSkills(iter_7_3)

				for iter_7_4, iter_7_5 in ipairs(var_7_4) do
					ResSplitModel.instance:addIncludeSkill(iter_7_5)
				end
			end
		end

		local var_7_5 = {}

		if not string.nilorempty(arg_7_0.aid) then
			var_7_5 = string.splitToNumber(arg_7_0.aid, "#")
		end

		for iter_7_6, iter_7_7 in ipairs(var_7_5) do
			local var_7_6 = iter_7_7 and lua_monster.configDict[iter_7_7]

			ResSplitModel.instance:addIncludeSkin(var_7_6.skinId)

			local var_7_7 = FightHelper.buildSkills(iter_7_7)

			for iter_7_8, iter_7_9 in ipairs(var_7_7) do
				ResSplitModel.instance:addIncludeSkill(iter_7_9)
			end
		end
	end
end

var_0_0._DependResExtDic = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function var_0_0._addDependRes(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0 = SLFramework.FrameworkSettings.GetEditorResPath(arg_8_0)

	local var_8_0 = ZProj.AssetDatabaseHelper.GetDependencies(arg_8_0, true)

	for iter_8_0 = 0, var_8_0.Length - 1 do
		local var_8_1 = var_8_0[iter_8_0]
		local var_8_2 = string.match(var_8_1, ".+%.(%w+)$")

		if string.find(var_8_1, "scenes/m_s08_hddt/") and var_0_0._DependResExtDic[var_8_2] then
			local var_8_3 = string.gsub(var_8_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_8_3, arg_8_1)
		end
	end
end

function var_0_0._buildMapData()
	local var_9_0 = lua_chapter_map_element.configDict

	var_0_0._mapElementResDic = {}
	var_0_0._mapElementFragmentDic = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if var_0_0._mapElementResDic[iter_9_1.mapId] == nil then
			var_0_0._mapElementResDic[iter_9_1.mapId] = {}
		end

		if string.nilorempty(iter_9_1.res) == false then
			table.insert(var_0_0._mapElementResDic[iter_9_1.mapId], iter_9_1.res)
		end

		if string.nilorempty(iter_9_1.effect) == false then
			table.insert(var_0_0._mapElementResDic[iter_9_1.mapId], iter_9_1.effect)
		end

		if iter_9_1.fragment > 0 then
			if var_0_0._mapElementFragmentDic[iter_9_1.mapId] == nil then
				var_0_0._mapElementFragmentDic[iter_9_1.mapId] = {}
			end

			var_0_0._mapElementFragmentDic[iter_9_1.mapId][iter_9_1.fragment] = true
		end
	end
end

return var_0_0
