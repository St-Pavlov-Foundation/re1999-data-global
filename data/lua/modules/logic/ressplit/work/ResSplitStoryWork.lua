module("modules.logic.ressplit.work.ResSplitStoryWork", package.seeall)

slot0 = class("ResSplitStoryWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/")

	slot0:_buildGuideStory()

	slot0._storyIndex = -1
	slot0._storyCount = slot0._arr.Length

	slot0:_dealStory()
end

function slot0._test(slot0)
	slot1 = {}
	slot2 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/singlebg/storybg/")
	slot3 = "Assets/ZResourcesLib/singlebg/storybg/"
	slot4 = ResSplitModel.instance:getExcludeDic(ResSplitEnum.Path)

	for slot9, slot10 in pairs(HandbookConfig.instance:getCGList()) do
		if StoryBgZoneModel.instance:getBgZoneByPath(slot10.image) ~= nil then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(slot11.path), true)
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(slot11.sourcePath), true)
		end
	end

	for slot10, slot11 in pairs(HandbookConfig.instance:getStoryGroupList()) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStorySmallBg(slot11.image), true)
	end

	for slot10 = 0, slot2.Length - 1 do
		if not string.find(slot2[slot10], ".meta") and not slot4[string.gsub(SLFramework.FileHelper.GetUnityPath(slot11), "D:/work/projm%-client/Unity/Assets/ZResourcesLib/", "")] then
			table.insert(slot1, slot12)
		end
	end

	slot8 = io.open("Assets/ZResourcesLib/configs/ressplit2.json", "w")

	slot8:write(tostring(string.gsub(cjson.encode(slot1), "\\/", "/")))
	slot8:close()
	slot0:onDone(true)
end

function slot0._dealStory(slot0)
	slot0._storyIndex = slot0._storyIndex + 1

	if slot0._storyCount <= slot0._storyIndex then
		slot0:onDone(true)

		return
	end

	if not string.find(slot0._arr[slot0._storyIndex], ".meta") then
		slot0._storyId = string.gsub(SLFramework.FileHelper.GetFileName(slot1, false), "json_story_step_", "")
		slot0._storyId = tonumber(slot0._storyId)

		if slot0._storyId ~= nil and slot0._storyId > 1000 then
			StoryController.instance:initStoryData(slot0._storyId, slot0._addStoryRes, slot0)
		else
			slot0:_dealStory()
		end
	else
		slot0:_dealStory()
	end
end

function slot0._buildGuideStory(slot0)
	if tabletool.len(ResSplitModel.instance:getIncludeGuide()) > 0 then
		for slot5, slot6 in pairs(slot1) do
			slot0:_buildGuideStory2(GuideConfig.instance:getStepList(slot5))
		end
	else
		for slot5, slot6 in pairs(GuideConfig.instance:getGuideList()) do
			slot0:_buildGuideStory2(GuideConfig.instance:getStepList(slot6.id))
		end
	end
end

function slot0._buildGuideStory2(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not string.nilorempty(slot6.action) then
			for slot11 = 1, #string.split(slot6.action, "|") do
				slot12, slot13 = string.find(slot7[slot11], "#")
				slot14, slot15 = nil

				if slot12 then
					slot14 = tonumber(string.sub(slot7[slot11], 1, slot12 - 1))
					slot15 = string.sub(slot7[slot11], slot12 + 1)
				else
					slot14 = tonumber(slot7[slot11]) or slot7[slot11]
				end

				if slot14 == 101 then
					for slot20, slot21 in ipairs(string.splitToNumber(slot15, "#")) do
						ResSplitModel.instance:addIncludeStory(slot21)
					end
				end
			end
		end
	end
end

function slot0._addStoryRes(slot0)
	slot2 = nil
	slot2 = ResSplitModel.instance:isExcludeStoryId(slot0._storyId) and true or false
	slot3 = nil

	for slot8, slot9 in ipairs(StoryStepModel.instance:getStepList()) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryBg(slot9.bg.bgImg), slot2)

		if StoryBgZoneModel.instance:getBgZoneByPath(slot9.bg.bgImg) then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(slot10.sourcePath), slot2)
		end

		for slot14, slot15 in pairs(slot9.videoList) do
			ResSplitModel.instance:setExclude(ResSplitEnum.Video, string.split(slot15.video, ".")[1], slot2)
		end

		for slot14, slot15 in pairs(slot9.conversation.audios) do
			if ResSplitModel.instance.audioDic[slot15] then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, slot16.bankName, slot2)
			end
		end

		for slot14, slot15 in pairs(slot9.audioList) do
			if ResSplitModel.instance.audioDic[slot15.audio] then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, slot16.bankName, slot2)
			end
		end

		slot14 = string.format("singlebg/headicon_small/%s", slot9.conversation.heroIcon)
		slot15 = slot2

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot14, slot15)

		for slot14, slot15 in pairs(slot9.picList) do
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryItem(slot15.picture), slot2)
		end

		for slot14, slot15 in pairs(slot9.heroList) do
			if StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(slot15.heroIndex) then
				slot3 = slot16.type == 0 and string.format("rolesstory/%s", slot16.prefab) or string.format("live2d/roles/%s", slot16.live2dPrefab)

				if slot16.type == 0 and slot16.prefab == "" then
					logError("rolesstory is nil", slot1, slot15.heroIndex)
				elseif slot16.type ~= 0 and slot16.live2dPrefab == "" then
					logError("live2dPrefab is nil", slot1, slot15.heroIndex)
				elseif slot16.type == 0 then
					ResSplitModel.instance:setExclude(ResSplitEnum.Path, string.gsub(slot3, "/" .. SLFramework.FileHelper.GetFileName(slot3, true), ""), slot2)
				else
					ResSplitModel.instance:setExclude(ResSplitEnum.Folder, string.gsub(slot3, slot17, ""), slot2)
				end
			end
		end
	end

	slot0:_dealStory()
end

return slot0
