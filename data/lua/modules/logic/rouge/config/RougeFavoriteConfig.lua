module("modules.logic.rouge.config.RougeFavoriteConfig", package.seeall)

slot0 = class("RougeFavoriteConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_story_list",
		"rouge_illustration_list"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_story_list" then
		slot0:_initStoryList()
	elseif slot1 == "rouge_illustration_list" then
		slot0:_initIllustrationList()
	end
end

function slot0._initIllustrationList(slot0)
	slot0._illustrationList = {}
	slot0._illustrationPages = {}
	slot0._normalIllustrationPageCount = 0
	slot0._dlcIllustrationPageCount = 0
	slot1 = {}

	for slot5, slot6 in ipairs(lua_rouge_illustration_list.configList) do
		table.insert(slot1, slot6)
	end

	table.sort(slot1, uv0._sortIllustration)

	slot2 = 0

	for slot6, slot7 in ipairs(slot1) do
		slot9 = slot0._illustrationPages[slot2] and #slot8 or 0
		slot11 = slot8 and slot8[slot9]

		if not slot8 or not (slot0:isDLCIllustration(slot11 and slot11.config) == slot0:isDLCIllustration(slot7)) or RougeEnum.IllustrationNumOfPage <= slot9 then
			slot0._illustrationPages[slot2 + 1] = {}

			if slot14 then
				slot0._dlcIllustrationPageCount = slot0._dlcIllustrationPageCount + 1
			else
				slot0._normalIllustrationPageCount = slot0._normalIllustrationPageCount + 1
			end
		end

		slot17 = {
			config = slot7,
			eventIdList = string.splitToNumber(slot7.eventId, "|")
		}

		table.insert(slot0._illustrationPages[slot2], slot17)
		table.insert(slot0._illustrationList, slot17)
	end
end

function slot0._sortIllustration(slot0, slot1)
	if uv0.instance:isDLCIllustration(slot0) ~= uv0.instance:isDLCIllustration(slot1) then
		return not slot2
	end

	if slot0.order ~= slot1.order then
		return slot1.order < slot0.order
	end

	return slot0.id < slot1.id
end

function slot0.isDLCIllustration(slot0, slot1)
	return slot1 and slot1.dlc == 1
end

function slot0.getIllustrationList(slot0)
	return slot0._illustrationList
end

function slot0.getIllustrationPages(slot0)
	return slot0._illustrationPages
end

function slot0.getNormalIllustrationPageCount(slot0)
	return slot0._normalIllustrationPageCount
end

function slot0.getDLCIllustationPageCount(slot0)
	return slot0._dlcIllustrationPageCount
end

function slot0._initStoryList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_rouge_story_list.configList) do
		table.insert(slot1, slot6)
	end

	slot5 = uv0._sortStory

	table.sort(slot1, slot5)

	slot0._storyList = {}
	slot0._storyMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			index = slot5,
			config = slot6,
			storyIdList = string.splitToNumber(slot6.storyIdList, "#")
		}

		table.insert(slot0._storyList, slot7)

		slot0._storyMap[slot7.storyIdList[#slot7.storyIdList]] = true
	end
end

function slot0._sortStory(slot0, slot1)
	if slot0.stageId ~= slot1.stageId then
		return slot0.stageId < slot1.stageId
	end

	return slot0.id < slot1.id
end

function slot0.getStoryList(slot0)
	return slot0._storyList
end

function slot0.inRougeStoryList(slot0, slot1)
	return slot0._storyMap and slot0._storyMap[slot1]
end

slot0.instance = slot0.New()

return slot0
