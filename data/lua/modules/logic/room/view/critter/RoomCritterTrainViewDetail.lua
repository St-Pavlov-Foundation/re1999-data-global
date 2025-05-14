module("modules.logic.room.view.critter.RoomCritterTrainViewDetail", package.seeall)

local var_0_0 = class("RoomCritterTrainViewDetail", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotrainingdetail = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_trainingdetail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntrainevent:AddClickListener(arg_2_0._btntraineventOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntrainevent:RemoveClickListener()
end

function var_0_0._btntrainfinishOnClick(arg_4_0)
	local var_4_0 = arg_4_0._slotMO and arg_4_0._slotMO.critterMO

	if var_4_0 and var_4_0.trainInfo then
		if var_4_0.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(var_4_0.id)
		else
			RoomCritterController.instance:openTrainEventView(var_4_0.id)
		end
	end
end

function var_0_0._btntraineventOnClick(arg_5_0)
	if arg_5_0:_isHasEventTrigger() then
		RoomCritterController.instance:openTrainEventView(arg_5_0._critterMO.id)
	end
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = arg_6_0:getResInst(RoomCritterTrainDetailItem.prefabPath, arg_6_0._gotrainingdetail)

	arg_6_0.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, RoomCritterTrainDetailItem, arg_6_0)
	arg_6_0._gomapui = gohelper.findChild(arg_6_0.viewGO, "#go_mapui")
	arg_6_0._goeventicon = gohelper.findChild(arg_6_0.viewGO, "#go_mapui/go_eventicon")
	arg_6_0._btntrainevent = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "#go_mapui/go_eventicon/btn_trainevent")
	arg_6_0._goeventiconTrs = arg_6_0._goeventicon.transform
	arg_6_0._gomapuiTrs = arg_6_0._gomapui.transform
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._scene = RoomCameraController.instance:getRoomScene()

	arg_8_0:addEventCb(CritterController.instance, CritterEvent.TrainStartTrainCritterReply, arg_8_0._onTrainStartTrainCritterReply, arg_8_0)
	arg_8_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_8_0._onCritterInfoChanged, arg_8_0)
	arg_8_0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, arg_8_0._onTrainSelectEventOptionReply, arg_8_0)

	if arg_8_0.viewContainer then
		arg_8_0:addEventCb(arg_8_0.viewContainer, CritterEvent.UITrainSelectSlot, arg_8_0._onSelectSlotItem, arg_8_0)
		arg_8_0:addEventCb(arg_8_0.viewContainer, CritterEvent.UITrainCdTime, arg_8_0._opTranCdTimeUpdate, arg_8_0)
	end

	arg_8_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_8_0._refreshPosition, arg_8_0)
	arg_8_0.detailItem:setCritterChanageCallback(arg_8_0._critterChangeCallblck, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.detailItem:onDestroy()
	TaskDispatcher.cancelTask(arg_10_0._playLevelUp, arg_10_0)

	arg_10_0._specialEventIds = nil
end

function var_0_0._critterChangeCallblck(arg_11_0)
	arg_11_0.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, arg_11_0._slotMO)
end

function var_0_0._onSelectSlotItem(arg_12_0, arg_12_1)
	arg_12_0._slotMO = arg_12_1
	arg_12_0._critterMO = arg_12_1.critterMO
	arg_12_0._critterUid = arg_12_0._critterMO and arg_12_0._critterMO.id

	arg_12_0.detailItem:onUpdateMO(arg_12_1.critterMO)
	arg_12_0:_refreshUI()
end

function var_0_0._opTranCdTimeUpdate(arg_13_0)
	if not arg_13_0._specialEventIds or #arg_13_0._specialEventIds < 1 then
		arg_13_0.detailItem:tranCdTimeUpdate()
	end

	arg_13_0:_refreshUI()
end

function var_0_0._refreshUI(arg_14_0)
	local var_14_0 = arg_14_0:_isHasEventTrigger()

	if arg_14_0._isLastHasTrigger ~= var_14_0 then
		arg_14_0._isLastHasTrigger = var_14_0

		gohelper.setActive(arg_14_0._goeventicon, var_14_0)
		arg_14_0:_refreshPosition()
	end
end

function var_0_0._onTrainStartTrainCritterReply(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.detailItem:refreshUI()
end

function var_0_0._onTrainSelectEventOptionReply(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_16_2)

	if var_16_0 and var_16_0.type == CritterEnum.EventType.Special then
		arg_16_0._specialEventIds = arg_16_0._specialEventIds or {}

		if #arg_16_0._specialEventIds < 1 then
			TaskDispatcher.runDelay(arg_16_0._playLevelUp, arg_16_0, 0.1)
		end

		table.insert(arg_16_0._specialEventIds, arg_16_2)
	end
end

function var_0_0._onCritterInfoChanged(arg_17_0)
	arg_17_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_17_0._critterUid)

	arg_17_0.detailItem:onUpdateMO(arg_17_0._critterMO)
end

function var_0_0._isHasEventTrigger(arg_18_0)
	if arg_18_0._critterMO and arg_18_0._critterMO.trainInfo:isHasEventTrigger() then
		return true
	end

	return false
end

function var_0_0._playLevelUp(arg_19_0)
	local var_19_0 = arg_19_0._specialEventIds

	arg_19_0._specialEventIds = nil

	local var_19_1 = arg_19_0._critterMO

	if var_19_0 and var_19_1 and var_19_1:isCultivating() then
		local var_19_2 = {}
		local var_19_3 = var_19_1.trainInfo.events

		for iter_19_0 = 1, #var_19_3 do
			local var_19_4 = var_19_3[iter_19_0]

			if tabletool.indexOf(var_19_0, var_19_4.eventId) then
				tabletool.addValues(var_19_2, var_19_4.addAttributes)
			end
		end

		ViewMgr.instance:openView(ViewName.RoomCritterTrainEventResultView, {
			critterMO = var_19_1,
			addAttributeMOs = var_19_2
		})
	end
end

function var_0_0._refreshPosition(arg_20_0)
	if not arg_20_0._isLastHasTrigger then
		return
	end

	local var_20_0 = arg_20_0:_getCritterEntity()

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0.critterspine:getMountheadGOTrs() or var_20_0.goTrs

	if not var_20_1 then
		return
	end

	local var_20_2, var_20_3, var_20_4 = transformhelper.getPos(var_20_1)
	local var_20_5 = RoomBendingHelper.worldToBendingSimple(Vector3(var_20_2, var_20_3, var_20_4))
	local var_20_6 = RoomBendingHelper.worldPosToAnchorPos(var_20_5, arg_20_0._gomapuiTrs)

	if var_20_6 then
		recthelper.setAnchor(arg_20_0._goeventiconTrs, var_20_6.x, var_20_6.y)
	end
end

function var_0_0._getCritterEntity(arg_21_0)
	if not arg_21_0._scene then
		return nil
	end

	if arg_21_0._scene.cameraFollow:isFollowing() then
		return arg_21_0._scene.crittermgr:getCritterEntity(arg_21_0._critterUid, SceneTag.RoomCharacter)
	end

	return arg_21_0._scene.crittermgr:getTempCritterEntity()
end

return var_0_0
