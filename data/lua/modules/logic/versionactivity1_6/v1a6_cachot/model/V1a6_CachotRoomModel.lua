module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoomModel", package.seeall)

local var_0_0 = class("V1a6_CachotRoomModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isPlayerMoving = false
	arg_1_0._layer = 0
	arg_1_0._room = 0
	arg_1_0._roomEvents = {}
	arg_1_0.isFromDramaToDrama = false
	arg_1_0.isLockPlayerMove = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._layer = 0
	arg_3_0._room = 0
	arg_3_0._roomEvents = {}

	arg_3_0:clearRoomChangeStatus()
end

local var_0_1 = {
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

function var_0_0.setLayerAndRoom(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0._layer and arg_4_2 == arg_4_0._room then
		return
	end

	V1a6_CachotStatController.instance:statFinishRoom(arg_4_0._room, arg_4_0._layer)
	V1a6_CachotStatController.instance:statEnterRoom()

	arg_4_0._isRoomChange = arg_4_0._room and arg_4_0._room ~= 0
	arg_4_0._isLayerChange = arg_4_0._layer and arg_4_0._layer ~= 0 and arg_4_1 > 1 and arg_4_0._layer ~= arg_4_1
	arg_4_0._layer = arg_4_1
	arg_4_0._room = arg_4_2

	arg_4_0:refreshRoomEvents()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChange)
end

function var_0_0.getRoomIsChange(arg_5_0)
	return arg_5_0._isRoomChange
end

function var_0_0.getLayerIsChange(arg_6_0)
	return arg_6_0._isLayerChange
end

function var_0_0.clearRoomChangeStatus(arg_7_0)
	arg_7_0._isRoomChange = false
	arg_7_0._isLayerChange = false
end

function var_0_0.refreshRoomEvents(arg_8_0)
	local var_8_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_8_0 then
		return
	end

	arg_8_0._roomEvents = {}

	if var_8_0.isFinish then
		return
	end

	local var_8_1 = false
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.currentEvents) do
		if iter_8_1.status ~= 0 then
			var_8_2[iter_8_1.eventId] = true
			var_8_1 = true
		end
	end

	local var_8_3 = #var_8_0.currentEvents
	local var_8_4 = math.min(var_8_3, 3)

	for iter_8_2 = 1, var_8_4 do
		local var_8_5 = var_8_0.currentEvents[iter_8_2]

		if not var_8_1 or var_8_2[var_8_5.eventId] then
			var_8_5.index = var_0_1[var_8_4][iter_8_2]

			table.insert(arg_8_0._roomEvents, var_8_5)
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomEventChange)
end

function var_0_0.tryAddSelectEvent(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._roomEvents) do
		if iter_9_1.eventId == arg_9_1.eventId then
			iter_9_1:init(arg_9_1)

			break
		end
	end

	local var_9_0
	local var_9_1 = V1a6_CachotModel.instance:getRogueInfo()

	for iter_9_2, iter_9_3 in ipairs(var_9_1.selectedEvents) do
		if iter_9_3.eventId == arg_9_1.eventId then
			var_9_0 = iter_9_3

			iter_9_3:init(arg_9_1)

			break
		end
	end

	if not var_9_0 then
		local var_9_2 = RogueEventMO.New()

		var_9_2:init(arg_9_1)
		table.insert(var_9_1.selectedEvents, var_9_2)
		arg_9_0:refreshRoomEvents()

		return var_9_2
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventChange, var_9_0)
	end
end

local var_0_2

function var_0_0.tryRemoveSelectEvent(arg_10_0, arg_10_1)
	if not var_0_2 then
		var_0_2 = tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value)
	end

	if arg_10_1.eventId == var_0_2 then
		V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
			str = lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value2,
			style = V1a6_CachotEnum.TipStyle.ChangeConclusion
		})
	end

	local var_10_0 = V1a6_CachotModel.instance:getRogueInfo()

	for iter_10_0, iter_10_1 in ipairs(var_10_0.selectedEvents) do
		if iter_10_1.eventId == arg_10_1.eventId then
			iter_10_1:init(arg_10_1)
			table.remove(var_10_0.selectedEvents, iter_10_0)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventRemove, iter_10_1)

			break
		end
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0._roomEvents) do
		if iter_10_3.eventId == arg_10_1.eventId then
			iter_10_3:init(arg_10_1)
			arg_10_0:refreshRoomEvents()
		end
	end
end

function var_0_0.getNowBattleEventMo(arg_11_0)
	if ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local var_11_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_11_0 then
		return
	end

	local var_11_1

	for iter_11_0 = 1, #var_11_0.selectedEvents do
		local var_11_2 = var_11_0.selectedEvents[iter_11_0].eventId

		if lua_rogue_event.configDict[var_11_2].type == V1a6_CachotEnum.EventType.Battle then
			var_11_1 = var_11_0.selectedEvents[iter_11_0]

			break
		end
	end

	return var_11_1
end

function var_0_0.getNowTopEventMo(arg_12_0)
	local var_12_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_12_0 or #var_12_0.selectedEvents == 0 then
		return
	end

	return var_12_0.selectedEvents[#var_12_0.selectedEvents]
end

function var_0_0.getIsMoving(arg_13_0)
	return arg_13_0._isPlayerMoving
end

function var_0_0.setIsMoving(arg_14_0, arg_14_1)
	if arg_14_0._isPlayerMoving == arg_14_1 then
		return
	end

	arg_14_0._isPlayerMoving = arg_14_1

	if arg_14_1 then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerBeginMove)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerStopMove)
	end
end

function var_0_0.getRoomEventMos(arg_15_0)
	return arg_15_0._roomEvents
end

function var_0_0.getNearEventMo(arg_16_0)
	return arg_16_0._nearEventMo
end

function var_0_0.setNearEventMo(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._nearEventMo then
		return
	end

	arg_17_0._nearEventMo = arg_17_1

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.NearEventMoChange, arg_17_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
