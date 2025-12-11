module("modules.logic.ressplit.controller.VersionResSplitHandler", package.seeall)

local var_0_0 = ResSplitEnum.VersionResEnum
local var_0_1 = class("VersionResSplitHandler")
local var_0_2 = {
	{
		resKey = "image",
		format = "singlebg/storybg/%s",
		luaName = "lua_cg"
	}
}

function var_0_1.generateResSplitCfg(arg_1_0)
	arg_1_0:_InitMapElementData()
	arg_1_0:_InitAudioCfg()
	arg_1_0:_InitAudioInfoXml()
	arg_1_0:_InitGuideCfg()
	arg_1_0:_InitStoryCfg()
	arg_1_0:_initRunWork()
	arg_1_0:_loadAllStoryCfg(arg_1_0._generateResSplitCfg, arg_1_0)
end

function var_0_1._initRunWork(arg_2_0)
	arg_2_0._auidoWhiteWork = VersionResSpiltAudioWhiteWork.New()

	local var_2_0 = FlowSequence.New()

	var_2_0:addWork(arg_2_0._auidoWhiteWork)
	var_2_0:start(arg_2_0)
end

function var_0_1._generateResSplitCfg(arg_3_0)
	local var_3_0 = lua_version_res_split.configDict

	arg_3_0._resSplitResult = {}
	arg_3_0._versionSplitData = {}
	arg_3_0._allVersionSplitPathMap = {}

	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_4 = iter_3_1.chapter

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			var_3_1[iter_3_3] = true
		end

		local var_3_5 = iter_3_1.uiFolder

		for iter_3_4, iter_3_5 in ipairs(var_3_5) do
			local var_3_6 = var_0_1._getFolderPrefabs(iter_3_5)

			for iter_3_6, iter_3_7 in ipairs(var_3_6) do
				var_3_2[iter_3_7] = true
			end
		end

		local var_3_7 = iter_3_1.story

		for iter_3_8, iter_3_9 in ipairs(var_3_7) do
			var_3_3[iter_3_9] = true
		end
	end

	for iter_3_10, iter_3_11 in pairs(var_3_1) do
		local var_3_8 = DungeonConfig.instance:getChapterEpisodeCOList(iter_3_10)

		if var_3_8 then
			for iter_3_12, iter_3_13 in ipairs(var_3_8) do
				local var_3_9 = iter_3_13.beforeStory

				if var_3_9 ~= 0 then
					var_3_3[var_3_9] = true
				end

				local var_3_10 = string.split(iter_3_13.story, "#")

				if #var_3_10 == 3 then
					var_3_3[tonumber(var_3_10[3])] = true
				end

				local var_3_11 = iter_3_13.afterStory

				if var_3_11 ~= 0 then
					var_3_3[var_3_11] = true
				end
			end
		end
	end

	local var_3_12 = VersionResSplitData.New()

	var_3_12:init(0)

	local var_3_13 = lua_chapter.configList

	for iter_3_14, iter_3_15 in ipairs(var_3_13) do
		if not var_3_1[iter_3_14] then
			arg_3_0:_fillSceneResByChatper(iter_3_14, var_3_12)
		end
	end

	local var_3_14 = "ui"
	local var_3_15 = var_0_1._getFolderPrefabs(var_3_14)

	for iter_3_16, iter_3_17 in ipairs(var_3_15) do
		if not var_3_2[iter_3_17] then
			arg_3_0:_fillUIRes(iter_3_17, var_3_12)
		end
	end

	for iter_3_18, iter_3_19 in ipairs(arg_3_0._allStoryIds) do
		if not var_3_3[iter_3_19] then
			arg_3_0:_fillStoryRes(iter_3_19, var_3_12)
		end
	end

	for iter_3_20, iter_3_21 in pairs(var_3_0) do
		local var_3_16 = VersionResSplitData.New()

		var_3_16:init(iter_3_20)

		arg_3_0._versionSplitData[iter_3_20] = var_3_16

		local var_3_17 = iter_3_21.chapter

		for iter_3_22, iter_3_23 in ipairs(var_3_17) do
			arg_3_0:_fillSceneResByChatper(iter_3_23, var_3_16)
			arg_3_0:_fillStoryResByChatper(iter_3_23, var_3_16)
		end

		local var_3_18 = iter_3_21.audio

		for iter_3_24, iter_3_25 in ipairs(var_3_18) do
			arg_3_0:_fillAudioResByAudioId(iter_3_25, var_3_16)
		end

		local var_3_19 = iter_3_21.guide

		for iter_3_26, iter_3_27 in ipairs(var_3_19) do
			arg_3_0:_fillResByGuideId(iter_3_27, var_3_16)
		end

		local var_3_20 = iter_3_21.story

		for iter_3_28, iter_3_29 in ipairs(var_3_20) do
			arg_3_0:_fillStoryRes(iter_3_29, var_3_16)
		end

		local var_3_21 = iter_3_21.uiFolder

		for iter_3_30, iter_3_31 in ipairs(var_3_21) do
			iter_3_31 = string.gsub(iter_3_31, SLFramework.FrameworkSettings.ResourcesLibName .. "/", "")

			local var_3_22 = var_0_1._getFolderPrefabs(iter_3_31)

			for iter_3_32, iter_3_33 in ipairs(var_3_22) do
				arg_3_0:_fillUIRes(iter_3_33, var_3_16)
			end
		end

		local var_3_23 = iter_3_21.folderPath

		for iter_3_34, iter_3_35 in ipairs(var_3_23) do
			var_3_16:addResSplitInfo(ResSplitEnum.Folder, var_0_0.SingleFolder, iter_3_35)
		end

		local var_3_24 = iter_3_21.path

		for iter_3_36, iter_3_37 in ipairs(var_3_24) do
			var_3_16:addResSplitInfo(ResSplitEnum.Path, var_0_0.SingleFile, iter_3_37)
		end

		local var_3_25 = iter_3_21.videoPath or {}

		for iter_3_38, iter_3_39 in ipairs(var_3_25) do
			var_3_16:addResSplitInfo(ResSplitEnum.Video, var_0_0.SingleFile, iter_3_39)
		end

		local var_3_26 = var_3_16:getAllResDict()

		for iter_3_40, iter_3_41 in pairs(var_3_26) do
			for iter_3_42, iter_3_43 in pairs(iter_3_41) do
				if var_3_12:checkResSplitInfo(iter_3_40, iter_3_42) then
					var_3_16:deleteResSplitInfo(iter_3_40, nil, iter_3_42)
				end
			end
		end

		local var_3_27 = var_3_16:getAllResTypeDict()

		for iter_3_44, iter_3_45 in pairs(var_3_27) do
			for iter_3_46, iter_3_47 in pairs(iter_3_45) do
				if var_3_12:checkResTypeSplitInfo(iter_3_44, iter_3_46) then
					var_3_16:deleteResSplitInfo(nil, iter_3_44, iter_3_46)
				end
			end
		end
	end

	for iter_3_48, iter_3_49 in pairs(arg_3_0._versionSplitData) do
		local var_3_28 = iter_3_49:getAllResDict()

		for iter_3_50, iter_3_51 in pairs(var_3_28) do
			for iter_3_52, iter_3_53 in pairs(iter_3_51) do
				if iter_3_53 then
					if arg_3_0._allVersionSplitPathMap[iter_3_52] then
						logWarn("存在于多个版本分包中的资源： " .. iter_3_52)
					else
						arg_3_0._allVersionSplitPathMap[iter_3_52] = true
					end
				end
			end
		end
	end

	arg_3_0:_ExportSplitResult()
end

function var_0_1._mergeSplitResult(arg_4_0)
	local var_4_0 = lua_version_res_split.configDict
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._versionSplitData) do
		local var_4_2 = var_4_0[iter_4_0] or var_4_0[tonumber(iter_4_0)]
		local var_4_3 = var_4_2 and var_4_2.packName or "opveract"

		if not var_4_1[var_4_3] then
			var_4_1[var_4_3] = {}
		end

		local var_4_4 = var_4_1[var_4_3]
		local var_4_5 = iter_4_1:getResSplitMap()

		for iter_4_2, iter_4_3 in pairs(var_4_5) do
			if not var_4_4[iter_4_2] then
				var_4_4[iter_4_2] = {}
			end

			tabletool.addValues(var_4_4[iter_4_2], iter_4_3)
		end
	end

	local var_4_6 = arg_4_0:_getResWhiteListDict()
	local var_4_7 = arg_4_0._auidoWhiteWork.bankNameWhiteDic
	local var_4_8 = arg_4_0._auidoWhiteWork.wenNameWhiteDic

	for iter_4_4, iter_4_5 in pairs(var_4_1) do
		if iter_4_5.pathList then
			arg_4_0:_checkResWhiteList(iter_4_5.pathList, var_4_6)
		end

		if iter_4_5.audioBank then
			arg_4_0:_checkResWhiteList(iter_4_5.audioBank, var_4_7)
		end

		if iter_4_5.audioWem then
			arg_4_0:_checkResWhiteList(iter_4_5.audioWem, var_4_8)
		end
	end

	return var_4_1
end

function var_0_1._checkSingleBgAb(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0 = #arg_5_1, 1, -1 do
		local var_5_1 = arg_5_1[iter_5_0]

		if string.find(var_5_1, "singlebg") then
			local var_5_2 = string.format("Assets/ZResourcesLib/%s", string.gsub(var_5_1, "\\/", "/"))

			table.remove(arg_5_1, iter_5_0)

			var_5_0[var_5_2] = var_5_1
		end
	end

	local var_5_3 = {}

	for iter_5_1, iter_5_2 in pairs(arg_5_2) do
		local var_5_4 = true

		for iter_5_3, iter_5_4 in ipairs(iter_5_2) do
			if not var_5_0[iter_5_4] then
				var_5_4 = false
			elseif var_5_3[iter_5_4] == nil then
				var_5_3[iter_5_4] = false
			end
		end

		if var_5_4 then
			for iter_5_5, iter_5_6 in ipairs(iter_5_2) do
				if not var_5_3[iter_5_6] then
					var_5_3[iter_5_6] = true

					table.insert(arg_5_1, var_5_0[iter_5_6])
				end
			end
		end
	end

	for iter_5_7, iter_5_8 in pairs(var_5_0) do
		if var_5_3[iter_5_7] == nil then
			var_5_3[iter_5_7] = true

			table.insert(arg_5_1, iter_5_8)
		end
	end
end

function var_0_1._getResWhiteListDict(arg_6_0)
	local var_6_0 = io.open(ResSplitEnum.VersionResWhiteListPath, "r")
	local var_6_1 = var_6_0:read("*a")

	var_6_0:close()

	local var_6_2 = string.gsub(var_6_1, "\\/", "/")
	local var_6_3 = cjson.decode(var_6_2)
	local var_6_4 = {}

	if var_6_3 and #var_6_3 > 0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_3) do
			var_6_4[iter_6_1] = true
		end
	end

	local var_6_5 = var_0_2

	for iter_6_2 = 1, #var_6_5 do
		local var_6_6 = var_6_5[iter_6_2]
		local var_6_7 = _G[var_6_6.luaName]

		if var_6_7 and var_6_7.configList then
			local var_6_8 = var_6_7.configList

			for iter_6_3, iter_6_4 in ipairs(var_6_8) do
				local var_6_9 = iter_6_4[var_6_6.resKey]

				if not string.nilorempty(var_6_9) then
					var_6_4[string.format(var_6_6.format, iter_6_4[var_6_6.resKey])] = true
				end
			end
		end
	end

	return var_6_4
end

function var_0_1._checkResWhiteList(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 and #arg_7_1 > 0 and arg_7_2 then
		for iter_7_0 = #arg_7_1, 1, -1 do
			if arg_7_2[arg_7_1[iter_7_0]] then
				table.remove(arg_7_1, iter_7_0)
			end
		end
	end
end

function var_0_1._ExportSplitResult(arg_8_0)
	local var_8_0 = cjson.encode(arg_8_0:_mergeSplitResult())
	local var_8_1 = string.gsub(var_8_0, "\\/", "/")
	local var_8_2 = io.open(ResSplitEnum.VersionResSplitCfgPath, "w")

	var_8_2:write(tostring(var_8_1))
	var_8_2:close()

	local var_8_3 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._versionSplitData) do
		var_8_3[tostring(iter_8_0)] = arg_8_0._versionSplitData[iter_8_0]:getResTypeSplitMap()
	end

	local var_8_4 = cjson.encode(var_8_3)
	local var_8_5 = string.gsub(var_8_4, "\\/", "/")
	local var_8_6 = string.format("%s/../versionressplitdebug.json", UnityEngine.Application.dataPath)
	local var_8_7 = io.open(var_8_6, "w")

	var_8_7:write(tostring(var_8_5))
	var_8_7:close()
end

function var_0_1._InitMapElementData(arg_9_0)
	local var_9_0 = lua_chapter_map_element.configDict

	arg_9_0._mapElementResDic = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		arg_9_0._mapElementResDic[iter_9_1.mapId] = arg_9_0._mapElementResDic[iter_9_1.mapId] or {}

		if not string.nilorempty(iter_9_1.res) then
			table.insert(arg_9_0._mapElementResDic[iter_9_1.mapId], iter_9_1.res)
		end

		if not string.nilorempty(iter_9_1.effect) then
			table.insert(arg_9_0._mapElementResDic[iter_9_1.mapId], iter_9_1.effect)
		end
	end
end

function var_0_1._InitGuideCfg(arg_10_0)
	local var_10_0 = lua_helppage.configList

	arg_10_0._guideId2HelpPageDict = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.type == 2 then
			local var_10_1 = iter_10_1.unlockGuideId

			arg_10_0._guideId2HelpPageDict[var_10_1] = arg_10_0._guideId2HelpPageDict[var_10_1] or {}

			local var_10_2 = arg_10_0._guideId2HelpPageDict[var_10_1]

			var_10_2[#var_10_2 + 1] = iter_10_1
		end
	end
end

function var_0_1._InitAudioCfg(arg_11_0)
	arg_11_0._allAudioDic = AudioConfig.instance:getAudioCO()
end

function var_0_1._InitAudioInfoXml(arg_12_0)
	local var_12_0 = "../audios/Android/SoundbanksInfo.xml"
	local var_12_1 = io.open(var_12_0, "r")
	local var_12_2 = var_12_1:read("*a")

	var_12_1:close()

	local var_12_3 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(var_12_3):parse(var_12_2)

	arg_12_0._bnk2wenDic = {}
	arg_12_0.bankEvent2wenDic = {}
	arg_12_0.wen2BankDic = {}

	for iter_12_0, iter_12_1 in pairs(var_12_3.root.SoundBanksInfo.SoundBanks.SoundBank) do
		arg_12_0:_dealSingleSoundBank(iter_12_1)
	end
end

function var_0_1._dealSingleSoundBank(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.ShortName
	local var_13_1 = arg_13_1.Path

	if arg_13_1._attr.Language == "SFX" and arg_13_1.IncludedEvents then
		for iter_13_0, iter_13_1 in pairs(arg_13_1.IncludedEvents.Event) do
			local var_13_2 = iter_13_1._attr.Name

			if iter_13_1.ReferencedStreamedFiles then
				for iter_13_2, iter_13_3 in pairs(iter_13_1.ReferencedStreamedFiles.File) do
					arg_13_0:_addWenInfo(var_13_0, var_13_2, iter_13_3._attr.Id)
				end
			end
		end
	end
end

function var_0_1._addWenInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0._bnk2wenDic[arg_14_1] == nil then
		arg_14_0._bnk2wenDic[arg_14_1] = {}
	end

	table.insert(arg_14_0._bnk2wenDic[arg_14_1], arg_14_3)

	local var_14_0 = arg_14_1 .. "#" .. arg_14_2

	if arg_14_0.bankEvent2wenDic[var_14_0] == nil then
		arg_14_0.bankEvent2wenDic[var_14_0] = {}
	end

	table.insert(arg_14_0.bankEvent2wenDic[var_14_0], arg_14_3)

	if arg_14_0.wen2BankDic[arg_14_3] == nil then
		arg_14_0.wen2BankDic[arg_14_3] = {}
	end

	arg_14_0.wen2BankDic[arg_14_3][arg_14_1] = true
end

function var_0_1._InitStoryCfg(arg_15_0)
	local var_15_0 = "Assets/ZResourcesLib/configs/story/groups"
	local var_15_1 = SLFramework.FileHelper.GetDirFilePaths(var_15_0)

	arg_15_0._allStoryIds = {}

	for iter_15_0 = 0, var_15_1.Length - 1 do
		local var_15_2 = var_15_1[iter_15_0]

		if var_15_2:match("%.json$") then
			local var_15_3 = SLFramework.FileHelper.GetFileName(var_15_2, false)
			local var_15_4 = string.gsub(var_15_3, "json_story_group_", "")
			local var_15_5 = tonumber(var_15_4)

			if var_15_5 > 999 then
				arg_15_0._allStoryIds[#arg_15_0._allStoryIds + 1] = var_15_5
			end
		end
	end
end

function var_0_1._loadAllStoryCfg(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._loadStroyFinishCount and arg_16_0._loadStroyFinishCount > 0 then
		return
	end

	arg_16_0._loadFinishCallblock = arg_16_1
	arg_16_0._loadFinishCallblockObj = arg_16_2
	arg_16_0._loadStroyFinishCount = #arg_16_0._allStoryIds * 2

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._allStoryIds) do
		local var_16_0 = string.format("configs/story/steps/json_story_step_%s.json", iter_16_1)
		local var_16_1 = string.format("configs/story/groups/json_story_group_%s.json", iter_16_1)

		loadNonAbAsset(var_16_0, SLFramework.AssetType.TEXT, arg_16_0._loadStoryCfgCallBack, arg_16_0)
		loadNonAbAsset(var_16_1, SLFramework.AssetType.TEXT, arg_16_0._loadStoryCfgCallBack, arg_16_0)
	end
end

function var_0_1._loadStoryCfgCallBack(arg_17_0, arg_17_1)
	if not arg_17_1.IsLoadSuccess then
		logError("config load fail: " .. arg_17_1.ResPath)

		return
	end

	arg_17_0._loadStroyFinishCount = arg_17_0._loadStroyFinishCount - 1
	arg_17_0._storyCfgMap = arg_17_0._storyCfgMap or {}
	arg_17_0._storyCfgMap[arg_17_1.ResPath] = cjson.decode(arg_17_1.TextAsset)

	if arg_17_0._loadStroyFinishCount <= 0 and arg_17_0._loadFinishCallblock then
		if arg_17_0._loadFinishCallblockObj then
			arg_17_0._loadFinishCallblock(arg_17_0._loadFinishCallblockObj)
		else
			arg_17_0._loadFinishCallblock()
		end
	end
end

function var_0_1._fillSceneResByChatper(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(lua_chapter_map.configList) do
		if iter_18_1.chapterId == arg_18_1 then
			local var_18_0 = iter_18_1.res
			local var_18_1 = ResUrl.getDungeonMapRes(var_18_0)

			arg_18_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.ChapterScene, var_18_1)
			arg_18_0:_fillSceneDependRes(var_18_1, arg_18_2)

			local var_18_2 = arg_18_0._mapElementResDic[iter_18_1.id]

			if var_18_2 then
				for iter_18_2, iter_18_3 in ipairs(var_18_2) do
					arg_18_0:_fillSceneDependRes(iter_18_3, arg_18_2)
				end
			end
		end
	end
end

local var_0_3 = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	anim = true,
	mat = true
}
local var_0_4 = {
	["font/"] = true
}

function var_0_1._fillSceneDependRes(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = SLFramework.FrameworkSettings.GetEditorResPath(arg_19_1)

	local var_19_0 = ZProj.AssetDatabaseHelper.GetDependencies(arg_19_1, true)

	for iter_19_0 = 0, var_19_0.Length - 1 do
		local var_19_1 = var_19_0[iter_19_0]
		local var_19_2 = string.match(var_19_1, ".+%.(%w+)$")
		local var_19_3 = false

		for iter_19_1, iter_19_2 in pairs(var_0_4) do
			if string.match(var_19_1, "font/") then
				var_19_3 = true

				break
			end
		end

		if not var_19_3 then
			local var_19_4 = string.match(var_19_1, ".+%.(%w+)$")

			if var_0_3[var_19_4] then
				local var_19_5 = string.gsub(var_19_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				arg_19_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.ChapterSceneDepand, var_19_5)
			end
		end
	end
end

function var_0_1._fillStoryResByChatper(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_20_1)

	if not var_20_0 then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_1 = iter_20_1.beforeStory

		if var_20_1 ~= 0 then
			arg_20_0:_fillStoryRes(var_20_1, arg_20_2)
		end

		local var_20_2 = string.split(iter_20_1.story, "#")

		if #var_20_2 == 3 then
			local var_20_3 = tonumber(var_20_2[3])

			arg_20_0:_fillStoryRes(var_20_3, arg_20_2)
		end

		local var_20_4 = iter_20_1.afterStory

		if var_20_4 ~= 0 then
			arg_20_0:_fillStoryRes(var_20_4, arg_20_2)
		end
	end
end

function var_0_1._fillStoryRes(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = string.format("configs/story/steps/json_story_step_%s.json", arg_21_1)
	local var_21_1 = string.format("configs/story/groups/json_story_group_%s.json", arg_21_1)
	local var_21_2 = arg_21_0._storyCfgMap[var_21_0]
	local var_21_3 = arg_21_0._storyCfgMap[var_21_1]

	if not var_21_2 then
		logNormal(string.format("找不到剧情配置Id:%s", arg_21_1))

		return
	end

	if var_21_2 == nil or var_21_3 == nil then
		return
	end

	StoryModel.instance:clearData()
	StoryStepModel.instance:setStepList(var_21_2[3])
	StoryGroupModel.instance:setGroupList(var_21_3)

	local var_21_4 = StoryStepModel.instance:getStepList()

	for iter_21_0, iter_21_1 in ipairs(var_21_4) do
		if not string.nilorempty(iter_21_1.bg.bgImg) then
			local var_21_5 = ResUrl.getStoryBg(iter_21_1.bg.bgImg)

			arg_21_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBg, var_21_5)

			local var_21_6 = StoryBgZoneModel.instance:getBgZoneByPath(iter_21_1.bg.bgImg)

			if var_21_6 then
				local var_21_7 = ResUrl.getStoryRes(var_21_6.sourcePath)

				arg_21_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBg, var_21_7)
			end
		end

		for iter_21_2, iter_21_3 in pairs(iter_21_1.videoList) do
			local var_21_8 = string.split(iter_21_3.video, ".")[1]

			arg_21_2:addResSplitInfo(ResSplitEnum.Video, var_0_0.StoryVideo, var_21_8)
		end

		for iter_21_4, iter_21_5 in pairs(iter_21_1.conversation.audios) do
			local var_21_9 = arg_21_0._allAudioDic[iter_21_5]

			if var_21_9 then
				arg_21_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.StoryAudio, var_21_9.bankName)
				arg_21_0:_fillAudioResByAudioBnkName(var_21_9.bankName, arg_21_2)
			end
		end

		for iter_21_6, iter_21_7 in pairs(iter_21_1.audioList) do
			local var_21_10 = arg_21_0._allAudioDic[iter_21_7.audio]

			if var_21_10 then
				arg_21_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.StoryAudio, var_21_10.bankName)
				arg_21_0:_fillAudioResByAudioBnkName(var_21_10.bankName, arg_21_2)
			end
		end

		for iter_21_8, iter_21_9 in pairs(iter_21_1.picList) do
			if not string.nilorempty(iter_21_9.picture) then
				local var_21_11 = ResUrl.getStoryItem(iter_21_9.picture)

				arg_21_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.StoryBgItem, var_21_11)
			end
		end
	end
end

function var_0_1._fillAudioResByAudioId(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._allAudioDic[arg_22_1]

	if var_22_0 then
		arg_22_2:addResSplitInfo(ResSplitEnum.AudioBank, var_0_0.VersionAudio, var_22_0.bankName)
		arg_22_0:_fillAudioResByAudioBnkName(var_22_0.bankName, arg_22_2)
	end
end

function var_0_1._fillAudioResByAudioBnkName(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._bnk2wenDic[arg_23_1]

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			arg_23_2:addResSplitInfo(ResSplitEnum.AudioWem, var_0_0.VersionAudio, iter_23_1)
		end
	end
end

function var_0_1._fillResByGuideId(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0._guideId2HelpPageDict[arg_24_1]

	if var_24_0 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			local var_24_1 = ResUrl.getVersionActivityHelpItem(iter_24_1.icon, iter_24_1.isCn)

			arg_24_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.GuideHalpPage, var_24_1)
		end
	end
end

function var_0_1._fillUIResByFolder(arg_25_0, arg_25_1, arg_25_2)
	arg_25_1 = SLFramework.FrameworkSettings.GetEditorResPath(arg_25_1)

	local var_25_0 = SLFramework.FileHelper.GetDirFilePaths(arg_25_1)

	for iter_25_0 = 0, var_25_0.Length - 1 do
		local var_25_1 = var_25_0[iter_25_0]

		if var_25_1:match("%.prefab$") then
			arg_25_0:_fillUIRes(var_25_1, arg_25_2)
		end
	end
end

function var_0_1._fillUIRes(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = string.find(arg_26_1, "Assets")
	local var_26_1 = string.sub(arg_26_1, var_26_0, string.len(arg_26_1))
	local var_26_2 = string.gsub(var_26_1, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")
	local var_26_3 = ZProj.AssetDatabaseHelper.GetDependencies(var_26_1, true)

	arg_26_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.UIPrefab, var_26_2)

	for iter_26_0 = 0, var_26_3.Length - 1 do
		local var_26_4 = var_26_3[iter_26_0]
		local var_26_5 = false

		for iter_26_1, iter_26_2 in pairs(var_0_4) do
			if string.match(var_26_4, "font/") then
				var_26_5 = true

				break
			end
		end

		if not var_26_5 then
			local var_26_6 = string.match(var_26_4, ".+%.(%w+)$")

			if var_0_3[var_26_6] then
				local var_26_7 = string.gsub(var_26_4, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				arg_26_2:addResSplitInfo(ResSplitEnum.Path, var_0_0.UIPrefabDepand, var_26_7)
			end
		end
	end

	if not arg_26_3 then
		local var_26_8 = "Assets/ZResourcesLib/lang/common/" .. var_26_2

		arg_26_0:_fillUIRes(var_26_8, arg_26_2, true)
	end
end

function var_0_1._getFolderPrefabs(arg_27_0)
	local var_27_0 = {}

	arg_27_0 = SLFramework.FrameworkSettings.GetEditorResPath(arg_27_0)

	if not SLFramework.FileHelper.IsDirExists(arg_27_0) then
		logError("文件夹" .. arg_27_0 .. "不存在，请检查")
	else
		local var_27_1 = SLFramework.FileHelper.GetDirFilePaths(arg_27_0)

		for iter_27_0 = 0, var_27_1.Length - 1 do
			local var_27_2 = var_27_1[iter_27_0]

			if var_27_2:match("%.prefab$") then
				var_27_0[#var_27_0 + 1] = var_27_2
			end
		end
	end

	return var_27_0
end

function var_0_1._getResFolderFiles(arg_28_0, arg_28_1)
	local var_28_0 = {}

	arg_28_0 = SLFramework.FrameworkSettings.GetEditorResPath(arg_28_0)

	if not SLFramework.FileHelper.IsDirExists(arg_28_0) then
		logError("文件夹" .. arg_28_0 .. " 不存在，请检查")
	else
		local var_28_1 = SLFramework.FileHelper.GetDirFilePaths(arg_28_0)

		for iter_28_0 = 0, var_28_1.Length - 1 do
			local var_28_2 = var_28_1[iter_28_0]

			if var_28_2:match("%." .. arg_28_1 .. "$") then
				var_28_0[#var_28_0 + 1] = var_28_2
			end
		end
	end

	return var_28_0
end

return var_0_1
