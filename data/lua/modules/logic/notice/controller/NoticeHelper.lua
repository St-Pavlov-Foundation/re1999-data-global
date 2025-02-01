module("modules.logic.notice.controller.NoticeHelper", package.seeall)

slot0 = class("NoticeHelper")

function slot0._initTypeHandle()
	if uv0.timeTypeHandleDict then
		return
	end

	uv0.timeTypeHandleDict = {
		[NoticeEnum.FindTimeType.MD_HM] = uv0._matchTime_MD_HM,
		[NoticeEnum.FindTimeType.YMD_HMS] = uv0._matchTime_YMD_HMS,
		[NoticeEnum.FindTimeType.YMD_HM] = uv0._matchTime_YMD_HM,
		[NoticeEnum.FindTimeType.MDH] = uv0._matchTime_MDH,
		[NoticeEnum.FindTimeType.YMD_W_HM] = uv0._matchTime_YMD_W_HM
	}
end

function slot0.getTimeMatchIndex(slot0)
	uv0._initTypeHandle()

	for slot4, slot5 in ipairs(NoticeEnum.TimeFormatType) do
		if uv0.timeTypeHandleDict[slot4](slot0, slot5, false) then
			return slot4, slot7
		end
	end
end

function slot0.getTimeMatchIndexAndTimeTable(slot0)
	uv0._initTypeHandle()

	for slot4, slot5 in ipairs(NoticeEnum.TimeFormatType) do
		slot7, slot8 = uv0.timeTypeHandleDict[slot4](slot0, slot5, true)

		if slot7 then
			return slot4, slot7, slot8
		end
	end
end

function slot0._matchTime_YMD_HMS(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot8, slot9, slot10, slot11, slot12, slot13, slot14, slot15 = string.find(slot0, slot7)

		if slot10 and slot11 and slot12 and slot13 and slot14 and slot15 then
			if slot2 then
				return slot6, {
					year = slot10,
					month = slot11,
					day = slot12,
					hour = slot13,
					min = slot14,
					sec = slot15
				}
			else
				return slot6
			end
		end
	end
end

function slot0._matchTime_MD_HM(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot8, slot9, slot10, slot11, slot12, slot13 = string.find(slot0, slot7)

		if slot10 and slot11 and slot12 and slot13 then
			if slot2 then
				return slot6, {
					sec = 0,
					year = TimeUtil.timestampToTable(os.time()).year,
					month = slot10,
					day = slot11,
					hour = slot12,
					min = slot13
				}
			else
				return slot6
			end
		end
	end
end

function slot0._matchTime_YMD_HM(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot8, slot9, slot10, slot11, slot12, slot13, slot14 = string.find(slot0, slot7)

		if slot10 and slot11 and slot12 and slot13 and slot14 then
			if slot2 then
				return slot6, {
					sec = 0,
					year = slot10,
					month = slot11,
					day = slot12,
					hour = slot13,
					min = slot14
				}
			else
				return slot6
			end
		end
	end
end

function slot0._matchTime_MDH(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot8, slot9, slot10, slot11, slot12 = string.find(slot0, slot7)

		if slot10 and slot11 and slot12 then
			if slot2 then
				return slot6, {
					min = 0,
					sec = 0,
					year = TimeUtil.timestampToTable(os.time()).year,
					month = slot10,
					day = slot11,
					hour = slot12
				}
			else
				return slot6
			end
		end
	end
end

function slot0._matchTime_YMD_W_HM(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot8, slot9, slot10, slot11, slot12, slot13, slot14, slot15 = string.find(slot0, slot7)

		if slot10 and slot11 and slot12 and slot14 and slot15 then
			if slot2 then
				return slot6, {
					sec = 0,
					year = slot10,
					month = slot11,
					day = slot12,
					hour = slot14,
					min = slot15
				}
			else
				return slot6
			end
		end
	end
end

function slot0.buildTimeByType(slot0, slot1, slot2)
	slot3 = NoticeEnum.TimeFormat[slot0] or NoticeEnum.TimeFormat[NoticeEnum.FindTimeType.YMD_HMS]

	return uv0.buildTimeByFormat(slot3[slot1] or slot3[1], slot2)
end

function slot0.buildTimeByFormat(slot0, slot1)
	return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(slot0, NoticeEnum.Time.Year, slot1.year), NoticeEnum.Time.Month, slot1.month), NoticeEnum.Time.Day, slot1.day), NoticeEnum.Time.Hour, string.format("%02d", slot1.hour)), NoticeEnum.Time.Minute, string.format("%02d", slot1.min)), NoticeEnum.Time.Second, string.format("%02d", slot1.sec)), NoticeEnum.Time.Week, NoticeEnum.WeekDayToChar[TimeUtil.convertWday(slot1.wday)])
end

return slot0
