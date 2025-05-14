module("modules.logic.versionactivity2_1.activity165.model.Activity165Model", package.seeall)

local var_0_0 = class("Activity165Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitInfo(arg_2_0)
	arg_2_0._actId = VersionActivity2_1Enum.ActivityId.StoryDeduction

	if ActivityModel.instance:isActOnLine(arg_2_0._actId) then
		Activity165Rpc.instance:sendAct165GetInfoRequest(arg_2_0._actId)
	end
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._actId = arg_3_1

	for iter_3_0, iter_3_1 in pairs(arg_3_2) do
		if iter_3_1.storyId then
			arg_3_0:onGetStoryInfo(iter_3_1)
		end
	end

	arg_3_0:_initAllElements()
end

function var_0_0.getStoryCount(arg_4_0)
	return 3
end

function var_0_0.onGetStoryInfo(arg_5_0, arg_5_1)
	arg_5_0:setStoryMo(arg_5_0._actId, arg_5_1)
end

function var_0_0.onModifyKeywordCallback(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.storyId

	arg_6_0:getStoryMo(arg_6_1, var_6_0):onModifyKeywordCallback(arg_6_2)
end

function var_0_0.onGenerateEnding(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_0.setEndingRedDot(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getStoryMo(arg_8_0._actId, arg_8_1)

	for iter_8_0, iter_8_1 in pairs(var_8_0.unlockEndings) do
		GameUtil.playerPrefsSetNumberByUserId(arg_8_0:getEndingRedDotKey(iter_8_0), 1)
	end
end

function var_0_0.isShowEndingRedDot(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryMo(arg_9_0._actId, arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0.unlockEndings) do
		if GameUtil.playerPrefsGetNumberByUserId(arg_9_0:getEndingRedDotKey(iter_9_0), 0) == 0 then
			return true
		end
	end
end

function var_0_0.getEndingRedDotIndex(arg_10_0)
	for iter_10_0 = 1, arg_10_0:getStoryCount() do
		if arg_10_0:isShowEndingRedDot(iter_10_0) then
			return iter_10_0
		end
	end
end

function var_0_0.getEndingRedDotKey(arg_11_0, arg_11_1)
	return arg_11_0:_getStoryPrefsKey("Ending", arg_11_1)
end

function var_0_0._getStoryPrefsKey(arg_12_0, arg_12_1, arg_12_2)
	return string.format("Activity165_%s_%s_%s", arg_12_1, arg_12_0._actId, arg_12_2)
end

function var_0_0.onRestart(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:setStoryMo(arg_13_1, arg_13_2)
end

function var_0_0.onGetReward(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:getStoryMo(arg_14_1, arg_14_2):setclaimRewardCount(arg_14_3)
end

function var_0_0.getActivityId(arg_15_0)
	return arg_15_0._actId or VersionActivity2_1Enum.ActivityId.StoryDeduction
end

function var_0_0.setStoryMo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:getStoryMo(arg_16_1, arg_16_2.storyId):setMo(arg_16_2)
end

function var_0_0.getStoryMo(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._storyMoDict then
		arg_17_0._storyMoDict = {}
	end

	if not arg_17_0._storyMoDict[arg_17_1] then
		arg_17_0._storyMoDict[arg_17_1] = {}
	end

	local var_17_0 = arg_17_0._storyMoDict[arg_17_1][arg_17_2]

	if not var_17_0 then
		var_17_0 = Activity165StoryMo.New()

		var_17_0:onInit(arg_17_1, arg_17_2)

		arg_17_0._storyMoDict[arg_17_1][arg_17_2] = var_17_0
	end

	return var_17_0
end

function var_0_0.getAllActStory(arg_18_0)
	return arg_18_0._storyMoDict and arg_18_0._storyMoDict[arg_18_0._actId] or {}
end

function var_0_0.hasUnlockStory(arg_19_0)
	local var_19_0 = arg_19_0:getAllActStory()

	if LuaUtil.tableNotEmpty(var_19_0) then
		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			if iter_19_1.isUnlock then
				return true
			end
		end
	end
end

function var_0_0.isHasUnlockEnding(arg_20_0)
	local var_20_0 = arg_20_0:getAllActStory()

	if LuaUtil.tableNotEmpty(var_20_0) then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if iter_20_1:getUnlockEndingCount() > 0 then
				return true
			end
		end
	end
end

function var_0_0._initAllElements(arg_21_0)
	local var_21_0 = arg_21_0:getAllActStory()

	arg_21_0._elements = {}

	if LuaUtil.tableNotEmpty(var_21_0) then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			tabletool.addValues(arg_21_0._elements, iter_21_1:getElements())
		end
	end
end

function var_0_0.getAllElements(arg_22_0)
	return arg_22_0._elements
end

function var_0_0.isShowAct165Reddot(arg_23_0)
	local var_23_0 = arg_23_0:getAllActStory()

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if iter_23_1:isShowReddot() then
				return true
			end
		end
	end

	return false
end

function var_0_0.setSeparateChars(arg_24_0, arg_24_1)
	local var_24_0 = {}

	if not string.nilorempty(arg_24_1) then
		local var_24_1 = string.split(arg_24_1, "\n")
		local var_24_2 = ""

		for iter_24_0 = 1, #var_24_1 do
			if not string.nilorempty(var_24_1[iter_24_0]) then
				local var_24_3 = LuaUtil.getUCharArr(var_24_1[iter_24_0])

				for iter_24_1 = 1, #var_24_3 do
					var_24_2 = var_24_2 .. var_24_3[iter_24_1]

					table.insert(var_24_0, var_24_2)
				end

				var_24_2 = var_24_2 .. "\n"

				table.insert(var_24_0, var_24_2)
			end
		end
	end

	return var_24_0
end

function var_0_0.GMCheckConfig(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(lua_activity165_step.configDict) do
		if iter_25_1.answersKeywordIds == "-1" then
			table.insert(var_25_0, iter_25_1.stepId)
		end
	end

	arg_25_0.allRounds = {}

	local var_25_1 = {}

	for iter_25_2, iter_25_3 in pairs(lua_activity165_step.configDict) do
		if not string.nilorempty(iter_25_3.nextStepConditionIds) then
			local var_25_2 = GameUtil.splitString2(iter_25_3.nextStepConditionIds, true)

			for iter_25_4, iter_25_5 in pairs(var_25_2) do
				if not arg_25_0.allRounds[iter_25_2] then
					arg_25_0.allRounds[iter_25_2] = {}
				end

				table.insert(arg_25_0.allRounds[iter_25_2], iter_25_5)

				if not LuaUtil.tableContains(var_25_1, iter_25_5[2]) then
					table.insert(var_25_1, iter_25_5[2])
				end
			end
		end
	end

	arg_25_0:GMCheckAllRounds()
end

function var_0_0.GMCheckAllRounds(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.allRounds) do
		arg_26_0:GMCheckisSameRound1(iter_26_0, iter_26_1)
	end
end

function var_0_0.GMCheckisSameRound1(arg_27_0, arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in pairs(arg_27_2) do
		if LuaUtil.tableNotEmpty(iter_27_1) then
			local var_27_0 = iter_27_1[1]

			if not arg_27_0:GMCheckisSameRound2(arg_27_1, iter_27_1, var_27_0) then
				local var_27_1 = arg_27_0:GMNextRoundByLast(var_27_0, arg_27_1)
				local var_27_2 = string.format("跳转步骤错误: 当前检查：%s步骤%s,\n%s中通过%s的步骤有：\n%s", arg_27_1, arg_27_0:logRound(iter_27_1), var_27_0, arg_27_1, arg_27_0:logRounds(var_27_1))

				SLFramework.SLLogger.LogError(var_27_2)
			elseif not arg_27_0:GMCheckisSameRound4(arg_27_1, iter_27_1) then
				local var_27_3 = string.format("跳转步骤错误: 当前检查：%s步骤%s,请检查%s是否缺少这条路径", arg_27_1, arg_27_0:logRound(iter_27_1), iter_27_1[#iter_27_1])

				SLFramework.SLLogger.LogError(var_27_3)
			end
		end
	end
end

function var_0_0.GMCheckisSameRound2(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0.allRounds[arg_28_3]

	if not var_28_0 then
		local var_28_1 = Activity165Config.instance:getStepCo(arg_28_0._actId, arg_28_3)

		if not var_28_1 or var_28_1.answersKeywordIds ~= "-1" then
			SLFramework.SLLogger.LogError("跳转步骤错误 " .. arg_28_1 .. "    " .. arg_28_3)

			return false
		else
			return true
		end
	end

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if arg_28_0:GMCheckisSameRound3(2, arg_28_2, iter_28_1) then
			return true
		end
	end

	return false
end

function var_0_0.GMCheckisSameRound4(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {}

	table.insert(var_29_0, arg_29_1)

	local var_29_1 = arg_29_2[#arg_29_2]

	for iter_29_0 = 2, #arg_29_2 - 1 do
		table.insert(var_29_0, arg_29_2[iter_29_0])
	end

	local var_29_2 = arg_29_0.allRounds[var_29_1]

	if var_29_2 then
		for iter_29_1, iter_29_2 in pairs(var_29_2) do
			if arg_29_0:GMCheckisSameRound3(1, var_29_0, iter_29_2) then
				return true
			end
		end
	else
		return true
	end

	return false
end

function var_0_0.GMNextRoundByLast(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.allRounds[arg_30_1]
	local var_30_1 = {}

	if var_30_0 then
		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			if iter_30_1[#iter_30_1] == arg_30_2 then
				table.insert(var_30_1, iter_30_1)
			end
		end
	end

	return var_30_1
end

function var_0_0.logRounds(arg_31_0, arg_31_1)
	local var_31_0 = ""

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		local var_31_1 = arg_31_0:logRound(iter_31_1)

		var_31_0 = var_31_0 .. "         " .. var_31_1
	end

	return var_31_0
end

function var_0_0.logRound(arg_32_0, arg_32_1)
	local var_32_0 = ""

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		var_32_0 = var_32_0 .. "#" .. iter_32_1
	end

	return var_32_0
end

function var_0_0.GMCheckisSameRound3(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	for iter_33_0 = arg_33_1, #arg_33_2 do
		if arg_33_2[iter_33_0] ~= arg_33_3[iter_33_0] then
			return false
		end
	end

	return true
end

function var_0_0.isPrintLog(arg_34_0)
	return arg_34_0._isPrintLog
end

function var_0_0.setPrintLog(arg_35_0, arg_35_1)
	arg_35_0._isPrintLog = arg_35_1
end

function var_0_0.closeEditView(arg_36_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
