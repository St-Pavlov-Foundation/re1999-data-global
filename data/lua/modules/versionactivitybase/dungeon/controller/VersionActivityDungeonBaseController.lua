module("modules.versionactivitybase.dungeon.controller.VersionActivityDungeonBaseController", package.seeall)

slot0 = class("VersionActivityDungeonBaseController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, slot0.updateIsFirstPassEpisodeByDungeonInfo, slot0)
end

function slot0.getChapterLastSelectEpisode(slot0, slot1)
	if not slot0.chapterIdLastSelectEpisodeIdDict then
		slot0:initChapterIdLastSelectEpisodeIdDict()
	end

	if not slot0.chapterIdLastSelectEpisodeIdDict[slot1] then
		return DungeonConfig.instance:getChapterEpisodeCOList(slot1)[1].id
	end

	return slot0.chapterIdLastSelectEpisodeIdDict[slot1]
end

function slot0.getKey(slot0)
	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.VersionActivityChapterLastSelectEpisodeId)
end

function slot0.initChapterIdLastSelectEpisodeIdDict(slot0)
	slot0.chapterIdLastSelectEpisodeIdDict = {}

	if string.nilorempty(PlayerPrefsHelper.getString(slot0:getKey(), "")) then
		return
	end

	slot2 = nil
	slot7 = slot1

	for slot6, slot7 in ipairs(string.split(slot7, ";")) do
		if string.splitToNumber(slot7, ":") and #slot2 == 2 then
			slot0.chapterIdLastSelectEpisodeIdDict[slot2[1]] = slot2[2]
		end
	end
end

function slot0.setChapterIdLastSelectEpisodeId(slot0, slot1, slot2)
	if not slot0.chapterIdLastSelectEpisodeIdDict then
		slot0:initChapterIdLastSelectEpisodeIdDict()
	end

	if slot0.chapterIdLastSelectEpisodeIdDict[slot1] == slot2 then
		return
	end

	slot0.chapterIdLastSelectEpisodeIdDict[slot1] = slot2
	slot3 = {}

	for slot7, slot8 in pairs(slot0.chapterIdLastSelectEpisodeIdDict) do
		table.insert(slot3, string.format("%s:%s", slot7, slot8))
	end

	PlayerPrefsHelper.setString(slot0:getKey(), table.concat(slot3, ";"))
end

function slot0.clearChapterIdLastSelectEpisodeId(slot0)
	slot0.chapterIdLastSelectEpisodeIdDict = nil
end

function slot0.getIsFirstPassEpisode(slot0)
	return slot0.checkIsFirstPass, slot0.checkEpisodeId
end

function slot0.resetIsFirstPassEpisode(slot0, slot1)
	slot0.checkEpisodeId = slot1
	slot0.checkIsFirstPass = false

	if not slot1 then
		slot0.hasPassEpisode = true

		return
	end

	slot0.hasPassEpisode = DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0.updateIsFirstPassEpisodeByDungeonInfo(slot0, slot1)
	if slot1 and slot1.episodeId then
		slot0:updateIsFirstPassEpisode(slot1.episodeId)
	end
end

function slot0.updateIsFirstPassEpisode(slot0, slot1)
	if slot0.checkEpisodeId ~= slot1 then
		return
	end

	if slot0.hasPassEpisode then
		slot0.checkIsFirstPass = false

		return
	end

	slot0.checkIsFirstPass = DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0.isOpenActivityHardDungeonChapter(slot0, slot1)
	if not ActivityConfig.instance:getActivityDungeonConfig(slot1) then
		logError("act Id : " .. slot1 .. " not exist activity dungeon config, please check!!!")

		return false
	end

	if not VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(slot2.hardChapterId) then
		return false
	end

	return DungeonModel.instance:chapterIsUnLock(slot2.hardChapterId)
end

function slot0.isOpenActivityHardDungeonChapterAndGetToast(slot0, slot1)
	if not ActivityConfig.instance:getActivityDungeonConfig(slot1) then
		logError("act Id : " .. slot1 .. " not exist activity dungeon config, please check!!!")

		return false, 10301
	end

	if not VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(slot2.hardChapterId) then
		return false, 10301
	end

	if not DungeonModel.instance:chapterIsUnLock(slot2.hardChapterId) then
		return false, 10302
	end

	return true
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)
slot0.instance:addConstEvents()

return slot0
