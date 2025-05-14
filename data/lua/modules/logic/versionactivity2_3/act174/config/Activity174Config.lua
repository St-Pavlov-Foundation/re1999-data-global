module("modules.logic.versionactivity2_3.act174.config.Activity174Config", package.seeall)

local var_0_0 = class("Activity174Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity174_const",
		"activity174_turn",
		"activity174_shop",
		"activity174_bag",
		"activity174_role",
		"activity174_collection",
		"activity174_enhance",
		"activity174_bet",
		"activity174_season",
		"activity174_badge",
		"activity174_template",
		"activity174_effect"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity174_turn" then
		arg_3_0.turnConfig = arg_3_2
	elseif arg_3_1 == "activity174_shop" then
		arg_3_0.shopConfig = arg_3_2
	elseif arg_3_1 == "activity174_role" then
		arg_3_0.roleConfig = arg_3_2
	elseif arg_3_1 == "activity174_collection" then
		arg_3_0.collectionConfig = arg_3_2
	end
end

function var_0_0.initUnlockNewTeamTurnData(arg_4_0)
	arg_4_0.unlockNewTeamTurn = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.turnConfig.configList) do
		local var_4_0 = iter_4_1.turn
		local var_4_1 = iter_4_1.groupNum
		local var_4_2 = arg_4_0.unlockNewTeamTurn[var_4_1]

		if not var_4_2 or var_4_0 < var_4_2 then
			arg_4_0.unlockNewTeamTurn[var_4_1] = var_4_0
		end
	end
end

function var_0_0.isUnlockNewTeamTurn(arg_5_0, arg_5_1)
	local var_5_0 = false

	if not arg_5_0.unlockNewTeamTurn then
		arg_5_0:initUnlockNewTeamTurnData()
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.unlockNewTeamTurn) do
		if iter_5_1 == arg_5_1 then
			var_5_0 = true

			break
		end
	end

	return var_5_0
end

function var_0_0.getTurnCo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.turnConfig.configDict[arg_6_1][arg_6_2]

	if not var_6_0 then
		logError("dont exist turnCo" .. tostring(arg_6_1) .. "#" .. tostring(arg_6_2))
	end

	return var_6_0
end

function var_0_0.getMaxRound(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.turnConfig.configDict[arg_7_1]) do
		if iter_7_1.endless == 1 then
			var_7_0 = iter_7_1.turn
		end
	end

	if var_7_0 < arg_7_2 then
		return #arg_7_0.turnConfig.configDict[arg_7_1], true
	end

	return var_7_0, false
end

function var_0_0.getUnlockLevel(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.turnConfig.configDict[arg_8_1]) do
		if iter_8_1.groupNum == arg_8_2 then
			return iter_8_1.turn
		end
	end
end

function var_0_0.getShopCo(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.shopConfig.configList) do
		if iter_9_1.activityId == arg_9_1 and iter_9_1.level == arg_9_2 then
			return iter_9_1
		end
	end

	logError("dont exist shopCo" .. tostring(arg_9_1) .. "#" .. tostring(arg_9_2))
end

function var_0_0.getHeroPassiveSkillIdList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getRoleCo(arg_10_1)
	local var_10_1 = {}

	if arg_10_2 then
		var_10_1 = string.splitToNumber(var_10_0.replacePassiveSkill, "|")
	else
		var_10_1 = string.splitToNumber(var_10_0.passiveSkill, "|")
	end

	return var_10_1
end

function var_0_0.getHeroSkillIdDic(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getRoleCo(arg_11_1)
	local var_11_1 = {}
	local var_11_2 = string.splitToNumber(var_11_0.activeSkill1, "#")
	local var_11_3 = string.splitToNumber(var_11_0.activeSkill2, "#")

	if arg_11_2 then
		var_11_1[1] = var_11_2[#var_11_2]
		var_11_1[2] = var_11_3[#var_11_2]
		var_11_1[3] = var_11_0.uniqueSkill
	else
		var_11_1[1] = var_11_2
		var_11_1[2] = var_11_3
		var_11_1[3] = {
			var_11_0.uniqueSkill
		}
	end

	return var_11_1
end

function var_0_0.getRoleCo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.roleConfig.configDict[arg_12_1]

	if not var_12_0 then
		logError("dont exist role" .. tostring(arg_12_1))
	end

	return var_12_0
end

function var_0_0.getRoleCoByHeroId(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.roleConfig.configList) do
		if iter_13_1.heroId == arg_13_1 then
			return iter_13_1
		end
	end

	logError("dont exist role with heroId" .. tostring(arg_13_1))
end

function var_0_0.getCollectionCo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.collectionConfig.configDict[arg_14_1]

	if not var_14_0 then
		logError("dont exist collection" .. tostring(arg_14_1))
	end

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
