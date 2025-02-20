module("modules.logic.ressplit.controller.VersionResSplitHandler", package.seeall)

slot0 = ResSplitEnum.VersionResEnum
slot1 = class("VersionResSplitHandler")

function slot1.generateResSplitCfg(slot0)
	slot0:_InitMapElementData()
	slot0:_InitAudioCfg()
	slot0:_InitAudioInfoXml()
	slot0:_InitGuideCfg()
	slot0:_InitStoryCfg()
	slot0:_loadAllStoryCfg(slot0._generateResSplitCfg, slot0)
end

function slot1._generateResSplitCfg(slot0)
	slot0._resSplitResult = {}
	slot0._versionSplitData = {}
	slot0._allVersionSplitPathMap = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(lua_version_res_split.configDict) do
		for slot14, slot15 in ipairs(slot9.chapter) do
			slot2[slot15] = true
		end

		for slot15, slot16 in ipairs(slot9.uiFolder) do
			for slot21, slot22 in ipairs(uv0._getFolderPrefabs(slot16)) do
				slot3[slot22] = true
			end
		end

		for slot16, slot17 in ipairs(slot9.story) do
			slot4[slot17] = true
		end
	end

	for slot8, slot9 in pairs(slot2) do
		if DungeonConfig.instance:getChapterEpisodeCOList(slot8) then
			for slot14, slot15 in ipairs(slot10) do
				if slot15.beforeStory ~= 0 then
					slot4[slot16] = true
				end

				if #string.split(slot15.story, "#") == 3 then
					slot4[tonumber(slot17[3])] = true
				end

				if slot15.afterStory ~= 0 then
					slot4[slot18] = true
				end
			end
		end
	end

	VersionResSplitData.New():init(0)

	for slot10, slot11 in ipairs(lua_chapter.configList) do
		if not slot2[slot10] then
			slot0:_fillSceneResByChatper(slot10, slot5)
		end
	end

	for slot12, slot13 in ipairs(uv0._getFolderPrefabs("ui/viewres")) do
		if not slot3[slot13] then
			slot0:_fillUIRes(slot13, slot5)
		end
	end

	for slot12, slot13 in ipairs(slot0._allStoryIds) do
		if not slot4[slot13] then
			slot0:_fillStoryRes(slot13, slot5)
		end
	end

	for slot12, slot13 in pairs(slot1) do
		slot14 = VersionResSplitData.New()

		slot14:init(slot12)

		slot0._versionSplitData[slot12] = slot14

		for slot19, slot20 in ipairs(slot13.chapter) do
			slot0:_fillSceneResByChatper(slot20, slot14)
			slot0:_fillStoryResByChatper(slot20, slot14)
		end

		for slot20, slot21 in ipairs(slot13.audio) do
			slot0:_fillAudioResByAudioId(slot21, slot14)
		end

		for slot21, slot22 in ipairs(slot13.guide) do
			slot0:_fillResByGuideId(slot22, slot14)
		end

		for slot22, slot23 in ipairs(slot13.story) do
			slot0:_fillStoryRes(slot23, slot14)
		end

		for slot23, slot24 in ipairs(slot13.uiFolder) do
			slot29 = ""

			for slot29, slot30 in ipairs(uv0._getFolderPrefabs(string.gsub(slot24, SLFramework.FrameworkSettings.ResourcesLibName .. "/", slot29))) do
				slot0:_fillUIRes(slot30, slot14)
			end
		end

		for slot24, slot25 in ipairs(slot13.folderPath) do
			slot14:addResSplitInfo(ResSplitEnum.Folder, uv1.SingleFolder, slot25)
		end

		for slot25, slot26 in ipairs(slot13.path) do
			slot14:addResSplitInfo(ResSplitEnum.Path, uv1.SingleFile, slot26)
		end

		for slot26, slot27 in pairs(slot14:getAllResDict()) do
			for slot31, slot32 in pairs(slot27) do
				if slot5:checkResSplitInfo(slot26, slot31) then
					slot14:deleteResSplitInfo(slot26, nil, slot31)
				end
			end
		end

		for slot27, slot28 in pairs(slot14:getAllResTypeDict()) do
			for slot32, slot33 in pairs(slot28) do
				if slot5:checkResTypeSplitInfo(slot27, slot32) then
					slot14:deleteResSplitInfo(nil, slot27, slot32)
				end
			end
		end
	end

	for slot12, slot13 in pairs(slot0._versionSplitData) do
		for slot18, slot19 in pairs(slot13:getAllResDict()) do
			for slot23, slot24 in pairs(slot19) do
				if slot24 then
					if slot0._allVersionSplitPathMap[slot23] then
						logWarn("存在于多个版本分包中的资源： " .. slot23)
					else
						slot0._allVersionSplitPathMap[slot23] = true
					end
				end
			end
		end
	end

	slot0:_ExportSplitResult()
end

function slot1._mergeSplitResult(slot0)
	slot1 = lua_version_res_split.configDict
	slot2 = {}

	for slot6, slot7 in pairs(slot0._versionSplitData) do
		slot8 = slot1[slot6] or slot1[tonumber(slot6)]

		if not slot2[slot8 and slot8.packName or "opveract"] then
			slot2[slot9] = {}
		end

		slot10 = slot2[slot9]

		for slot15, slot16 in pairs(slot7:getResSplitMap()) do
			if not slot10[slot15] then
				slot10[slot15] = {}
			end

			tabletool.addValues(slot10[slot15], slot16)
		end
	end

	slot3 = io.open(ResSplitEnum.SingleBgAbCfgPath, "r")

	slot3:close()

	for slot10, slot11 in pairs(slot2) do
		if slot11.pathList then
			slot0:_checkSingleBgAb(slot11.pathList, cjson.decode(string.gsub(slot3:read("*a"), "\\/", "/")))
			slot0:_checkResWhiteList(slot11.pathList, slot0:_getResWhiteListDict())
		end
	end

	return slot2
end

function slot1._checkSingleBgAb(slot0, slot1, slot2)
	slot3 = {
		[string.format("Assets/ZResourcesLib/%s", string.gsub(slot8, "\\/", "/"))] = slot8
	}

	for slot7 = #slot1, 1, -1 do
		if string.find(slot1[slot7], "singlebg") then
			table.remove(slot1, slot7)
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot2) do
		slot10 = true

		for slot14, slot15 in ipairs(slot9) do
			if not slot3[slot15] then
				slot10 = false
			elseif slot4[slot15] == nil then
				slot4[slot15] = false
			end
		end

		if slot10 then
			for slot14, slot15 in ipairs(slot9) do
				if not slot4[slot15] then
					slot4[slot15] = true

					table.insert(slot1, slot3[slot15])
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot3) do
		if slot4[slot8] == nil then
			slot4[slot8] = true

			table.insert(slot1, slot9)
		end
	end
end

function slot1._getResWhiteListDict(slot0)
	slot1 = io.open(ResSplitEnum.VersionResWhiteListPath, "r")

	slot1:close()

	slot4 = {}

	if cjson.decode(string.gsub(slot1:read("*a"), "\\/", "/")) and #slot3 > 0 then
		for slot8, slot9 in ipairs(slot3) do
			slot4[slot9] = true
		end
	end

	return slot4
end

function slot1._checkResWhiteList(slot0, slot1, slot2)
	if slot1 and #slot1 > 0 and slot2 then
		for slot6 = #slot1, 1, -1 do
			if slot2[slot1[slot6]] then
				table.remove(slot1, slot6)
			end
		end
	end
end

function slot1._ExportSplitResult(slot0)
	slot2 = io.open(ResSplitEnum.VersionResSplitCfgPath, "w")
	slot8 = string.gsub(cjson.encode(slot0:_mergeSplitResult()), "\\/", "/")

	slot2:write(tostring(slot8))
	slot2:close()

	for slot7, slot8 in pairs(slot0._versionSplitData) do
		-- Nothing
	end

	slot6 = io.open(string.format("%s/../versionressplitdebug.json", UnityEngine.Application.dataPath), "w")

	slot6:write(tostring(string.gsub(cjson.encode({
		[tostring(slot7)] = slot0._versionSplitData[slot7]:getResTypeSplitMap()
	}), "\\/", "/")))
	slot6:close()
end

function slot1._InitMapElementData(slot0)
	slot0._mapElementResDic = {}

	for slot5, slot6 in pairs(lua_chapter_map_element.configDict) do
		slot0._mapElementResDic[slot6.mapId] = slot0._mapElementResDic[slot6.mapId] or {}

		if not string.nilorempty(slot6.res) then
			table.insert(slot0._mapElementResDic[slot6.mapId], slot6.res)
		end

		if not string.nilorempty(slot6.effect) then
			table.insert(slot0._mapElementResDic[slot6.mapId], slot6.effect)
		end
	end
end

function slot1._InitGuideCfg(slot0)
	slot0._guideId2HelpPageDict = {}

	for slot5, slot6 in ipairs(lua_helppage.configList) do
		if slot6.type == 2 then
			slot0._guideId2HelpPageDict[slot7] = slot0._guideId2HelpPageDict[slot6.unlockGuideId] or {}
			slot8 = slot0._guideId2HelpPageDict[slot7]
			slot8[#slot8 + 1] = slot6
		end
	end
end

function slot1._InitAudioCfg(slot0)
	slot0._allAudioDic = AudioConfig.instance:getAudioCO()
end

function slot1._InitAudioInfoXml(slot0)
	slot2 = io.open("../audios/Android/SoundbanksInfo.xml", "r")

	slot2:close()

	slot4 = ResSplitXmlTree:new()
	slot9 = slot2:read("*a")

	ResSplitXml2lua.parser(slot4):parse(slot9)

	slot0._bnk2wenDic = {}
	slot0.bankEvent2wenDic = {}
	slot0.wen2BankDic = {}

	for slot9, slot10 in pairs(slot4.root.SoundBanksInfo.SoundBanks.SoundBank) do
		slot0:_dealSingleSoundBank(slot10)
	end
end

function slot1._dealSingleSoundBank(slot0, slot1)
	slot2 = slot1.ShortName
	slot3 = slot1.Path

	if slot1._attr.Language == "SFX" and slot1.IncludedEvents then
		for slot7, slot8 in pairs(slot1.IncludedEvents.Event) do
			slot9 = slot8._attr.Name

			if slot8.ReferencedStreamedFiles then
				for slot13, slot14 in pairs(slot8.ReferencedStreamedFiles.File) do
					slot0:_addWenInfo(slot2, slot9, slot14._attr.Id)
				end
			end
		end
	end
end

function slot1._addWenInfo(slot0, slot1, slot2, slot3)
	if slot0._bnk2wenDic[slot1] == nil then
		slot0._bnk2wenDic[slot1] = {}
	end

	table.insert(slot0._bnk2wenDic[slot1], slot3)

	if slot0.bankEvent2wenDic[slot1 .. "#" .. slot2] == nil then
		slot0.bankEvent2wenDic[slot4] = {}
	end

	table.insert(slot0.bankEvent2wenDic[slot4], slot3)

	if slot0.wen2BankDic[slot3] == nil then
		slot0.wen2BankDic[slot3] = {}
	end

	slot0.wen2BankDic[slot3][slot1] = true
end

function slot1._InitStoryCfg(slot0)
	slot0._allStoryIds = {}

	for slot6 = 0, SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/configs/story/groups").Length - 1 do
		if slot2[slot6]:match("%.json$") and tonumber(string.gsub(SLFramework.FileHelper.GetFileName(slot7, false), "json_story_group_", "")) > 999 then
			slot0._allStoryIds[#slot0._allStoryIds + 1] = slot10
		end
	end
end

function slot1._loadAllStoryCfg(slot0, slot1, slot2)
	if slot0._loadStroyFinishCount and slot0._loadStroyFinishCount > 0 then
		return
	end

	slot0._loadFinishCallblock = slot1
	slot0._loadFinishCallblockObj = slot2
	slot0._loadStroyFinishCount = #slot0._allStoryIds * 2

	for slot6, slot7 in ipairs(slot0._allStoryIds) do
		loadNonAbAsset(string.format("configs/story/steps/json_story_step_%s.json", slot7), SLFramework.AssetType.TEXT, slot0._loadStoryCfgCallBack, slot0)
		loadNonAbAsset(string.format("configs/story/groups/json_story_group_%s.json", slot7), SLFramework.AssetType.TEXT, slot0._loadStoryCfgCallBack, slot0)
	end
end

function slot1._loadStoryCfgCallBack(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("config load fail: " .. slot1.ResPath)

		return
	end

	slot0._loadStroyFinishCount = slot0._loadStroyFinishCount - 1
	slot0._storyCfgMap = slot0._storyCfgMap or {}
	slot0._storyCfgMap[slot1.ResPath] = cjson.decode(slot1.TextAsset)

	slot1:Retain()

	if slot0._loadStroyFinishCount <= 0 and slot0._loadFinishCallblock then
		if slot0._loadFinishCallblockObj then
			slot0._loadFinishCallblock(slot0._loadFinishCallblockObj)
		else
			slot0._loadFinishCallblock()
		end
	end
end

function slot1._fillSceneResByChatper(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(lua_chapter_map.configList) do
		if slot7.chapterId == slot1 then
			slot9 = ResUrl.getDungeonMapRes(slot7.res)

			slot2:addResSplitInfo(ResSplitEnum.Path, uv0.ChapterScene, slot9)
			slot0:_fillSceneDependRes(slot9, slot2)

			if slot0._mapElementResDic[slot7.id] then
				for slot14, slot15 in ipairs(slot10) do
					slot0:_fillSceneDependRes(slot15, slot2)
				end
			end
		end
	end
end

slot2 = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	anim = true,
	mat = true
}
slot3 = {
	["font/"] = true
}

function slot1._fillSceneDependRes(slot0, slot1, slot2)
	for slot7 = 0, ZProj.AssetDatabaseHelper.GetDependencies(SLFramework.FrameworkSettings.GetEditorResPath(slot1), true).Length - 1 do
		slot9 = string.match(slot3[slot7], ".+%.(%w+)$")
		slot10 = false

		for slot14, slot15 in pairs(uv0) do
			if string.match(slot8, "font/") then
				slot10 = true

				break
			end
		end

		if not slot10 and uv1[string.match(slot8, ".+%.(%w+)$")] then
			slot2:addResSplitInfo(ResSplitEnum.Path, uv2.ChapterSceneDepand, string.gsub(slot8, SLFramework.FrameworkSettings.AssetRootDir .. "/", ""))
		end
	end
end

function slot1._fillStoryResByChatper(slot0, slot1, slot2)
	if not DungeonConfig.instance:getChapterEpisodeCOList(slot1) then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8.beforeStory ~= 0 then
			slot0:_fillStoryRes(slot9, slot2)
		end

		if #string.split(slot8.story, "#") == 3 then
			slot0:_fillStoryRes(tonumber(slot10[3]), slot2)
		end

		if slot8.afterStory ~= 0 then
			slot0:_fillStoryRes(slot11, slot2)
		end
	end
end

function slot1._fillStoryRes(slot0, slot1, slot2)
	StoryModel.instance:clearData()
	StoryStepModel.instance:setStepList(slot0._storyCfgMap[string.format("configs/story/steps/json_story_step_%s.json", slot1)][3])
	StoryGroupModel.instance:setGroupList(slot0._storyCfgMap[string.format("configs/story/groups/json_story_group_%s.json", slot1)])

	for slot11, slot12 in ipairs(StoryStepModel.instance:getStepList()) do
		if not string.nilorempty(slot12.bg.bgImg) then
			slot2:addResSplitInfo(ResSplitEnum.Path, uv0.StoryBg, ResUrl.getStoryBg(slot12.bg.bgImg))
		end

		for slot16, slot17 in pairs(slot12.videoList) do
			slot2:addResSplitInfo(ResSplitEnum.Video, uv0.StoryVideo, string.split(slot17.video, ".")[1])
		end

		for slot16, slot17 in pairs(slot12.conversation.audios) do
			if slot0._allAudioDic[slot17] then
				slot2:addResSplitInfo(ResSplitEnum.AudioBank, uv0.StoryAudio, slot18.bankName)
				slot0:_fillAudioResByAudioBnkName(slot18.bankName, slot2)
			end
		end

		for slot16, slot17 in pairs(slot12.audioList) do
			if slot0._allAudioDic[slot17.audio] then
				slot2:addResSplitInfo(ResSplitEnum.AudioBank, uv0.StoryAudio, slot18.bankName)
				slot0:_fillAudioResByAudioBnkName(slot18.bankName, slot2)
			end
		end

		for slot16, slot17 in pairs(slot12.picList) do
			if not string.nilorempty(slot17.picture) then
				slot2:addResSplitInfo(ResSplitEnum.Path, uv0.StoryBgItem, ResUrl.getStoryItem(slot17.picture))
			end
		end
	end
end

function slot1._fillAudioResByAudioId(slot0, slot1, slot2)
	if slot0._allAudioDic[slot1] then
		slot2:addResSplitInfo(ResSplitEnum.AudioBank, uv0.VersionAudio, slot3.bankName)
		slot0:_fillAudioResByAudioBnkName(slot3.bankName, slot2)
	end
end

function slot1._fillAudioResByAudioBnkName(slot0, slot1, slot2)
	if slot0._bnk2wenDic[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			slot2:addResSplitInfo(ResSplitEnum.AudioWem, uv0.VersionAudio, slot8)
		end
	end
end

function slot1._fillResByGuideId(slot0, slot1, slot2)
	if slot0._guideId2HelpPageDict[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			slot2:addResSplitInfo(ResSplitEnum.Path, uv0.GuideHalpPage, ResUrl.getHelpItem(slot8.icon, slot8.isCn))
		end
	end
end

function slot1._fillUIResByFolder(slot0, slot1, slot2)
	for slot7 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.GetEditorResPath(slot1)).Length - 1 do
		if slot3[slot7]:match("%.prefab$") then
			slot0:_fillUIRes(slot8, slot2)
		end
	end
end

function slot1._fillUIRes(slot0, slot1, slot2, slot3)
	slot5 = string.sub(slot1, string.find(slot1, "Assets"), string.len(slot1))
	slot11 = ResSplitEnum.Path

	slot2:addResSplitInfo(slot11, uv0.UIPrefab, string.gsub(slot5, SLFramework.FrameworkSettings.AssetRootDir .. "/", ""))

	for slot11 = 0, ZProj.AssetDatabaseHelper.GetDependencies(slot5, true).Length - 1 do
		slot12 = slot7[slot11]
		slot13 = false

		for slot17, slot18 in pairs(uv1) do
			if string.match(slot12, "font/") then
				slot13 = true

				break
			end
		end

		if not slot13 and uv2[string.match(slot12, ".+%.(%w+)$")] then
			slot2:addResSplitInfo(ResSplitEnum.Path, uv0.UIPrefabDepand, string.gsub(slot12, SLFramework.FrameworkSettings.AssetRootDir .. "/", ""))
		end
	end

	if not slot3 then
		slot0:_fillUIRes("Assets/ZResourcesLib/lang/common/" .. slot6, slot2, true)
	end
end

function slot1._getFolderPrefabs(slot0)
	slot1 = {}

	if not SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.GetEditorResPath(slot0)) then
		logError("文件夹" .. slot0 .. "不存在，请检查")
	else
		for slot6 = 0, SLFramework.FileHelper.GetDirFilePaths(slot0).Length - 1 do
			if slot2[slot6]:match("%.prefab$") then
				slot1[#slot1 + 1] = slot7
			end
		end
	end

	return slot1
end

function slot1._getResFolderFiles(slot0, slot1)
	slot2 = {}

	if not SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.GetEditorResPath(slot0)) then
		logError("文件夹" .. slot0 .. " 不存在，请检查")
	else
		for slot7 = 0, SLFramework.FileHelper.GetDirFilePaths(slot0).Length - 1 do
			if slot3[slot7]:match("%." .. slot1 .. "$") then
				slot2[#slot2 + 1] = slot8
			end
		end
	end

	return slot2
end

return slot1
