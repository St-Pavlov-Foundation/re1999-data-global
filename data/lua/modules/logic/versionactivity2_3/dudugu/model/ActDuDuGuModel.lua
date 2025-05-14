module("modules.logic.versionactivity2_3.dudugu.model.ActDuDuGuModel", package.seeall)

local var_0_0 = class("ActDuDuGuModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curLvIndex = 0
end

function var_0_0.setCurLvIndex(arg_3_0, arg_3_1)
	arg_3_0._curLvIndex = arg_3_1
end

function var_0_0.getCurLvIndex(arg_4_0)
	return arg_4_0._curLvIndex or 0
end

function var_0_0.initData(arg_5_0, arg_5_1)
	RoleActivityModel.instance:initData(arg_5_1)
end

function var_0_0.updateData(arg_6_0, arg_6_1)
	RoleActivityModel.instance:updateData(arg_6_1)
end

function var_0_0.isLevelUnlock(arg_7_0, arg_7_1, arg_7_2)
	return (RoleActivityModel.instance:isLevelUnlock(arg_7_1, arg_7_2))
end

function var_0_0.isLevelPass(arg_8_0, arg_8_1, arg_8_2)
	return (RoleActivityModel.instance:isLevelPass(arg_8_1, arg_8_2))
end

function var_0_0.getNewFinishStoryLvl(arg_9_0)
	local var_9_0 = VersionActivity2_3Enum.ActivityId.DuDuGu
	local var_9_1 = RoleActivityConfig.instance:getStoryLevelList(var_9_0)
	local var_9_2 = var_9_1[arg_9_0._curLvIndex].id

	if not var_9_2 or var_9_2 <= 0 then
		return
	end

	local var_9_3 = arg_9_0._curLvIndex + 1 <= #var_9_1 and var_9_1[arg_9_0._curLvIndex + 1].id or 0

	if var_9_3 > 0 then
		local var_9_4 = arg_9_0:isLevelPass(var_9_0, var_9_2)
		local var_9_5 = true
		local var_9_6 = var_9_1[arg_9_0._curLvIndex].afterStory

		if var_9_6 > 0 then
			var_9_5 = StoryModel.instance:isStoryFinished(var_9_6)
		end

		local var_9_7 = arg_9_0:isLevelUnlock(var_9_0, var_9_3)

		if var_9_4 and not var_9_7 and var_9_5 then
			arg_9_0.newFinishStoryLvlId = var_9_2

			return arg_9_0.newFinishStoryLvlId
		end
	end

	arg_9_0.newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()

	return arg_9_0.newFinishStoryLvlId
end

function var_0_0.clearNewFinishStoryLvl(arg_10_0)
	RoleActivityModel.instance:clearNewFinishStoryLvl()

	return arg_10_0.newFinishStoryLvlId
end

var_0_0.instance = var_0_0.New()

return var_0_0
