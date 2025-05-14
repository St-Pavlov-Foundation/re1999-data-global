module("modules.logic.achievement.controller.AchievementLevelController", package.seeall)

local var_0_0 = class("AchievementLevelController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2)
	AchievementLevelModel.instance:initData(arg_1_1, arg_1_2)
	var_0_0.instance:cleanAchievementIsNew(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	return
end

function var_0_0.selectTask(arg_3_0, arg_3_1)
	AchievementLevelModel.instance:setSelectTask(arg_3_1)
	arg_3_0:dispatchEvent(AchievementEvent.LevelViewUpdated)
end

function var_0_0.scrollTask(arg_4_0, arg_4_1)
	if AchievementLevelModel.instance:scrollTask(arg_4_1) then
		local var_4_0 = AchievementLevelModel.instance:getAchievement()

		arg_4_0:cleanAchievementIsNew(var_4_0)
		arg_4_0:dispatchEvent(AchievementEvent.LevelViewUpdated)
	end
end

function var_0_0.cleanAchievementIsNew(arg_5_0, arg_5_1)
	local var_5_0 = AchievementModel.instance:getAchievementTaskCoList(arg_5_1)

	if var_5_0 then
		local var_5_1 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_2 = AchievementModel.instance:getById(iter_5_1.id)

			if var_5_2 and var_5_2.isNew then
				table.insert(var_5_1, iter_5_1.id)
			end
		end

		if #var_5_1 > 0 then
			AchievementRpc.instance:sendReadNewAchievementRequest(var_5_1)
		end
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
