module("modules.logic.versionactivity1_4.act135.model.Activity135Model", package.seeall)

local var_0_0 = class("Activity135Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getActivityShowReward(arg_3_0, arg_3_1)
	local var_3_0 = Activity135Config.instance:getEpisodeCos(arg_3_1)

	if not var_3_0 then
		return
	end

	local var_3_1 = {}
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		var_3_2[iter_3_1.activityId] = true

		if ActivityHelper.getActivityStatus(iter_3_1.activityId, true) == ActivityEnum.ActivityStatus.Normal then
			local var_3_3 = DungeonConfig.instance:getBonusCO(iter_3_1.firstBounsId)

			if var_3_3 then
				local var_3_4 = GameUtil.splitString2(var_3_3.fixBonus, true)

				if var_3_4 then
					for iter_3_2, iter_3_3 in ipairs(var_3_4) do
						iter_3_3.activityId = iter_3_1.activityId
						iter_3_3.isLimitFirstReward = true
					end

					tabletool.addValues(var_3_1, var_3_4)
				end
			end
		end
	end

	return var_3_1, var_3_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
