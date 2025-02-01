module("modules.logic.room.view.manufacture.RoomTransportOverItem", package.seeall)

slot0 = class("RoomTransportOverItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._gounlink = gohelper.findChild(slot0.go, "unlink")
	slot0._golinked = gohelper.findChild(slot0.go, "linked")
	slot0._btngoto = gohelper.findChildClickWithAudio(slot0.go, "linked/#btn_goto/clickarea")
	slot0._gocritterInfoItem = gohelper.findChild(slot0.go, "linked/critterInfo/#go_critterInfoItem")
	slot0._txtto = gohelper.findChildText(slot0.go, "linked/transportInfo/info/#txt_to")
	slot0._txtfrom = gohelper.findChildText(slot0.go, "linked/transportInfo/info/#txt_from")
	slot0._gopause = gohelper.findChild(slot0.go, "linked/transportInfo/info/pause")
	slot0._gotransporting = gohelper.findChild(slot0.go, "linked/transportInfo/info/transporting")
	slot0._simagevehicle = gohelper.findChildSingleImage(slot0.go, "linked/transportInfo/vehicle/#simage_vehicle")
	slot0._govehicleimg = slot0._simagevehicle.gameObject
	slot0._txtvehicle = gohelper.findChildText(slot0.go, "linked/transportInfo/vehicle/#txt_vehicle")
	slot0._txtway = gohelper.findChildText(slot0.go, "linked/transportInfo/vehicle/#txt_vehicle/#txt_way")

	slot0:clearVar()
end

function slot0.addEventListeners(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, slot0._onCritterChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, slot0._onVehicleChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, slot0._onCritterChanged, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, slot0._onVehicleChange, slot0)
end

function slot0._btngotoOnClick(slot0)
	if slot0.transportPathMO then
		ViewMgr.instance:closeView(ViewName.RoomOverView, true)
		RoomTransportController.instance:openTransportSiteView(RoomTransportHelper.fromTo2SiteType(slot0.transportPathMO.fromType, slot0.transportPathMO.toType), RoomEnum.CameraState.Overlook)

		if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
			ManufactureController.instance:closeCritterBuildingView(true)
		end
	end
end

function slot0.onManufactureInfoUpdate(slot0)
	slot0:checkIsTransporting()
end

function slot0._onCritterChanged(slot0)
	slot0:refreshCritterItem()
	slot0:checkHasMood()
end

function slot0._onVehicleChange(slot0, slot1)
	slot0:refreshInfo()
	slot0:checkIsTransporting()
end

function slot0.setData(slot0, slot1)
	slot0.transportPathMO = slot1

	slot0:checkHasMood()
	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0:refreshInfo()
	slot0:refreshCritterItem()
	slot0:checkIsTransporting()
end

function slot0.refreshInfo(slot0)
	slot1 = nil
	slot2 = false
	slot3 = ""
	slot4 = ""

	if slot0.transportPathMO then
		slot2 = RoomConfig.instance:getBuildingConfig(slot0.transportPathMO.buildingId) and true or false
		slot3 = luaLang(RoomBuildingEnum.BuildingTypeAreName[slot0.transportPathMO.fromType])
		slot4 = luaLang(RoomBuildingEnum.BuildingTypeAreName[slot0.transportPathMO.toType])
	end

	slot0._txtfrom.text = slot3
	slot0._txtto.text = slot4
	slot5 = ""
	slot6 = ""

	if slot2 then
		slot5 = slot1.name
		slot6 = slot1.useDesc

		slot0._simagevehicle:LoadImage(ResUrl.getRoomImage("building/" .. slot1.icon))
	end

	slot0._txtvehicle.text = slot5
	slot0._txtway.text = slot6

	gohelper.setActive(slot0._govehicleimg, slot2)
end

function slot0.refreshCritterItem(slot0)
	if not slot0.critterInfoItem then
		slot0.critterInfoItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocritterInfoItem, RoomTransportCritterInfo)
	end

	slot1, slot2 = nil

	if slot0.transportPathMO then
		slot1 = slot0.transportPathMO.id

		if slot0.transportPathMO.critterUid ~= tonumber(CritterEnum.InvalidCritterUid) and slot3 ~= CritterEnum.InvalidCritterUid then
			slot2 = slot3
		end
	end

	slot0.critterInfoItem:setData(slot2, slot1)
end

function slot0.checkHasMood(slot0)
	slot1 = 0

	if slot0.transportPathMO and CritterModel.instance:getCritterMOByUid(slot0.transportPathMO.critterUid) then
		slot1 = slot2:getMoodValue()
	end

	slot0.hasMood = slot1 > 0 and true or false

	slot0:checkIsTransporting()
end

function slot0.checkIsTransporting(slot0)
	slot0.isTransporting = false
	slot1 = slot0.transportPathMO and true or false

	gohelper.setActive(slot0._golinked, slot1)
	gohelper.setActive(slot0._gounlink, not slot1)

	if slot1 then
		slot0.isTransporting = slot0.transportPathMO:isTransporting()
	end

	gohelper.setActive(slot0._gotransporting, slot0.isTransporting)
	gohelper.setActive(slot0._gopause, not slot0.isTransporting)
end

function slot0.everySecondCall(slot0)
	if slot0.hasMood and slot0.isTransporting then
		slot0:checkHasMood()
	end
end

function slot0.clearVar(slot0)
	slot0.hasMood = false
	slot0.isTransporting = false

	slot0._simagevehicle:UnLoadImage()
end

function slot0.onDestroy(slot0)
	slot0:clearVar()
end

return slot0
