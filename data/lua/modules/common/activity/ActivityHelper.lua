module("modules.common.activity.ActivityHelper", package.seeall)

local var_0_0 = class("ActivityHelper")

function var_0_0.getActivityStatus(arg_1_0, arg_1_1)
	local var_1_0 = ActivityModel.instance:getActivityInfo()[arg_1_0]

	if not var_1_0 then
		if not arg_1_1 then
			logError(string.format("not found ActivityId : %s activity", arg_1_0))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not var_1_0:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen
	end

	if var_1_0:isExpired() then
		return ActivityEnum.ActivityStatus.Expired
	end

	local var_1_1 = var_1_0.config and var_1_0.config.openId

	if var_1_1 and var_1_1 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_1_1) then
		return ActivityEnum.ActivityStatus.NotUnlock
	end

	if not var_1_0:isOnline() then
		return ActivityEnum.ActivityStatus.NotOnLine
	end

	return ActivityEnum.ActivityStatus.Normal
end

function var_0_0.isOpen(arg_2_0)
	return var_0_0.getActivityStatus(arg_2_0, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getActivityStatusAndToast(arg_3_0, arg_3_1)
	local var_3_0 = ActivityModel.instance:getActivityInfo()[arg_3_0]

	if not var_3_0 then
		if not arg_3_1 then
			logError(string.format("not found ActivityId : %s activity", arg_3_0))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not var_3_0:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if var_3_0:isExpired() then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	local var_3_1 = var_3_0.config and var_3_0.config.openId

	if var_3_1 and var_3_1 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_3_1) then
		local var_3_2, var_3_3 = OpenHelper.getToastIdAndParam(var_3_1)

		return ActivityEnum.ActivityStatus.NotUnlock, var_3_2, var_3_3
	end

	if not var_3_0:isOnline() then
		return ActivityEnum.ActivityStatus.NotOnLine, ToastEnum.ActivityEnd
	end

	return ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getActivityRemainTimeStr(arg_4_0, arg_4_1)
	local var_4_0 = ActivityModel.instance:getRemainTimeSec(arg_4_0)

	if var_4_0 then
		if var_4_0 >= 0 then
			return TimeUtil.SecondToActivityTimeFormat(var_4_0, arg_4_1)
		else
			return luaLang("turnback_end")
		end
	end

	return ""
end

local var_0_1
local var_0_2

function var_0_0.initActivityVersion()
	if not var_0_1 then
		var_0_1 = {}
		var_0_2 = {}

		var_0_0._loadAllDefineVersionActivityEnum()
		var_0_0._loadVersionActivityEnum(2, 9)
	end
end

function var_0_0._loadAllDefineVersionActivityEnum()
	local var_6_0 = 1

	for iter_6_0 = 1, math.huge do
		for iter_6_1 = var_6_0, math.huge do
			local var_6_1 = var_0_0._loadVersionActivityEnum(iter_6_0, iter_6_1)

			if iter_6_1 == 0 and not var_6_1 then
				return
			elseif not var_6_1 then
				break
			end
		end

		var_6_0 = 0
	end
end

function var_0_0._loadVersionActivityEnum(arg_7_0, arg_7_1)
	local var_7_0 = string.format("VersionActivity%d_%dEnum", arg_7_0, arg_7_1)

	if arg_7_0 == 1 and arg_7_1 == 1 then
		var_7_0 = "VersionActivityEnum"
	end

	local var_7_1 = _G[var_7_0]

	if not var_7_1 then
		return
	end

	if isDebugBuild then
		logNormal("自动加载" .. var_7_0)
	end

	if var_7_1.ActivityId then
		local var_7_2 = string.format("%d_%d", arg_7_0, arg_7_1)

		for iter_7_0, iter_7_1 in pairs(var_7_1.ActivityId) do
			var_0_1[iter_7_1] = var_7_2
		end
	end

	if var_7_1.JumpNeedCloseView then
		for iter_7_2, iter_7_3 in pairs(var_7_1.JumpNeedCloseView()) do
			var_0_2[iter_7_3] = true
		end
	end

	return var_7_1
end

function var_0_0.getActivityVersion(arg_8_0)
	var_0_0.initActivityVersion()

	return var_0_1[arg_8_0] or ""
end

function var_0_0.getJumpNeedCloseViewDict()
	var_0_0.initActivityVersion()

	return var_0_2
end

function var_0_0.activateClass(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 1
	arg_10_2 = arg_10_2 or 0

	for iter_10_0 = arg_10_1, math.huge do
		for iter_10_1 = arg_10_2, math.huge do
			local var_10_0 = string.format(arg_10_0, iter_10_0, iter_10_1)
			local var_10_1 = _G[var_10_0]

			if not var_10_1 then
				local var_10_2 = iter_10_1

				while iter_10_1 < 10 do
					iter_10_1 = iter_10_1 + 1
					var_10_0 = string.format(arg_10_0, iter_10_0, iter_10_1)
					var_10_1 = _G[var_10_0]

					if var_10_1 then
						break
					end
				end

				if var_10_2 == 0 and not var_10_1 then
					return
				end

				if iter_10_1 >= 10 then
					break
				end
			end

			if iter_10_1 == 0 and not var_10_1 then
				return
			elseif not var_10_1 then
				break
			end

			if isDebugBuild then
				logNormal("自动加载" .. var_10_0)
			end
		end

		arg_10_2 = 0
	end
end

return var_0_0
