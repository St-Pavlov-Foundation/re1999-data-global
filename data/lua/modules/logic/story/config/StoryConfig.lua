module("modules.logic.story.config.StoryConfig", package.seeall)

local var_0_0 = class("StoryConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._groupConfigs = {}
	arg_1_0._stepConfigs = {}
	arg_1_0._cutConfig = {}
	arg_1_0._skipConfig = {}
	arg_1_0._txtdiffConfig = {}
	arg_1_0._fadeConfig = {}
	arg_1_0._activityOpenConfig = {}
	arg_1_0._prologueConfig = {}
	arg_1_0._textRefrectConfig = {}
	arg_1_0._leadHeroSpineConfig = {}
	arg_1_0._picTxtsConfig = {}
	arg_1_0._storyHeroConfig = {}
	arg_1_0._storyBgEffTransConfig = {}
	arg_1_0._storyBgZoneConfig = {}
	arg_1_0._audioSwitchConfig = {}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_loadStoryConfig()
end

function var_0_0.reqConfigNames(arg_3_0)
	return {
		"herocut",
		"storyskip",
		"story_txtdiff",
		"storydialogfade",
		"story_activity_open",
		"story_prologue_synopsis",
		"story_text_reflect",
		"story_leadherospine",
		"story_pictxt",
		"story_audio_switch"
	}
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "herocut" then
		arg_4_0._cutConfig = arg_4_2
	elseif arg_4_1 == "storyskip" then
		arg_4_0._skipConfig = arg_4_2
	elseif arg_4_1 == "story_txtdiff" then
		arg_4_0._txtdiffConfig = arg_4_2
	elseif arg_4_1 == "storydialogfade" then
		arg_4_0._fadeConfig = arg_4_2
	elseif arg_4_1 == "story_activity_open" then
		arg_4_0._activityOpenConfig = arg_4_2
	elseif arg_4_1 == "story_prologue_synopsis" then
		arg_4_0._prologueConfig = arg_4_2
	elseif arg_4_1 == "story_text_reflect" then
		arg_4_0._textRefrectConfig = arg_4_2
	elseif arg_4_1 == "story_leadherospine" then
		arg_4_0._leadHeroSpineConfig = arg_4_2
	elseif arg_4_1 == "story_pictxt" then
		arg_4_0._picTxtsConfig = arg_4_2
	elseif arg_4_1 == "story_audio_switch" then
		arg_4_0._audioSwitchConfig = arg_4_2
	end
end

function var_0_0._loadStoryConfig(arg_5_0)
	local var_5_0 = addGlobalModule("modules.configs.story.lua_story_heroparam")

	StoryHeroLibraryModel.instance:setStoryHeroLibraryList(var_5_0)

	local var_5_1 = addGlobalModule("modules.configs.story.lua_story_bgefftranstype")

	StoryBgEffectTransModel.instance:setStoryBgEffectTransList(var_5_1)

	if GameResMgr.IsFromEditorDir then
		local var_5_2 = "configs/story/json_zone_storybg.json"

		loadNonAbAsset(var_5_2, SLFramework.AssetType.TEXT, function(arg_6_0)
			if not arg_6_0.IsLoadSuccess then
				logError("config load fail: " .. arg_6_0.ResPath)

				return
			end

			local var_6_0 = cjson.decode(arg_6_0.TextAsset)

			StoryBgZoneModel.instance:setZoneList(var_6_0)
		end)
	else
		local var_5_3 = "configs/story/json_zone_storybg.json"

		loadAbAsset("configs/story", false, function(arg_7_0)
			if arg_7_0.IsLoadSuccess then
				local var_7_0 = cjson.decode(arg_7_0:GetResource(var_5_3).text)

				StoryBgZoneModel.instance:setZoneList(var_7_0)
				arg_7_0:Retain()
			else
				logError("加载剧情bgzone json出错！")
			end
		end)
	end
end

function var_0_0.loadStoryConfig(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if GameResMgr.IsFromEditorDir then
		local var_8_0 = string.format("configs/story/steps/json_story_step_%s.json", arg_8_1)
		local var_8_1 = false
		local var_8_2 = false

		loadNonAbAsset(var_8_0, SLFramework.AssetType.TEXT, function(arg_9_0)
			if not arg_9_0.IsLoadSuccess then
				logError("config load fail: " .. arg_9_0.ResPath)

				return
			end

			local var_9_0 = cjson.decode(arg_9_0.TextAsset)

			StoryStepModel.instance:setStepList(var_9_0[3])
			TaskDispatcher.runDelay(function()
				SLFramework.ResMgr.Instance:ClearItem(arg_9_0)
			end, nil, 0.1)

			var_8_1 = true

			if var_8_2 and arg_8_2 then
				arg_8_2(arg_8_3)
			end
		end)

		local var_8_3 = string.format("configs/story/groups/json_story_group_%s.json", arg_8_1)

		loadNonAbAsset(var_8_3, SLFramework.AssetType.TEXT, function(arg_11_0)
			if not arg_11_0.IsLoadSuccess then
				logError("config load fail: " .. arg_11_0.ResPath)

				return
			end

			local var_11_0 = cjson.decode(arg_11_0.TextAsset)

			StoryGroupModel.instance:setGroupList(var_11_0)
			TaskDispatcher.runDelay(function()
				SLFramework.ResMgr.Instance:ClearItem(arg_11_0)
			end, nil, 0.1)

			var_8_2 = true

			if var_8_1 and arg_8_2 then
				arg_8_2(arg_8_3)
			end
		end)
	else
		local var_8_4 = string.format("configs/story/steps/json_story_step_%s.json", arg_8_1)
		local var_8_5 = string.format("configs/story/groups/json_story_group_%s.json", arg_8_1)

		loadAbAsset("configs/story", false, function(arg_13_0)
			if arg_13_0.IsLoadSuccess then
				local var_13_0 = cjson.decode(arg_13_0:GetResource(var_8_4).text)

				StoryStepModel.instance:setStepList(var_13_0[3])

				local var_13_1 = cjson.decode(arg_13_0:GetResource(var_8_5).text)

				StoryGroupModel.instance:setGroupList(var_13_1)

				if arg_8_2 then
					arg_8_2(arg_8_3)
				end

				arg_13_0:Retain()
			else
				logError("加载剧情运行json出错！")
			end
		end)
	end
end

function var_0_0.getActivityOpenConfig(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._activityOpenConfig.configDict[arg_14_1]

	return var_14_0 and var_14_0[arg_14_2]
end

function var_0_0.getStoryCutConfig(arg_15_0)
	return arg_15_0._cutConfig.configDict
end

function var_0_0.getStorySkipConfig(arg_16_0, arg_16_1)
	return arg_16_0._skipConfig.configDict[arg_16_1]
end

function var_0_0.getStoryTxtDiffConfig(arg_17_0)
	return arg_17_0._txtdiffConfig.configDict
end

function var_0_0.getStoryDialogFadeConfig(arg_18_0)
	return arg_18_0._fadeConfig.configDict
end

function var_0_0.getStoryPrologueSkipConfig(arg_19_0)
	return arg_19_0._prologueConfig.configDict
end

function var_0_0.getStoryTextReflectConfig(arg_20_0)
	return arg_20_0._textRefrectConfig.configDict
end

function var_0_0.getStoryLeadHeroSpine(arg_21_0)
	return arg_21_0._leadHeroSpineConfig.configDict
end

function var_0_0.getStoryPicTxtConfig(arg_22_0, arg_22_1)
	return arg_22_0._picTxtsConfig.configDict[arg_22_1]
end

function var_0_0.getStoryAudioSwitchConfig(arg_23_0, arg_23_1)
	return arg_23_0._audioSwitchConfig.configDict[arg_23_1]
end

function var_0_0.getEpisodeStoryIds(arg_24_0, arg_24_1)
	local var_24_0 = {}

	if not arg_24_1 then
		return var_24_0
	end

	if arg_24_1.beforeStory > 0 then
		table.insert(var_24_0, arg_24_1.beforeStory)
	end

	local var_24_1 = arg_24_0:getEpisodeFightStory(arg_24_1)

	tabletool.addValues(var_24_0, var_24_1)

	if arg_24_1.afterStory > 0 then
		table.insert(var_24_0, arg_24_1.afterStory)
	end

	return var_24_0
end

function var_0_0.getEpisodeFightStory(arg_25_0, arg_25_1)
	local var_25_0 = {}

	if not string.nilorempty(arg_25_1.story) then
		local var_25_1 = string.split(arg_25_1.story, "|")

		for iter_25_0 = 1, #var_25_1 do
			local var_25_2 = var_25_1[iter_25_0]
			local var_25_3 = string.split(var_25_2, "#")
			local var_25_4 = var_25_3[3] and tonumber(var_25_3[3])

			if var_25_4 and var_25_4 > 0 then
				table.insert(var_25_0, var_25_4)
			end
		end
	end

	return var_25_0
end

function var_0_0.replaceStoryMagicText(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._textRefrectConfig.configDict) do
		arg_26_1 = string.gsub(arg_26_1, iter_26_1.magicText, iter_26_1.normalText)
	end

	return arg_26_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
