module("modules.logic.activity.model.warmup.ActivityWarmUpModel", package.seeall)

local var_0_0 = class("ActivityWarmUpModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	arg_3_0._startTime = nil
	arg_3_0._activityDurationDay = nil
	arg_3_0._selectedIndex = nil
	arg_3_0._orderInfoMap = nil
	arg_3_0._daysOrderMap = nil
	arg_3_0._actId = nil
	arg_3_0._hasOrderAccepted = nil
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._actId = arg_4_1
	arg_4_0._selectedIndex = nil
	arg_4_0._startTime = 0

	arg_4_0:initOrders()
	arg_4_0:updateAcceptedStatus()
end

function var_0_0.setStartTime(arg_5_0, arg_5_1)
	arg_5_0._startTime = arg_5_1 / 1000
end

function var_0_0.initOrders(arg_6_0)
	local var_6_0 = Activity106Config.instance:getActivityWarmUpAllOrderCo(arg_6_0._actId)

	arg_6_0._daysOrderMap = {}
	arg_6_0._orderInfoMap = {}

	local var_6_1 = -1

	if not var_6_0 then
		logNormal("can't find config warmup : " .. tostring(arg_6_0._actId))
	else
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			local var_6_2 = ActivityWarmUpOrderMO.New()

			var_6_2:init(iter_6_1)

			arg_6_0._orderInfoMap[iter_6_0] = var_6_2

			local var_6_3 = iter_6_1.openDay

			arg_6_0._daysOrderMap[var_6_3] = arg_6_0._daysOrderMap[var_6_3] or {}

			table.insert(arg_6_0._daysOrderMap[var_6_3], var_6_2)

			if var_6_1 < var_6_3 then
				var_6_1 = var_6_3
			end
		end
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0._daysOrderMap) do
		table.sort(iter_6_3, var_0_0.sortOrder)
	end

	arg_6_0._activityDurationDay = var_6_1
end

function var_0_0.sortOrder(arg_7_0, arg_7_1)
	return arg_7_0.cfg.order < arg_7_1.cfg.order
end

function var_0_0.setServerOrderInfos(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_1 do
		local var_8_0 = arg_8_1[iter_8_0]
		local var_8_1 = arg_8_0._orderInfoMap[var_8_0.orderId]

		if var_8_1 then
			var_8_1:initServerData(var_8_0)
		end
	end

	arg_8_0:updateAcceptedStatus()
end

function var_0_0.updateSingleOrder(arg_9_0, arg_9_1)
	if not arg_9_0._orderInfoMap then
		return
	end

	local var_9_0 = arg_9_0._orderInfoMap[arg_9_1.orderId]

	if var_9_0 then
		var_9_0:initServerData(arg_9_1)
	end

	arg_9_0:updateAcceptedStatus()
end

function var_0_0.updateAcceptedStatus(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._orderInfoMap) do
		if iter_10_1.accept then
			arg_10_0._hasOrderAccepted = true

			return
		end
	end

	arg_10_0._hasOrderAccepted = false
end

function var_0_0.selectDayTab(arg_11_0, arg_11_1)
	arg_11_0._selectedIndex = arg_11_1
end

function var_0_0.getSelectedDay(arg_12_0)
	return arg_12_0._selectedIndex
end

function var_0_0.getCurrentDay(arg_13_0)
	local var_13_0 = 86400
	local var_13_1 = os.date("*t", ServerTime.timeInLocal(arg_13_0._startTime))

	var_13_1.hour = 5
	var_13_1.min = 0
	var_13_1.sec = 0

	local var_13_2 = (os.time(var_13_1) or 0) - ServerTime.clientToServerOffset()
	local var_13_3 = ServerTime.now() - var_13_2
	local var_13_4 = math.floor(var_13_3 / var_13_0 + 1)

	return math.min(var_13_4, arg_13_0._activityDurationDay)
end

function var_0_0.getSelectedDayOrders(arg_14_0)
	return arg_14_0._daysOrderMap[arg_14_0._selectedIndex]
end

function var_0_0.getAllOrders(arg_15_0)
	return arg_15_0._orderInfoMap
end

function var_0_0.getTotalContentDays(arg_16_0)
	return arg_16_0._activityDurationDay
end

function var_0_0.hasOrderAccepted(arg_17_0)
	return arg_17_0._hasOrderAccepted
end

function var_0_0.getOrderAccepted(arg_18_0)
	if not arg_18_0._orderInfoMap then
		return nil
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._orderInfoMap) do
		if iter_18_1.accept then
			return iter_18_1
		end
	end
end

function var_0_0.getBriefName(arg_19_0, arg_19_1, arg_19_2)
	if LuaUtil.isEmptyStr(arg_19_0) then
		return ""
	end

	if arg_19_1 >= LuaUtil.getStrLen(arg_19_0) then
		return arg_19_0
	end

	local var_19_0 = var_0_0.getUCharArrIncludeSpace(arg_19_0)

	if var_19_0 == nil or #var_19_0 <= 0 then
		return LuaUtil.emptyStr
	end

	arg_19_2 = arg_19_2 or "..."

	local var_19_1 = LuaUtil.emptyStr
	local var_19_2 = 0

	for iter_19_0 = 1, #var_19_0 do
		local var_19_3 = string.byte(var_19_0[iter_19_0])

		if var_19_3 > 0 and var_19_3 <= 127 then
			var_19_2 = var_19_2 + 1
		elseif var_19_3 >= 192 and var_19_3 <= 239 then
			var_19_2 = var_19_2 + 2
		end

		if var_19_2 <= arg_19_1 then
			var_19_1 = var_19_1 .. var_19_0[iter_19_0]
		end
	end

	return var_19_1 .. arg_19_2
end

function var_0_0.getUCharArrIncludeSpace(arg_20_0)
	if LuaUtil.isEmptyStr(arg_20_0) then
		return
	end

	local var_20_0 = {}

	for iter_20_0 in string.gmatch(arg_20_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF ]*") do
		if not LuaUtil.isEmptyStr(iter_20_0) then
			table.insert(var_20_0, iter_20_0)
		end
	end

	return var_20_0
end

function var_0_0.getActId(arg_21_0)
	return arg_21_0._actId
end

function var_0_0.getOrderMo(arg_22_0, arg_22_1)
	return arg_22_0._orderInfoMap[arg_22_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
