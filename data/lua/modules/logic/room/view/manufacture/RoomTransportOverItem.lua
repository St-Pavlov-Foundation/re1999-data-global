module("modules.logic.room.view.manufacture.RoomTransportOverItem", package.seeall)

local var_0_0 = class("RoomTransportOverItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gounlink = gohelper.findChild(arg_2_0.go, "unlink")
	arg_2_0._golinked = gohelper.findChild(arg_2_0.go, "linked")
	arg_2_0._btngoto = gohelper.findChildClickWithAudio(arg_2_0.go, "linked/#btn_goto/clickarea")
	arg_2_0._gocritterInfoItem = gohelper.findChild(arg_2_0.go, "linked/critterInfo/#go_critterInfoItem")
	arg_2_0._txtto = gohelper.findChildText(arg_2_0.go, "linked/transportInfo/info/#txt_to")
	arg_2_0._txtfrom = gohelper.findChildText(arg_2_0.go, "linked/transportInfo/info/#txt_from")
	arg_2_0._gopause = gohelper.findChild(arg_2_0.go, "linked/transportInfo/info/pause")
	arg_2_0._gotransporting = gohelper.findChild(arg_2_0.go, "linked/transportInfo/info/transporting")
	arg_2_0._simagevehicle = gohelper.findChildSingleImage(arg_2_0.go, "linked/transportInfo/vehicle/#simage_vehicle")
	arg_2_0._govehicleimg = arg_2_0._simagevehicle.gameObject
	arg_2_0._txtvehicle = gohelper.findChildText(arg_2_0.go, "linked/transportInfo/vehicle/#txt_vehicle")
	arg_2_0._txtway = gohelper.findChildText(arg_2_0.go, "linked/transportInfo/vehicle/#txt_vehicle/#txt_way")

	arg_2_0:clearVar()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btngoto:AddClickListener(arg_3_0._btngotoOnClick, arg_3_0)
	arg_3_0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, arg_3_0._onCritterChanged, arg_3_0)
	arg_3_0:addEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, arg_3_0._onVehicleChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btngoto:RemoveClickListener()
	arg_4_0:removeEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, arg_4_0._onCritterChanged, arg_4_0)
	arg_4_0:removeEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, arg_4_0._onVehicleChange, arg_4_0)
end

function var_0_0._btngotoOnClick(arg_5_0)
	if arg_5_0.transportPathMO then
		ViewMgr.instance:closeView(ViewName.RoomOverView, true)

		local var_5_0 = RoomTransportHelper.fromTo2SiteType(arg_5_0.transportPathMO.fromType, arg_5_0.transportPathMO.toType)

		RoomTransportController.instance:openTransportSiteView(var_5_0, RoomEnum.CameraState.Overlook)

		if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
			ManufactureController.instance:closeCritterBuildingView(true)
		end
	end
end

function var_0_0.onManufactureInfoUpdate(arg_6_0)
	arg_6_0:checkIsTransporting()
end

function var_0_0._onCritterChanged(arg_7_0)
	arg_7_0:refreshCritterItem()
	arg_7_0:checkHasMood()
end

function var_0_0._onVehicleChange(arg_8_0, arg_8_1)
	arg_8_0:refreshInfo()
	arg_8_0:checkIsTransporting()
end

function var_0_0.setData(arg_9_0, arg_9_1)
	arg_9_0.transportPathMO = arg_9_1

	arg_9_0:checkHasMood()
	arg_9_0:refresh()
end

function var_0_0.refresh(arg_10_0)
	arg_10_0:refreshInfo()
	arg_10_0:refreshCritterItem()
	arg_10_0:checkIsTransporting()
end

function var_0_0.refreshInfo(arg_11_0)
	local var_11_0
	local var_11_1 = false
	local var_11_2 = ""
	local var_11_3 = ""

	if arg_11_0.transportPathMO then
		var_11_0 = RoomConfig.instance:getBuildingConfig(arg_11_0.transportPathMO.buildingId)
		var_11_1 = var_11_0 and true or false

		local var_11_4 = RoomBuildingEnum.BuildingTypeAreName[arg_11_0.transportPathMO.fromType]
		local var_11_5 = RoomBuildingEnum.BuildingTypeAreName[arg_11_0.transportPathMO.toType]

		var_11_2 = luaLang(var_11_4)
		var_11_3 = luaLang(var_11_5)
	end

	arg_11_0._txtfrom.text = var_11_2
	arg_11_0._txtto.text = var_11_3

	local var_11_6 = ""
	local var_11_7 = ""

	if var_11_1 then
		var_11_6 = var_11_0.name
		var_11_7 = var_11_0.useDesc

		local var_11_8 = ResUrl.getRoomImage("building/" .. var_11_0.icon)

		arg_11_0._simagevehicle:LoadImage(var_11_8)
	end

	arg_11_0._txtvehicle.text = var_11_6
	arg_11_0._txtway.text = var_11_7

	gohelper.setActive(arg_11_0._govehicleimg, var_11_1)
end

function var_0_0.refreshCritterItem(arg_12_0)
	if not arg_12_0.critterInfoItem then
		arg_12_0.critterInfoItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_12_0._gocritterInfoItem, RoomTransportCritterInfo)
	end

	local var_12_0
	local var_12_1

	if arg_12_0.transportPathMO then
		var_12_0 = arg_12_0.transportPathMO.id

		local var_12_2 = arg_12_0.transportPathMO.critterUid

		if var_12_2 ~= tonumber(CritterEnum.InvalidCritterUid) and var_12_2 ~= CritterEnum.InvalidCritterUid then
			var_12_1 = var_12_2
		end
	end

	arg_12_0.critterInfoItem:setData(var_12_1, var_12_0)
end

function var_0_0.checkHasMood(arg_13_0)
	local var_13_0 = 0

	if arg_13_0.transportPathMO then
		local var_13_1 = CritterModel.instance:getCritterMOByUid(arg_13_0.transportPathMO.critterUid)

		if var_13_1 then
			var_13_0 = var_13_1:getMoodValue()
		end
	end

	arg_13_0.hasMood = var_13_0 > 0 and true or false

	arg_13_0:checkIsTransporting()
end

function var_0_0.checkIsTransporting(arg_14_0)
	arg_14_0.isTransporting = false

	local var_14_0 = arg_14_0.transportPathMO and true or false

	gohelper.setActive(arg_14_0._golinked, var_14_0)
	gohelper.setActive(arg_14_0._gounlink, not var_14_0)

	if var_14_0 then
		arg_14_0.isTransporting = arg_14_0.transportPathMO:isTransporting()
	end

	gohelper.setActive(arg_14_0._gotransporting, arg_14_0.isTransporting)
	gohelper.setActive(arg_14_0._gopause, not arg_14_0.isTransporting)
end

function var_0_0.everySecondCall(arg_15_0)
	if arg_15_0.hasMood and arg_15_0.isTransporting then
		arg_15_0:checkHasMood()
	end
end

function var_0_0.clearVar(arg_16_0)
	arg_16_0.hasMood = false
	arg_16_0.isTransporting = false

	arg_16_0._simagevehicle:UnLoadImage()
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0:clearVar()
end

return var_0_0
