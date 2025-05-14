module("modules.logic.versionactivity1_6.getian.model.ActGeTianModel", package.seeall)

local var_0_0 = class("ActGeTianModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.newFinishStoryLvlId = nil
	arg_2_0.newFinishFightLvlId = nil
	arg_2_0.lvlDataDic = nil
end

function var_0_0.initData(arg_3_0)
	if not arg_3_0.lvlDataDic then
		arg_3_0.lvlDataDic = {}

		local var_3_0 = RoleActivityConfig.instance:getStoryLevelList(ActGeTianEnum.ActivityId)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_1 = DungeonModel.instance:getEpisodeInfo(iter_3_1.id)
			local var_3_2 = DungeonModel.instance:isUnlock(iter_3_1)
			local var_3_3 = {
				config = iter_3_1,
				isUnlock = var_3_2,
				star = var_3_1 and var_3_1.star or 0
			}

			arg_3_0.lvlDataDic[iter_3_1.id] = var_3_3
		end

		local var_3_4 = RoleActivityConfig.instance:getBattleLevelList(ActGeTianEnum.ActivityId)

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			local var_3_5 = DungeonModel.instance:getEpisodeInfo(iter_3_3.id)
			local var_3_6 = DungeonModel.instance:isUnlock(iter_3_3)
			local var_3_7 = {
				config = iter_3_3,
				isUnlock = var_3_6,
				star = var_3_5 and var_3_5.star or 0
			}

			arg_3_0.lvlDataDic[iter_3_3.id] = var_3_7
		end
	end

	if not arg_3_0.storyChapteId or not arg_3_0.fightChapterId then
		local var_3_8 = RoleActivityConfig.instance:getActivityEnterInfo(ActGeTianEnum.ActivityId)

		arg_3_0.storyChapteId = var_3_8.storyGroupId
		arg_3_0.fightChapterId = var_3_8.episodeGroupId
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

function var_0_0.setFirstEnter(arg_12_0)
	arg_12_0.firstEnter = true
end

function var_0_0.getFirstEnter(arg_13_0)
	return arg_13_0.firstEnter
end

function var_0_0.clearFirstEnter(arg_14_0)
	arg_14_0.firstEnter = nil
end

function var_0_0.setEnterFightIndex(arg_15_0, arg_15_1)
	arg_15_0.recordFightIndex = arg_15_1
end

function var_0_0.getEnterFightIndex(arg_16_0)
	local var_16_0 = arg_16_0.recordFightIndex

	arg_16_0.recordFightIndex = nil

	return var_16_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
