module("modules.logic.ressplit.work.ResSplitStoryWork", package.seeall)

local var_0_0 = class("ResSplitStoryWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/")

	arg_1_0:_buildGuideStory()

	arg_1_0._storyIndex = -1
	arg_1_0._storyCount = arg_1_0._arr.Length

	arg_1_0:_dealStory()
end

function var_0_0._test(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/singlebg/storybg/")
	local var_2_2 = "Assets/ZResourcesLib/singlebg/storybg/"
	local var_2_3 = ResSplitModel.instance:getExcludeDic(ResSplitEnum.Path)
	local var_2_4 = HandbookConfig.instance:getCGList()

	for iter_2_0, iter_2_1 in pairs(var_2_4) do
		local var_2_5 = StoryBgZoneModel.instance:getBgZoneByPath(iter_2_1.image)

		if var_2_5 ~= nil then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(var_2_5.path), true)
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(var_2_5.sourcePath), true)
		end
	end

	local var_2_6 = HandbookConfig.instance:getStoryGroupList()

	for iter_2_2, iter_2_3 in pairs(var_2_6) do
		local var_2_7 = ResUrl.getStorySmallBg(iter_2_3.image)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_7, true)
	end

	for iter_2_4 = 0, var_2_1.Length - 1 do
		local var_2_8 = var_2_1[iter_2_4]

		if not string.find(var_2_8, ".meta") then
			local var_2_9 = SLFramework.FileHelper.GetUnityPath(var_2_8)
			local var_2_10 = string.gsub(var_2_9, "D:/work/projm%-client/Unity/Assets/ZResourcesLib/", "")

			if not var_2_3[var_2_10] then
				table.insert(var_2_0, var_2_10)
			end
		end
	end

	local var_2_11 = cjson.encode(var_2_0)
	local var_2_12 = string.gsub(var_2_11, "\\/", "/")
	local var_2_13 = io.open("Assets/ZResourcesLib/configs/ressplit2.json", "w")

	var_2_13:write(tostring(var_2_12))
	var_2_13:close()
	arg_2_0:onDone(true)
end

function var_0_0._dealStory(arg_3_0)
	arg_3_0._storyIndex = arg_3_0._storyIndex + 1

	if arg_3_0._storyIndex >= arg_3_0._storyCount then
		arg_3_0:onDone(true)

		return
	end

	local var_3_0 = arg_3_0._arr[arg_3_0._storyIndex]

	if not string.find(var_3_0, ".meta") then
		local var_3_1 = SLFramework.FileHelper.GetFileName(var_3_0, false)

		arg_3_0._storyId = string.gsub(var_3_1, "json_story_step_", "")
		arg_3_0._storyId = tonumber(arg_3_0._storyId)

		if arg_3_0._storyId ~= nil and arg_3_0._storyId > 1000 then
			StoryController.instance:initStoryData(arg_3_0._storyId, arg_3_0._addStoryRes, arg_3_0)
		else
			arg_3_0:_dealStory()
		end
	else
		arg_3_0:_dealStory()
	end
end

function var_0_0._buildGuideStory(arg_4_0)
	local var_4_0 = ResSplitModel.instance:getIncludeGuide()

	if tabletool.len(var_4_0) > 0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			local var_4_1 = GuideConfig.instance:getStepList(iter_4_0)

			arg_4_0:_buildGuideStory2(var_4_1)
		end
	else
		local var_4_2 = GuideConfig.instance:getGuideList()

		for iter_4_2, iter_4_3 in pairs(var_4_2) do
			local var_4_3 = GuideConfig.instance:getStepList(iter_4_3.id)

			arg_4_0:_buildGuideStory2(var_4_3)
		end
	end
end

function var_0_0._buildGuideStory2(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if not string.nilorempty(iter_5_1.action) then
			local var_5_0 = string.split(iter_5_1.action, "|")

			for iter_5_2 = 1, #var_5_0 do
				local var_5_1, var_5_2 = string.find(var_5_0[iter_5_2], "#")
				local var_5_3
				local var_5_4

				if var_5_1 then
					var_5_3 = tonumber(string.sub(var_5_0[iter_5_2], 1, var_5_1 - 1))
					var_5_4 = string.sub(var_5_0[iter_5_2], var_5_1 + 1)
				else
					var_5_3 = tonumber(var_5_0[iter_5_2]) or var_5_0[iter_5_2]
				end

				if var_5_3 == 101 then
					local var_5_5 = string.splitToNumber(var_5_4, "#")

					for iter_5_3, iter_5_4 in ipairs(var_5_5) do
						ResSplitModel.instance:addIncludeStory(iter_5_4)
					end
				end
			end
		end
	end
end

function var_0_0._addStoryRes(arg_6_0)
	local var_6_0 = arg_6_0._storyId
	local var_6_1
	local var_6_2 = ResSplitModel.instance:isExcludeStoryId(var_6_0) and true or false
	local var_6_3
	local var_6_4 = StoryStepModel.instance:getStepList()

	for iter_6_0, iter_6_1 in ipairs(var_6_4) do
		local var_6_5 = ResUrl.getStoryBg(iter_6_1.bg.bgImg)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_5, var_6_2)

		local var_6_6 = StoryBgZoneModel.instance:getBgZoneByPath(iter_6_1.bg.bgImg)

		if var_6_6 then
			local var_6_7 = ResUrl.getStoryRes(var_6_6.sourcePath)

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_7, var_6_2)
		end

		for iter_6_2, iter_6_3 in pairs(iter_6_1.videoList) do
			local var_6_8 = string.split(iter_6_3.video, ".")[1]

			ResSplitModel.instance:setExclude(ResSplitEnum.Video, var_6_8, var_6_2)
		end

		for iter_6_4, iter_6_5 in pairs(iter_6_1.conversation.audios) do
			local var_6_9 = ResSplitModel.instance.audioDic[iter_6_5]

			if var_6_9 then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, var_6_9.bankName, var_6_2)
			end
		end

		for iter_6_6, iter_6_7 in pairs(iter_6_1.audioList) do
			local var_6_10 = ResSplitModel.instance.audioDic[iter_6_7.audio]

			if var_6_10 then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, var_6_10.bankName, var_6_2)
			end
		end

		local var_6_11 = string.format("singlebg/headicon_small/%s", iter_6_1.conversation.heroIcon)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_11, var_6_2)

		for iter_6_8, iter_6_9 in pairs(iter_6_1.picList) do
			local var_6_12 = ResUrl.getStoryItem(iter_6_9.picture)

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_12, var_6_2)
		end

		for iter_6_10, iter_6_11 in pairs(iter_6_1.heroList) do
			local var_6_13 = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(iter_6_11.heroIndex)

			if var_6_13 then
				local var_6_14 = var_6_13.type == 0 and string.format("rolesstory/%s", var_6_13.prefab) or string.format("live2d/roles/%s", var_6_13.live2dPrefab)

				if var_6_13.type == 0 and var_6_13.prefab == "" then
					logError("rolesstory is nil", var_6_0, iter_6_11.heroIndex)
				elseif var_6_13.type ~= 0 and var_6_13.live2dPrefab == "" then
					logError("live2dPrefab is nil", var_6_0, iter_6_11.heroIndex)
				else
					local var_6_15 = SLFramework.FileHelper.GetFileName(var_6_14, true)

					if var_6_13.type == 0 then
						var_6_14 = string.gsub(var_6_14, "/" .. var_6_15, "")

						ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_6_14, var_6_2)
					else
						local var_6_16 = string.gsub(var_6_14, var_6_15, "")

						ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_6_16, var_6_2)
					end
				end
			end
		end
	end

	arg_6_0:_dealStory()
end

return var_0_0
