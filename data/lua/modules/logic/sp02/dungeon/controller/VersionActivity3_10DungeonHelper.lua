-- chunkname: @modules/logic/sp02/dungeon/controller/VersionActivity3_10DungeonHelper.lua

module("modules.logic.sp02.dungeon.controller.VersionActivity3_10DungeonHelper", package.seeall)

local VersionActivity3_10DungeonHelper = _M

function VersionActivity3_10DungeonHelper.getEpisodeMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local mode = ActivityConfig.instance:getChapterIdMode(episodeCo.chapterId)

	return mode
end

function VersionActivity3_10DungeonHelper.calcEpisodeProgress(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)
	local star = episodeMo and episodeMo.star or 0
	local conditionCount = VersionActivity3_10DungeonHelper.getEpisodeConditionCount(episodeId)

	if conditionCount == 0 then
		return 0
	end

	local curProgress = star / conditionCount

	return curProgress
end

function VersionActivity3_10DungeonHelper.getEpisodeConditionCount(episodeId)
	local count = 0
	local firstConditionList = DungeonConfig.instance:getEpisodeWinConditionTextList(episodeId)
	local advanceCondition1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local advanceCondition2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(episodeId)

	if not string.nilorempty(advanceCondition1) then
		count = count + 1
	end

	if not string.nilorempty(advanceCondition2) then
		count = count + 1
	end

	local firstConditionCount = firstConditionList and #firstConditionList or 0

	count = count + firstConditionCount

	return count
end

return VersionActivity3_10DungeonHelper
