module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonMo", package.seeall)

local var_0_0 = pureTable("VersionActivity1_8DungeonMo", VersionActivityDungeonBaseMo)

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
			if arg_1_0:getIsInSideMission() then
				local var_1_3 = var_1_2[#var_1_2]

				var_1_0 = var_1_3 and var_1_3.id
			end
		else
			local var_1_4

			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				if (iter_1_1 and DungeonModel.instance:getEpisodeInfo(iter_1_1.id) or nil) and arg_1_0:checkEpisodeUnLock(iter_1_1) then
					var_1_0 = iter_1_1.id
				end
			end
		end
	end

	if var_1_0 then
		arg_1_0.episodeId = var_1_0
	else
		arg_1_0.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(arg_1_0.chapterId)
	end
end

function var_0_0.getIsInSideMission(arg_2_0)
	local var_2_0 = false

	if not Activity157Model.instance:getIsSideMissionUnlocked() then
		return var_2_0
	end

	local var_2_1 = DungeonConfig.instance:getChapterEpisodeCOList(arg_2_0.chapterId)
	local var_2_2 = var_2_1[#var_2_1]
	local var_2_3 = var_2_2 and var_2_2.id

	if not var_2_3 then
		return var_2_0
	end

	local var_2_4 = Activity157Model.instance:getActId()
	local var_2_5 = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(var_2_3)
	local var_2_6 = VersionActivity1_8DungeonModel.instance:getElementCoList(var_2_5.id)

	for iter_2_0, iter_2_1 in ipairs(var_2_6) do
		local var_2_7 = iter_2_1.id
		local var_2_8 = Activity157Config.instance:getMissionIdByElementId(var_2_4, var_2_7)

		if var_2_8 and Activity157Config.instance:isSideMission(var_2_4, var_2_8) then
			local var_2_9 = Activity157Config.instance:getMissionGroup(var_2_4, var_2_8)

			if not Activity157Model.instance:isFinishMission(var_2_9, var_2_8) then
				var_2_0 = true

				break
			end
		end
	end

	return var_2_0
end

function var_0_0.checkEpisodeUnLock(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return true
	end

	local var_3_0 = arg_3_1.elementList

	if string.nilorempty(var_3_0) then
		return true
	end

	local var_3_1 = string.splitToNumber(var_3_0, "#")

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if not DungeonMapModel.instance:elementIsFinished(iter_3_1) then
			return false
		end
	end

	return true
end

return var_0_0
