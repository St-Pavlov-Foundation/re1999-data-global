module("modules.logic.room.view.manufacture.RoomViewUIManufactureItem", package.seeall)

slot0 = class("RoomViewUIManufactureItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._manufactureType = slot1
end

function slot0._customOnInit(slot0)
	slot0._gonone = gohelper.findChild(slot0._gocontainer, "#go_none")
	slot0._produceAnimator = slot0._gonone:GetComponent(RoomEnum.ComponentType.Animator)
	slot0._golayoutGet = gohelper.findChild(slot0._gocontainer, "#go_layoutGet")
	slot0._goget = gohelper.findChild(slot0._gocontainer, "#go_layoutGet/#go_get")
	slot0._txtbuildingname = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._txtbuildingname.text = luaLang(RoomBuildingEnum.BuildingTypeAreName[slot0._manufactureType])

	gohelper.setActive(slot0._goget, false)
end

function slot0._customAddEventListeners(slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._refreshManufactureItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._refreshManufactureItem, slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._refreshManufactureItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._refreshManufactureItem, slot0)
end

function slot0._onClick(slot0, slot1, slot2)
	if slot0._canGet then
		ManufactureController.instance:gainCompleteManufactureItem()
	else
		ManufactureController.instance:openManufactureBuildingViewByType(slot0._manufactureType)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshManufactureItem()
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
end

function slot0._refreshManufactureItem(slot0)
	slot0._canGet = false
	slot1 = false
	slot2 = {}

	if RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot0._manufactureType) and slot3:getBuildingMOList(true) then
		for slot8, slot9 in ipairs(slot4) do
			slot1 = slot1 or slot9:getManufactureState() == RoomManufactureEnum.ManufactureState.Running

			if slot9:getNewerCompleteManufactureItem() then
				slot0._canGet = true

				table.insert(slot2, slot10)
			end
		end
	end

	if slot0._iconList then
		for slot8, slot9 in ipairs(slot0._iconList) do
			slot9:UnLoadImage()
		end
	end

	slot0._iconList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onsSetManufactureItem, slot2, slot0._golayoutGet, slot0._goget)
	gohelper.setActive(slot0._gonone, not slot0._canGet)
	gohelper.setActive(slot0._golayoutGet, slot0._canGet)

	slot5 = "idle"

	if not slot0._canGet and slot1 then
		slot5 = "loop"
	end

	slot0._produceAnimator:Play(slot5, 0, 0)
end

function slot0._onsSetManufactureItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildSingleImage(slot1, "#simage_item")
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ManufactureConfig.instance:getItemId(slot2))

	if not string.nilorempty(slot7) then
		slot4:LoadImage(slot7)
	end

	slot0._iconList[#slot0._iconList + 1] = slot4
end

function slot0._refreshShow(slot0, slot1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		slot0:_setShow(false, slot1)

		return
	end

	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook and slot2 ~= RoomEnum.CameraState.OverlookAll then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	if not slot0._scene.buildingmgr:getBuildingEntity(RoomMapBuildingAreaModel.instance:getBuildingUidByType(slot0._manufactureType), SceneTag.RoomBuilding) then
		slot0:_setShow(false, true)

		return Vector3.zero
	end

	slot5 = slot2:getHeadGO() and slot3.transform.position or slot2.containerGO.transform.position

	return RoomBendingHelper.worldToBendingSimple(Vector3(slot5.x, slot5.y, slot5.z))
end

function slot0._customOnDestory(slot0)
	for slot4, slot5 in ipairs(slot0._iconList) do
		slot5:UnLoadImage()
	end
end

return slot0
