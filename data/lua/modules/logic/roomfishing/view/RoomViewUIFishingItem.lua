module("modules.logic.roomfishing.view.RoomViewUIFishingItem", package.seeall)

local var_0_0 = class("RoomViewUIFishingItem", RoomViewUIBaseItem)

function var_0_0._customOnInit(arg_1_0)
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0._gocontainer, "#simage_Prop")
	arg_1_0._goNum = gohelper.findChild(arg_1_0._gocontainer, "Num")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0._gocontainer, "Num/#txt_Num")
	arg_1_0._gounfishing = gohelper.findChild(arg_1_0._gocontainer, "#go_unfishing")
	arg_1_0._gofishing = gohelper.findChild(arg_1_0._gocontainer, "#go_fishing")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0._gocontainer, "#go_fishing/#txt_RemainTime")
	arg_1_0._transtipnode = gohelper.findChild(arg_1_0._gocontainer, "#go_tipNode").transform

	arg_1_0:refreshUI(true)
end

function var_0_0._customAddEventListeners(arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_2_0._onFishingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, arg_2_0._onFishingProgressUpdate, arg_2_0)
end

function var_0_0._customRemoveEventListeners(arg_3_0)
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_3_0._onFishingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, arg_3_0._onFishingProgressUpdate, arg_3_0)
end

function var_0_0._onClick(arg_4_0, arg_4_1, arg_4_2)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_4_0 = arg_4_0:getBuildingMO()

	if not var_4_0 then
		arg_4_0:_cameraTweenFinish()

		return
	end

	local var_4_1 = arg_4_0._scene.camera:getCameraState()
	local var_4_2 = arg_4_0._scene.camera:getCameraFocus()
	local var_4_3 = HexMath.hexToPosition(var_4_0.hexPoint, RoomBlockEnum.BlockSize)
	local var_4_4 = var_4_3.x
	local var_4_5 = var_4_3.y

	if var_4_1 == RoomEnum.CameraState.OverlookAll and math.abs(var_4_2.x - var_4_4) < 0.1 and math.abs(var_4_2.y - var_4_5) < 0.1 then
		arg_4_0:_cameraTweenFinish()

		return
	end

	arg_4_0._scene.camera:switchCameraState(RoomEnum.CameraState.OverlookAll, {
		focusX = var_4_4,
		focusY = var_4_5
	}, nil, arg_4_0._cameraTweenFinish, arg_4_0)
end

function var_0_0._cameraTweenFinish(arg_5_0)
	local var_5_0 = FishingModel.instance:getCurShowingUserId()

	if FishingModel.instance:getIsFishingInUserPool(var_5_0) then
		return
	end

	FishingController.instance:dispatchEvent(FishingEvent.ShowFishingTip, arg_5_0._transtipnode.position)
end

function var_0_0._onFishingInfoUpdate(arg_6_0)
	arg_6_0:_onInfoUpdate()
end

function var_0_0._onFishingProgressUpdate(arg_7_0)
	arg_7_0:_onInfoUpdate()
end

function var_0_0._onInfoUpdate(arg_8_0)
	arg_8_0:_refreshItem()

	local var_8_0 = false
	local var_8_1 = FishingModel.instance:getCurShowingUserId()
	local var_8_2 = FishingModel.instance:getIsFishingInUserPool(var_8_1)

	if arg_8_0._isShowFishing ~= var_8_2 then
		var_8_0 = true
	end

	arg_8_0:_refreshStatus(var_8_0)
end

function var_0_0.refreshUI(arg_9_0, arg_9_1)
	arg_9_0:_refreshShow(arg_9_1)
	arg_9_0:_refreshItem()
	arg_9_0:_refreshPosition()
	arg_9_0:_refreshStatus()
end

function var_0_0._refreshItem(arg_10_0)
	local var_10_0 = FishingModel.instance:getCurFishingPoolItem()

	if not var_10_0 then
		return
	end

	local var_10_1, var_10_2 = ItemModel.instance:getItemConfigAndIcon(var_10_0[1], var_10_0[2])

	arg_10_0._simageProp:LoadImage(var_10_2)
end

function var_0_0._refreshShow(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._scene.camera:getCameraState()

	if var_11_0 ~= RoomEnum.CameraState.Overlook and var_11_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_11_0:_setShow(false, arg_11_1)

		return
	end

	local var_11_1 = arg_11_0:getBuildingEntity() ~= nil

	arg_11_0:_setShow(var_11_1, arg_11_1)
	arg_11_0:_refreshStatus()
end

function var_0_0._refreshStatus(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = "room_task_in"
	local var_12_2 = FishingModel.instance:getCurShowingUserId()
	local var_12_3 = FishingModel.instance:getIsFishingInUserPool(var_12_2)

	if var_12_3 then
		arg_12_0:_refreshTime()
		TaskDispatcher.cancelTask(arg_12_0._refreshTime, arg_12_0)
		TaskDispatcher.runRepeat(arg_12_0._refreshTime, arg_12_0, TimeUtil.OneSecond)

		local var_12_4 = FishingModel.instance:getCurFishingPoolItem()

		if var_12_4 then
			local var_12_5 = FishingModel.instance:getFishingTimes(var_12_2)

			arg_12_0._txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), var_12_4[3] * var_12_5)

			gohelper.setActive(arg_12_0._goNum, true)
		end

		gohelper.setActive(arg_12_0._gofishing, true)
		gohelper.setActive(arg_12_0._gounfishing, true)

		var_12_1 = "switch"
		var_12_0 = AudioEnum3_1.RoomFishing.ui_home_mingdi_dalao
	else
		gohelper.setActive(arg_12_0._gofishing, false)
		gohelper.setActive(arg_12_0._gounfishing, true)
		gohelper.setActive(arg_12_0._goNum, false)
	end

	arg_12_0._isShowFishing = var_12_3

	if arg_12_1 then
		arg_12_0._baseAnimator:Play(var_12_1, 0, 0)

		if var_12_0 then
			AudioMgr.instance:trigger(var_12_0)
		end
	else
		arg_12_0._baseAnimator:Play(var_12_1, 0, 1)
	end
end

function var_0_0._refreshTime(arg_13_0)
	local var_13_0 = FishingModel.instance:getCurShowingUserId()
	local var_13_1 = FishingModel.instance:getRemainFishingTime(var_13_0)
	local var_13_2, var_13_3, var_13_4 = TimeUtil.secondToHMS(var_13_1)
	local var_13_5 = string.format("%02d", var_13_2)
	local var_13_6 = string.format("%02d", var_13_3)
	local var_13_7 = string.format("%02d", var_13_4)

	arg_13_0._txtTime.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_fishing_time"), var_13_5, var_13_6, var_13_7)

	if var_13_1 <= 0 then
		TaskDispatcher.cancelTask(arg_13_0._refreshTime, arg_13_0)
	end
end

function var_0_0.getUI3DPos(arg_14_0)
	local var_14_0 = arg_14_0:getBuildingEntity()

	if not var_14_0 then
		arg_14_0:_setShow(false, true)

		return Vector3.zero
	end

	local var_14_1 = var_14_0.containerGO
	local var_14_2 = var_14_0:getHeadGO()
	local var_14_3 = var_14_2 and var_14_2.transform.position or var_14_1.transform.position
	local var_14_4 = Vector3(var_14_3.x, var_14_3.y, var_14_3.z)

	return (RoomBendingHelper.worldToBendingSimple(var_14_4))
end

function var_0_0.getBuildingMO(arg_15_0)
	local var_15_0 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = iter_15_1:getBelongUserId()
			local var_15_2 = PlayerModel.instance:getMyUserId()

			if var_15_1 and var_15_1 == var_15_2 then
				return iter_15_1
			end
		end
	end
end

function var_0_0.getBuildingEntity(arg_16_0)
	local var_16_0 = arg_16_0:getBuildingMO()

	if var_16_0 then
		return (arg_16_0._scene.buildingmgr:getBuildingEntity(var_16_0.buildingUid, SceneTag.RoomBuilding))
	end
end

function var_0_0._customOnDestory(arg_17_0)
	arg_17_0._simageProp:UnLoadImage()
	TaskDispatcher.cancelTask(arg_17_0._refreshTime, arg_17_0)
end

var_0_0.prefabPath = "ui/viewres/room/fish/roomfishbubbleui.prefab"

return var_0_0
