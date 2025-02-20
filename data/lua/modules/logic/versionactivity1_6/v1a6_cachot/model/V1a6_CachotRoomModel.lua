module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoomModel", package.seeall)

slot0 = class("V1a6_CachotRoomModel", BaseModel)

function slot0.onInit(slot0)
	slot0._isPlayerMoving = false
	slot0._layer = 0
	slot0._room = 0
	slot0._roomEvents = {}
	slot0.isFromDramaToDrama = false
	slot0.isLockPlayerMove = false
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.clear(slot0)
	slot0._layer = 0
	slot0._room = 0
	slot0._roomEvents = {}

	slot0:clearRoomChangeStatus()
end

slot1 = {
	{
		2
	},
	{
		1,
		3
	},
	{
		1,
		2,
		3
	}
}

function slot0.setLayerAndRoom(slot0, slot1, slot2)
	if slot1 == slot0._layer and slot2 == slot0._room then
		return
	end

	V1a6_CachotStatController.instance:statFinishRoom(slot0._room, slot0._layer)
	V1a6_CachotStatController.instance:statEnterRoom()

	slot0._isRoomChange = slot0._room and slot0._room ~= 0
	slot0._isLayerChange = slot0._layer and slot0._layer ~= 0 and slot1 > 1 and slot0._layer ~= slot1
	slot0._layer = slot1
	slot0._room = slot2

	slot0:refreshRoomEvents()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChange)
end

function slot0.getRoomIsChange(slot0)
	return slot0._isRoomChange
end

function slot0.getLayerIsChange(slot0)
	return slot0._isLayerChange
end

function slot0.clearRoomChangeStatus(slot0)
	slot0._isRoomChange = false
	slot0._isLayerChange = false
end

function slot0.refreshRoomEvents(slot0)
	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	slot0._roomEvents = {}

	if slot1.isFinish then
		return
	end

	slot2 = false
	slot3 = {
		[slot8.eventId] = true
	}

	for slot7, slot8 in ipairs(slot1.currentEvents) do
		if slot8.status ~= 0 then
			slot2 = true
		end
	end

	slot8 = 3

	for slot8 = 1, math.min(#slot1.currentEvents, slot8) do
		slot9 = slot1.currentEvents[slot8]

		if not slot2 or slot3[slot9.eventId] then
			slot9.index = uv0[slot4][slot8]

			table.insert(slot0._roomEvents, slot9)
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomEventChange)
end

function slot0.tryAddSelectEvent(slot0, slot1)
	for slot5, slot6 in pairs(slot0._roomEvents) do
		if slot6.eventId == slot1.eventId then
			slot6:init(slot1)

			break
		end
	end

	slot2 = nil

	for slot7, slot8 in ipairs(V1a6_CachotModel.instance:getRogueInfo().selectedEvents) do
		if slot8.eventId == slot1.eventId then
			slot2 = slot8

			slot8:init(slot1)

			break
		end
	end

	if not slot2 then
		slot4 = RogueEventMO.New()

		slot4:init(slot1)
		table.insert(slot3.selectedEvents, slot4)
		slot0:refreshRoomEvents()

		return slot4
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventChange, slot2)
	end
end

slot2 = nil

function slot0.tryRemoveSelectEvent(slot0, slot1)
	if not uv0 then
		uv0 = tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value)
	end

	if slot1.eventId == uv0 then
		V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
			str = lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value2,
			style = V1a6_CachotEnum.TipStyle.ChangeConclusion
		})
	end

	for slot6, slot7 in ipairs(V1a6_CachotModel.instance:getRogueInfo().selectedEvents) do
		if slot7.eventId == slot1.eventId then
			slot7:init(slot1)
			table.remove(slot2.selectedEvents, slot6)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventRemove, slot7)

			break
		end
	end

	for slot6, slot7 in pairs(slot0._roomEvents) do
		if slot7.eventId == slot1.eventId then
			slot7:init(slot1)
			slot0:refreshRoomEvents()
		end
	end
end

function slot0.getNowBattleEventMo(slot0)
	if ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	slot3 = nil

	for slot7 = 1, #slot2.selectedEvents do
		if lua_rogue_event.configDict[slot2.selectedEvents[slot7].eventId].type == V1a6_CachotEnum.EventType.Battle then
			slot3 = slot2.selectedEvents[slot7]

			break
		end
	end

	return slot3
end

function slot0.getNowTopEventMo(slot0)
	if not V1a6_CachotModel.instance:getRogueInfo() or #slot1.selectedEvents == 0 then
		return
	end

	return slot1.selectedEvents[#slot1.selectedEvents]
end

function slot0.getIsMoving(slot0)
	return slot0._isPlayerMoving
end

function slot0.setIsMoving(slot0, slot1)
	if slot0._isPlayerMoving == slot1 then
		return
	end

	slot0._isPlayerMoving = slot1

	if slot1 then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerBeginMove)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerStopMove)
	end
end

function slot0.getRoomEventMos(slot0)
	return slot0._roomEvents
end

function slot0.getNearEventMo(slot0)
	return slot0._nearEventMo
end

function slot0.setNearEventMo(slot0, slot1)
	if slot1 == slot0._nearEventMo then
		return
	end

	slot0._nearEventMo = slot1

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.NearEventMoChange, slot1)
end

slot0.instance = slot0.New()

return slot0
