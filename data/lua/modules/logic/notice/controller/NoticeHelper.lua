module("modules.logic.notice.controller.NoticeHelper", package.seeall)

local var_0_0 = class("NoticeHelper")

function var_0_0._initTypeHandle()
	if var_0_0.timeTypeHandleDict then
		return
	end

	var_0_0.timeTypeHandleDict = {
		[NoticeEnum.FindTimeType.MD_HM] = var_0_0._matchTime_MD_HM,
		[NoticeEnum.FindTimeType.YMD_HMS] = var_0_0._matchTime_YMD_HMS,
		[NoticeEnum.FindTimeType.YMD_HM] = var_0_0._matchTime_YMD_HM,
		[NoticeEnum.FindTimeType.MDH] = var_0_0._matchTime_MDH,
		[NoticeEnum.FindTimeType.YMD_W_HM] = var_0_0._matchTime_YMD_W_HM
	}
end

function var_0_0.getTimeMatchIndex(arg_2_0)
	var_0_0._initTypeHandle()

	for iter_2_0, iter_2_1 in ipairs(NoticeEnum.TimeFormatType) do
		local var_2_0 = var_0_0.timeTypeHandleDict[iter_2_0](arg_2_0, iter_2_1, false)

		if var_2_0 then
			return iter_2_0, var_2_0
		end
	end
end

function var_0_0.getTimeMatchIndexAndTimeTable(arg_3_0)
	var_0_0._initTypeHandle()

	for iter_3_0, iter_3_1 in ipairs(NoticeEnum.TimeFormatType) do
		local var_3_0, var_3_1 = var_0_0.timeTypeHandleDict[iter_3_0](arg_3_0, iter_3_1, true)

		if var_3_0 then
			return iter_3_0, var_3_0, var_3_1
		end
	end
end

function var_0_0._matchTime_YMD_HMS(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0, var_4_1, var_4_2, var_4_3, var_4_4, var_4_5, var_4_6, var_4_7 = string.find(arg_4_0, iter_4_1)

		if var_4_2 and var_4_3 and var_4_4 and var_4_5 and var_4_6 and var_4_7 then
			if arg_4_2 then
				local var_4_8 = {
					year = var_4_2,
					month = var_4_3,
					day = var_4_4,
					hour = var_4_5,
					min = var_4_6,
					sec = var_4_7
				}

				return iter_4_0, var_4_8
			else
				return iter_4_0
			end
		end
	end
end

function var_0_0._matchTime_MD_HM(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0, var_5_1, var_5_2, var_5_3, var_5_4, var_5_5 = string.find(arg_5_0, iter_5_1)

		if var_5_2 and var_5_3 and var_5_4 and var_5_5 then
			if arg_5_2 then
				local var_5_6 = TimeUtil.timestampToTable(os.time())
				local var_5_7 = {
					sec = 0,
					year = var_5_6.year,
					month = var_5_2,
					day = var_5_3,
					hour = var_5_4,
					min = var_5_5
				}

				return iter_5_0, var_5_7
			else
				return iter_5_0
			end
		end
	end
end

function var_0_0._matchTime_YMD_HM(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0, var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6 = string.find(arg_6_0, iter_6_1)

		if var_6_2 and var_6_3 and var_6_4 and var_6_5 and var_6_6 then
			if arg_6_2 then
				local var_6_7 = {
					sec = 0,
					year = var_6_2,
					month = var_6_3,
					day = var_6_4,
					hour = var_6_5,
					min = var_6_6
				}

				return iter_6_0, var_6_7
			else
				return iter_6_0
			end
		end
	end
end

function var_0_0._matchTime_MDH(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0, var_7_1, var_7_2, var_7_3, var_7_4 = string.find(arg_7_0, iter_7_1)

		if var_7_2 and var_7_3 and var_7_4 then
			if arg_7_2 then
				local var_7_5 = TimeUtil.timestampToTable(os.time())
				local var_7_6 = {
					min = 0,
					sec = 0,
					year = var_7_5.year,
					month = var_7_2,
					day = var_7_3,
					hour = var_7_4
				}

				return iter_7_0, var_7_6
			else
				return iter_7_0
			end
		end
	end
end

function var_0_0._matchTime_YMD_W_HM(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0, var_8_1, var_8_2, var_8_3, var_8_4, var_8_5, var_8_6, var_8_7 = string.find(arg_8_0, iter_8_1)

		if var_8_2 and var_8_3 and var_8_4 and var_8_6 and var_8_7 then
			if arg_8_2 then
				local var_8_8 = {
					sec = 0,
					year = var_8_2,
					month = var_8_3,
					day = var_8_4,
					hour = var_8_6,
					min = var_8_7
				}

				return iter_8_0, var_8_8
			else
				return iter_8_0
			end
		end
	end
end

function var_0_0.buildTimeByType(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = NoticeEnum.TimeFormat[arg_9_0] or NoticeEnum.TimeFormat[NoticeEnum.FindTimeType.YMD_HMS]
	local var_9_1 = var_9_0[arg_9_1] or var_9_0[1]

	return var_0_0.buildTimeByFormat(var_9_1, arg_9_2)
end

function var_0_0.buildTimeByFormat(arg_10_0, arg_10_1)
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Year, arg_10_1.year)
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Month, arg_10_1.month)
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Day, arg_10_1.day)
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Hour, string.format("%02d", arg_10_1.hour))
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Minute, string.format("%02d", arg_10_1.min))
	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Second, string.format("%02d", arg_10_1.sec))

	local var_10_0 = TimeUtil.convertWday(arg_10_1.wday)

	arg_10_0 = string.gsub(arg_10_0, NoticeEnum.Time.Week, NoticeEnum.WeekDayToChar[var_10_0])

	return arg_10_0
end

return var_0_0
