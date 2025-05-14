module("modules.logic.room.view.manufacture.RoomManufactureAccelerateView", package.seeall)

local var_0_0 = class("RoomManufactureAccelerateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._clickMask = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "mask")
	arg_1_0._imagebuildingIcon = gohelper.findChildImage(arg_1_0.viewGO, "title/#simage_buildingIcon")
	arg_1_0._txtbuildingName = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_buildingName")
	arg_1_0._imgquality = gohelper.findChildImage(arg_1_0.viewGO, "progress/#image_quality")
	arg_1_0._gomanufactureItem = gohelper.findChild(arg_1_0.viewGO, "progress/#go_manufactureItem")
	arg_1_0._txtmanufactureItemName = gohelper.findChildText(arg_1_0.viewGO, "progress/#txt_manufactureItemName")
	arg_1_0._simagebarIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "progress/progressBar/#simage_barIcon")
	arg_1_0._simagebarValue = gohelper.findChildImage(arg_1_0.viewGO, "progress/progressBar/#simage_barValue")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "progress/progressBar/#go_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "progress/progressBar/#go_time/#txt_time")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "itemArea/#scroll_item/viewport/content")
	arg_1_0._goaccelerateItem = gohelper.findChild(arg_1_0.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._clickMask:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_2_0._onManufactureInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_2_0._onManufactureBuildingInfoChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickMask:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._onManufactureInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._onManufactureBuildingInfoChange, arg_3_0)
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._onManufactureInfoUpdate(arg_5_0)
	arg_5_0:refreshProgress()
end

function var_0_0._onManufactureBuildingInfoChange(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._buildingMO and arg_6_0._buildingMO.id

	if arg_6_1 and not arg_6_1[var_6_0] then
		return
	end

	arg_6_0:refreshProgress()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._accelerateItemList = {}
end

function var_0_0.onUpdateParam(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.buildingUid

	arg_8_0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(var_8_0)

	arg_8_0:refreshTitle()
	arg_8_0:setManufactureItem()
end

function var_0_0.setManufactureItem(arg_9_0)
	arg_9_0.curSlotId = arg_9_0._buildingMO and arg_9_0._buildingMO:getSlotIdInProgress()

	local var_9_0 = arg_9_0._buildingMO:getSlotManufactureItemId(arg_9_0.curSlotId)
	local var_9_1 = ManufactureConfig.instance:getItemId(var_9_0)

	if var_9_1 then
		if not arg_9_0._itemIcon then
			arg_9_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_9_0._gomanufactureItem)

			arg_9_0._itemIcon:isShowQuality(false)
		end

		local var_9_2 = ManufactureConfig.instance:getBatchIconPath(var_9_0)

		arg_9_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, var_9_1, nil, nil, nil, {
			specificIcon = var_9_2
		})

		local var_9_3 = arg_9_0._itemIcon:getRare()
		local var_9_4 = RoomManufactureEnum.RareImageMap[var_9_3]

		UISpriteSetMgr.instance:setCritterSprite(arg_9_0._imgquality, var_9_4)

		local var_9_5 = ManufactureConfig.instance:getManufactureItemName(var_9_0)

		arg_9_0._txtmanufactureItemName.text = var_9_5
	end

	arg_9_0:refreshProgress()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:onUpdateParam()
	arg_10_0:setAccelerateItemList()
	arg_10_0:everySecondCall()
	TaskDispatcher.runRepeat(arg_10_0.everySecondCall, arg_10_0, 1)
end

function var_0_0.setAccelerateItemList(arg_11_0)
	local var_11_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.RoomManufactureAccelerateItem)

	gohelper.CreateObjList(arg_11_0, arg_11_0._onSetAccelerateItem, var_11_0, arg_11_0._gocontent, arg_11_0._goaccelerateItem, RoomManufactureAccelerateItem)
end

function var_0_0._onSetAccelerateItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:setData(arg_12_0._buildingMO.id, arg_12_2)
end

function var_0_0.refreshTitle(arg_13_0)
	local var_13_0 = ""
	local var_13_1

	if arg_13_0._buildingMO then
		var_13_0 = arg_13_0._buildingMO.config.useDesc
		var_13_1 = ManufactureConfig.instance:getManufactureBuildingIcon(arg_13_0._buildingMO.buildingId)
	end

	arg_13_0._txtbuildingName.text = var_13_0

	UISpriteSetMgr.instance:setRoomSprite(arg_13_0._imagebuildingIcon, var_13_1)
end

function var_0_0.refreshProgress(arg_14_0)
	if not arg_14_0._buildingMO then
		return
	end

	if not (arg_14_0._buildingMO:getManufactureState() == RoomManufactureEnum.ManufactureState.Running) then
		arg_14_0:closeThis()
	end

	local var_14_0 = arg_14_0._buildingMO:getSlotIdInProgress()

	if not var_14_0 or var_14_0 ~= arg_14_0.curSlotId then
		arg_14_0:closeThis()
	end

	local var_14_1 = 0
	local var_14_2 = arg_14_0._buildingMO:getSlotProgress(arg_14_0.curSlotId)
	local var_14_3 = arg_14_0._buildingMO:getSlotManufactureItemId(arg_14_0.curSlotId)

	if var_14_3 and var_14_3 ~= 0 then
		var_14_1 = ManufactureConfig.instance:getNeedTime(var_14_3) * (1 - var_14_2)
	end

	local var_14_4 = ManufactureController.instance:getFormatTime(var_14_1)

	arg_14_0._simagebarValue.fillAmount = var_14_2
	arg_14_0._txttime.text = var_14_4
end

function var_0_0.everySecondCall(arg_15_0)
	arg_15_0:refreshProgress()
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.everySecondCall, arg_16_0)
	MessageBoxController.instance:dispatchEvent(MessageBoxEvent.CloseSpecificMessageBoxView, MessageBoxIdDefine.RoomManufactureAccelerateOver)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
