module("modules.logic.commandstation.view.CommandStationMapEventView", package.seeall)

local var_0_0 = class("CommandStationMapEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goevents = gohelper.findChild(arg_1_0.viewGO, "#go_bg/#go_events")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._eventList = arg_2_0:getUserDataTb_()
	arg_2_0._decorationList = arg_2_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(CommandStationController.instance, CommandStationEvent.MapLoadFinish, arg_3_0._onMapLoadFinish, arg_3_0)
	arg_3_0:addEventCb(CommandStationController.instance, CommandStationEvent.ChangeEventCategory, arg_3_0._onChangeEventCategory, arg_3_0)
	arg_3_0:addEventCb(CommandStationController.instance, CommandStationEvent.MoveTimeline, arg_3_0._onMoveTimeline, arg_3_0)
	arg_3_0:addEventCb(CommandStationController.instance, CommandStationEvent.FocusEvent, arg_3_0._onFocusEvent, arg_3_0)
end

function var_0_0._onFocusEvent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._eventList[arg_4_1]

	if var_4_0 then
		var_4_0:FocusEvent()
	end
end

function var_0_0._onMapLoadFinish(arg_5_0, arg_5_1)
	arg_5_0:_addDecoration(arg_5_1)
	arg_5_0:_updateEventItems()
end

function var_0_0._onChangeEventCategory(arg_6_0)
	arg_6_0:_updateEventItems()
end

function var_0_0._onMoveTimeline(arg_7_0)
	arg_7_0:_updateEventItems()
end

function var_0_0.filterEventList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if CommandStationConfig.instance:getCharacterIdByEventId(iter_8_1) == arg_8_0 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0._updateEventItems(arg_9_0)
	local var_9_0 = CommandStationMapModel.instance:getTimeId()
	local var_9_1 = CommandStationConfig.instance:getTimePointEpisodeId(var_9_0)

	if not DungeonModel.instance:hasPassLevelAndStory(var_9_1) then
		arg_9_0:_addEventItems()

		return
	end

	local var_9_2 = CommandStationMapModel.instance:getEventCategory()
	local var_9_3 = var_9_2 == CommandStationEnum.EventCategory.Normal and CommandStationEnum.EventCategoryKey.Normal or CommandStationEnum.EventCategoryKey.Character
	local var_9_4 = CommandStationConfig.instance:getEventList(var_9_0, nil, var_9_3)

	if var_9_2 == CommandStationEnum.EventCategory.Character and CommandStationMapModel.instance:getCharacterId() then
		local var_9_5 = CommandStationMapModel.instance:getCharacterId()

		var_9_4 = var_0_0.filterEventList(var_9_5, var_9_4)
	end

	arg_9_0:_addEventItems(var_9_4)
end

function var_0_0.FocuseLeftEvent(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:checkEventsDir()

	if var_10_0 then
		var_10_0:FirstFocusEvent()
	end
end

function var_0_0.FocuseRightEvent(arg_11_0)
	local var_11_0, var_11_1 = arg_11_0:checkEventsDir()

	if var_11_1 then
		var_11_1:FirstFocusEvent()
	end
end

function var_0_0.checkEventsDir(arg_12_0)
	local var_12_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_12_1 = 20
	local var_12_2 = var_12_0 / 2 + var_12_1
	local var_12_3 = -var_12_2 - var_12_1
	local var_12_4 = var_12_2
	local var_12_5
	local var_12_6

	for iter_12_0, iter_12_1 in pairs(arg_12_0._eventList) do
		local var_12_7 = recthelper.getAnchorX(iter_12_1.viewGO.transform)

		if var_12_7 < var_12_3 then
			var_12_5 = iter_12_1
		elseif var_12_4 < var_12_7 then
			var_12_6 = iter_12_1
		end
	end

	return var_12_5, var_12_6
end

function var_0_0._addEventItems(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._eventList) do
		iter_13_1:playCloseAnim()
	end

	tabletool.clear(arg_13_0._eventList)
	CommandStationMapModel.instance:clearSceneNodeList()

	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_0.viewContainer:getSetting().otherRes[1]
	local var_13_1 = CommandStationMapModel.instance:getEventCategory()
	local var_13_2 = false
	local var_13_3

	for iter_13_2, iter_13_3 in ipairs(arg_13_1) do
		local var_13_4 = arg_13_0:getResInst(var_13_0, arg_13_0._goevents)
		local var_13_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_4, CommandStationMapItem)

		var_13_5:onUpdateMO(iter_13_3, var_13_1)

		arg_13_0._eventList[iter_13_3] = var_13_5

		if iter_13_2 == 1 then
			var_13_3 = var_13_5
		end

		if var_13_1 == CommandStationEnum.EventCategory.Normal then
			if not var_13_2 and var_13_5:isMainType() then
				var_13_2 = true

				var_13_5:FirstFocusEvent()
			end
		elseif not var_13_2 then
			var_13_2 = true

			var_13_5:FirstFocusEvent()
		end
	end

	if not var_13_2 and var_13_3 then
		var_13_3:FirstFocusEvent()
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.EventCreateFinish)
end

function var_0_0._addDecoration(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._decorationList) do
		gohelper.destroy(iter_14_1)

		arg_14_0._decorationList[iter_14_0] = nil
	end

	local var_14_0 = CommandStationMapModel.instance:getTimeId()
	local var_14_1 = lua_copost_time_point_event.configDict[var_14_0]
	local var_14_2 = var_14_1 and var_14_1.coordinatesId

	if not var_14_2 then
		return
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_2) do
		local var_14_3 = lua_copost_decoration_coordinates.configDict[iter_14_3]

		if var_14_3 then
			local var_14_4 = var_14_3.decorationId
			local var_14_5 = lua_copost_decoration.configDict[var_14_4]

			if var_14_5 then
				local var_14_6 = UnityEngine.GameObject.New(tostring(iter_14_3))

				gohelper.addChild(arg_14_1, var_14_6)
				table.insert(arg_14_0._decorationList, var_14_6)

				local var_14_7 = var_14_3.coordinates

				transformhelper.setLocalPos(var_14_6.transform, var_14_7[1] or 0, var_14_7[2] or 0, var_14_7[3] or 0)
				PrefabInstantiate.Create(var_14_6):startLoad(var_14_5.decoration)
			else
				logError(string.format("can not find decoration config, id = %s", var_14_4))
			end
		else
			logError(string.format("can not find decoration coordinate config, id = %s", iter_14_3))
		end
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

return var_0_0
