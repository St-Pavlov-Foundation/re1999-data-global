module("modules.logic.room.model.record.RoomLogModel", package.seeall)

slot0 = class("RoomLogModel", BaseModel)

function slot0.onInit(slot0)
	slot0._currentPage = 1
end

function slot0.reInit(slot0)
	slot0._currentPage = 1
end

function slot0.getInfos(slot0)
	return slot0._list
end

function slot0.setInfos(slot0, slot1)
	slot0._currentTime = nil
	slot0._list = {}
	slot0._newLog = nil

	function slot6(slot0, slot1)
		return slot1.time < slot0.time
	end

	table.sort(slot1, slot6)

	for slot6, slot7 in ipairs(slot1) do
		slot0:setConfigByType(slot7, {
			type = slot7.type,
			time = slot7.time,
			timestr = TimeUtil.timestampToString4(slot7.time)
		})

		if slot0:checkIsNewDay(slot7.time) and #slot1 > 0 then
			table.insert(slot0._list, {
				type = RoomRecordEnum.LogType.Time,
				day = os.date("*t", slot7.time - TimeUtil.OneDaySecond).wday
			})
		end

		table.insert(slot0._list, slot8)
	end

	if slot0._newLog then
		RoomController.instance:dispatchEvent(RoomEvent.NewLog, slot0._newLog)
	end
end

function slot0.setConfigByType(slot0, slot1, slot2)
	if slot1.type == RoomRecordEnum.LogType.Speical then
		if HeroConfig.instance:getHeroCO(RoomConfig.instance:getCharacterInteractionConfig(slot1.id).heroId).name then
			slot2.heroname = slot5
		end

		slot2.config = slot4

		while true do
			slot2.logConfigList = slot2.logConfigList or {}

			if not RoomConfig.instance:getCharacterDialogConfig(slot4.dialogId, 0 + 1) then
				break
			end

			table.insert(slot2.logConfigList, slot7)
		end
	elseif slot1.type == RoomRecordEnum.LogType.Normal then
		if RoomLogConfig.instance:getLogConfigById(slot1.id) then
			slot2.content = slot3.content
		end
	elseif slot1.type == RoomRecordEnum.LogType.Custom then
		if RoomTradeConfig.instance:getTaskCoById(slot1.id) then
			slot2.config = slot3
			slot2.name = HeroConfig.instance:getHeroCO(tonumber(slot3.speaker)).name
			slot4 = {}

			if not string.nilorempty(slot3.logtext) then
				slot4 = string.splitToNumber(slot3.logtext, "#")
			end

			if #slot4 > 0 then
				slot2.logConfigList = slot2.logConfigList or {}
				slot7 = slot4[1]

				while slot7 <= slot4[2] do
					table.insert(slot2.logConfigList, RoomLogConfig.instance:getLogConfigById(slot7))

					slot7 = slot7 + 1
				end
			end
		end

		if slot1.isNew and not slot0._newLog then
			slot0._newLog = slot2
		end
	end
end

function slot0.checkIsNewDay(slot0, slot1)
	if not slot0._currentTime then
		slot0._currentTime = slot1

		return false
	elseif slot1 < slot0._currentTime and not TimeUtil.isSameDay(slot1, slot0._currentTime) then
		slot0._currentTime = slot1

		return true
	end
end

function slot0.setPage(slot0, slot1)
	slot0._currentPage = slot1
end

function slot0.getPage(slot0)
	return slot0._currentPage or 1
end

slot0.instance = slot0.New()

return slot0
