module("modules.logic.story.config.StoryConfig", package.seeall)

slot0 = class("StoryConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._groupConfigs = {}
	slot0._stepConfigs = {}
	slot0._cutConfig = {}
	slot0._skipConfig = {}
	slot0._txtdiffConfig = {}
	slot0._fadeConfig = {}
	slot0._activityOpenConfig = {}
	slot0._prologueConfig = {}
	slot0._textRefrectConfig = {}
	slot0._leadHeroSpineConfig = {}
	slot0._picTxtsConfig = {}
	slot0._storyHeroConfig = {}
	slot0._storyBgEffTransConfig = {}
	slot0._storyBgZoneConfig = {}
end

function slot0.onInit(slot0)
	slot0:_loadStoryConfig()
end

function slot0.reqConfigNames(slot0)
	return {
		"herocut",
		"storyskip",
		"story_txtdiff",
		"storydialogfade",
		"story_activity_open",
		"story_prologue_synopsis",
		"story_text_reflect",
		"story_leadherospine",
		"story_pictxt"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "herocut" then
		slot0._cutConfig = slot2
	elseif slot1 == "storyskip" then
		slot0._skipConfig = slot2
	elseif slot1 == "story_txtdiff" then
		slot0._txtdiffConfig = slot2
	elseif slot1 == "storydialogfade" then
		slot0._fadeConfig = slot2
	elseif slot1 == "story_activity_open" then
		slot0._activityOpenConfig = slot2
	elseif slot1 == "story_prologue_synopsis" then
		slot0._prologueConfig = slot2
	elseif slot1 == "story_text_reflect" then
		slot0._textRefrectConfig = slot2
	elseif slot1 == "story_leadherospine" then
		slot0._leadHeroSpineConfig = slot2
	elseif slot1 == "story_pictxt" then
		slot0._picTxtsConfig = slot2
	end
end

function slot0._loadStoryConfig(slot0)
	StoryHeroLibraryModel.instance:setStoryHeroLibraryList(addGlobalModule("modules.configs.story.lua_story_heroparam"))
	StoryBgEffectTransModel.instance:setStoryBgEffectTransList(addGlobalModule("modules.configs.story.lua_story_bgefftranstype"))

	if GameResMgr.IsFromEditorDir then
		loadNonAbAsset("configs/story/json_zone_storybg.json", SLFramework.AssetType.TEXT, function (slot0)
			if not slot0.IsLoadSuccess then
				logError("config load fail: " .. slot0.ResPath)

				return
			end

			StoryBgZoneModel.instance:setZoneList(cjson.decode(slot0.TextAsset))
		end)
	else
		slot3 = "configs/story/json_zone_storybg.json"

		loadAbAsset("configs/story", false, function (slot0)
			if slot0.IsLoadSuccess then
				StoryBgZoneModel.instance:setZoneList(cjson.decode(slot0:GetResource(uv0).text))
				slot0:Retain()
			else
				logError("加载剧情bgzone json出错！")
			end
		end)
	end
end

function slot0.loadStoryConfig(slot0, slot1, slot2, slot3)
	if GameResMgr.IsFromEditorDir then
		slot5 = false
		slot6 = false

		loadNonAbAsset(string.format("configs/story/steps/json_story_step_%s.json", slot1), SLFramework.AssetType.TEXT, function (slot0)
			if not slot0.IsLoadSuccess then
				logError("config load fail: " .. slot0.ResPath)

				return
			end

			StoryStepModel.instance:setStepList(cjson.decode(slot0.TextAsset)[3])
			slot0:Retain()

			uv0 = true

			if uv1 and uv2 then
				uv2(uv3)
			end
		end)
		loadNonAbAsset(string.format("configs/story/groups/json_story_group_%s.json", slot1), SLFramework.AssetType.TEXT, function (slot0)
			if not slot0.IsLoadSuccess then
				logError("config load fail: " .. slot0.ResPath)

				return
			end

			StoryGroupModel.instance:setGroupList(cjson.decode(slot0.TextAsset))
			slot0:Retain()

			uv0 = true

			if uv1 and uv2 then
				uv2(uv3)
			end
		end)

		return
	end

	slot4 = string.format("configs/story/steps/json_story_step_%s.json", slot1)
	slot5 = string.format("configs/story/groups/json_story_group_%s.json", slot1)

	loadAbAsset("configs/story", false, function (slot0)
		if slot0.IsLoadSuccess then
			StoryStepModel.instance:setStepList(cjson.decode(slot0:GetResource(uv0).text)[3])
			StoryGroupModel.instance:setGroupList(cjson.decode(slot0:GetResource(uv1).text))

			if uv2 then
				uv2(uv3)
			end

			slot0:Retain()
		else
			logError("加载剧情运行json出错！")
		end
	end)
end

function slot0.getActivityOpenConfig(slot0, slot1, slot2)
	return slot0._activityOpenConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getStoryCutConfig(slot0)
	return slot0._cutConfig.configDict
end

function slot0.getStorySkipConfig(slot0, slot1)
	return slot0._skipConfig.configDict[slot1]
end

function slot0.getStoryTxtDiffConfig(slot0)
	return slot0._txtdiffConfig.configDict
end

function slot0.getStoryDialogFadeConfig(slot0)
	return slot0._fadeConfig.configDict
end

function slot0.getStoryPrologueSkipConfig(slot0)
	return slot0._prologueConfig.configDict
end

function slot0.getStoryTextReflectConfig(slot0)
	return slot0._textRefrectConfig.configDict
end

function slot0.getStoryLeadHeroSpine(slot0)
	return slot0._leadHeroSpineConfig.configDict
end

function slot0.getStoryPicTxtConfig(slot0, slot1)
	return slot0._picTxtsConfig.configDict[slot1]
end

function slot0.getEpisodeStoryIds(slot0, slot1)
	if not slot1 then
		return {}
	end

	if slot1.beforeStory > 0 then
		table.insert(slot2, slot1.beforeStory)
	end

	tabletool.addValues(slot2, slot0:getEpisodeFightStory(slot1))

	if slot1.afterStory > 0 then
		table.insert(slot2, slot1.afterStory)
	end

	return slot2
end

function slot0.getEpisodeFightStory(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.story) then
		for slot7 = 1, #string.split(slot1.story, "|") do
			if string.split(slot3[slot7], "#")[3] and tonumber(slot8[3]) and slot9 > 0 then
				table.insert(slot2, slot9)
			end
		end
	end

	return slot2
end

function slot0.replaceStoryMagicText(slot0, slot1)
	for slot5, slot6 in pairs(slot0._textRefrectConfig.configDict) do
		slot1 = string.gsub(slot1, slot6.magicText, slot6.normalText)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
