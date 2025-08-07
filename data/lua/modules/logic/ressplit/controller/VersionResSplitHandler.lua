module("modules.logic.ressplit.controller.VersionResSplitHandler", package.seeall)

local var_0_0 = ResSplitEnum.VersionResEnum
local var_0_1 = class("VersionResSplitHandler")

function var_0_1.generateResSplitCfg(arg_1_0)
	arg_1_0:_InitMapElementData()
	arg_1_0:_InitAudioCfg()
	arg_1_0:_InitAudioInfoXml()
	arg_1_0:_InitGuideCfg()
	arg_1_0:_InitStoryCfg()
	arg_1_0:_loadAllStoryCfg(arg_1_0._generateResSplitCfg, arg_1_0)
end

function var_0_1._generateResSplitCfg(arg_2_0)
	local var_2_0 = lua_version_res_split.configDict

	arg_2_0._resSplitResult = {}
	arg_2_0._versionSplitData = {}
	arg_2_0._allVersionSplitPathMap = {}

	local var_2_1 = {}
	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_4 = iter_2_1.chapter

		for iter_2_2, iter_2_3 in ipairs(var_2_4) do
			var_2_1[iter_2_3] = true
		end

		local var_2_5 = iter_2_1.uiFolder

		for iter_2_4, iter_2_5 in ipairs(var_2_5) do
			local var_2_6 = var_0_1._getFolderPrefabs(iter_2_5)

			for iter_2_6, iter_2_7 in ipairs(var_2_6) do
				var_2_2[iter_2_7] = true
			end
		end

		local var_2_7 = iter_2_1.story

		for iter_2_8, iter_2_9 in ipairs(var_2_7) do
			var_2_3[iter_2_9] = true
		end
	end

	for iter_2_10, iter_2_11 in pairs(var_2_1) do
		local var_2_8 = DungeonConfig.instance:getChapterEpisodeCOList(iter_2_10)

		if var_2_8 then
			for iter_2_12, iter_2_13 in ipairs(var_2_8) do
				local var_2_9 = iter_2_13.beforeStory

				if var_2_9 ~= 0 then
					var_2_3[var_2_9] = true
				end

				local var_2_10 = string.split(iter_2_13.story, "#")

				if #var_2_10 == 3 then
					var_2_3[tonumber(var_2_10[3])] = true
				end

				local var_2_11 = iter_2_13.afterStory

				if var_2_11 ~= 0 then
					var_2_3[var_2_11] = true
				end
			end
		end
	end

	local var_2_12 = VersionResSplitData.New()

	var_2_12:init(0)

	local var_2_13 = lua_chapter.configList

	for iter_2_14, iter_2_15 in ipairs(var_2_13) do
		if not var_2_1[iter_2_14] then
			arg_2_0:_fillSceneResByChatper(iter_2_14, var_2_12)
		end
	end

	local var_2_14 = "ui/viewres"
	local var_2_15 = var_0_1._getFolderPrefabs(var_2_14)

	for iter_2_16, iter_2_17 in ipairs(var_2_15) do
		if not var_2_2[iter_2_17] then
			arg_2_0:_fillUIRes(iter_2_17, var_2_12)
		end
	end

	for iter_2_18, iter_2_19 in ipairs(arg_2_0._allStoryIds) do
		if not var_2_3[iter_2_19] then
			arg_2_0:_fillStoryRes(iter_2_19, var_2_12)
		end
	end

	for iter_2_20, iter_2_21 in pairs(var_2_0) do
		local var_2_16 = VersionResSplitData.New()

		var_2_16:init(iter_2_20)

		arg_2_0._versionSplitData[iter_2_20] = var_2_16

		local var_2_17 = iter_2_21.chapter

		for iter_2_22, iter_2_23 in ipairs(var_2_17) do
			arg_2_0:_fillSceneResByChatper(iter_2_23, var_2_16)
			arg_2_0:_fillStoryResByChatper(iter_2_23, var_2_16)
		end

		local var_2_18 = iter_2_21.audio

		for iter_2_24, iter_2_25 in ipairs(var_2_18) do
			arg_2_0:_fillAudioResByAudioId(iter_2_25, var_2_16)
		end

		local var_2_19 = iter_2_21.guide

		for iter_2_26, iter_2_27 in ipairs(var_2_19) do
			arg_2_0:_fillResByGuideId(iter_2_27, var_2_16)
		end

		local var_2_20 = iter_2_21.story

		for iter_2_28, iter_2_29 in ipairs(var_2_20) do
			arg_2_0:_fillStoryRes(iter_2_29, var_2_16)
		end

		local var_2_21 = iter_2_21.uiFolder

		for iter_2_30, iter_2_31 in ipairs(var_2_21) do
			iter_2_31 = string.gsub(iter_2_31, SLFramework.FrameworkSettings.ResourcesLibName .. "/", "")

			local var_2_22 = var_0_1._getFolderPrefabs(iter_2_31)

			for iter_2_32, iter_2_33 in ipairs(var_2_22) do
				arg_2_0:_fillUIRes(iter_2_33, var_2_16)
			end
		end

		local var_2_23 = iter_2_21.folderPath

		for iter_2_34, iter_2_35 in ipairs(var_2_23) do
			var_2_16:addResSplitInfo(ResSplitEnum.Folder, var_0_0.SingleFolder, iter_2_35)
		end

		local var_2_24 = iter_2_21.path

		for iter_2_36, iter_2_37 in ipairs(var_2_24) do
			var_2_16:addResSplitInfo(ResSplitEnum.Path, var_0_0.SingleFile, iter_2_37)
		end

		local var_2_25 = iter_2_21.videoPath or {}

		for iter_2_38, iter_2_39 in ipairs(var_2_25) do
			var_2_16:addResSplitInfo(ResSplitEnum.Video, var_0_0.SingleFile, iter_2_39)
		end

		local var_2_26 = var_2_16:getAllResDict()

		for iter_2_40, iter_2_41 in pairs(var_2_26) do
			for iter_2_42, iter_2_43 in pairs(iter_2_41) do
				if var_2_12:checkResSplitInfo(iter_2_40, iter_2_42) then
					var_2_16:deleteResSplitInfo(iter_2_40, nil, iter_2_42)
				end
			end
		end

		local var_2_27 = var_2_16:getAllResTypeDict()

		for iter_2_44, iter_2_45 in pairs(var_2_27) do
			for iter_2_46, iter_2_47 in pairs(iter_2_45) do
				if var_2_12:checkResTypeSplitInfo(iter_2_44, iter_2_46) then
					var_2_16:deleteResSplitInfo(nil, iter_2_44, iter_2_46)
				end
			end
		end
	end

	for iter_2_48, iter_2_49 in pairs(arg_2_0._versionSplitData) do
		local var_2_28 = iter_2_49:getAllResDict()

		for iter_2_50, iter_2_51 in pairs(var_2_28) do
			for iter_2_52, iter_2_53 in pairs(iter_2_51) do
				if iter_2_53 then
					if arg_2_0._allVersionSplitPathMap[iter_2_52] then
						logWarn("存在于多个版本分包中的资源： " .. iter_2_52)
					else
						arg_2_0._allVersionSplitPathMap[iter_2_52] = true
					end
				end
			end
		end
	end

	arg_2_0:_ExportSplitResult()
end

function var_0_1._mergeSplitResult(arg_3_0)
	local var_3_0 = lua_version_res_split.configDict
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0._versionSplitData) do
		local var_3_2 = var_3_0[iter_3_0] or var_3_0[tonumber(iter_3_0)]
		local var_3_3 = var_3_2 and var_3_2.packName or "opveract"

		if not var_3_1[var_3_3] then
			var_3_1[var_3_3] = {}
		end

		local var_3_4 = var_3_1[var_3_3]
		local var_3_5 = iter_3_1:getResSplitMap()

		for iter_3_2, iter_3_3 in pairs(var_3_5) do
			if not var_3_4[iter_3_2] then
				var_3_4[iter_3_2] = {}
			end

			tabletool.addValues(var_3_4[iter_3_2], iter_3_3)
		end
	end

	local var_3_6 = arg_3_0:_getResWhiteListDict()

	for iter_3_4, iter_3_5 in pairs(var_3_1) do
		if iter_3_5.pathList then
			arg_3_0:_checkResWhiteList(iter_3_5.pathList, var_3_6)
		end
	end

	return var_3_1
end

function var_0_1._checkSingleBgAb(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0 = #arg_4_1, 1, -1 do
		local var_4_1 = arg_4_1[iter_4_0]

		if string.find(var_4_1, "singlebg") then
			local var_4_2 = string.format("Assets/ZResourcesLib/%s", string.gsub(var_4_1, "\\/", "/"))

			table.remove(arg_4_1, iter_4_0)

			var_4_0[var_4_2] = var_4_1
		end
	end

	local var_4_3 = {}

	for iter_4_1, iter_4_2 in pairs(arg_4_2) do
		local var_4_4 = true

		for iter_4_3, iter_4_4 in ipairs(iter_4_2) do
			if not var_4_0[iter_4_4] then
				var_4_4 = false
			elseif var_4_3[iter_4_4] == nil then
				var_4_3[iter_4_4] = false
			end
		end

		if var_4_4 then
			for iter_4_5, iter_4_6 in ipairs(iter_4_2) do
				if not var_4_3[iter_4_6] then
					var_4_3[iter_4_6] = true

					table.insert(arg_4_1, var_4_0[iter_4_6])
				end
			end
		end
	end

	for iter_4_7, iter_4_8 in pairs(var_4_0) do
		if var_4_3[iter_4_7] == nil then
			var_4_3[iter_4_7] = true

			table.insert(arg_4_1, iter_4_8)
		end
	end
end

function var_0_1._getResWhiteListDict(arg_5_0)
	local var_5_0 = io.open(ResSplitEnum.VersionResWhiteListPath, "r")
	local var_5_1 = var_5_0:read("*a")

	var_5_0:close()

	local var_5_2 = string.gsub(var_5_1, "\\/", "/")
	local var_5_3 = cjson.decode(var_5_2)
	local var_5_4 = {}

	if var_5_3 and #var_5_3 > 0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_3) do
			var_5_4[iter_5_1] = true
		end
	end

	return var_5_4
end

function var_0_1._checkResWhiteList(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 and #arg_6_1 > 0 and arg_6_2 then
		for iter_6_0 = #arg_6_1, 1, -1 do
			if arg_6_2[arg_6_1[iter_6_0]] then
				table.remove(arg_6_1, iter_6_0)
			end
		end
	end
end

function var_0_1._ExportSplitResult(arg_7_0)
	local var_7_0 = cjson.encode(arg_7_0:_mergeSplitResult())
	local var_7_1 = string.gsub(var_7_0, "\\/", "/")
	local var_7_2 = io.open(ResSplitEnum.VersionResSplitCfgPath, "w")

	var_7_2:write(tostring(var_7_1))
	var_7_2:close()

	local var_7_3 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._versionSplitData) do
		var_7_3[tostring(iter_7_0)] = arg_7_0._versionSplitData[iter_7_0]:getResTypeSplitMap()
	end

	local var_7_4 = cjson.encode(var_7_3)
	local var_7_5 = string.gsub(var_7_4, "\\/", "/")
	local var_7_6 = string.format("%s/../versionressplitdebug.json", UnityEngine.Application.dataPath)
	local var_7_7 = io.open(var_7_6, "w")

	var_7_7:write(tostring(var_7_5))
	var_7_7:close()
end

function var_0_1._InitMapElementData(arg_8_0)
	local var_8_0 = lua_chapter_map_element.configDict

	arg_8_0._mapElementResDic = {}

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		arg_8_0._mapElementResDic[iter_8_1.mapId] = arg_8_0._mapElementResDic[iter_8_1.mapId] or {}

		if not string.nilorempty(iter_8_1.res) then
			table.insert(arg_8_0._mapElementResDic[iter_8_1.mapId], iter_8_1.res)
		end

		if not string.nilorempty(iter_8_1.effect) then
			table.insert(arg_8_0._mapElementResDic[iter_8_1.mapId], iter_8_1.effect)
		end
	end
end

function var_0_1._InitGuideCfg(arg_9_0)
	local var_9_0 = lua_helppage.configList

	arg_9_0._guideId2HelpPageDict = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.type == 2 then
			local var_9_1 = iter_9_1.unlockGuideId

			arg_9_0._guideId2HelpPageDict[var_9_1] = arg_9_0._guideId2HelpPageDict[var_9_1] or {}

			local var_9_2 = arg_9_0._guideId2HelpPageDict[var_9_1]

			var_9_2[#var_9_2 + 1] = iter_9_1
		end
	end
end

function var_0_1._InitAudioCfg(arg_10_0)
	arg_10_0._allAudioDic = AudioConfig.instance:getAudioCO()
end

function var_0_1._InitAudioInfoXml(arg_11_0)
	local var_11_0 = "../audios/Android/SoundbanksInfo.xml"
	local var_11_1 = io.open(var_11_0, "r")
	local var_11_2 = var_11_1:read("*a")

	var_11_1:close()

	local var_11_3 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(var_11_3):parse(var_11_2)

	arg_11_0._bnk2wenDic = {}
	arg_11_0.bankEvent2wenDic = {}
	arg_11_0.wen2BankDic = {}

	for iter_11_0, iter_11_1 in pairs(var_11_3.root.SoundBanksInfo.SoundBanks.SoundBank) do
		arg_11_0:_dealSingleSoundBank(iter_11_1)
	end
end

function var_0_1._dealSingleSoundBank(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.ShortName
	local var_12_1 = arg_12_1.Path

	if arg_12_1._attr.Language == "SFX" and arg_12_1.IncludedEvents then
		for iter_12_0, iter_12_1 in pairs(arg_12_1.IncludedEvents.Event) do
			local var_12_2 = iter_12_1._attr.Name

			if iter_12_1.ReferencedStreamedFiles then
				for iter_12_2, iter_12_3 in pairs(iter_12_1.ReferencedStreamedFiles.File) do
					arg_12_0:_addWenInfo(var_12_0, var_12_2, iter_12_3._attr.Id)
				end
			end
		end
	end
end

function var_0_1._addWenInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0._bnk2wenDic[arg_13_1] == nil then
		arg_13_0._bnk2wenDic[arg_13_1] = {}
	end

	table.insert(arg_13_0._bnk2wenDic[arg_13_1], arg_13_3)

	local var_13_0 = arg_13_1 .. "#" .. arg_13_2

	if arg_13_0.bankEvent2wenDic[var_13_0] == nil then
		arg_13_0.bankEvent2wenDic[var_13_0] = {}
	end

	table.insert(arg_13_0.bankEvent2wenDic[var_13_0], arg_13_3)

	if arg_13_0.wen2BankDic[arg_13_3] == nil then
		arg_13_0.wen2BankDic[arg_13_3] = {}
	end

	arg_13_0.wen2BankDic[arg_13_3][arg_13_1] = true
end

function var_0_1._InitStoryCfg(arg_14_0)
	local var_14_0 = "Assets/ZResourcesLib/configs/story/groups"
	local var_14_1 = SLFramework.FileHelper.GetDirFilePaths(var_14_0)

	arg_14_0._allStoryIds = {}

	for iter_14_0 = 0, var_14_1.Length - 1 do
		local var_14_2 = var_14_1[iter_14_0]

		if var_14_2:match("%.json$") then
			local var_14_3 = SLFramework.FileHelper.GetFileName(var_14_2, false)
			local var_14_4 = string.gsub(var_14_3, "json_story_group_", "")
			local var_14_5 = tonumber(var_14_4)

			if var_14_5 > 999 then
				arg_14_0._allStoryIds[#arg_14_0._allStoryIds + 1] = var_14_5
			end
		end
	end
end

function var_0_1._loadAllStoryCfg(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._loadStroyFinishCount and arg_15_0._loadStroyFinishCount > 0 then
		return
	end

	arg_15_0._loadFinishCallblock = arg_15_1
	arg_15_0._loadFinishCallblockObj = arg_15_2
	arg_15_0._loadStroyFinishCount = #arg_15_0._allStoryIds * 2

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._allStoryIds) do
		local var_15_0 = string.format("configs/story/steps/json_story_step_%s.json", iter_15_1)
		local var_15_1 = string.format("configs/story/groups/json_story_group_%s.json", iter_15_1)

		loadNonAbAsset(var_15_0, SLFramework.AssetType.TEXT, arg_15_0._loadStoryCfgCallBack, arg_15_0)
		loadNonAbAsset(var_15_1, SLFramework.AssetType.TEXT, arg_15_0._loadStoryCfgCallBack, arg_15_0)
	end
end

function var_0_1._loadStoryCfgCallBack(arg_16_0, arg_16_1)
	if not arg_16_1.IsLoadSuccess then
		logError("config load fail: " .. arg_16_1.ResPath)

		return
	end

	arg_16_0._loadStroyFinishCount = arg_16_0._loadStroyFinishCount - 1
	arg_16_0._storyCfgMap = arg_16_0._storyCfgMap or {}
	arg_16_0._storyCfgMap[arg_16_1.ResPath] = cjson.decode(arg_16_1.TextAsset)

	arg_16_1:Retain()

	if arg_16_0._loadStroyFinishCount <= 0 and arg_16_0._loadFinishCallblock then
		if arg_16_0._loadFinishCallblockObj then
			arg_16_0._loadFinishCallblock(arg_16_0._loadFinishCallblockObj)
		else
			arg_16_0._loadFinishCallblock()
		end
	end
end

function var_0_1._fillSceneResByChatper(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(lua_chapter_map.configList) do
		if iter_17_1.chapterId == arg_17_1 then
			local var_17_0 = iter_17_1.res
			local var_17_1 = ResUrl.getDungeonMapRes(var_17_0)

			arg_17_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.ChapterScene, var_17_1)
			arg_17_0:_fillSceneDependRes(var_17_1, arg_17_2)

			local var_17_2 = arg_17_0._mapElementResDic[iter_17_1.id]

			if var_17_2 then
				for iter_17_2, iter_17_3 in ipairs(var_17_2) do
					arg_17_0:_fillSceneDependRes(iter_17_3, arg_17_2)
				end
			end
		end
	end
end

local var_0_2 = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	anim = true,
	mat = true
}
local var_0_3 = {
	["font/"] = true
}

function var_0_1._fillSceneDependRes(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = SLFramework.FrameworkSettings.GetEditorResPath(arg_18_1)

	local var_18_0 = ZProj.AssetDatabaseHelper.GetDependencies(arg_18_1, true)

	for iter_18_0 = 0, var_18_0.Length - 1 do
		local var_18_1 = var_18_0[iter_18_0]
		local var_18_2 = string.match(var_18_1, ".+%.(%w+)$")
		local var_18_3 = false

		for iter_18_1, iter_18_2 in pairs(var_0_3) do
			if string.match(var_18_1, "font/") then
				var_18_3 = true

				break
			end
		end

		if not var_18_3 then
			local var_18_4 = string.match(var_18_1, ".+%.(%w+)$")

			if var_0_2[var_18_4] then
				local var_18_5 = string.gsub(var_18_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				arg_18_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.ChapterSceneDepand, var_18_5)
			end
		end
	end
end

function var_0_1._fillStoryResByChatper(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_19_1)

	if not var_19_0 then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_1 = iter_19_1.beforeStory

		if var_19_1 ~= 0 then
			arg_19_0:_fillStoryRes(var_19_1, arg_19_2)
		end

		local var_19_2 = string.split(iter_19_1.story, "#")

		if #var_19_2 == 3 then
			local var_19_3 = tonumber(var_19_2[3])

			arg_19_0:_fillStoryRes(var_19_3, arg_19_2)
		end

		local var_19_4 = iter_19_1.afterStory

		if var_19_4 ~= 0 then
			arg_19_0:_fillStoryRes(var_19_4, arg_19_2)
		end
	end
end

function var_0_1._fillStoryRes(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = string.format("configs/story/steps/json_story_step_%s.json", arg_20_1)
	local var_20_1 = string.format("configs/story/groups/json_story_group_%s.json", arg_20_1)
	local var_20_2 = arg_20_0._storyCfgMap[var_20_0]
	local var_20_3 = arg_20_0._storyCfgMap[var_20_1]

	if var_20_2 == nil or var_20_3 == nil then
		return
	end

	StoryModel.instance:clearData()
	StoryStepModel.instance:setStepList(var_20_2[3])
	StoryGroupModel.instance:setGroupList(var_20_3)

	local var_20_4 = StoryStepModel.instance:getStepList()

	for iter_20_0, iter_20_1 in ipairs(var_20_4) do
		if not string.nilorempty(iter_20_1.bg.bgImg) then
			local var_20_5 = ResUrl.getStoryBg(iter_20_1.bg.bgImg)

			arg_20_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBg, var_20_5)

			local var_20_6 = StoryBgZoneModel.instance:getBgZoneByPath(iter_20_1.bg.bgImg)

			if var_20_6 then
				local var_20_7 = ResUrl.getStoryRes(var_20_6.sourcePath)

				arg_20_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBg, var_20_7)
			end
		end

		for iter_20_2, iter_20_3 in pairs(iter_20_1.videoList) do
			local var_20_8 = string.split(iter_20_3.video, ".")[1]

			arg_20_2:addResSplitInfo(ResSplitEnum.Video, var_0_0.StoryVideo, var_20_8)
		end

		for iter_20_4, iter_20_5 in pairs(iter_20_1.conversation.audios) do
			local var_20_9 = arg_20_0._allAudioDic[iter_20_5]

			if var_20_9 then
				arg_20_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.StoryAudio, var_20_9.bankName)
				arg_20_0:_fillAudioResByAudioBnkName(var_20_9.bankName, arg_20_2)
			end
		end

		for iter_20_6, iter_20_7 in pairs(iter_20_1.audioList) do
			local var_20_10 = arg_20_0._allAudioDic[iter_20_7.audio]

			if var_20_10 then
				arg_20_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.StoryAudio, var_20_10.bankName)
				arg_20_0:_fillAudioResByAudioBnkName(var_20_10.bankName, arg_20_2)
			end
		end

		for iter_20_8, iter_20_9 in pairs(iter_20_1.picList) do
			if not string.nilorempty(iter_20_9.picture) then
				local var_20_11 = ResUrl.getStoryItem(iter_20_9.picture)

				arg_20_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBgItem, var_20_11)
			end
		end
	end
end

function var_0_1._fillAudioResByAudioId(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._allAudioDic[arg_21_1]

	if var_21_0 then
		arg_21_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.VersionAudio, var_21_0.bankName)
		arg_21_0:_fillAudioResByAudioBnkName(var_21_0.bankName, arg_21_2)
	end
end

function var_0_1._fillAudioResByAudioBnkName(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._bnk2wenDic[arg_22_1]

	if var_22_0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			arg_22_2:addResSplitInfo(ResSplitEnum.AudioWem, var_0_0.VersionAudio, iter_22_1)
		end
	end
end

function var_0_1._fillResByGuideId(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._guideId2HelpPageDict[arg_23_1]

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_1 = ResUrl.getVersionActivityHelpItem(iter_23_1.icon, iter_23_1.isCn)

			arg_23_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.GuideHalpPage, var_23_1)
		end
	end
end

function var_0_1._fillUIResByFolder(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1 = SLFramework.FrameworkSettings.GetEditorResPath(arg_24_1)

	local var_24_0 = SLFramework.FileHelper.GetDirFilePaths(arg_24_1)

	for iter_24_0 = 0, var_24_0.Length - 1 do
		local var_24_1 = var_24_0[iter_24_0]

		if var_24_1:match("%.prefab$") then
			arg_24_0:_fillUIRes(var_24_1, arg_24_2)
		end
	end
end

function var_0_1._fillUIRes(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = string.find(arg_25_1, "Assets")
	local var_25_1 = string.sub(arg_25_1, var_25_0, string.len(arg_25_1))
	local var_25_2 = string.gsub(var_25_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")
	local var_25_3 = ZProj.AssetDatabaseHelper.GetDependencies(var_25_1, true)

	arg_25_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.UIPrefab, var_25_2)

	for iter_25_0 = 0, var_25_3.Length - 1 do
		local var_25_4 = var_25_3[iter_25_0]
		local var_25_5 = false

		for iter_25_1, iter_25_2 in pairs(var_0_3) do
			if string.match(var_25_4, "font/") then
				var_25_5 = true

				break
			end
		end

		if not var_25_5 then
			local var_25_6 = string.match(var_25_4, ".+%.(%w+)$")

			if var_0_2[var_25_6] then
				local var_25_7 = string.gsub(var_25_4, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				arg_25_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.UIPrefabDepand, var_25_7)
			end
		end
	end

	if not arg_25_3 then
		local var_25_8 = "Assets/ZResourcesLib/lang/common/" .. var_25_2

		arg_25_0:_fillUIRes(var_25_8, arg_25_2, true)
	end
end

function var_0_1._getFolderPrefabs(arg_26_0)
	local var_26_0 = {}

	arg_26_0 = SLFramework.FrameworkSettings.GetEditorResPath(arg_26_0)

	if not SLFramework.FileHelper.IsDirExists(arg_26_0) then
		logError("文件夹" .. arg_26_0 .. "不存在，请检查")
	else
		local var_26_1 = SLFramework.FileHelper.GetDirFilePaths(arg_26_0)

		for iter_26_0 = 0, var_26_1.Length - 1 do
			local var_26_2 = var_26_1[iter_26_0]

			if var_26_2:match("%.prefab$") then
				var_26_0[#var_26_0 + 1] = var_26_2
			end
		end
	end

	return var_26_0
end

function var_0_1._getResFolderFiles(arg_27_0, arg_27_1)
	local var_27_0 = {}

	arg_27_0 = SLFramework.FrameworkSettings.GetEditorResPath(arg_27_0)

	if not SLFramework.FileHelper.IsDirExists(arg_27_0) then
		logError("文件夹" .. arg_27_0 .. " 不存在，请检查")
	else
		local var_27_1 = SLFramework.FileHelper.GetDirFilePaths(arg_27_0)

		for iter_27_0 = 0, var_27_1.Length - 1 do
			local var_27_2 = var_27_1[iter_27_0]

			if var_27_2:match("%." .. arg_27_1 .. "$") then
				var_27_0[#var_27_0 + 1] = var_27_2
			end
		end
	end

	return var_27_0
end

return var_0_1
