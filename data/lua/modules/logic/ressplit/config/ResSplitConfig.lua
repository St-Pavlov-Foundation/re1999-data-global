module("modules.logic.ressplit.config.ResSplitConfig", package.seeall)

slot0 = class("ResSplitConfig", BaseConfig)

function slot0.onInit(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"app_include",
		"version_res_split"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "app_include" then
		slot0._appIncludeConfig = slot2
	end
end

function slot0.getAppIncludeConfig(slot0)
	return slot0._appIncludeConfig.configDict
end

function slot0.getMaxWeekWalkLayer(slot0)
	if slot0._maxLayer == nil then
		slot0._maxLayer = 0

		for slot4, slot5 in pairs(slot0._appIncludeConfig.configDict) do
			slot0._maxLayer = math.max(slot0._maxLayer, slot5.maxWeekWalk)
		end
	end

	return slot0._maxLayer
end

function slot0.getAllChapterIds(slot0)
	if slot0._allChapterIds == nil then
		slot0._allChapterIds = {}

		for slot4, slot5 in pairs(slot0._appIncludeConfig.configDict) do
			for slot9, slot10 in pairs(slot5.chapter) do
				slot0._allChapterIds[slot10] = true
			end
		end
	end

	return slot0._allChapterIds
end

function slot0.isSaveChapter(slot0, slot1)
	slot0:getAllChapterIds()

	return slot0._allChapterIds[slot1]
end

function slot0.getAllCharacterIds(slot0)
	if slot0._allCharacterIds == nil then
		slot0._allCharacterIds = {}

		for slot4, slot5 in pairs(slot0._appIncludeConfig.configDict) do
			for slot9, slot10 in pairs(slot5.character) do
				slot0._allCharacterIds[slot10] = true
			end
		end
	end

	return slot0._allCharacterIds
end

slot0.instance = slot0.New()

return slot0
