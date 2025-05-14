module("modules.logic.versionactivity1_2.jiexika.config.Activity114Config", package.seeall)

local var_0_0 = class("Activity114Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity114_photo",
		"activity114_round",
		"activity114_task",
		"activity114_meeting",
		"activity114_difficulty",
		"activity114_const",
		"activity114_test",
		"activity114_motion",
		"activity114_event",
		"activity114_feature",
		"activity114_attribute",
		"activity114_travel"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._attrVerify = nil
	arg_2_0._eventDict = nil
	arg_2_0._eduEventDict = nil
	arg_2_0._restEventDict = nil
	arg_2_0._rateDescDict = nil
	arg_2_0._allActivityIds = nil
	arg_2_0._answerFailDict = nil
	arg_2_0._motionDic = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity114_attribute" then
		arg_3_0._attrVerify = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			local var_3_0 = string.split(iter_3_1.attributeNum, "|")
			local var_3_1 = {}

			for iter_3_2, iter_3_3 in ipairs(var_3_0) do
				var_3_1[iter_3_2] = string.splitToNumber(iter_3_3, "#")
			end

			if not arg_3_0._attrVerify[iter_3_1.activityId] then
				arg_3_0._attrVerify[iter_3_1.activityId] = {}
			end

			arg_3_0._attrVerify[iter_3_1.activityId][iter_3_1.id] = var_3_1
		end
	elseif arg_3_1 == "activity114_event" then
		arg_3_0._eventDict = {}
		arg_3_0._eduEventDict = {}
		arg_3_0._restEventDict = {}
		arg_3_0._allActivityIds = {}

		for iter_3_4, iter_3_5 in ipairs(arg_3_2.configList) do
			if not arg_3_0._eventDict[iter_3_5.activityId] then
				arg_3_0._eventDict[iter_3_5.activityId] = {}
			end

			arg_3_0._allActivityIds[iter_3_5.activityId] = true

			local var_3_2 = {}
			local var_3_3 = {}
			local var_3_4 = {}
			local var_3_5 = {}
			local var_3_6 = {}
			local var_3_7 = {}

			arg_3_0:_splitVerifyInfo(iter_3_5.successVerify, var_3_3, var_3_2)
			arg_3_0:_splitVerifyInfo(iter_3_5.failureVerify, var_3_5, var_3_4)
			arg_3_0:_splitVerifyInfo(iter_3_5.successBattle, var_3_7, var_3_6)

			local var_3_8 = {
				config = iter_3_5,
				successVerify = var_3_2,
				failureVerify = var_3_4,
				successFeatures = var_3_3,
				failureFeatures = var_3_5,
				successBattleFeatures = var_3_7,
				successBattleVerify = var_3_6
			}

			arg_3_0._eventDict[iter_3_5.activityId][iter_3_5.id] = var_3_8

			if iter_3_5.eventType == Activity114Enum.EventType.Edu then
				if not arg_3_0._eduEventDict[iter_3_5.activityId] then
					arg_3_0._eduEventDict[iter_3_5.activityId] = {}
				end

				arg_3_0._eduEventDict[iter_3_5.activityId][tonumber(iter_3_5.param)] = var_3_8
			elseif iter_3_5.eventType == Activity114Enum.EventType.Rest then
				if not arg_3_0._restEventDict[iter_3_5.activityId] then
					arg_3_0._restEventDict[iter_3_5.activityId] = {}
				end

				arg_3_0._restEventDict[iter_3_5.activityId][tonumber(iter_3_5.param)] = var_3_8
			end
		end
	elseif arg_3_1 == "activity114_difficulty" then
		arg_3_0._rateDescDict = {}

		for iter_3_6, iter_3_7 in ipairs(arg_3_2.configList) do
			local var_3_9 = string.splitToNumber(iter_3_7.interval, ",")

			arg_3_0._rateDescDict[iter_3_6] = {
				min = var_3_9[1],
				max = var_3_9[2],
				co = iter_3_7
			}
		end
	elseif arg_3_1 == "activity114_test" then
		arg_3_0._answerFailDict = {}

		for iter_3_8, iter_3_9 in pairs(arg_3_2.configDict) do
			arg_3_0._answerFailDict[iter_3_8] = {}

			for iter_3_10, iter_3_11 in pairs(iter_3_9) do
				if not arg_3_0._answerFailDict[iter_3_8][iter_3_11.testId] then
					local var_3_10 = string.splitToNumber(iter_3_11.result, "#")

					arg_3_0._answerFailDict[iter_3_8][iter_3_11.testId] = var_3_10[1]
				end
			end
		end
	elseif arg_3_1 == "activity114_motion" then
		arg_3_0._motionDic = {}

		for iter_3_12, iter_3_13 in ipairs(arg_3_2.configList) do
			if iter_3_13.type == Activity114Enum.MotionType.Time then
				if not arg_3_0._motionDic[iter_3_13.type] then
					arg_3_0._motionDic[iter_3_13.type] = {}

					local var_3_11 = string.splitToNumber(iter_3_13.param, "#")

					arg_3_0._motionDic.firstTime = var_3_11[1] or 0
					arg_3_0._motionDic.nextTime = var_3_11[2] or 0
				end

				table.insert(arg_3_0._motionDic[iter_3_13.type], iter_3_13)
			elseif iter_3_13.type == Activity114Enum.MotionType.Click then
				arg_3_0._motionDic[iter_3_13.type] = iter_3_13
			else
				if not arg_3_0._motionDic[iter_3_13.type] then
					arg_3_0._motionDic[iter_3_13.type] = {}
				end

				arg_3_0._motionDic[iter_3_13.type][tonumber(iter_3_13.param)] = iter_3_13
			end
		end
	end
end

function var_0_0._splitVerifyInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if string.nilorempty(arg_4_1) then
		return
	end

	for iter_4_0, iter_4_1 in pairs(string.split(arg_4_1, "|")) do
		local var_4_0 = string.splitToNumber(iter_4_1, "#")

		if not var_4_0[1] then
			logError("洁西卡事件奖励配置错误：" .. arg_4_1)
		end

		if var_4_0[1] == Activity114Enum.AddAttrType.Feature then
			table.insert(arg_4_2, var_4_0[2])
		elseif var_4_0[1] and var_4_0[1] < Activity114Enum.Attr.End or var_4_0[1] == Activity114Enum.AddAttrType.Attention or var_4_0[1] == Activity114Enum.AddAttrType.KeyDayScore or var_4_0[1] == Activity114Enum.AddAttrType.LastKeyDayScore then
			arg_4_3[var_4_0[1]] = (arg_4_3[var_4_0[1]] or 0) + var_4_0[2]
		elseif var_4_0[1] then
			arg_4_3[var_4_0[1]] = arg_4_3[var_4_0[1]] or {}

			table.insert(arg_4_3[var_4_0[1]], var_4_0[2])
		end
	end
end

function var_0_0.getUnlockIds(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(lua_activity114_meeting.configDict[arg_5_1]) do
		if string.find(iter_5_1.condition, "^1#") then
			var_5_0[iter_5_1.id] = true
		end
	end

	for iter_5_2, iter_5_3 in pairs(lua_activity114_travel.configDict[arg_5_1]) do
		if string.find(iter_5_3.condition, "^1#") then
			var_5_1[iter_5_3.id] = true
		end
	end

	return var_5_0, var_5_1
end

function var_0_0.getAllActivityIds(arg_6_0)
	return arg_6_0._allActivityIds
end

function var_0_0.getFeatureCo(arg_7_0, arg_7_1, arg_7_2)
	return lua_activity114_feature.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getFeatureName(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(lua_activity114_feature.configDict[arg_8_1]) do
		table.insert(var_8_0, iter_8_1.features)
	end

	return var_8_0
end

function var_0_0.getMotionCo(arg_9_0)
	return arg_9_0._motionDic
end

function var_0_0.getAttrVerify(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_0._attrVerify[arg_10_1][arg_10_2] then
		return 0
	end

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._attrVerify[arg_10_1][arg_10_2]) do
		if arg_10_3 >= iter_10_1[1] then
			var_10_0 = iter_10_1[2]
		else
			break
		end
	end

	return var_10_0 or 0
end

function var_0_0.getEduEventCo(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._eduEventDict[arg_11_1][arg_11_2]
end

function var_0_0.getRestEventCo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._restEventDict[arg_12_1][arg_12_2]
end

function var_0_0.getEventCoById(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._eventDict[arg_13_1][arg_13_2]
end

function var_0_0.getMeetingCoList(arg_14_0, arg_14_1)
	return lua_activity114_meeting.configDict[arg_14_1]
end

function var_0_0.getTravelCoList(arg_15_0, arg_15_1)
	return lua_activity114_travel.configDict[arg_15_1]
end

function var_0_0.getTaskCoById(arg_16_0, arg_16_1, arg_16_2)
	return lua_activity114_task.configDict[arg_16_1][arg_16_2]
end

function var_0_0.getAnswerCo(arg_17_0, arg_17_1, arg_17_2)
	return lua_activity114_test.configDict[arg_17_1][arg_17_2]
end

function var_0_0.getAnswerResult(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:getAnswerCo(arg_18_1, arg_18_2)
	local var_18_1 = string.splitToNumber(var_18_0.result, "#")

	for iter_18_0 = 3, 1, -1 do
		if var_18_1[iter_18_0] > 0 then
			local var_18_2, var_18_3 = arg_18_0:getConstValue(arg_18_1, var_18_1[iter_18_0])

			if var_18_2 <= arg_18_3 then
				return iter_18_0, var_18_3
			end
		end
	end

	if var_18_1[1] > 0 then
		local var_18_4, var_18_5 = arg_18_0:getConstValue(arg_18_1, var_18_1[1])

		return 1, var_18_5
	end

	logError("查找结果失败>>" .. var_18_0.id .. " >>> " .. arg_18_3)

	return 1, ""
end

function var_0_0.getRoundCo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	return lua_activity114_round.configDict[arg_19_1][arg_19_2][arg_19_3]
end

function var_0_0.getRoundCount(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_3

	for iter_20_0 = 1, arg_20_2 - 1 do
		var_20_0 = var_20_0 + #lua_activity114_round.configDict[arg_20_1][iter_20_0]
	end

	return var_20_0
end

function var_0_0.getKeyDayCo(arg_21_0, arg_21_1, arg_21_2)
	while true do
		local var_21_0 = lua_activity114_round.configDict[arg_21_1][arg_21_2 + 1]

		if not var_21_0 or not var_21_0[1] then
			return
		end

		if var_21_0[1].type == Activity114Enum.RoundType.KeyDay then
			return var_21_0[1]
		end

		arg_21_2 = arg_21_2 + 1
	end
end

function var_0_0.getPhotoCoList(arg_22_0, arg_22_1)
	return lua_activity114_photo.configDict[arg_22_1]
end

function var_0_0.getRateDes(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._rateDescDict) do
		if arg_23_1 >= iter_23_1.min and arg_23_1 <= iter_23_1.max then
			return iter_23_1.co.word, iter_23_0
		end
	end

	return "??", 1
end

function var_0_0.getEduSuccessRate(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:getAttrCo(arg_24_1, arg_24_2)

	if not var_24_0 then
		return 0
	end

	local var_24_1 = string.splitToNumber(var_24_0.educationAttentionConsts, "#")
	local var_24_2
	local var_24_3
	local var_24_4
	local var_24_5 = (var_24_1[1] or 0) / 1000
	local var_24_6 = (var_24_1[2] or 0) / 1000
	local var_24_7 = (var_24_1[3] or 0) / 1000

	arg_24_3 = Mathf.Clamp(arg_24_3, 0, 100)

	local var_24_8 = Mathf.Floor(var_24_5 * arg_24_3^2 + var_24_6 * arg_24_3 + var_24_7)

	return Mathf.Clamp(var_24_8, 0, 100)
end

function var_0_0.getAttrName(arg_25_0, arg_25_1, arg_25_2)
	return lua_activity114_attribute.configDict[arg_25_1][arg_25_2].attrName
end

function var_0_0.getAttrCo(arg_26_0, arg_26_1, arg_26_2)
	return lua_activity114_attribute.configDict[arg_26_1][arg_26_2]
end

function var_0_0.getAttrMaxValue(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._attrVerify[arg_27_1][arg_27_2]

	if not var_27_0 then
		return 0
	end

	return var_27_0[#var_27_0][1]
end

function var_0_0.getConstValue(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = lua_activity114_const.configDict[arg_28_1]
	local var_28_1 = var_28_0 and var_28_0[arg_28_2]

	if not var_28_1 then
		return 0, ""
	end

	return var_28_1.value, var_28_1.value2
end

function var_0_0.getDiceRate(arg_29_0, arg_29_1)
	if arg_29_1 <= 2 then
		return 100
	end

	if arg_29_1 > 12 then
		return 0
	end

	if arg_29_1 >= 7 then
		arg_29_1 = 14 - arg_29_1

		local var_29_0 = 0

		for iter_29_0 = 1, arg_29_1 - 1 do
			var_29_0 = var_29_0 + iter_29_0
		end

		return Mathf.Round(var_29_0 / 36 * 100)
	else
		local var_29_1 = 0

		for iter_29_1 = 2, arg_29_1 - 1 do
			var_29_1 = var_29_1 + iter_29_1 - 1
		end

		return Mathf.Round(100 - var_29_1 / 36 * 100)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
