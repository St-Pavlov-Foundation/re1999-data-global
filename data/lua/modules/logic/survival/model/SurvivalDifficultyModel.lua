module("modules.logic.survival.model.SurvivalDifficultyModel", package.seeall)

local var_0_0 = class("SurvivalDifficultyModel", ListScrollModel)

function var_0_0.refreshDifficulty(arg_1_0)
	arg_1_0.customDifficulty = arg_1_0:loadCustomHard()
	arg_1_0._customDifficultyDict = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.customDifficulty) do
		arg_1_0._customDifficultyDict[iter_1_1] = true
	end

	arg_1_0.difficultyList = arg_1_0:getDifficultyList()
	arg_1_0.customDifficultyList = arg_1_0:getCustomDifficultyList()
	arg_1_0.customSelectIndex = 1

	local var_1_0 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, 1)

	arg_1_0.difficultyIndex = math.min(#arg_1_0.difficultyList, var_1_0)
end

function var_0_0.getDifficultyId(arg_2_0)
	local var_2_0 = arg_2_0.difficultyList[arg_2_0.difficultyIndex]

	return var_2_0 and var_2_0.id or 0
end

function var_0_0.getCustomDifficulty(arg_3_0)
	return arg_3_0.customDifficulty
end

function var_0_0.hasSelectCustomDifficulty(arg_4_0)
	local var_4_0 = arg_4_0:getCustomDifficulty()

	return next(var_4_0) ~= nil
end

function var_0_0.isCustomDifficulty(arg_5_0)
	return arg_5_0:getDifficultyId() == SurvivalConst.CustomDifficulty
end

function var_0_0.changeDifficultyIndex(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = arg_6_0:isCustomDifficulty()

	arg_6_0.difficultyIndex = arg_6_0.difficultyIndex + arg_6_1

	if arg_6_0.difficultyIndex < 1 then
		arg_6_0.difficultyIndex = #arg_6_0.difficultyList
	end

	if arg_6_0.difficultyIndex > #arg_6_0.difficultyList then
		arg_6_0.difficultyIndex = 1
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, arg_6_0.difficultyIndex)

	local var_6_2 = arg_6_0:isCustomDifficulty()

	if var_6_1 and not var_6_2 then
		var_6_0 = "panel_out"
	elseif not var_6_1 and var_6_2 then
		var_6_0 = "panel_in"
	elseif not var_6_1 and not var_6_2 then
		var_6_0 = arg_6_1 > 0 and "switch_right" or "switch_left"
	end

	return var_6_0
end

function var_0_0.getArrowStatus(arg_7_0)
	local var_7_0 = arg_7_0.difficultyIndex > 1
	local var_7_1 = arg_7_0.difficultyIndex < #arg_7_0.difficultyList

	return var_7_0, var_7_1
end

function var_0_0.getDifficultyList(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getOutSideInfo()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_survival_hardness_mod.configList) do
		if iter_8_1.optional == 1 and var_8_0:isUnlockDifficultyMod(iter_8_1.id) then
			table.insert(var_8_1, iter_8_1)
		end
	end

	table.sort(var_8_1, SortUtil.keyLower("id"))

	return var_8_1
end

function var_0_0.getCustomDifficultyList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_survival_hardness.configList) do
		if iter_9_1.optional == 1 then
			if not var_9_0[iter_9_1.type] then
				var_9_0[iter_9_1.type] = {}
			end

			if not var_9_0[iter_9_1.type][iter_9_1.subtype] then
				var_9_0[iter_9_1.type][iter_9_1.subtype] = {}
			end

			table.insert(var_9_0[iter_9_1.type][iter_9_1.subtype], iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		for iter_9_4, iter_9_5 in pairs(iter_9_3) do
			local var_9_1 = {}

			for iter_9_6, iter_9_7 in ipairs(iter_9_5) do
				if var_9_1[iter_9_7.level] then
					logError(string.format("有相同等级的配置, type:%s subType:%s level:%s id:%s %s", iter_9_2, iter_9_4, iter_9_7.level, var_9_1[iter_9_7.level].id, iter_9_7.id))
				end

				var_9_1[iter_9_7.level] = iter_9_7
			end

			local var_9_2 = {}

			for iter_9_8 = 1, 5 do
				table.insert(var_9_2, var_9_1[iter_9_8] or {})
			end

			iter_9_3[iter_9_4] = var_9_2
		end
	end

	return var_9_0
end

function var_0_0.getDifficultyAssess(arg_10_0)
	local var_10_0 = arg_10_0:getList()
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = iter_10_1.hardId

		if var_10_2 then
			var_10_1 = var_10_1 + lua_survival_hardness.configDict[var_10_2].scoreRate
		end
	end

	return 1 + var_10_1 * 0.001
end

function var_0_0.getDifficultyShowList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = lua_survival_hardness_mod.configDict[arg_11_0:getDifficultyId()]
	local var_11_2 = string.splitToNumber(var_11_1.hardness, "#")

	if var_11_2 then
		for iter_11_0, iter_11_1 in pairs(var_11_2) do
			table.insert(var_11_0, {
				hardId = iter_11_1
			})
		end
	end

	if arg_11_0:isCustomDifficulty() then
		local var_11_3 = arg_11_0:getCustomDifficulty()

		if var_11_3 then
			for iter_11_2, iter_11_3 in pairs(var_11_3) do
				table.insert(var_11_0, {
					hardId = iter_11_3
				})
			end
		end
	end

	return var_11_0
end

function var_0_0.refreshDifficultyShowList(arg_12_0)
	local var_12_0 = arg_12_0:getDifficultyShowList()
	local var_12_1 = arg_12_0:filterSameTypeHard(var_12_0, true)
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if lua_survival_hardness.configDict[iter_12_1.hardId].isShow == 0 then
			table.insert(var_12_2, iter_12_1)
		end
	end

	local var_12_3 = #var_12_2

	if var_12_3 < 4 then
		for iter_12_2 = var_12_3 + 1, 4 do
			table.insert(var_12_2, {})
		end
	end

	arg_12_0:setList(var_12_2)
end

function var_0_0.filterSameTypeHard(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_2 = iter_13_1.hardId

		if var_13_2 then
			local var_13_3 = lua_survival_hardness.configDict[var_13_2]

			if var_13_3 then
				local var_13_4 = string.format("%s_%s", var_13_3.type, var_13_3.subtype)

				if var_13_1[var_13_4] then
					local var_13_5 = lua_survival_hardness.configDict[var_13_1[var_13_4].hardId]

					if var_13_3.level > var_13_5.level then
						var_13_1[var_13_4] = iter_13_1
					end
				else
					var_13_1[var_13_4] = iter_13_1
				end
			end
		end
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_1) do
		local var_13_6 = iter_13_3.hardId

		if var_13_6 then
			local var_13_7 = lua_survival_hardness.configDict[var_13_6]

			if var_13_7 then
				local var_13_8 = string.format("%s_%s", var_13_7.type, var_13_7.subtype)

				if var_13_1[var_13_8] and var_13_1[var_13_8].hardId == var_13_6 then
					table.insert(var_13_0, iter_13_3)
				end
			end
		end
	end

	return var_13_0
end

function var_0_0.sendDifficultyChoose(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getDifficultyId()

	if arg_14_0:isCustomDifficulty() then
		local var_14_1 = arg_14_0:getDifficultyShowList()
		local var_14_2 = arg_14_0:filterSameTypeHard(var_14_1)
		local var_14_3 = {}

		if var_14_2 then
			local var_14_4 = lua_survival_hardness_mod.configDict[arg_14_0:getDifficultyId()]
			local var_14_5 = string.splitToNumber(var_14_4.hardness, "#")

			for iter_14_0, iter_14_1 in pairs(var_14_2) do
				local var_14_6 = iter_14_1.hardId

				if var_14_6 then
					local var_14_7 = lua_survival_hardness.configDict[var_14_6]

					if var_14_7 and var_14_7.optional == 1 and not tabletool.indexOf(var_14_5, var_14_6) then
						table.insert(var_14_3, var_14_6)
					end
				end
			end
		end

		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(var_14_0, var_14_3, arg_14_1, arg_14_2)
	else
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(var_14_0, nil, arg_14_1, arg_14_2)
	end
end

function var_0_0.setCustomSelectIndex(arg_15_0, arg_15_1)
	if arg_15_0.customSelectIndex == arg_15_1 then
		return
	end

	arg_15_0.customSelectIndex = arg_15_1

	return true
end

function var_0_0.getCustomSelectIndex(arg_16_0)
	return arg_16_0.customSelectIndex
end

function var_0_0.getCustomDifficultyAssess(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_0:getCustomDifficulty()

	if var_17_1 then
		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			local var_17_2 = lua_survival_hardness.configDict[iter_17_1]

			if var_17_2 and var_17_2.type == arg_17_1 then
				var_17_0 = var_17_0 + var_17_2.level
			end
		end
	end

	return var_17_0
end

function var_0_0.isSelectCustomDifficulty(arg_18_0, arg_18_1)
	return arg_18_0._customDifficultyDict[arg_18_1] ~= nil
end

function var_0_0.selectCustomDifficulty(arg_19_0, arg_19_1)
	local var_19_0 = lua_survival_hardness.configDict[arg_19_1]
	local var_19_1
	local var_19_2

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.customDifficulty) do
		if iter_19_1 ~= arg_19_1 then
			local var_19_3 = lua_survival_hardness.configDict[iter_19_1]

			if var_19_0.type == var_19_3.type and var_19_0.subtype == var_19_3.subtype then
				var_19_1 = iter_19_0
				var_19_2 = iter_19_1

				break
			end
		end
	end

	if var_19_1 then
		arg_19_0._customDifficultyDict[var_19_2] = nil

		table.remove(arg_19_0.customDifficulty, var_19_1)
	end

	if arg_19_0:isSelectCustomDifficulty(arg_19_1) then
		arg_19_0._customDifficultyDict[arg_19_1] = nil

		tabletool.removeValue(arg_19_0.customDifficulty, arg_19_1)
	else
		arg_19_0._customDifficultyDict[arg_19_1] = true

		table.insert(arg_19_0.customDifficulty, arg_19_1)
	end

	arg_19_0:saveCustomHard()

	return true
end

function var_0_0.saveCustomHard(arg_20_0)
	local var_20_0 = arg_20_0:getCustomDifficulty()
	local var_20_1 = string.format("%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_20_1, table.concat(var_20_0, "#"))
end

function var_0_0.loadCustomHard(arg_21_0)
	local var_21_0 = string.format("%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId)
	local var_21_1 = PlayerPrefsHelper.getString(var_21_0)
	local var_21_2 = {}

	if not string.nilorempty(var_21_1) then
		local var_21_3 = SurvivalModel.instance:getOutSideInfo()
		local var_21_4 = string.splitToNumber(var_21_1, "#")

		for iter_21_0, iter_21_1 in ipairs(var_21_4) do
			local var_21_5 = lua_survival_hardness.configDict[iter_21_1]

			if var_21_5 and var_21_5.optional == 1 and var_21_3:isUnlockDifficulty(iter_21_1) then
				table.insert(var_21_2, iter_21_1)
			end
		end
	end

	return var_21_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
