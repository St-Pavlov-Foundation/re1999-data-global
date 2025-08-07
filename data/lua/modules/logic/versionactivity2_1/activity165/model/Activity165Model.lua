module("modules.logic.versionactivity2_1.activity165.model.Activity165Model", package.seeall)

local var_0_0 = class("Activity165Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._storyMoDict = nil
end

function var_0_0.onInitInfo(arg_3_0)
	arg_3_0._actId = VersionActivity2_1Enum.ActivityId.StoryDeduction

	if ActivityModel.instance:isActOnLine(arg_3_0._actId) then
		Activity165Rpc.instance:sendAct165GetInfoRequest(arg_3_0._actId)
	end
end

function var_0_0.onGetInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._actId = arg_4_1

	for iter_4_0, iter_4_1 in pairs(arg_4_2) do
		if iter_4_1.storyId then
			arg_4_0:onGetStoryInfo(iter_4_1)
		end
	end

	arg_4_0:_initAllElements()
end

function var_0_0.getStoryCount(arg_5_0)
	return 3
end

function var_0_0.onGetStoryInfo(arg_6_0, arg_6_1)
	arg_6_0:setStoryMo(arg_6_0._actId, arg_6_1)
end

function var_0_0.onModifyKeywordCallback(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.storyId

	arg_7_0:getStoryMo(arg_7_1, var_7_0):onModifyKeywordCallback(arg_7_2)
end

function var_0_0.onGenerateEnding(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return
end

function var_0_0.setEndingRedDot(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryMo(arg_9_0._actId, arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0.unlockEndings) do
		GameUtil.playerPrefsSetNumberByUserId(arg_9_0:getEndingRedDotKey(iter_9_0), 1)
	end
end

function var_0_0.isShowEndingRedDot(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getStoryMo(arg_10_0._actId, arg_10_1)

	for iter_10_0, iter_10_1 in pairs(var_10_0.unlockEndings) do
		if GameUtil.playerPrefsGetNumberByUserId(arg_10_0:getEndingRedDotKey(iter_10_0), 0) == 0 then
			return true
		end
	end
end

function var_0_0.getEndingRedDotIndex(arg_11_0)
	for iter_11_0 = 1, arg_11_0:getStoryCount() do
		if arg_11_0:isShowEndingRedDot(iter_11_0) then
			return iter_11_0
		end
	end
end

function var_0_0.getEndingRedDotKey(arg_12_0, arg_12_1)
	return arg_12_0:_getStoryPrefsKey("Ending", arg_12_1)
end

function var_0_0._getStoryPrefsKey(arg_13_0, arg_13_1, arg_13_2)
	return (PlayerModel.instance:getPlayerPrefsKey(string.format("Activity165_%s_%s_%s", arg_13_1, arg_13_0._actId, arg_13_2)))
end

function var_0_0.onRestart(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:setStoryMo(arg_14_1, arg_14_2)
end

function var_0_0.onGetReward(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:getStoryMo(arg_15_1, arg_15_2):setclaimRewardCount(arg_15_3)
end

function var_0_0.getActivityId(arg_16_0)
	return arg_16_0._actId or VersionActivity2_1Enum.ActivityId.StoryDeduction
end

function var_0_0.setStoryMo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:getStoryMo(arg_17_1, arg_17_2.storyId):setMo(arg_17_2)
end

function var_0_0.getStoryMo(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._storyMoDict then
		arg_18_0._storyMoDict = {}
	end

	if not arg_18_0._storyMoDict[arg_18_1] then
		arg_18_0._storyMoDict[arg_18_1] = {}
	end

	local var_18_0 = arg_18_0._storyMoDict[arg_18_1][arg_18_2]

	if not var_18_0 then
		var_18_0 = Activity165StoryMo.New()

		var_18_0:onInit(arg_18_1, arg_18_2)

		arg_18_0._storyMoDict[arg_18_1][arg_18_2] = var_18_0
	end

	return var_18_0
end

function var_0_0.getAllActStory(arg_19_0)
	return arg_19_0._storyMoDict and arg_19_0._storyMoDict[arg_19_0._actId] or {}
end

function var_0_0.hasUnlockStory(arg_20_0)
	local var_20_0 = arg_20_0:getAllActStory()

	if LuaUtil.tableNotEmpty(var_20_0) then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if iter_20_1.isUnlock then
				return true
			end
		end
	end
end

function var_0_0.isHasUnlockEnding(arg_21_0)
	local var_21_0 = arg_21_0:getAllActStory()

	if LuaUtil.tableNotEmpty(var_21_0) then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			if iter_21_1:getUnlockEndingCount() > 0 then
				return true
			end
		end
	end
end

function var_0_0._initAllElements(arg_22_0)
	local var_22_0 = arg_22_0:getAllActStory()

	arg_22_0._elements = {}

	if LuaUtil.tableNotEmpty(var_22_0) then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			tabletool.addValues(arg_22_0._elements, iter_22_1:getElements())
		end
	end
end

function var_0_0.getAllElements(arg_23_0)
	return arg_23_0._elements
end

function var_0_0.isShowAct165Reddot(arg_24_0)
	local var_24_0 = arg_24_0:getAllActStory()

	if var_24_0 then
		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			if iter_24_1:isShowReddot() then
				return true
			end
		end
	end

	return false
end

function var_0_0.setSeparateChars(arg_25_0, arg_25_1)
	local var_25_0 = {}

	if not string.nilorempty(arg_25_1) then
		local var_25_1 = string.split(arg_25_1, "\n")
		local var_25_2 = ""

		for iter_25_0 = 1, #var_25_1 do
			if not string.nilorempty(var_25_1[iter_25_0]) then
				local var_25_3 = LuaUtil.getUCharArr(var_25_1[iter_25_0])

				for iter_25_1 = 1, #var_25_3 do
					var_25_2 = var_25_2 .. var_25_3[iter_25_1]

					table.insert(var_25_0, var_25_2)
				end

				var_25_2 = var_25_2 .. "\n"

				table.insert(var_25_0, var_25_2)
			end
		end
	end

	return var_25_0
end

function var_0_0.GMCheckConfig(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(lua_activity165_step.configDict) do
		if iter_26_1.answersKeywordIds == "-1" then
			table.insert(var_26_0, iter_26_1.stepId)
		end
	end

	arg_26_0.allRounds = {}

	local var_26_1 = {}

	for iter_26_2, iter_26_3 in pairs(lua_activity165_step.configDict) do
		if not string.nilorempty(iter_26_3.nextStepConditionIds) then
			local var_26_2 = GameUtil.splitString2(iter_26_3.nextStepConditionIds, true)

			for iter_26_4, iter_26_5 in pairs(var_26_2) do
				if not arg_26_0.allRounds[iter_26_2] then
					arg_26_0.allRounds[iter_26_2] = {}
				end

				table.insert(arg_26_0.allRounds[iter_26_2], iter_26_5)

				if not LuaUtil.tableContains(var_26_1, iter_26_5[2]) then
					table.insert(var_26_1, iter_26_5[2])
				end
			end
		end
	end

	arg_26_0:GMCheckAllRounds()
end

function var_0_0.GMCheckAllRounds(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.allRounds) do
		arg_27_0:GMCheckisSameRound1(iter_27_0, iter_27_1)
	end
end

function var_0_0.GMCheckisSameRound1(arg_28_0, arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in pairs(arg_28_2) do
		if LuaUtil.tableNotEmpty(iter_28_1) then
			local var_28_0 = iter_28_1[1]

			if not arg_28_0:GMCheckisSameRound2(arg_28_1, iter_28_1, var_28_0) then
				local var_28_1 = arg_28_0:GMNextRoundByLast(var_28_0, arg_28_1)
				local var_28_2 = string.format("跳转步骤错误: 当前检查：%s步骤%s,\n%s中通过%s的步骤有：\n%s", arg_28_1, arg_28_0:logRound(iter_28_1), var_28_0, arg_28_1, arg_28_0:logRounds(var_28_1))

				SLFramework.SLLogger.LogError(var_28_2)
			elseif not arg_28_0:GMCheckisSameRound4(arg_28_1, iter_28_1) then
				local var_28_3 = string.format("跳转步骤错误: 当前检查：%s步骤%s,请检查%s是否缺少这条路径", arg_28_1, arg_28_0:logRound(iter_28_1), iter_28_1[#iter_28_1])

				SLFramework.SLLogger.LogError(var_28_3)
			end
		end
	end
end

function var_0_0.GMCheckisSameRound2(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0.allRounds[arg_29_3]

	if not var_29_0 then
		local var_29_1 = Activity165Config.instance:getStepCo(arg_29_0._actId, arg_29_3)

		if not var_29_1 or var_29_1.answersKeywordIds ~= "-1" then
			SLFramework.SLLogger.LogError("跳转步骤错误 " .. arg_29_1 .. "    " .. arg_29_3)

			return false
		else
			return true
		end
	end

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if arg_29_0:GMCheckisSameRound3(2, arg_29_2, iter_29_1) then
			return true
		end
	end

	return false
end

function var_0_0.GMCheckisSameRound4(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	table.insert(var_30_0, arg_30_1)

	local var_30_1 = arg_30_2[#arg_30_2]

	for iter_30_0 = 2, #arg_30_2 - 1 do
		table.insert(var_30_0, arg_30_2[iter_30_0])
	end

	local var_30_2 = arg_30_0.allRounds[var_30_1]

	if var_30_2 then
		for iter_30_1, iter_30_2 in pairs(var_30_2) do
			if arg_30_0:GMCheckisSameRound3(1, var_30_0, iter_30_2) then
				return true
			end
		end
	else
		return true
	end

	return false
end

function var_0_0.GMNextRoundByLast(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.allRounds[arg_31_1]
	local var_31_1 = {}

	if var_31_0 then
		for iter_31_0, iter_31_1 in pairs(var_31_0) do
			if iter_31_1[#iter_31_1] == arg_31_2 then
				table.insert(var_31_1, iter_31_1)
			end
		end
	end

	return var_31_1
end

function var_0_0.logRounds(arg_32_0, arg_32_1)
	local var_32_0 = ""

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		local var_32_1 = arg_32_0:logRound(iter_32_1)

		var_32_0 = var_32_0 .. "         " .. var_32_1
	end

	return var_32_0
end

function var_0_0.logRound(arg_33_0, arg_33_1)
	local var_33_0 = ""

	for iter_33_0, iter_33_1 in pairs(arg_33_1) do
		var_33_0 = var_33_0 .. "#" .. iter_33_1
	end

	return var_33_0
end

function var_0_0.GMCheckisSameRound3(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	for iter_34_0 = arg_34_1, #arg_34_2 do
		if arg_34_2[iter_34_0] ~= arg_34_3[iter_34_0] then
			return false
		end
	end

	return true
end

function var_0_0.isPrintLog(arg_35_0)
	return arg_35_0._isPrintLog
end

function var_0_0.setPrintLog(arg_36_0, arg_36_1)
	arg_36_0._isPrintLog = arg_36_1
end

function var_0_0.closeEditView(arg_37_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
