module("modules.logic.room.view.manufacture.RoomViewUIManufactureItem", package.seeall)

local var_0_0 = class("RoomViewUIManufactureItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._manufactureType = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._gonone = gohelper.findChild(arg_2_0._gocontainer, "#go_none")
	arg_2_0._produceAnimator = arg_2_0._gonone:GetComponent(RoomEnum.ComponentType.Animator)
	arg_2_0._golayoutGet = gohelper.findChild(arg_2_0._gocontainer, "#go_layoutGet")
	arg_2_0._goget = gohelper.findChild(arg_2_0._gocontainer, "#go_layoutGet/#go_get")
	arg_2_0._txtbuildingname = gohelper.findChildText(arg_2_0._gocontainer, "bottom/txt_buildingName")

	local var_2_0 = RoomBuildingEnum.BuildingTypeAreName[arg_2_0._manufactureType]

	arg_2_0._txtbuildingname.text = luaLang(var_2_0)

	gohelper.setActive(arg_2_0._goget, false)
end

function var_0_0._customAddEventListeners(arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._refreshManufactureItem, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._refreshManufactureItem, arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_4_0._refreshManufactureItem, arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_4_0._refreshManufactureItem, arg_4_0)
end

function var_0_0._onClick(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._canGet then
		ManufactureController.instance:gainCompleteManufactureItem()
	else
		ManufactureController.instance:openManufactureBuildingViewByType(arg_5_0._manufactureType)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0.refreshUI(arg_6_0, arg_6_1)
	arg_6_0:_refreshManufactureItem()
	arg_6_0:_refreshShow(arg_6_1)
	arg_6_0:_refreshPosition()
end

function var_0_0._refreshManufactureItem(arg_7_0)
	arg_7_0._canGet = false

	local var_7_0 = false
	local var_7_1 = {}
	local var_7_2 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(arg_7_0._manufactureType)
	local var_7_3 = var_7_2 and var_7_2:getBuildingMOList(true)

	if var_7_3 then
		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			local var_7_4 = iter_7_1:getNewerCompleteManufactureItem()
			local var_7_5 = iter_7_1:getManufactureState() == RoomManufactureEnum.ManufactureState.Running

			var_7_0 = var_7_0 or var_7_5

			if var_7_4 then
				arg_7_0._canGet = true

				table.insert(var_7_1, var_7_4)
			end
		end
	end

	if arg_7_0._iconList then
		for iter_7_2, iter_7_3 in ipairs(arg_7_0._iconList) do
			iter_7_3:UnLoadImage()
		end
	end

	arg_7_0._iconList = arg_7_0:getUserDataTb_()

	gohelper.CreateObjList(arg_7_0, arg_7_0._onsSetManufactureItem, var_7_1, arg_7_0._golayoutGet, arg_7_0._goget)
	gohelper.setActive(arg_7_0._gonone, not arg_7_0._canGet)
	gohelper.setActive(arg_7_0._golayoutGet, arg_7_0._canGet)

	local var_7_6 = "idle"

	if not arg_7_0._canGet and var_7_0 then
		var_7_6 = "loop"
	end

	arg_7_0._produceAnimator:Play(var_7_6, 0, 0)
end

function var_0_0._onsSetManufactureItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildSingleImage(arg_8_1, "#simage_item")
	local var_8_1 = ManufactureConfig.instance:getItemId(arg_8_2)
	local var_8_2, var_8_3 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_8_1)

	if not string.nilorempty(var_8_3) then
		var_8_0:LoadImage(var_8_3)
	end

	arg_8_0._iconList[#arg_8_0._iconList + 1] = var_8_0
end

function var_0_0._refreshShow(arg_9_0, arg_9_1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_9_0:_setShow(false, arg_9_1)

		return
	end

	local var_9_0 = arg_9_0._scene.camera:getCameraState()

	if var_9_0 ~= RoomEnum.CameraState.Overlook and var_9_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_9_0:_setShow(false, arg_9_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_9_0:_setShow(false, arg_9_1)

		return
	end

	arg_9_0:_setShow(true, arg_9_1)
end

function var_0_0.getUI3DPos(arg_10_0)
	local var_10_0 = RoomMapBuildingAreaModel.instance:getBuildingUidByType(arg_10_0._manufactureType)
	local var_10_1 = arg_10_0._scene.buildingmgr:getBuildingEntity(var_10_0, SceneTag.RoomBuilding)

	if not var_10_1 then
		arg_10_0:_setShow(false, true)

		return Vector3.zero
	end

	local var_10_2 = var_10_1:getHeadGO()
	local var_10_3 = var_10_1.containerGO
	local var_10_4 = var_10_2 and var_10_2.transform.position or var_10_3.transform.position
	local var_10_5 = Vector3(var_10_4.x, var_10_4.y, var_10_4.z)

	return (RoomBendingHelper.worldToBendingSimple(var_10_5))
end

function var_0_0._customOnDestory(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._iconList) do
		iter_11_1:UnLoadImage()
	end
end

return var_0_0
