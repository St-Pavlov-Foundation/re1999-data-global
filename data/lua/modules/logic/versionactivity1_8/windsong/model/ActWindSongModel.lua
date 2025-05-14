module("modules.logic.versionactivity1_8.windsong.model.ActWindSongModel", package.seeall)

local var_0_0 = class("ActWindSongModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.newFinishStoryLvlId = nil
	arg_2_0.newFinishFightLvlId = nil
	arg_2_0.lvlDataDic = nil
end

function var_0_0.initData(arg_3_0)
	local var_3_0 = VersionActivity1_8Enum.ActivityId.WindSong

	if not arg_3_0.lvlDataDic then
		arg_3_0.lvlDataDic = {}

		local var_3_1 = RoleActivityConfig.instance:getStoryLevelList(var_3_0)

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			local var_3_2 = DungeonModel.instance:getEpisodeInfo(iter_3_1.id)
			local var_3_3 = DungeonModel.instance:isUnlock(iter_3_1)
			local var_3_4 = {
				config = iter_3_1,
				isUnlock = var_3_3,
				star = var_3_2 and var_3_2.star or 0
			}

			arg_3_0.lvlDataDic[iter_3_1.id] = var_3_4
		end

		local var_3_5 = RoleActivityConfig.instance:getBattleLevelList(var_3_0)

		for iter_3_2, iter_3_3 in ipairs(var_3_5) do
			local var_3_6 = DungeonModel.instance:getEpisodeInfo(iter_3_3.id)
			local var_3_7 = DungeonModel.instance:isUnlock(iter_3_3)
			local var_3_8 = {
				config = iter_3_3,
				isUnlock = var_3_7,
				star = var_3_6 and var_3_6.star or 0
			}

			arg_3_0.lvlDataDic[iter_3_3.id] = var_3_8
		end
	end

	if not arg_3_0.storyChapteId or not arg_3_0.fightChapterId then
		local var_3_9 = RoleActivityConfig.instance:getActivityEnterInfo(var_3_0)

		arg_3_0.storyChapteId = var_3_9.storyGroupId
		arg_3_0.fightChapterId = var_3_9.episodeGroupId
	end
end

function var_0_0.updateData(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.lvlDataDic) do
		local var_4_0 = DungeonModel.instance:getEpisodeInfo(iter_4_0)

		iter_4_1.isUnlock = DungeonModel.instance:isUnlock(iter_4_1.config)
		iter_4_1.star = var_4_0 and var_4_0.star or 0
	end
end

function var_0_0.isLevelUnlock(arg_5_0, arg_5_1)
	if not arg_5_0.lvlDataDic[arg_5_1] then
		logError(arg_5_1 .. "data is null")

		return
	end

	return arg_5_0.lvlDataDic[arg_5_1].isUnlock
end

function var_0_0.isLevelPass(arg_6_0, arg_6_1)
	if not arg_6_0.lvlDataDic[arg_6_1] then
		logError(arg_6_1 .. "data is null")

		return
	end

	return arg_6_0.lvlDataDic[arg_6_1].star > 0
end

function var_0_0.checkFinishLevel(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.lvlDataDic then
		return
	end

	local var_7_0 = arg_7_0.lvlDataDic[arg_7_1]

	if var_7_0 and var_7_0.star == 0 and arg_7_2 > 0 then
		local var_7_1 = var_7_0.config.chapterId

		if var_7_1 == arg_7_0.storyChapteId then
			arg_7_0.newFinishStoryLvlId = arg_7_1
		elseif var_7_1 == arg_7_0.fightChapterId then
			arg_7_0.newFinishFightLvlId = arg_7_1
		end
	end
end

function var_0_0.getNewFinishStoryLvl(arg_8_0)
	return arg_8_0.newFinishStoryLvlId
end

function var_0_0.clearNewFinishStoryLvl(arg_9_0)
	arg_9_0.newFinishStoryLvlId = nil
end

function var_0_0.getNewFinishFightLvl(arg_10_0)
	return arg_10_0.newFinishFightLvlId
end

function var_0_0.clearNewFinishFightLvl(arg_11_0)
	arg_11_0.newFinishFightLvlId = nil
end

function var_0_0.setEnterFightIndex(arg_12_0, arg_12_1)
	arg_12_0.recordFightIndex = arg_12_1
end

function var_0_0.getEnterFightIndex(arg_13_0)
	local var_13_0 = arg_13_0.recordFightIndex

	arg_13_0.recordFightIndex = nil

	return var_13_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
