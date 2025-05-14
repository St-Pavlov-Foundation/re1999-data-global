module("modules.logic.signin.model.SignInModel", package.seeall)

local var_0_0 = class("SignInModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._totalSignDays = 0
	arg_2_0._targetdate = {
		2021,
		1,
		1
	}
	arg_2_0._newShowDetail = true
	arg_2_0._newSwitch = false
	arg_2_0._isAutoSignGetReward = true
	arg_2_0._showBirthday = false
	arg_2_0._signInfo = {}
	arg_2_0._historySignInfos = {}
	arg_2_0._heroBirthdayInfos = {}
end

function var_0_0.setHeroBirthdayInfos(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not arg_3_0._heroBirthdayInfos[iter_3_1.heroId] then
			local var_3_0 = SignInHeroBirthdayInfoMo.New()

			var_3_0:init(iter_3_1)

			arg_3_0._heroBirthdayInfos[iter_3_1.heroId] = var_3_0
		else
			arg_3_0._heroBirthdayInfos[iter_3_1.heroId]:reset(iter_3_1)
		end
	end
end

function var_0_0.addSignInBirthdayCount(arg_4_0, arg_4_1)
	if not arg_4_0._heroBirthdayInfos[arg_4_1] then
		local var_4_0 = SignInHeroBirthdayInfoMo.New()

		arg_4_0._heroBirthdayInfos[arg_4_1] = var_4_0
	end

	arg_4_0._heroBirthdayInfos[arg_4_1]:addBirthdayCount()
end

function var_0_0.getHeroBirthdayCount(arg_5_0, arg_5_1)
	if arg_5_0._heroBirthdayInfos[arg_5_1] then
		return arg_5_0._heroBirthdayInfos[arg_5_1].birthdayCount
	end

	return 0
end

function var_0_0.setShowBirthday(arg_6_0, arg_6_1)
	arg_6_0._showBirthday = arg_6_1
end

function var_0_0.isShowBirthday(arg_7_0)
	return arg_7_0._showBirthday
end

function var_0_0.setHeroBirthdayGet(arg_8_0, arg_8_1)
	arg_8_0._signInfo:addBirthdayHero(arg_8_1)
end

function var_0_0.isHeroBirthdayGet(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = RoomConfig.instance:getHeroSpecialBlockId(arg_9_1)

	if var_9_1 then
		var_9_0 = RoomModel.instance:isHasBlockById(var_9_1)
	end

	if var_9_0 then
		return true
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._signInfo.birthdayHeroIds) do
		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function var_0_0.getCurDayBirthdayHeros(arg_10_0)
	local var_10_0 = arg_10_0:getCurDate()
	local var_10_1 = {}
	local var_10_2 = arg_10_0:getDayAllBirthdayHeros(var_10_0.month, var_10_0.day)

	for iter_10_0, iter_10_1 in pairs(var_10_2) do
		local var_10_3 = HeroConfig.instance:getHeroCO(iter_10_1)

		if var_10_3.roleBirthday ~= "" then
			local var_10_4 = string.splitToNumber(var_10_3.roleBirthday, "/")
			local var_10_5 = #string.split(var_10_3.birthdayBonus, ";")

			if var_10_4[1] == var_10_0.month and var_10_4[2] == var_10_0.day then
				local var_10_6 = arg_10_0:getHeroBirthdayCount(iter_10_1)

				if arg_10_0:isHeroBirthdayGet(iter_10_1) then
					if var_10_6 <= var_10_5 then
						table.insert(var_10_1, iter_10_1)
					end
				elseif var_10_6 < var_10_5 then
					table.insert(var_10_1, iter_10_1)
				end
			end
		end
	end

	table.sort(var_10_1)

	return var_10_1
end

function var_0_0.getNoSignBirthdayHeros(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:getDayAllBirthdayHeros(arg_11_1, arg_11_2)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = HeroConfig.instance:getHeroCO(iter_11_1)

		if var_11_2.roleBirthday ~= "" then
			local var_11_3 = string.splitToNumber(var_11_2.roleBirthday, "/")
			local var_11_4 = #string.split(var_11_2.birthdayBonus, ";")
			local var_11_5 = arg_11_0:getHeroBirthdayCount(iter_11_1)

			if var_11_3[1] == arg_11_1 and var_11_3[2] == arg_11_2 and var_11_5 < var_11_4 then
				table.insert(var_11_0, tonumber(var_11_2.id))
			end
		end
	end

	table.sort(var_11_0)

	return var_11_0
end

function var_0_0.getDayAllBirthdayHeros(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = lua_character.configDict

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if iter_12_1.roleBirthday ~= "" and iter_12_1.isOnline == "1" then
			local var_12_2 = string.splitToNumber(iter_12_1.roleBirthday, "/")

			if var_12_2[1] == arg_12_1 and var_12_2[2] == arg_12_2 then
				table.insert(var_12_0, tonumber(iter_12_1.id))
			end
		end
	end

	table.sort(var_12_0)

	return var_12_0
end

function var_0_0.getSignBirthdayHeros(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}
	local var_13_1 = {}

	arg_13_0._curDate = arg_13_0:getCurDate()

	local var_13_2 = arg_13_0:getDayAllBirthdayHeros(arg_13_2, arg_13_3)
	local var_13_3 = false

	if arg_13_2 < arg_13_0._curDate.month or arg_13_2 == arg_13_0._curDate.month and arg_13_3 < arg_13_0._curDate.day then
		var_13_3 = true
	end

	for iter_13_0, iter_13_1 in pairs(var_13_2) do
		local var_13_4 = HeroConfig.instance:getHeroCO(iter_13_1)

		if var_13_4.roleBirthday ~= "" then
			local var_13_5 = string.splitToNumber(var_13_4.roleBirthday, "/")
			local var_13_6 = #string.split(var_13_4.birthdayBonus, ";")

			if var_13_5[1] == arg_13_2 and var_13_5[2] == arg_13_3 then
				local var_13_7 = arg_13_0:getHeroBirthdayCount(iter_13_1)

				if arg_13_0._curDate.year ~= arg_13_1 then
					if arg_13_0._curDate.month == arg_13_2 then
						var_13_7 = var_13_7 - 1
					end
				elseif not arg_13_0:isHeroBirthdayGet(iter_13_1) and not var_13_3 then
					var_13_7 = var_13_7 + 1
				end

				if var_13_7 > 0 and var_13_7 <= var_13_6 then
					table.insert(var_13_0, iter_13_1)
				end
			end
		end
	end

	table.sort(var_13_0)

	return var_13_0
end

function var_0_0.setSignInInfo(arg_14_0, arg_14_1)
	arg_14_0._signInfo = SignInInfoMo.New()

	arg_14_0._signInfo:init(arg_14_1)

	arg_14_0._totalSignDays = arg_14_0._signInfo.addupSignInDay
end

function var_0_0.setSignDayRewardGet(arg_15_0, arg_15_1)
	arg_15_0._signInfo:addSignInfo(arg_15_1)

	arg_15_0._totalSignDays = #arg_15_0._signInfo:getSignDays()
end

function var_0_0.checkDailyAllowanceIsOpen(arg_16_0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DailyAllowance) then
		return false
	end

	return true
end

function var_0_0.checkIsFirstGoldDay(arg_17_0)
	if arg_17_0:checkDailyAllowanceIsOpen() then
		local var_17_0 = ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance)
		local var_17_1 = ServerTime.now() - var_17_0:getRealStartTimeStamp()

		if TimeUtil.secondsToDDHHMMSS(var_17_1) + 1 == 1 then
			return true
		end

		return false
	end
end

function var_0_0.getDailyAllowanceBonus(arg_18_0)
	if arg_18_0:checkDailyAllowanceIsOpen() then
		local var_18_0 = math.floor(arg_18_0:getGoldOpenDay())

		return SignInConfig.instance:getGoldReward(var_18_0)
	end
end

function var_0_0.getTargetDailyAllowanceBonus(arg_19_0, arg_19_1)
	if arg_19_0:checkDailyAllowanceIsOpen() then
		local var_19_0 = TimeUtil.timeToTimeStamp(arg_19_1[1], arg_19_1[2], arg_19_1[3], TimeDispatcher.DailyRefreshTime, 1, 1)
		local var_19_1 = math.floor(arg_19_0:getGoldOpenDay(var_19_0))

		return SignInConfig.instance:getGoldReward(var_19_1)
	end
end

function var_0_0.getGoldOpenDay(arg_20_0, arg_20_1)
	local var_20_0 = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.DailyAllowance) / 1000
	local var_20_1 = os.date("*t", ServerTime.timeInLocal(var_20_0))

	var_20_1.hour = 5
	var_20_1.min = 0
	var_20_1.sec = 0

	local var_20_2 = os.time(var_20_1) - ServerTime.clientToServerOffset()
	local var_20_3 = ServerTime.now() - var_20_2

	if arg_20_1 then
		var_20_3 = arg_20_1 - var_20_2
	end

	return var_20_3 / 86400 + 1
end

function var_0_0.checkIsGoldDayAndPass(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0:checkIsGoldDay(arg_21_1, arg_21_2, arg_21_3) then
		local var_21_0 = arg_21_1[3]

		if arg_21_2 then
			var_21_0 = arg_21_3
		end

		local var_21_1 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = arg_21_1[1],
			month = arg_21_1[2],
			day = var_21_0
		}
		local var_21_2 = os.time(var_21_1) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		local var_21_3 = ServerTime.now() - TimeDispatcher.DailyRefreshTime * 3600
		local var_21_4 = ServerTime.timeInLocal(tonumber(PlayerModel.instance:getPlayinfo().registerTime) / 1000)
		local var_21_5 = os.date("*t", var_21_4 - TimeDispatcher.DailyRefreshTime * 3600)
		local var_21_6 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = var_21_5.year,
			month = var_21_5.month,
			day = var_21_5.day
		}

		return var_21_2 >= os.time(var_21_6) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset() and var_21_2 <= var_21_3
	end

	return false
end

function var_0_0.checkIsGoldDay(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0:checkDailyAllowanceIsOpen() then
		local var_22_0 = arg_22_1[3]

		if arg_22_2 then
			var_22_0 = arg_22_3
		end

		local var_22_1 = {
			hour = 12,
			min = 0,
			sec = 0,
			year = arg_22_1[1],
			month = arg_22_1[2],
			day = var_22_0
		}
		local var_22_2 = os.time(var_22_1) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		local var_22_3 = ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance)
		local var_22_4 = var_22_3:getRealStartTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600
		local var_22_5 = var_22_3:getRealEndTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600
		local var_22_6 = lua_activity143_bonus.configDict
		local var_22_7 = var_22_6 and var_22_6[ActivityEnum.Activity.DailyAllowance]
		local var_22_8 = var_22_4 + (var_22_7 and #var_22_7 or 0) * TimeUtil.OneDaySecond
		local var_22_9 = math.min(var_22_5, var_22_8)

		return var_22_4 < var_22_2 and var_22_2 < var_22_9
	end

	return false
end

function var_0_0.setSignTotalRewardGet(arg_23_0, arg_23_1)
	arg_23_0._signInfo:addSignTotalIds(arg_23_1)
end

function var_0_0.getTotalSignDays(arg_24_0)
	return arg_24_0._totalSignDays
end

function var_0_0.getAllSignDays(arg_25_0)
	return arg_25_0._signInfo.hasSignInDays
end

function var_0_0.getAllSignTotals(arg_26_0)
	return arg_26_0._signInfo.hasGetAddupBonus
end

function var_0_0.isSignDayRewardGet(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._signInfo.hasSignInDays) do
		if iter_27_1 == arg_27_1 then
			return true
		end
	end

	return false
end

function var_0_0.clearSignInDays(arg_28_0)
	arg_28_0._signInfo:clearSignInDays()

	arg_28_0._getBirthHeros = {}
end

function var_0_0.isSignTotalRewardGet(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_0._signInfo.hasGetAddupBonus) do
		if iter_29_1 == arg_29_1 then
			return true
		end
	end

	return false
end

function var_0_0.isSignSeverDataGet(arg_30_0)
	local var_30_0 = arg_30_0:getCurDate()

	return arg_30_0:isSignDayRewardGet(var_30_0.day)
end

function var_0_0.getValidMonthCard(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = TimeUtil.timeToTimeStamp(arg_31_1, arg_31_2, arg_31_3, 0, 0, 0)

	for iter_31_0, iter_31_1 in pairs(arg_31_0._signInfo.monthCardHistory) do
		if TimeUtil.isSameDay(var_31_0, iter_31_1.startTime - TimeDispatcher.DailyRefreshTime * 3600) or TimeUtil.isSameDay(var_31_0, iter_31_1.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1) then
			return iter_31_1.id
		end

		if var_31_0 >= iter_31_1.startTime - TimeDispatcher.DailyRefreshTime * 3600 and var_31_0 <= iter_31_1.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1 then
			return iter_31_1.id
		end
	end

	return nil
end

function var_0_0.getCurDate(arg_32_0)
	return os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)
end

function var_0_0.isAutoSign(arg_33_0)
	return arg_33_0._isAutoSignGetReward
end

function var_0_0.setAutoSign(arg_34_0, arg_34_1)
	arg_34_0._isAutoSignGetReward = arg_34_1
end

function var_0_0.isNewShowDetail(arg_35_0)
	return arg_35_0._newShowDetail
end

function var_0_0.setNewShowDetail(arg_36_0, arg_36_1)
	arg_36_0._newShowDetail = arg_36_1
end

function var_0_0.isNewSwitch(arg_37_0)
	return arg_37_0._newSwitch
end

function var_0_0.setNewSwitch(arg_38_0, arg_38_1)
	arg_38_0._newSwitch = arg_38_1
end

function var_0_0.setSignInHistory(arg_39_0, arg_39_1)
	arg_39_0._historySignInfos[arg_39_1.month] = SignInHistoryInfoMo.New()

	arg_39_0._historySignInfos[arg_39_1.month]:init(arg_39_1)
end

function var_0_0.getHistorySignInDays(arg_40_0, arg_40_1)
	return arg_40_0._historySignInfos[arg_40_1].hasSignInDays
end

function var_0_0.isHistoryDaySigned(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0._historySignInfos[arg_41_1] then
		return false
	end

	for iter_41_0, iter_41_1 in pairs(arg_41_0._historySignInfos[arg_41_1].hasSignInDays) do
		if tonumber(iter_41_1) == tonumber(arg_41_2) then
			return true
		end
	end

	return false
end

function var_0_0.getSignTargetDate(arg_42_0)
	return arg_42_0._targetdate
end

function var_0_0.setTargetDate(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0._targetdate = {
		arg_43_1,
		arg_43_2,
		arg_43_3
	}
end

function var_0_0.getAdvanceHero(arg_44_0)
	local var_44_0 = arg_44_0:getCurDate()

	for iter_44_0 = 1, 3 do
		local var_44_1 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() + 86400 * iter_44_0 - TimeDispatcher.DailyRefreshTime * 3600)
		local var_44_2 = arg_44_0:getNoSignBirthdayHeros(var_44_1.month, var_44_1.day)

		if #var_44_2 > 0 then
			local var_44_3 = var_44_2[1]

			for iter_44_1, iter_44_2 in pairs(var_44_2) do
				local var_44_4 = HeroConfig.instance:getHeroCO(var_44_3)
				local var_44_5 = HeroConfig.instance:getHeroCO(iter_44_2)

				if var_44_4.rare < var_44_5.rare then
					var_44_3 = iter_44_2
				end
			end

			return var_44_3, iter_44_0
		end
	end

	return 0
end

function var_0_0.getShowMonthItemCo(arg_45_0)
	local var_45_0 = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	local var_45_1 = os.date("!*t", var_45_0 / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)
	local var_45_2 = arg_45_0:getCurDate()
	local var_45_3 = {}

	if var_45_1.year == var_45_2.year then
		for iter_45_0 = var_45_1.month, var_45_2.month do
			local var_45_4 = {
				year = var_45_1.year,
				month = iter_45_0
			}

			table.insert(var_45_3, var_45_4)
		end
	else
		if var_45_2.year - var_45_1.year > 1 then
			for iter_45_1 = var_45_2.month, 12 do
				local var_45_5 = {
					year = var_45_2.year - 1,
					month = iter_45_1
				}

				table.insert(var_45_3, var_45_5)
			end
		else
			for iter_45_2 = var_45_1.month < var_45_2.month and var_45_2.month or var_45_1.month, 12 do
				local var_45_6 = {
					year = var_45_2.year - 1,
					month = iter_45_2
				}

				table.insert(var_45_3, var_45_6)
			end
		end

		for iter_45_3 = 1, var_45_2.month do
			local var_45_7 = {
				year = var_45_2.year,
				month = iter_45_3
			}

			table.insert(var_45_3, var_45_7)
		end
	end

	return var_45_3
end

function var_0_0.checkFestivalDecorationUnlock()
	local var_46_0 = ActivityController.instance:Vxax_ActId("Calendar_Decoration", ActivityEnum.Activity.V2a2_Calendar_Decoration)
	local var_46_1 = ActivityModel.instance:isActOnLine(var_46_0)

	if var_46_1 == nil or var_46_1 == false then
		return false
	end

	local var_46_2 = ActivityModel.instance:getActStartTime(var_46_0)
	local var_46_3 = ActivityModel.instance:getActEndTime(var_46_0)
	local var_46_4 = ServerTime.now() * 1000

	return var_46_2 ~= nil and var_46_3 ~= nil and var_46_2 <= var_46_4 and var_46_4 < var_46_3
end

function var_0_0.onReceiveSignInTotalRewardReply(arg_47_0, arg_47_1)
	arg_47_0:setRewardMark(arg_47_1.mark)
end

function var_0_0.isClaimedAccumulateReward(arg_48_0, arg_48_1)
	return arg_48_0._signInfo:isClaimedAccumulateReward(arg_48_1)
end

function var_0_0.isClaimableAccumulateReward(arg_49_0, arg_49_1)
	return arg_49_0._signInfo:isClaimableAccumulateReward(arg_49_1)
end

function var_0_0.onReceiveSignInTotalRewardAllReply(arg_50_0, arg_50_1)
	arg_50_0:setRewardMark(arg_50_1.mark)
end

function var_0_0.setRewardMark(arg_51_0, arg_51_1)
	arg_51_0._signInfo:setRewardMark(arg_51_1 or 0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
