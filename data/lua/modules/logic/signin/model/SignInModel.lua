module("modules.logic.signin.model.SignInModel", package.seeall)

slot0 = class("SignInModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._totalSignDays = 0
	slot0._targetdate = {
		2021,
		1,
		1
	}
	slot0._newShowDetail = true
	slot0._newSwitch = false
	slot0._isAutoSignGetReward = true
	slot0._showBirthday = false
	slot0._signInfo = {}
	slot0._historySignInfos = {}
	slot0._heroBirthdayInfos = {}
end

function slot0.setHeroBirthdayInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._heroBirthdayInfos[slot6.heroId] then
			slot7 = SignInHeroBirthdayInfoMo.New()

			slot7:init(slot6)

			slot0._heroBirthdayInfos[slot6.heroId] = slot7
		else
			slot0._heroBirthdayInfos[slot6.heroId]:reset(slot6)
		end
	end
end

function slot0.addSignInBirthdayCount(slot0, slot1)
	if not slot0._heroBirthdayInfos[slot1] then
		slot0._heroBirthdayInfos[slot1] = SignInHeroBirthdayInfoMo.New()
	end

	slot0._heroBirthdayInfos[slot1]:addBirthdayCount()
end

function slot0.getHeroBirthdayCount(slot0, slot1)
	if slot0._heroBirthdayInfos[slot1] then
		return slot0._heroBirthdayInfos[slot1].birthdayCount
	end

	return 0
end

function slot0.setShowBirthday(slot0, slot1)
	slot0._showBirthday = slot1
end

function slot0.isShowBirthday(slot0)
	return slot0._showBirthday
end

function slot0.setHeroBirthdayGet(slot0, slot1)
	slot0._signInfo:addBirthdayHero(slot1)
end

function slot0.isHeroBirthdayGet(slot0, slot1)
	slot2 = false

	if RoomConfig.instance:getHeroSpecialBlockId(slot1) then
		slot2 = RoomModel.instance:isHasBlockById(slot3)
	end

	if slot2 then
		return true
	end

	for slot7, slot8 in pairs(slot0._signInfo.birthdayHeroIds) do
		if slot8 == slot1 then
			return true
		end
	end

	return false
end

function slot0.getCurDayBirthdayHeros(slot0)
	slot1 = slot0:getCurDate()
	slot2 = {}

	for slot7, slot8 in pairs(slot0:getDayAllBirthdayHeros(slot1.month, slot1.day)) do
		if HeroConfig.instance:getHeroCO(slot8).roleBirthday ~= "" then
			if string.splitToNumber(slot9.roleBirthday, "/")[1] == slot1.month and slot10[2] == slot1.day then
				if slot0:isHeroBirthdayGet(slot8) then
					if slot0:getHeroBirthdayCount(slot8) <= #string.split(slot9.birthdayBonus, ";") then
						table.insert(slot2, slot8)
					end
				elseif slot12 < slot11 then
					table.insert(slot2, slot8)
				end
			end
		end
	end

	table.sort(slot2)

	return slot2
end

function slot0.getNoSignBirthdayHeros(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in ipairs(slot0:getDayAllBirthdayHeros(slot1, slot2)) do
		if HeroConfig.instance:getHeroCO(slot9).roleBirthday ~= "" then
			if string.splitToNumber(slot10.roleBirthday, "/")[1] == slot1 and slot11[2] == slot2 and slot0:getHeroBirthdayCount(slot9) < #string.split(slot10.birthdayBonus, ";") then
				table.insert(slot3, tonumber(slot10.id))
			end
		end
	end

	table.sort(slot3)

	return slot3
end

function slot0.getDayAllBirthdayHeros(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in pairs(lua_character.configDict) do
		if slot9.roleBirthday ~= "" and slot9.isOnline == "1" and string.splitToNumber(slot9.roleBirthday, "/")[1] == slot1 and slot10[2] == slot2 then
			table.insert(slot3, tonumber(slot9.id))
		end
	end

	table.sort(slot3)

	return slot3
end

function slot0.getSignBirthdayHeros(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = {}
	slot0._curDate = slot0:getCurDate()
	slot5 = slot0:getDayAllBirthdayHeros(slot2, slot3)
	slot6 = false

	if slot2 < slot0._curDate.month or slot2 == slot0._curDate.month and slot3 < slot0._curDate.day then
		slot6 = true
	end

	for slot10, slot11 in pairs(slot5) do
		if HeroConfig.instance:getHeroCO(slot11).roleBirthday ~= "" then
			slot14 = #string.split(slot12.birthdayBonus, ";")

			if string.splitToNumber(slot12.roleBirthday, "/")[1] == slot2 and slot13[2] == slot3 then
				if slot0._curDate.year ~= slot1 then
					if slot0._curDate.month == slot2 then
						slot15 = slot0:getHeroBirthdayCount(slot11) - 1
					end
				elseif not slot0:isHeroBirthdayGet(slot11) and not slot6 then
					slot15 = slot15 + 1
				end

				if slot15 > 0 and slot15 <= slot14 then
					table.insert(slot4, slot11)
				end
			end
		end
	end

	table.sort(slot4)

	return slot4
end

function slot0.setSignInInfo(slot0, slot1)
	slot0._signInfo = SignInInfoMo.New()

	slot0._signInfo:init(slot1)

	slot0._totalSignDays = slot0._signInfo.addupSignInDay
end

function slot0.setSignDayRewardGet(slot0, slot1)
	slot0._signInfo:addSignInfo(slot1)

	slot0._totalSignDays = #slot0._signInfo:getSignDays()
end

function slot0.checkDailyAllowanceIsOpen(slot0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DailyAllowance) then
		return false
	end

	return true
end

function slot0.checkIsFirstGoldDay(slot0)
	if slot0:checkDailyAllowanceIsOpen() then
		if TimeUtil.secondsToDDHHMMSS(ServerTime.now() - ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance):getRealStartTimeStamp()) + 1 == 1 then
			return true
		end

		return false
	end
end

function slot0.getDailyAllowanceBonus(slot0)
	if slot0:checkDailyAllowanceIsOpen() then
		return SignInConfig.instance:getGoldReward(math.floor(slot0:getGoldOpenDay()))
	end
end

function slot0.getTargetDailyAllowanceBonus(slot0, slot1)
	if slot0:checkDailyAllowanceIsOpen() then
		return SignInConfig.instance:getGoldReward(math.floor(slot0:getGoldOpenDay(TimeUtil.timeToTimeStamp(slot1[1], slot1[2], slot1[3], TimeDispatcher.DailyRefreshTime, 1, 1))))
	end
end

function slot0.getGoldOpenDay(slot0, slot1)
	slot3 = os.date("*t", ServerTime.timeInLocal(ActivityModel.instance:getActStartTime(ActivityEnum.Activity.DailyAllowance) / 1000))
	slot3.hour = 5
	slot3.min = 0
	slot3.sec = 0
	slot5 = ServerTime.now() - (os.time(slot3) - ServerTime.clientToServerOffset())

	if slot1 then
		slot5 = slot1 - slot4
	end

	return slot5 / 86400 + 1
end

function slot0.checkIsGoldDayAndPass(slot0, slot1, slot2, slot3)
	if slot0:checkIsGoldDay(slot1, slot2, slot3) then
		slot4 = slot1[3]

		if slot2 then
			slot4 = slot3
		end

		slot10 = os.date("*t", ServerTime.timeInLocal(tonumber(PlayerModel.instance:getPlayinfo().registerTime) / 1000) - TimeDispatcher.DailyRefreshTime * 3600)

		return os.time({
			hour = 0,
			min = 0,
			sec = 0,
			year = slot1[1],
			month = slot1[2],
			day = slot4
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset() >= os.time({
			hour = 0,
			min = 0,
			sec = 0,
			year = slot10.year,
			month = slot10.month,
			day = slot10.day
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset() and slot7 <= ServerTime.now() - TimeDispatcher.DailyRefreshTime * 3600
	end

	return false
end

function slot0.checkIsGoldDay(slot0, slot1, slot2, slot3)
	if slot0:checkDailyAllowanceIsOpen() then
		slot4 = slot1[3]

		if slot2 then
			slot4 = slot3
		end

		slot7 = os.time({
			hour = 12,
			min = 0,
			sec = 0,
			year = slot1[1],
			month = slot1[2],
			day = slot4
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		slot8 = ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance)
		slot9 = slot8:getRealStartTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600
		slot12 = lua_activity143_bonus.configDict and slot11[ActivityEnum.Activity.DailyAllowance]

		return slot9 < slot7 and slot7 < math.min(slot8:getRealEndTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600, slot9 + (slot12 and #slot12 or 0) * TimeUtil.OneDaySecond)
	end

	return false
end

function slot0.setSignTotalRewardGet(slot0, slot1)
	slot0._signInfo:addSignTotalIds(slot1)
end

function slot0.getTotalSignDays(slot0)
	return slot0._totalSignDays
end

function slot0.getAllSignDays(slot0)
	return slot0._signInfo.hasSignInDays
end

function slot0.getAllSignTotals(slot0)
	return slot0._signInfo.hasGetAddupBonus
end

function slot0.isSignDayRewardGet(slot0, slot1)
	for slot5, slot6 in pairs(slot0._signInfo.hasSignInDays) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.clearSignInDays(slot0)
	slot0._signInfo:clearSignInDays()

	slot0._getBirthHeros = {}
end

function slot0.isSignTotalRewardGet(slot0, slot1)
	for slot5, slot6 in pairs(slot0._signInfo.hasGetAddupBonus) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isSignSeverDataGet(slot0)
	return slot0:isSignDayRewardGet(slot0:getCurDate().day)
end

function slot0.getValidMonthCard(slot0, slot1, slot2, slot3)
	slot8 = 0
	slot9 = 0
	slot4 = TimeUtil.timeToTimeStamp(slot1, slot2, slot3, slot8, slot9, 0)

	for slot8, slot9 in pairs(slot0._signInfo.monthCardHistory) do
		if TimeUtil.isSameDay(slot4, slot9.startTime - TimeDispatcher.DailyRefreshTime * 3600) or TimeUtil.isSameDay(slot4, slot9.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1) then
			return slot9.id
		end

		if slot4 >= slot9.startTime - TimeDispatcher.DailyRefreshTime * 3600 and slot4 <= slot9.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1 then
			return slot9.id
		end
	end

	return nil
end

function slot0.getCurDate(slot0)
	return os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)
end

function slot0.isAutoSign(slot0)
	return slot0._isAutoSignGetReward
end

function slot0.setAutoSign(slot0, slot1)
	slot0._isAutoSignGetReward = slot1
end

function slot0.isNewShowDetail(slot0)
	return slot0._newShowDetail
end

function slot0.setNewShowDetail(slot0, slot1)
	slot0._newShowDetail = slot1
end

function slot0.isNewSwitch(slot0)
	return slot0._newSwitch
end

function slot0.setNewSwitch(slot0, slot1)
	slot0._newSwitch = slot1
end

function slot0.setSignInHistory(slot0, slot1)
	slot0._historySignInfos[slot1.month] = SignInHistoryInfoMo.New()

	slot0._historySignInfos[slot1.month]:init(slot1)
end

function slot0.getHistorySignInDays(slot0, slot1)
	return slot0._historySignInfos[slot1].hasSignInDays
end

function slot0.isHistoryDaySigned(slot0, slot1, slot2)
	if not slot0._historySignInfos[slot1] then
		return false
	end

	for slot6, slot7 in pairs(slot0._historySignInfos[slot1].hasSignInDays) do
		if tonumber(slot7) == tonumber(slot2) then
			return true
		end
	end

	return false
end

function slot0.getSignTargetDate(slot0)
	return slot0._targetdate
end

function slot0.setTargetDate(slot0, slot1, slot2, slot3)
	slot0._targetdate = {
		slot1,
		slot2,
		slot3
	}
end

function slot0.getAdvanceHero(slot0)
	slot1 = slot0:getCurDate()

	for slot5 = 1, 3 do
		slot6 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() + 86400 * slot5 - TimeDispatcher.DailyRefreshTime * 3600)

		if #slot0:getNoSignBirthdayHeros(slot6.month, slot6.day) > 0 then
			for slot12, slot13 in pairs(slot7) do
				if HeroConfig.instance:getHeroCO(slot7[1]).rare < HeroConfig.instance:getHeroCO(slot13).rare then
					slot8 = slot13
				end
			end

			return slot8, slot5
		end
	end

	return 0
end

function slot0.getShowMonthItemCo(slot0)
	slot4 = {}

	if os.date("!*t", tonumber(PlayerModel.instance:getPlayinfo().registerTime) / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600).year == slot0:getCurDate().year then
		for slot8 = slot2.month, slot3.month do
			table.insert(slot4, {
				year = slot2.year,
				month = slot8
			})
		end
	else
		if slot3.year - slot2.year > 1 then
			for slot8 = slot3.month, 12 do
				table.insert(slot4, {
					year = slot3.year - 1,
					month = slot8
				})
			end
		else
			for slot9 = slot2.month < slot3.month and slot3.month or slot2.month, 12 do
				table.insert(slot4, {
					year = slot3.year - 1,
					month = slot9
				})
			end
		end

		for slot8 = 1, slot3.month do
			table.insert(slot4, {
				year = slot3.year,
				month = slot8
			})
		end
	end

	return slot4
end

function slot0.checkFestivalDecorationUnlock()
	if ActivityModel.instance:isActOnLine(ActivityController.instance:Vxax_ActId("Calendar_Decoration", ActivityEnum.Activity.V2a2_Calendar_Decoration)) == nil or slot1 == false then
		return false
	end

	slot3 = ActivityModel.instance:getActEndTime(slot0)
	slot4 = ServerTime.now() * 1000

	return ActivityModel.instance:getActStartTime(slot0) ~= nil and slot3 ~= nil and slot2 <= slot4 and slot4 < slot3
end

function slot0.onReceiveSignInTotalRewardReply(slot0, slot1)
	slot0:setRewardMark(slot1.mark)
end

function slot0.isClaimedAccumulateReward(slot0, slot1)
	return slot0._signInfo:isClaimedAccumulateReward(slot1)
end

function slot0.isClaimableAccumulateReward(slot0, slot1)
	return slot0._signInfo:isClaimableAccumulateReward(slot1)
end

function slot0.onReceiveSignInTotalRewardAllReply(slot0, slot1)
	slot0:setRewardMark(slot1.mark)
end

function slot0.setRewardMark(slot0, slot1)
	slot0._signInfo:setRewardMark(slot1 or 0)
end

slot0.instance = slot0.New()

return slot0
