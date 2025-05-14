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

function var_0_0.getActivityStatusAndToast(arg_2_0, arg_2_1)
	local var_2_0 = ActivityModel.instance:getActivityInfo()[arg_2_0]

	if not var_2_0 then
		if not arg_2_1 then
			logError(string.format("not found ActivityId : %s activity", arg_2_0))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not var_2_0:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if var_2_0:isExpired() then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	local var_2_1 = var_2_0.config and var_2_0.config.openId

	if var_2_1 and var_2_1 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_2_1) then
		local var_2_2, var_2_3 = OpenHelper.getToastIdAndParam(var_2_1)

		return ActivityEnum.ActivityStatus.NotUnlock, var_2_2, var_2_3
	end

	if not var_2_0:isOnline() then
		return ActivityEnum.ActivityStatus.NotOnLine, ToastEnum.ActivityEnd
	end

	return ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getActivityRemainTimeStr(arg_3_0, arg_3_1)
	local var_3_0 = ActivityModel.instance:getRemainTimeSec(arg_3_0)

	if var_3_0 then
		if var_3_0 >= 0 then
			return TimeUtil.SecondToActivityTimeFormat(var_3_0, arg_3_1)
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

		local var_4_0 = 1

		for iter_4_0 = 1, math.huge do
			for iter_4_1 = var_4_0, math.huge do
				local var_4_1 = string.format("VersionActivity%d_%dEnum", iter_4_0, iter_4_1)

				if iter_4_0 == 1 and iter_4_1 == 1 then
					var_4_1 = "VersionActivityEnum"
				end

				local var_4_2 = _G[var_4_1]

				if iter_4_1 == 0 and not var_4_2 then
					return
				elseif not var_4_2 then
					break
				end

				if isDebugBuild then
					logNormal("自动加载" .. var_4_1)
				end

				if var_4_2.ActivityId then
					local var_4_3 = string.format("%d_%d", iter_4_0, iter_4_1)

					for iter_4_2, iter_4_3 in pairs(var_4_2.ActivityId) do
						var_0_1[iter_4_3] = var_4_3
					end
				end

				if var_4_2.JumpNeedCloseView then
					for iter_4_4, iter_4_5 in pairs(var_4_2.JumpNeedCloseView()) do
						var_0_2[iter_4_5] = true
					end
				end
			end

			var_4_0 = 0
		end
	end
end

function var_0_0.getActivityVersion(arg_5_0)
	var_0_0.initActivityVersion()

	return var_0_1[arg_5_0] or ""
end

function var_0_0.getJumpNeedCloseViewDict()
	var_0_0.initActivityVersion()

	return var_0_2
end

function var_0_0.activateClass(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or 1
	arg_7_2 = arg_7_2 or 0

	for iter_7_0 = arg_7_1, math.huge do
		for iter_7_1 = arg_7_2, math.huge do
			local var_7_0 = string.format(arg_7_0, iter_7_0, iter_7_1)
			local var_7_1 = _G[var_7_0]

			if not var_7_1 then
				local var_7_2 = iter_7_1

				while iter_7_1 < 10 do
					iter_7_1 = iter_7_1 + 1
					var_7_0 = string.format(arg_7_0, iter_7_0, iter_7_1)
					var_7_1 = _G[var_7_0]

					if var_7_1 then
						break
					end
				end

				if var_7_2 == 0 and not var_7_1 then
					return
				end

				if iter_7_1 >= 10 then
					break
				end
			end

			if iter_7_1 == 0 and not var_7_1 then
				return
			elseif not var_7_1 then
				break
			end

			if isDebugBuild then
				logNormal("自动加载" .. var_7_0)
			end
		end

		arg_7_2 = 0
	end
end

return var_0_0
