module("modules.versionactivitybase.dungeon.controller.VersionActivityDungeonBaseController", package.seeall)

local var_0_0 = class("VersionActivityDungeonBaseController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_2_0.updateIsFirstPassEpisodeByDungeonInfo, arg_2_0)
end

function var_0_0.getChapterLastSelectEpisode(arg_3_0, arg_3_1)
	if not arg_3_0.chapterIdLastSelectEpisodeIdDict then
		arg_3_0:initChapterIdLastSelectEpisodeIdDict()
	end

	if not arg_3_0.chapterIdLastSelectEpisodeIdDict[arg_3_1] then
		return DungeonConfig.instance:getChapterEpisodeCOList(arg_3_1)[1].id
	end

	return arg_3_0.chapterIdLastSelectEpisodeIdDict[arg_3_1]
end

function var_0_0.getKey(arg_4_0)
	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.VersionActivityChapterLastSelectEpisodeId)
end

function var_0_0.initChapterIdLastSelectEpisodeIdDict(arg_5_0)
	arg_5_0.chapterIdLastSelectEpisodeIdDict = {}

	local var_5_0 = PlayerPrefsHelper.getString(arg_5_0:getKey(), "")

	if string.nilorempty(var_5_0) then
		return
	end

	local var_5_1

	for iter_5_0, iter_5_1 in ipairs(string.split(var_5_0, ";")) do
		local var_5_2 = string.splitToNumber(iter_5_1, ":")

		if var_5_2 and #var_5_2 == 2 then
			arg_5_0.chapterIdLastSelectEpisodeIdDict[var_5_2[1]] = var_5_2[2]
		end
	end
end

function var_0_0.setChapterIdLastSelectEpisodeId(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.chapterIdLastSelectEpisodeIdDict then
		arg_6_0:initChapterIdLastSelectEpisodeIdDict()
	end

	if arg_6_0.chapterIdLastSelectEpisodeIdDict[arg_6_1] == arg_6_2 then
		return
	end

	arg_6_0.chapterIdLastSelectEpisodeIdDict[arg_6_1] = arg_6_2

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.chapterIdLastSelectEpisodeIdDict) do
		table.insert(var_6_0, string.format("%s:%s", iter_6_0, iter_6_1))
	end

	PlayerPrefsHelper.setString(arg_6_0:getKey(), table.concat(var_6_0, ";"))
end

function var_0_0.clearChapterIdLastSelectEpisodeId(arg_7_0)
	arg_7_0.chapterIdLastSelectEpisodeIdDict = nil
end

function var_0_0.getIsFirstPassEpisode(arg_8_0)
	return arg_8_0.checkIsFirstPass, arg_8_0.checkEpisodeId
end

function var_0_0.resetIsFirstPassEpisode(arg_9_0, arg_9_1)
	arg_9_0.checkEpisodeId = arg_9_1
	arg_9_0.checkIsFirstPass = false

	if not arg_9_1 then
		arg_9_0.hasPassEpisode = true

		return
	end

	arg_9_0.hasPassEpisode = DungeonModel.instance:hasPassLevelAndStory(arg_9_1)
end

function var_0_0.updateIsFirstPassEpisodeByDungeonInfo(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1.episodeId then
		arg_10_0:updateIsFirstPassEpisode(arg_10_1.episodeId)
	end
end

function var_0_0.updateIsFirstPassEpisode(arg_11_0, arg_11_1)
	if arg_11_0.checkEpisodeId ~= arg_11_1 then
		return
	end

	if arg_11_0.hasPassEpisode then
		arg_11_0.checkIsFirstPass = false

		return
	end

	arg_11_0.checkIsFirstPass = DungeonModel.instance:hasPassLevelAndStory(arg_11_1)
end

function var_0_0.isOpenActivityHardDungeonChapter(arg_12_0, arg_12_1)
	local var_12_0 = ActivityConfig.instance:getActivityDungeonConfig(arg_12_1)

	if not var_12_0 then
		logError("act Id : " .. arg_12_1 .. " not exist activity dungeon config, please check!!!")

		return false
	end

	if not VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(var_12_0.hardChapterId) then
		return false
	end

	return DungeonModel.instance:chapterIsUnLock(var_12_0.hardChapterId)
end

function var_0_0.isOpenActivityHardDungeonChapterAndGetToast(arg_13_0, arg_13_1)
	local var_13_0 = ActivityConfig.instance:getActivityDungeonConfig(arg_13_1)

	if not var_13_0 then
		logError("act Id : " .. arg_13_1 .. " not exist activity dungeon config, please check!!!")

		return false, 10301
	end

	if not VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(var_13_0.hardChapterId) then
		return false, 10301
	end

	if not DungeonModel.instance:chapterIsUnLock(var_13_0.hardChapterId) then
		return false, 10302
	end

	return true
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)
var_0_0.instance:addConstEvents()

return var_0_0
