module("modules.logic.versionactivity2_3.dungeon.model.VersionActivity2_3DungeonMo", package.seeall)

local var_0_0 = pureTable("VersionActivity2_3DungeonMo", VersionActivityDungeonBaseMo)

function var_0_0.updateEpisodeId(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_1 then
		var_1_0 = arg_1_1

		local var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_0)

		if var_1_1.chapterId == arg_1_0.activityDungeonConfig.story2ChapterId or var_1_1.chapterId == arg_1_0.activityDungeonConfig.story3ChapterId then
			while var_1_1.chapterId ~= arg_1_0.activityDungeonConfig.story1ChapterId do
				var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_1.preEpisode)
			end
		end

		var_1_0 = var_1_1.id
	else
		local var_1_2 = DungeonConfig.instance:getChapterEpisodeCOList(arg_1_0.chapterId)

		if DungeonModel.instance:hasPassAllChapterEpisode(arg_1_0.chapterId) then
			var_1_0 = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(arg_1_0.chapterId)
		else
			local var_1_3

			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				if (iter_1_1 and DungeonModel.instance:getEpisodeInfo(iter_1_1.id) or nil) and arg_1_0:checkEpisodeUnLock(iter_1_1) then
					var_1_0 = iter_1_1.id
				end
			end
		end
	end

	arg_1_0.episodeId = var_1_0
end

function var_0_0.checkEpisodeUnLock(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return true
	end

	local var_2_0 = arg_2_1.elementList

	if string.nilorempty(var_2_0) then
		return true
	end

	local var_2_1 = string.splitToNumber(var_2_0, "#")

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if not DungeonMapModel.instance:elementIsFinished(iter_2_1) then
			return false
		end
	end

	return true
end

return var_0_0
