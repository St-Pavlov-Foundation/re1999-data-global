module("modules.logic.handbook.config.HandbookConfig", package.seeall)

slot0 = class("HandbookConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._cgConfig = nil
	slot0._cgList = nil
	slot0._storyGroupConfig = nil
	slot0._storyGroupList = nil
	slot0._storyChapterConfig = nil
	slot0._storyChapterList = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"cg",
		"handbook_story_group",
		"handbook_story_chapter",
		"handbook_character",
		"handbook_equip"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "cg" then
		slot0._cgConfig = slot2
	elseif slot1 == "handbook_story_group" then
		slot0._storyGroupConfig = slot2
	elseif slot1 == "handbook_story_chapter" then
		slot0._storyChapterConfig = slot2
	end
end

function slot0._initCGList(slot0)
	slot0._cgList = {}
	slot0._cgDungeonList = {}
	slot0._cgRoleList = {}

	for slot4, slot5 in pairs(slot0._cgConfig.configDict) do
		table.insert(slot0._cgList, slot5)
	end

	table.sort(slot0._cgList, function (slot0, slot1)
		if slot0.storyChapterId ~= slot1.storyChapterId then
			return uv0._sortBystoryChapterId(slot0.storyChapterId, slot1.storyChapterId)
		end

		if slot0.order ~= slot1.order then
			return slot0.order < slot1.order
		end

		return slot0.id < slot1.id
	end)

	for slot4, slot5 in pairs(slot0._cgList) do
		if string.len(tostring(slot5.storyChapterId)) >= 4 then
			table.insert(slot0._cgRoleList, slot5)
		else
			table.insert(slot0._cgDungeonList, slot5)
		end
	end
end

function slot0.getCGList(slot0, slot1)
	if not slot0._cgList then
		slot0:_initCGList()
	end

	if slot1 == HandbookEnum.CGType.Dungeon then
		return slot0._cgDungeonList
	elseif slot1 == HandbookEnum.CGType.Role then
		return slot0._cgRoleList
	end

	return slot0._cgList
end

function slot0.getDungeonCGList(slot0)
	if not slot0._cgList then
		slot0:_initCGList()
	end

	return slot0._cgDungeonList
end

function slot0.getRoleCGList(slot0)
	if not slot0._cgList then
		slot0:_initCGList()
	end

	return slot0._cgRoleList
end

function slot0.getCGCount(slot0)
	if not slot0._cgList then
		slot0:_initCGList()
	end

	return slot0._cgList and #slot0._cgList or 0
end

function slot0.getCGConfig(slot0, slot1)
	return slot0._cgConfig.configDict[slot1]
end

function slot0.getCGIndex(slot0, slot1, slot2)
	slot3 = slot0._cgList

	if slot2 == HandbookEnum.CGType.Dungeon then
		slot3 = slot0._cgDungeonList
	elseif slot2 == HandbookEnum.CGType.Role then
		slot3 = slot0._cgRoleList
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8.id == slot1 then
			return slot7
		end
	end

	return 0
end

function slot0._initStoryGroupList(slot0)
	slot0._storyGroupList = {}

	for slot4, slot5 in pairs(slot0._storyGroupConfig.configDict) do
		table.insert(slot0._storyGroupList, slot5)
	end

	table.sort(slot0._storyGroupList, function (slot0, slot1)
		if slot0.storyChapterId ~= slot1.storyChapterId then
			return uv0._sortBystoryChapterId(slot0.storyChapterId, slot1.storyChapterId)
		end

		if slot0.order ~= slot1.order then
			return slot0.order < slot1.order
		end

		return slot0.id < slot1.id
	end)
end

function slot0.getStoryGroupList(slot0)
	if not slot0._storyGroupList then
		slot0:_initStoryGroupList()
	end

	return slot0._storyGroupList
end

function slot0.getStoryGroupConfig(slot0, slot1)
	return slot0._storyGroupConfig.configDict[slot1]
end

function slot0._initStoryChapterList(slot0)
	slot0._storyChapterList = {}

	for slot4, slot5 in pairs(slot0._storyChapterConfig.configDict) do
		table.insert(slot0._storyChapterList, slot5)
	end

	table.sort(slot0._storyChapterList, function (slot0, slot1)
		if slot0.order ~= slot1.order then
			return slot0.order < slot1.order
		end

		return slot0.id < slot1.id
	end)
end

function slot0.getStoryChapterList(slot0)
	if not slot0._storyChapterList then
		slot0:_initStoryChapterList()
	end

	return slot0._storyChapterList
end

function slot0.getStoryChapterConfig(slot0, slot1)
	if not slot0._storyChapterConfig.configDict[slot1] then
		logError("章节不存在, ID: " .. tostring(slot1))
	end

	return slot2
end

function slot0._sortBystoryChapterId(slot0, slot1)
	if uv0.instance:getStoryChapterConfig(slot0).order ~= uv0.instance:getStoryChapterConfig(slot1).order then
		return slot2.order < slot3.order
	end

	return slot2.id < slot3.id
end

function slot0.getDialogByFragment(slot0, slot1)
	for slot5, slot6 in pairs(lua_chapter_map_element.configDict) do
		if slot6.fragment == slot1 and not string.nilorempty(slot6.param) then
			return tonumber(slot6.param)
		end
	end
end

slot0.instance = slot0.New()

return slot0
