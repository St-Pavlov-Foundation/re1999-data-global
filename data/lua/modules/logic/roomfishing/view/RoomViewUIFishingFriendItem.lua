module("modules.logic.roomfishing.view.RoomViewUIFishingFriendItem", package.seeall)

local var_0_0 = class("RoomViewUIFishingFriendItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._userId = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._goheadicon = gohelper.findChild(arg_2_0._gocontainer, "#go_headicon")
	arg_2_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_2_0._goheadicon)
	arg_2_0._txtPlayerName = gohelper.findChildText(arg_2_0._gocontainer, "#txt_PlayerName")

	local var_2_0, var_2_1 = FishingModel.instance:getFishingFriendInfo(arg_2_0._userId)

	arg_2_0._playericon:setMOValue(arg_2_0._userId, "", 0, var_2_1)
	arg_2_0._playericon:setShowLevel(false)
	arg_2_0._playericon:setEnableClick(false)

	arg_2_0._txtPlayerName.text = var_2_0
end

function var_0_0._customAddEventListeners(arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	return
end

function var_0_0.getUI3DPos(arg_5_0)
	local var_5_0 = arg_5_0:getBuildingEntity()

	if not var_5_0 then
		arg_5_0:_setShow(false, true)

		return Vector3.zero
	end

	local var_5_1 = var_5_0.containerGO
	local var_5_2 = var_5_0:getHeadGO()
	local var_5_3 = var_5_2 and var_5_2.transform.position or var_5_1.transform.position
	local var_5_4 = Vector3(var_5_3.x, var_5_3.y, var_5_3.z)

	return (RoomBendingHelper.worldToBendingSimple(var_5_4))
end

function var_0_0._onClick(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	arg_7_0:_refreshShow(arg_7_1)
	arg_7_0:_refreshPosition()
end

function var_0_0._refreshShow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._scene.camera:getCameraState()

	if var_8_0 ~= RoomEnum.CameraState.Overlook and var_8_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	local var_8_1 = arg_8_0:getBuildingEntity() ~= nil

	arg_8_0:_setShow(var_8_1, arg_8_1)
end

function var_0_0.getBuildingEntity(arg_9_0)
	local var_9_0 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = iter_9_1:getBelongUserId()

			if var_9_1 and var_9_1 == arg_9_0._userId then
				return (arg_9_0._scene.buildingmgr:getBuildingEntity(iter_9_1.buildingUid, SceneTag.RoomBuilding))
			end
		end
	end
end

function var_0_0._customOnDestory(arg_10_0)
	return
end

var_0_0.prefabPath = "ui/viewres/room/fish/roomfishfriendui.prefab"

return var_0_0
