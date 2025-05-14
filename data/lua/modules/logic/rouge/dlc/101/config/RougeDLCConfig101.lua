module("modules.logic.rouge.dlc.101.config.RougeDLCConfig101", package.seeall)

local var_0_0 = class("RougeDLCConfig101", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_limit",
		"rouge_limit_group",
		"rouge_risk",
		"rouge_limit_buff",
		"rouge_dlc_const",
		"rouge_surprise_attack",
		"rouge_unlock_skills"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "rouge_limit" then
		arg_2_0:_buildRougeLimitMap(arg_2_2)
	elseif arg_2_1 == "rouge_limit_group" then
		arg_2_0:_buildLimiterGroupMap(arg_2_2)
	elseif arg_2_1 == "rouge_risk" then
		arg_2_0._rougeRiskTab = arg_2_2
	elseif arg_2_1 == "rouge_limit_buff" then
		arg_2_0:_buildLimiterBuffMap(arg_2_2)
	elseif arg_2_1 == "rouge_unlock_skills" then
		arg_2_0:_buildRougeUnlockSkillsMap(arg_2_2)
	end
end

function var_0_0._buildRougeLimitMap(arg_3_0, arg_3_1)
	arg_3_0._limitConfigTab = arg_3_1
	arg_3_0._limiterCoGroupMap = {}
	arg_3_0._limiterCoMap = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.configList) do
		local var_3_0 = iter_3_1.group

		arg_3_0._limiterCoGroupMap[var_3_0] = arg_3_0._limiterCoGroupMap[var_3_0] or {}

		table.insert(arg_3_0._limiterCoGroupMap[var_3_0], iter_3_1)

		arg_3_0._limiterCoMap[iter_3_1.id] = iter_3_1
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0._limiterCoGroupMap) do
		table.sort(iter_3_3, var_0_0.limiterCoGroupSortFunc)
	end
end

function var_0_0.limiterCoGroupSortFunc(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.level
	local var_4_1 = arg_4_1.level

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0.getVersionLimiterCos(arg_5_0, arg_5_1)
	return arg_5_0._limitConfigTab.configDict[arg_5_1]
end

function var_0_0.getLimiterCo(arg_6_0, arg_6_1)
	return arg_6_0._limiterCoMap and arg_6_0._limiterCoMap[arg_6_1]
end

function var_0_0._buildLimiterGroupMap(arg_7_0, arg_7_1)
	arg_7_0._limitGroupConfigTab = arg_7_1
	arg_7_0._limiterGroupVersionMap = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.configList) do
			local var_7_0 = RougeDLCHelper.versionStrToList(iter_7_1.version)

			for iter_7_2, iter_7_3 in ipairs(var_7_0) do
				arg_7_0._limiterGroupVersionMap[iter_7_3] = arg_7_0._limiterGroupVersionMap[iter_7_3] or {}

				table.insert(arg_7_0._limiterGroupVersionMap[iter_7_3], iter_7_1)
			end
		end
	end
end

function var_0_0.getLimiterGroupCo(arg_8_0, arg_8_1)
	return arg_8_0._limitGroupConfigTab and arg_8_0._limitGroupConfigTab.configDict[arg_8_1]
end

function var_0_0.getAllLimiterGroupCos(arg_9_0)
	return arg_9_0._limitGroupConfigTab.configList
end

function var_0_0.getAllVersionLimiterGroupCos(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}

	if arg_10_1 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			local var_10_2 = arg_10_0._limiterGroupVersionMap and arg_10_0._limiterGroupVersionMap[iter_10_1]

			if var_10_2 then
				for iter_10_2, iter_10_3 in ipairs(var_10_2) do
					if not var_10_1[iter_10_3.id] then
						table.insert(var_10_0, iter_10_3)

						var_10_1[iter_10_3.id] = true
					end
				end
			end
		end
	end

	table.sort(var_10_0, var_0_0._limiterGroupSortFunc)

	return var_10_0
end

function var_0_0._limiterGroupSortFunc(arg_11_0, arg_11_1)
	return arg_11_0.id < arg_11_1.id
end

function var_0_0.getAllLimiterCosInGroup(arg_12_0, arg_12_1)
	return arg_12_0._limiterCoGroupMap and arg_12_0._limiterCoGroupMap[arg_12_1]
end

function var_0_0.getLimiterCoByGroupIdAndLv(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getAllLimiterCosInGroup(arg_13_1)

	return var_13_0 and var_13_0[arg_13_2]
end

function var_0_0.getLimiterGroupMaxLevel(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getAllLimiterCosInGroup(arg_14_1)

	return var_14_0 and #var_14_0 or 0
end

function var_0_0.getRougeRiskCo(arg_15_0, arg_15_1)
	return arg_15_0._rougeRiskTab and arg_15_0._rougeRiskTab[arg_15_1]
end

function var_0_0.getRougeRiskCoByRiskValue(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._rougeRiskTab.configList) do
		local var_16_1 = string.splitToNumber(iter_16_1.range, "#")
		local var_16_2 = var_16_1[1] or 0
		local var_16_3 = var_16_1[2] or 0

		if var_16_2 <= arg_16_1 and arg_16_1 <= var_16_3 then
			var_16_0 = iter_16_1

			break
		end
	end

	return var_16_0
end

function var_0_0._buildLimiterBuffMap(arg_17_0, arg_17_1)
	arg_17_0._buffTab = arg_17_1
	arg_17_0._buffTypeMap = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.configList) do
		local var_17_0 = iter_17_1.buffType

		if not string.nilorempty(var_17_0) then
			local var_17_1 = RougeDLCHelper.versionStrToList(iter_17_1.version)

			for iter_17_2, iter_17_3 in ipairs(var_17_1) do
				arg_17_0._buffTypeMap[var_17_0] = arg_17_0._buffTypeMap[var_17_0] or {}
				arg_17_0._buffTypeMap[var_17_0][iter_17_3] = arg_17_0._buffTypeMap[var_17_0][iter_17_3] or {}

				table.insert(arg_17_0._buffTypeMap[var_17_0][iter_17_3], iter_17_1)
			end
		else
			logError("肉鸽限制器Buff词条类型为空, buffId = " .. tostring(iter_17_1.id))
		end
	end
end

function var_0_0.getAllLimiterBuffCosByType(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = arg_18_0._buffTypeMap and arg_18_0._buffTypeMap[arg_18_2]

	if var_18_2 and arg_18_1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_3 = var_18_2[iter_18_1]

			if var_18_3 then
				for iter_18_2, iter_18_3 in ipairs(var_18_3) do
					if not var_18_1[iter_18_3.id] then
						var_18_1[iter_18_3.id] = true

						table.insert(var_18_0, iter_18_3)
					end
				end
			end
		end
	end

	return var_18_0
end

function var_0_0.getLimiterBuffCo(arg_19_0, arg_19_1)
	return arg_19_0._buffTab and arg_19_0._buffTab.configDict[arg_19_1]
end

function var_0_0.getAllLimiterBuffCos(arg_20_0)
	return arg_20_0._buffTab and arg_20_0._buffTab.configList
end

function var_0_0._buildRougeUnlockSkillsMap(arg_21_0, arg_21_1)
	arg_21_0._unlockSkillConfigTab = arg_21_1
	arg_21_0._unlockSkillMap = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1.configList) do
		local var_21_0 = iter_21_1.style

		arg_21_0._unlockSkillMap[var_21_0] = arg_21_0._unlockSkillMap[var_21_0] or {}

		table.insert(arg_21_0._unlockSkillMap[var_21_0], iter_21_1)
	end
end

function var_0_0.getStyleUnlockSkills(arg_22_0, arg_22_1)
	return arg_22_0._unlockSkillMap and arg_22_0._unlockSkillMap[arg_22_1]
end

function var_0_0.getUnlockSkills(arg_23_0, arg_23_1)
	return arg_23_0._unlockSkillConfigTab.configDict[arg_23_1]
end

function var_0_0.getMaxLevlRiskCo(arg_24_0)
	local var_24_0 = #lua_rouge_risk.configList

	return lua_rouge_risk.configList[var_24_0]
end

var_0_0.instance = var_0_0.New()

return var_0_0
