module("modules.logic.roleactivity.model.RoleActivityModel", package.seeall)

local var_0_0 = class("RoleActivityModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.newFinishStoryLvlId = nil
	arg_2_0.newFinishFightLvlId = nil
	arg_2_0.lvlDataDic = {}
	arg_2_0.recordFightIndex = {}
end

function var_0_0.initData(arg_3_0, arg_3_1)
	if not arg_3_0.lvlDataDic[arg_3_1] then
		arg_3_0.lvlDataDic[arg_3_1] = {}

		local var_3_0 = RoleActivityConfig.instance:getStoryLevelList(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			arg_3_0:_createLevelMo(arg_3_1, iter_3_1)
		end

		local var_3_1 = RoleActivityConfig.instance:getBattleLevelList(arg_3_1)

		for iter_3_2, iter_3_3 in ipairs(var_3_1) do
			arg_3_0:_createLevelMo(arg_3_1, iter_3_3)
		end
	end
end

function var_0_0._createLevelMo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = RoleActivityLevelMo.New()

	var_4_0:init(arg_4_2)

	arg_4_0.lvlDataDic[arg_4_1][arg_4_2.id] = var_4_0
end

function var_0_0.updateData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.lvlDataDic[arg_5_1]

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		iter_5_1:update()
	end
end

function var_0_0.isLevelUnlock(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.lvlDataDic[arg_6_1][arg_6_2]

	if not var_6_0 then
		logError(arg_6_2 .. "data is null")

		return
	end

	return var_6_0.isUnlock
end

function var_0_0.isLevelPass(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.lvlDataDic[arg_7_1][arg_7_2]

	if not var_7_0 then
		logError(arg_7_2 .. "data is null")

		return
	end

	return var_7_0.star > 0
end

function var_0_0.checkFinishLevel(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.lvlDataDic) do
		if iter_8_1[arg_8_1] then
			local var_8_0 = iter_8_1[arg_8_1]
			local var_8_1 = RoleActivityConfig.instance:getActivityEnterInfo(iter_8_0)

			if var_8_0 and var_8_0.star == 0 and arg_8_2 > 0 then
				local var_8_2 = var_8_0.config.chapterId

				if var_8_2 == var_8_1.storyGroupId then
					arg_8_0.newFinishStoryLvlId = arg_8_1

					break
				end

				if var_8_2 == var_8_1.episodeGroupId then
					arg_8_0.newFinishFightLvlId = arg_8_1
				end
			end

			break
		end
	end
end

function var_0_0.getNewFinishStoryLvl(arg_9_0)
	return arg_9_0.newFinishStoryLvlId
end

function var_0_0.clearNewFinishStoryLvl(arg_10_0)
	arg_10_0.newFinishStoryLvlId = nil
end

function var_0_0.getNewFinishFightLvl(arg_11_0)
	return arg_11_0.newFinishFightLvlId
end

function var_0_0.clearNewFinishFightLvl(arg_12_0)
	arg_12_0.newFinishFightLvlId = nil
end

function var_0_0.setEnterFightIndex(arg_13_0, arg_13_1)
	arg_13_0.recordFightIndex = arg_13_1
end

function var_0_0.getEnterFightIndex(arg_14_0)
	local var_14_0 = arg_14_0.recordFightIndex

	arg_14_0.recordFightIndex = nil

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
