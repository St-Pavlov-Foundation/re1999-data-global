module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

local var_0_0 = pureTable("AchievementTileMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.achievementCfgs = arg_1_1
	arg_1_0.groupId = arg_1_2
	arg_1_0.count = arg_1_1 and #arg_1_1 or 0
	arg_1_0.isGroupTop = arg_1_3
	arg_1_0.isFold = false
	arg_1_0.firstAchievementCo = arg_1_1 and arg_1_1[1]
end

function var_0_0.getLineHeightFunction(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		if arg_2_0.isGroupTop then
			return AchievementEnum.SpGroupTitleBarHeight
		else
			return 0
		end
	elseif arg_2_0.groupId == 0 then
		return AchievementEnum.MainTileLineItemHeight
	else
		if AchievementUtils.isGamePlayGroup(arg_2_0.firstAchievementCo.id) then
			return (arg_2_0.isGroupTop and AchievementEnum.SpGroupTitleBarHeight or 0) + AchievementEnum.MainTileLineItemHeight
		end

		return AchievementEnum.MainTileGroupItemHeight
	end
end

function var_0_0.getAchievementType(arg_3_0)
	return arg_3_0.groupId and arg_3_0.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
end

function var_0_0.isAchievementMatch(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = false

	if arg_4_1 == AchievementEnum.AchievementType.Single then
		if arg_4_0.achievementCfgs then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.achievementCfgs) do
				if iter_4_1.id == arg_4_2 then
					var_4_0 = true

					break
				end
			end
		end
	else
		var_4_0 = arg_4_2 == arg_4_0.groupId
	end

	return var_4_0
end

function var_0_0.overrideLineHeight(arg_5_0, arg_5_1)
	arg_5_0._cellHeight = arg_5_1
end

function var_0_0.clearOverrideLineHeight(arg_6_0)
	arg_6_0._cellHeight = nil
end

function var_0_0.getLineHeight(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._cellHeight then
		return arg_7_0._cellHeight
	end

	return (arg_7_0:getLineHeightFunction(arg_7_1, arg_7_2))
end

function var_0_0.setIsFold(arg_8_0, arg_8_1)
	arg_8_0.isFold = arg_8_1
end

function var_0_0.getIsFold(arg_9_0)
	return arg_9_0.isFold
end

function var_0_0.getGroupId(arg_10_0)
	return arg_10_0.groupId
end

return var_0_0
