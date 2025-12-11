module("modules.logic.survival.model.SurvivalOutSideInfoMo", package.seeall)

local var_0_0 = pureTable("SurvivalOutSideInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.season = arg_1_1.season
	arg_1_0.versions = arg_1_1.versions
	arg_1_0.inWeek = arg_1_1.inWeek

	table.sort(arg_1_0.versions)
	arg_1_0:refreshDifficulty(arg_1_1.unlockDifficulty)
	arg_1_0:refreshDifficultyMod(arg_1_1.passHardnessMod)

	arg_1_0.score = arg_1_1.score
	arg_1_0.gain = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.gain) do
		arg_1_0.gain[iter_1_1] = true
	end

	arg_1_0.currMod = arg_1_1.currMod
	arg_1_0.currDay = arg_1_1.currDay
	arg_1_0.equipIds = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.equipIds) do
		table.insert(arg_1_0.equipIds, iter_1_3)
	end

	arg_1_0.npcIds = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.npcId) do
		table.insert(arg_1_0.npcIds, iter_1_5)
	end

	arg_1_0.endIdDict = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.endId) do
		arg_1_0.endIdDict[iter_1_7] = true
	end

	arg_1_0.clientData = arg_1_0.clientData or SurvivalOutSideClientDataMo.New()

	arg_1_0.clientData:init(arg_1_1.clientData)

	local var_1_0 = arg_1_1.handbookBox

	SurvivalHandbookModel.instance:setSurvivalHandbookBox(var_1_0)
end

function var_0_0.refreshDifficulty(arg_2_0, arg_2_1)
	arg_2_0.difficultyDict = {}

	if not arg_2_1 then
		return
	end

	for iter_2_0 = 1, #arg_2_1 do
		arg_2_0.difficultyDict[arg_2_1[iter_2_0]] = true
	end
end

function var_0_0.refreshDifficultyMod(arg_3_0, arg_3_1)
	arg_3_0.difficultyModDict = {}

	if not arg_3_1 then
		return
	end

	for iter_3_0 = 1, #arg_3_1 do
		arg_3_0.difficultyModDict[arg_3_1[iter_3_0]] = true
	end
end

function var_0_0.isUnlockDifficultyMod(arg_4_0, arg_4_1)
	local var_4_0 = lua_survival_hardness_mod.configDict[arg_4_1]

	if not var_4_0 then
		return false
	end

	if string.nilorempty(var_4_0.unlock) then
		return true
	end

	local var_4_1 = string.split(var_4_0.unlock, "#")

	if var_4_1[1] == SurvivalEnum.HardUnlockCondition.overDif then
		local var_4_2 = tonumber(var_4_1[2])

		return arg_4_0:isPassDifficultyMod(var_4_2)
	elseif var_4_1[1] == SurvivalEnum.HardUnlockCondition.overDifMult then
		local var_4_3 = string.splitToNumber(var_4_1[2], ",")

		for iter_4_0, iter_4_1 in ipairs(var_4_3) do
			if arg_4_0:isPassDifficultyMod(iter_4_1) then
				return true
			end
		end
	else
		logError(string.format("undefine difficulty mod unlock condition : %s", var_4_0.unlock))
	end

	return false
end

function var_0_0.isPassDifficultyMod(arg_5_0, arg_5_1)
	return arg_5_0.difficultyModDict[arg_5_1] or false
end

function var_0_0.isUnlockDifficulty(arg_6_0, arg_6_1)
	return arg_6_0.difficultyDict[arg_6_1] or false
end

function var_0_0.isFirstPlay(arg_7_0)
	return not arg_7_0:isPassDifficultyMod(SurvivalConst.FirstPlayDifficulty)
end

function var_0_0.isGainReward(arg_8_0, arg_8_1)
	return arg_8_0.gain[arg_8_1]
end

function var_0_0.getScore(arg_9_0)
	return arg_9_0.score
end

function var_0_0.getRewardState(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0:isGainReward(arg_10_1) then
		return 2
	end

	if arg_10_2 <= arg_10_0:getScore() then
		return 1
	end

	return 0
end

function var_0_0.onGainReward(arg_11_0, arg_11_1)
	if arg_11_1 ~= 0 then
		arg_11_0.gain[arg_11_1] = true

		return
	end

	local var_11_0 = SurvivalConfig.instance:getRewardList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if arg_11_0:getRewardState(iter_11_1.id, iter_11_1.score) == 1 then
			arg_11_0.gain[iter_11_1.id] = true
		end
	end
end

function var_0_0.getEndId(arg_12_0)
	local var_12_0 = lua_survival_end.configList
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if arg_12_0.endIdDict[iter_12_1.id] then
			table.insert(var_12_1, iter_12_1)
		end
	end

	table.sort(var_12_1, SortUtil.tableKeyUpper({
		"order",
		"id"
	}))

	return var_12_1[1] and var_12_1[1].id or 0
end

function var_0_0.getBootyList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0.equipIds
	local var_13_2 = arg_13_0.npcIds

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_3 = SurvivalBagItemMo.New()

		var_13_3:init({
			count = 1,
			id = iter_13_1
		})

		if var_13_3.co ~= nil then
			table.insert(var_13_0, var_13_3)
		end
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		local var_13_4 = SurvivalBagItemMo.New()

		var_13_4:init({
			count = 1,
			id = iter_13_3
		})

		if var_13_4.co ~= nil then
			table.insert(var_13_0, var_13_4)
		end
	end

	return var_13_0
end

return var_0_0
