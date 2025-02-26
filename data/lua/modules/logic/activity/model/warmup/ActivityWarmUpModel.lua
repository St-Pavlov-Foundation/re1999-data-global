module("modules.logic.activity.model.warmup.ActivityWarmUpModel", package.seeall)

slot0 = class("ActivityWarmUpModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
	slot0._startTime = nil
	slot0._activityDurationDay = nil
	slot0._selectedIndex = nil
	slot0._orderInfoMap = nil
	slot0._daysOrderMap = nil
	slot0._actId = nil
	slot0._hasOrderAccepted = nil
end

function slot0.init(slot0, slot1)
	slot0._actId = slot1
	slot0._selectedIndex = nil
	slot0._startTime = 0

	slot0:initOrders()
	slot0:updateAcceptedStatus()
end

function slot0.setStartTime(slot0, slot1)
	slot0._startTime = slot1 / 1000
end

function slot0.initOrders(slot0)
	slot0._daysOrderMap = {}
	slot0._orderInfoMap = {}
	slot2 = -1

	if not Activity106Config.instance:getActivityWarmUpAllOrderCo(slot0._actId) then
		logNormal("can't find config warmup : " .. tostring(slot0._actId))
	else
		for slot6, slot7 in pairs(slot1) do
			slot8 = ActivityWarmUpOrderMO.New()

			slot8:init(slot7)

			slot0._orderInfoMap[slot6] = slot8
			slot0._daysOrderMap[slot9] = slot0._daysOrderMap[slot7.openDay] or {}

			table.insert(slot0._daysOrderMap[slot9], slot8)

			if slot2 < slot9 then
				slot2 = slot9
			end
		end
	end

	for slot6, slot7 in pairs(slot0._daysOrderMap) do
		table.sort(slot7, uv0.sortOrder)
	end

	slot0._activityDurationDay = slot2
end

function slot0.sortOrder(slot0, slot1)
	return slot0.cfg.order < slot1.cfg.order
end

function slot0.setServerOrderInfos(slot0, slot1)
	for slot5 = 1, #slot1 do
		if slot0._orderInfoMap[slot1[slot5].orderId] then
			slot7:initServerData(slot6)
		end
	end

	slot0:updateAcceptedStatus()
end

function slot0.updateSingleOrder(slot0, slot1)
	if not slot0._orderInfoMap then
		return
	end

	if slot0._orderInfoMap[slot1.orderId] then
		slot2:initServerData(slot1)
	end

	slot0:updateAcceptedStatus()
end

function slot0.updateAcceptedStatus(slot0)
	for slot4, slot5 in pairs(slot0._orderInfoMap) do
		if slot5.accept then
			slot0._hasOrderAccepted = true

			return
		end
	end

	slot0._hasOrderAccepted = false
end

function slot0.selectDayTab(slot0, slot1)
	slot0._selectedIndex = slot1
end

function slot0.getSelectedDay(slot0)
	return slot0._selectedIndex
end

function slot0.getCurrentDay(slot0)
	slot2 = os.date("*t", ServerTime.timeInLocal(slot0._startTime))
	slot2.hour = 5
	slot2.min = 0
	slot2.sec = 0

	return math.min(math.floor((ServerTime.now() - ((os.time(slot2) or 0) - ServerTime.clientToServerOffset())) / 86400 + 1), slot0._activityDurationDay)
end

function slot0.getSelectedDayOrders(slot0)
	return slot0._daysOrderMap[slot0._selectedIndex]
end

function slot0.getAllOrders(slot0)
	return slot0._orderInfoMap
end

function slot0.getTotalContentDays(slot0)
	return slot0._activityDurationDay
end

function slot0.hasOrderAccepted(slot0)
	return slot0._hasOrderAccepted
end

function slot0.getOrderAccepted(slot0)
	if not slot0._orderInfoMap then
		return nil
	end

	for slot4, slot5 in pairs(slot0._orderInfoMap) do
		if slot5.accept then
			return slot5
		end
	end
end

function slot0.getBriefName(slot0, slot1, slot2)
	if LuaUtil.isEmptyStr(slot0) then
		return ""
	end

	if LuaUtil.getStrLen(slot0) <= slot1 then
		return slot0
	end

	if uv0.getUCharArrIncludeSpace(slot0) == nil or #slot4 <= 0 then
		return LuaUtil.emptyStr
	end

	slot2 = slot2 or "..."
	slot5 = LuaUtil.emptyStr

	for slot10 = 1, #slot4 do
		if string.byte(slot4[slot10]) > 0 and slot11 <= 127 then
			slot6 = 0 + 1
		elseif slot11 >= 192 and slot11 <= 239 then
			slot6 = slot6 + 2
		end

		if slot1 >= slot6 then
			slot5 = slot5 .. slot4[slot10]
		end
	end

	return slot5 .. slot2
end

function slot0.getUCharArrIncludeSpace(slot0)
	if LuaUtil.isEmptyStr(slot0) then
		return
	end

	slot1 = {}

	for slot5 in string.gmatch(slot0, "[%z-\\xc2-\\xf4][\\x80-\\xbf ]*") do
		if not LuaUtil.isEmptyStr(slot5) then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot0.getActId(slot0)
	return slot0._actId
end

function slot0.getOrderMo(slot0, slot1)
	return slot0._orderInfoMap[slot1]
end

slot0.instance = slot0.New()

return slot0
