module("modules.logic.rouge.controller.RougeDLCHelper", package.seeall)

local var_0_0 = class("RougeDLCHelper")

function var_0_0.isUsingDLCs()
	local var_1_0 = RougeModel.instance:getVersion()

	return var_1_0 and #var_1_0 > 0
end

function var_0_0.isUsingTargetDLC(arg_2_0)
	local var_2_0 = RougeModel.instance:getVersion()

	if var_2_0 then
		local var_2_1 = tabletool.indexOf(var_2_0, arg_2_0)

		return var_2_1 and var_2_1 > 0
	end
end

function var_0_0.isCurrentUsingContent(arg_3_0)
	return var_0_0.isCurrentBaseContent(arg_3_0) or var_0_0.isCurrentUsingVersions(arg_3_0)
end

function var_0_0.isCurrentUsingVersions(arg_4_0)
	local var_4_0 = var_0_0.versionStrToList(arg_4_0)
	local var_4_1 = RougeModel.instance:getVersion()
	local var_4_2 = var_0_0.versionListToMap(var_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if var_4_2[iter_4_1] then
			return true
		end
	end
end

function var_0_0.isCurrentBaseContent(arg_5_0)
	return string.nilorempty(arg_5_0)
end

function var_0_0.versionListToMap(arg_6_0)
	local var_6_0 = {}

	if arg_6_0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			var_6_0[iter_6_1] = true
		end
	end

	return var_6_0
end

function var_0_0.versionStrToList(arg_7_0)
	if string.nilorempty(arg_7_0) then
		return {}
	end

	return (string.splitToNumber(arg_7_0, "#"))
end

function var_0_0.getAllCurrentUseStyleSkills(arg_8_0)
	local var_8_0 = RougeOutsideModel.instance:config():getStyleConfig(arg_8_0)

	if not var_8_0 then
		return {}
	end

	local var_8_1 = {}
	local var_8_2 = string.splitToNumber(var_8_0.activeSkills, "#")
	local var_8_3 = string.splitToNumber(var_8_0.mapSkills, "#")
	local var_8_4 = RougeDLCConfig101.instance:getStyleUnlockSkills(arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_5 = var_0_0._createSkillMo(RougeEnum.SkillType.Style, iter_8_1)

		table.insert(var_8_1, var_8_5)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_3) do
		local var_8_6 = var_0_0._createSkillMo(RougeEnum.SkillType.Map, iter_8_3)

		table.insert(var_8_1, var_8_6)
	end

	local var_8_7 = RougeOutsideModel.instance:getRougeGameRecord()

	for iter_8_4, iter_8_5 in ipairs(var_8_4 or {}) do
		local var_8_8 = var_0_0.isCurrentUsingContent(iter_8_5.version)
		local var_8_9 = var_8_7:isSkillUnlock(iter_8_5.type, iter_8_5.skillId)

		if var_8_8 and var_8_9 then
			local var_8_10 = var_0_0._createSkillMo(iter_8_5.type, iter_8_5.skillId)

			table.insert(var_8_1, var_8_10)
		end
	end

	table.sort(var_8_1, var_0_0._styleSkillSortFunc)

	return var_8_1
end

function var_0_0._createSkillMo(arg_9_0, arg_9_1)
	return {
		type = arg_9_0,
		skillId = arg_9_1
	}
end

function var_0_0._styleSkillSortFunc(arg_10_0, arg_10_1)
	local var_10_0 = RougeOutsideModel.instance:config()
	local var_10_1 = var_10_0 and var_10_0:getSkillCo(arg_10_0.type, arg_10_0.skillId)
	local var_10_2 = var_10_0 and var_10_0:getSkillCo(arg_10_1.type, arg_10_1.skillId)
	local var_10_3 = var_0_0.isCurrentBaseContent(var_10_1 and var_10_1.version)

	if var_10_3 ~= var_0_0.isCurrentBaseContent(var_10_2 and var_10_2.version) then
		return var_10_3
	end

	local var_10_4 = RougeEnum.SkillTypeSortEnum[arg_10_0.type]
	local var_10_5 = RougeEnum.SkillTypeSortEnum[arg_10_1.type]

	if var_10_4 and var_10_5 and var_10_4 ~= var_10_5 then
		return var_10_4 < var_10_5
	end

	return arg_10_0.skillId < arg_10_1.skillId
end

function var_0_0.getCurrentUseStyleFightSkills(arg_11_0)
	local var_11_0 = RougeOutsideModel.instance:config():getStyleConfig(arg_11_0)

	if not var_11_0 then
		return {}
	end

	local var_11_1 = {}
	local var_11_2 = string.splitToNumber(var_11_0.activeSkills, "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = var_0_0._createSkillMo(RougeEnum.SkillType.Style, iter_11_1)

		table.insert(var_11_1, var_11_3)
	end

	local var_11_4 = RougeOutsideModel.instance:getRougeGameRecord()
	local var_11_5 = RougeDLCConfig101.instance:getStyleUnlockSkills(arg_11_0)

	for iter_11_2, iter_11_3 in ipairs(var_11_5 or {}) do
		local var_11_6 = var_0_0.isCurrentUsingContent(iter_11_3.version)
		local var_11_7 = var_11_4:isSkillUnlock(iter_11_3.type, iter_11_3.skillId)

		if var_11_6 and var_11_7 and iter_11_3.type == RougeEnum.SkillType.Style then
			local var_11_8 = var_0_0._createSkillMo(iter_11_3.type, iter_11_3.skillId)

			table.insert(var_11_1, var_11_8)
		end
	end

	table.sort(var_11_1, var_0_0._styleSkillSortFunc)

	return var_11_1
end

function var_0_0.getCurVersionString()
	local var_12_0 = RougeOutsideModel.instance:getRougeGameRecord()
	local var_12_1 = var_12_0 and var_12_0:getVersionIds()

	return var_0_0.versionListToString(var_12_1)
end

function var_0_0.versionListToString(arg_13_0)
	local var_13_0 = ""

	if arg_13_0 then
		var_13_0 = table.concat(arg_13_0, "_")
	end

	return var_13_0
end

return var_0_0
