module("modules.logic.turnback.model.TurnbackRecommendModel", package.seeall)

local var_0_0 = class("TurnbackRecommendModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.recommendOpenMap = {}
	arg_1_0.turnbackId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.recommendOpenMap = {}
	arg_2_0.turnbackId = 0
end

function var_0_0.initReommendShowState(arg_3_0, arg_3_1)
	arg_3_0.turnbackId = arg_3_1

	local var_3_0 = TurnbackConfig.instance:getAllRecommendCo(arg_3_1) or {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if not arg_3_0.recommendOpenMap[arg_3_1] then
			arg_3_0.recommendOpenMap[arg_3_1] = {}
		end

		arg_3_0.recommendOpenMap[arg_3_1][iter_3_0] = arg_3_0:checkReommendShowState(arg_3_1, iter_3_0)
	end
end

function var_0_0.checkReommendShowState(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = TurnbackConfig.instance:getRecommendCo(arg_4_1, arg_4_2)

	if not var_4_0 then
		return false
	end

	local var_4_1 = arg_4_0:checkRecommendIsInTime(var_4_0)
	local var_4_2 = true

	if string.nilorempty(var_4_0.relateActId) and var_4_0.openId > 0 then
		var_4_2 = OpenModel.instance:isFunctionUnlock(var_4_0.openId)
	end

	return var_4_1 and var_4_2
end

function var_0_0.checkRecommendIsInTime(arg_5_0, arg_5_1)
	local var_5_0 = TurnbackModel.instance:getLeaveTime()
	local var_5_1 = 0
	local var_5_2 = 0
	local var_5_3 = 0
	local var_5_4 = not string.nilorempty(arg_5_1.onlineTime)

	if var_5_4 then
		var_5_2 = TimeUtil.stringToTimestamp(arg_5_1.onlineTime)
	end

	local var_5_5 = not string.nilorempty(arg_5_1.offlineTime)

	if var_5_5 then
		var_5_3 = TimeUtil.stringToTimestamp(arg_5_1.offlineTime)
	end

	local var_5_6 = not string.nilorempty(arg_5_1.constTime)

	if var_5_6 then
		var_5_1 = TimeUtil.stringToTimestamp(arg_5_1.constTime)
	end

	local var_5_7 = var_5_4 and ServerTime.now() - var_5_2 >= 0
	local var_5_8 = var_5_5 and ServerTime.now() - var_5_3 > 0
	local var_5_9 = var_5_6 and var_5_1 - var_5_0 > 0 and var_5_0 > 0
	local var_5_10 = arg_5_0:checkHasOpenRelateAct(arg_5_1)
	local var_5_11 = not string.nilorempty(arg_5_1.relateActId)

	if var_5_0 <= 0 then
		return false
	end

	if var_5_11 and var_5_10 and var_5_9 then
		return true
	elseif var_5_11 and var_5_10 and not var_5_6 then
		return true
	elseif not var_5_11 and not var_5_6 then
		return true
	elseif not var_5_11 and var_5_7 and not var_5_8 and var_5_9 then
		return true
	else
		return false
	end
end

function var_0_0.checkHasOpenRelateAct(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if not string.nilorempty(arg_6_1.relateActId) then
		local var_6_1 = string.splitToNumber(arg_6_1.relateActId, "#")

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			if ActivityHelper.getActivityStatusAndToast(iter_6_1) == ActivityEnum.ActivityStatus.Normal then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkRecommendCanShow(arg_7_0, arg_7_1)
	if not string.nilorempty(arg_7_1.prepose) then
		local var_7_0 = string.splitToNumber(arg_7_1.prepose, "#")

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			local var_7_1 = TurnbackConfig.instance:getRecommendCo(arg_7_0.turnbackId, iter_7_1)

			if not var_7_1 then
				logError("推荐页或前置推荐页id不存在,请检查配置，id: " .. tostring(iter_7_1))

				return
			end

			if arg_7_0:checkRecommendCanShow(var_7_1) then
				return false
			end
		end
	end

	return arg_7_0.recommendOpenMap[arg_7_0.turnbackId][arg_7_1.id]
end

function var_0_0.getCanShowRecommendList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = tabletool.copy(TurnbackConfig.instance:getAllRecommendCo(arg_8_0.turnbackId))

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if arg_8_0:checkRecommendCanShow(iter_8_1) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getCanShowRecommendCount(arg_9_0)
	return #arg_9_0:getCanShowRecommendList()
end

var_0_0.instance = var_0_0.New()

return var_0_0
