module("modules.logic.room.view.manufacture.RoomCritterRestViewMapUI", package.seeall)

local var_0_0 = class("RoomCritterRestViewMapUI", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gomap = gohelper.findChild(arg_2_0.viewGO, "content/go_map")
	arg_2_0._gomood = gohelper.findChild(arg_2_0.viewGO, "content/#go_select/mood")
	arg_2_0._moodItemCompList = {}
	arg_2_0._critterMoodShowDict = {}
	arg_2_0._gomapTrs = arg_2_0._gomap.transform
	arg_2_0._offX, arg_2_0._offY = recthelper.getAnchor(arg_2_0._gomood.transform)

	gohelper.setActive(arg_2_0._gomood, false)
end

function var_0_0.onUpdateParam(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_4_0._cameraTransformUpdate, arg_4_0)
	arg_4_0:addEventCb(arg_4_0.viewContainer, CritterEvent.UICritterDragIng, arg_4_0._cameraTransformUpdate, arg_4_0)
	arg_4_0:addEventCb(arg_4_0.viewContainer, CritterEvent.UICritterDragEnd, arg_4_0._startRefreshMoodTask, arg_4_0)
	arg_4_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_4_0._startRequestTask, arg_4_0)

	arg_4_0._scene = RoomCameraController.instance:getRoomScene()

	arg_4_0:_startRefreshMoodTask()
end

function var_0_0.onClose(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0:_stopRefreshMoodTask()
end

function var_0_0._startRequestTask(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:getViewBuilding()

	CritterController.instance:waitSendBuildManufacturAttrByBuid(var_7_0)
end

function var_0_0._startRefreshMoodTask(arg_8_0)
	if not arg_8_0._hasWaitRefreshMoodTask then
		arg_8_0._hasWaitRefreshMoodTask = true

		TaskDispatcher.runDelay(arg_8_0._onRunRefreshMoodTask, arg_8_0, 0.1)
	end
end

function var_0_0._stopRefreshMoodTask(arg_9_0)
	arg_9_0._hasWaitRefreshMoodTask = false

	TaskDispatcher.cancelTask(arg_9_0._onRunRefreshMoodTask, arg_9_0)
end

function var_0_0._onRunRefreshMoodTask(arg_10_0)
	arg_10_0._hasWaitRefreshMoodTask = false

	if not arg_10_0:_refreshMood() then
		arg_10_0:_startRefreshMoodTask()
	end

	if not arg_10_0._isSendCritterRequest then
		local var_10_0, var_10_1 = arg_10_0:getViewBuilding()

		if var_10_1 and var_10_1.config and var_10_1.config.buildingType then
			arg_10_0._isSendCritterRequest = true

			CritterController.instance:sendBuildManufacturAttrByBtype(var_10_1.config.buildingType)
		end
	end
end

function var_0_0._cameraTransformUpdate(arg_11_0)
	arg_11_0:_refreshMood()
end

local var_0_1 = {}

function var_0_0._refreshMood(arg_12_0)
	local var_12_0 = CritterModel.instance:getAllCritters()
	local var_12_1 = 0
	local var_12_2, var_12_3 = arg_12_0:getViewBuilding()
	local var_12_4 = true

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_5 = iter_12_1:getId()

		if var_12_3 and var_12_3:isCritterInSeatSlot(var_12_5) then
			var_12_1 = var_12_1 + 1

			local var_12_6 = arg_12_0._moodItemCompList[var_12_1]

			if not var_12_6 then
				local var_12_7 = gohelper.clone(arg_12_0._gomood, arg_12_0._gomap)

				var_12_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_7, CritterMoodItem)
				var_12_6.goViewTrs = var_12_7.transform

				table.insert(arg_12_0._moodItemCompList, var_12_6)
				var_12_6:setShowMoodRestore(false)
			end

			var_12_6:setCritterUid(var_12_5)

			local var_12_8 = arg_12_0:_updateMoodPos(var_12_5, var_12_6.goViewTrs)

			arg_12_0._critterMoodShowDict[var_12_5] = var_12_8

			if not var_12_8 then
				var_12_4 = false
			end
		end
	end

	for iter_12_2 = 1, #arg_12_0._moodItemCompList do
		local var_12_9 = arg_12_0._moodItemCompList[iter_12_2]
		local var_12_10 = var_12_9.critterUid

		gohelper.setActive(var_12_9.go, arg_12_0._critterMoodShowDict[var_12_10] and iter_12_2 <= var_12_1)
	end

	return var_12_4
end

function var_0_0._updateMoodPos(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._scene then
		return false
	end

	local var_13_0 = arg_13_0._scene.buildingcrittermgr:getCritterEntity(arg_13_1)
	local var_13_1 = var_13_0 and var_13_0.critterspine:getMountheadGOTrs()

	if gohelper.isNil(var_13_1) then
		return false
	end

	local var_13_2 = var_13_1.position
	local var_13_3 = RoomBendingHelper.worldToBendingSimple(var_13_2)
	local var_13_4 = RoomBendingHelper.worldPosToAnchorPos(var_13_3, arg_13_0._gomapTrs)

	if var_13_4 then
		recthelper.setAnchor(arg_13_2, var_13_4.x + arg_13_0._offX, var_13_4.y + arg_13_0._offY)

		return true
	end

	return false
end

function var_0_0.getViewBuilding(arg_14_0)
	return arg_14_0.viewContainer:getContainerViewBuilding()
end

return var_0_0
