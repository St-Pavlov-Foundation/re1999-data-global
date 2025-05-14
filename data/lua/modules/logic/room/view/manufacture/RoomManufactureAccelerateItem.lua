module("modules.logic.room.view.manufacture.RoomManufactureAccelerateItem", package.seeall)

local var_0_0 = class("RoomManufactureAccelerateItem", LuaCompBase)
local var_0_1 = 1

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._imgquality = gohelper.findChildImage(arg_2_0.go, "#image_quality")
	arg_2_0._goitem = gohelper.findChild(arg_2_0.go, "#go_item")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.go, "#txt_name")
	arg_2_0._gouse = gohelper.findChild(arg_2_0.go, "#go_use")
	arg_2_0._inputvalue = gohelper.findChildTextMeshInputField(arg_2_0.go, "#go_use/valuebg/#input_value")
	arg_2_0._btnmin = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_use/#btn_min")
	arg_2_0._btnsub = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_use/#btn_sub")
	arg_2_0._btnadd = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_use/#btn_add")
	arg_2_0._btnmax = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_use/#btn_max")
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_0.go, "#go_use/hasCount/#simage_icon")
	arg_2_0._txthas = gohelper.findChildText(arg_2_0.go, "#go_use/hasCount/#txt_has")
	arg_2_0._btnuse = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_use/#btn_use")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnmin:AddClickListener(arg_3_0._btnminOnClick, arg_3_0)
	arg_3_0._btnsub:AddClickListener(arg_3_0._btnsubOnClick, arg_3_0)
	arg_3_0._inputvalue:AddOnValueChanged(arg_3_0._onInputValueChange, arg_3_0)
	arg_3_0._btnadd:AddClickListener(arg_3_0._btnaddOnClick, arg_3_0)
	arg_3_0._btnmax:AddClickListener(arg_3_0._btnmaxOnClick, arg_3_0)
	arg_3_0._btnuse:AddClickListener(arg_3_0._btnuseOnClick, arg_3_0)
	arg_3_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnmin:RemoveClickListener()
	arg_4_0._btnsub:RemoveClickListener()
	arg_4_0._inputvalue:RemoveOnValueChanged()
	arg_4_0._btnadd:RemoveClickListener()
	arg_4_0._btnmax:RemoveClickListener()
	arg_4_0._btnuse:RemoveClickListener()
	arg_4_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_4_0._onItemChange, arg_4_0)
end

function var_0_0._btnminOnClick(arg_5_0)
	arg_5_0:changeCount(var_0_1)
end

function var_0_0._btnsubOnClick(arg_6_0)
	arg_6_0:changeCount(arg_6_0._count - 1)
end

function var_0_0._onInputValueChange(arg_7_0, arg_7_1)
	local var_7_0 = tonumber(arg_7_1) or var_0_1

	arg_7_0:changeCount(var_7_0)
end

function var_0_0._btnaddOnClick(arg_8_0)
	arg_8_0:changeCount(arg_8_0._count + 1)
end

function var_0_0._btnmaxOnClick(arg_9_0)
	local var_9_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_9_0._buildingUid)

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_0:getMaxCount()
	local var_9_2 = var_9_0:getSlotIdInProgress()
	local var_9_3 = var_9_0:getSlotRemainSecTime(var_9_2)

	if var_9_3 > 0 then
		local var_9_4 = var_9_0:getAccelerateEff(var_9_2, arg_9_0._itemId)

		if var_9_4 ~= 0 then
			var_9_1 = math.ceil(var_9_3 / var_9_4)
		end
	end

	arg_9_0:changeCount(var_9_1)
end

function var_0_0._btnuseOnClick(arg_10_0)
	if arg_10_0:checkCount() then
		local var_10_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_10_0._buildingUid)

		if not var_10_0 then
			return
		end

		local var_10_1 = var_10_0:getSlotIdInProgress()

		if var_10_0:getSlotRemainSecTime(var_10_1) < var_10_0:getAccelerateEff(var_10_1, arg_10_0._itemId) * arg_10_0._count then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomManufactureAccelerateOver, MsgBoxEnum.BoxType.Yes_No, arg_10_0._sendUseItem, nil, nil, arg_10_0)
		else
			arg_10_0:_sendUseItem()
		end
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function var_0_0._sendUseItem(arg_11_0)
	local var_11_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_11_0._buildingUid)
	local var_11_1 = var_11_0 and var_11_0:getSlotIdInProgress()

	ManufactureController.instance:useAccelerateItem(arg_11_0._buildingUid, arg_11_0._itemId, arg_11_0._count, var_11_1)
end

function var_0_0._onItemChange(arg_12_0)
	arg_12_0:changeCount(var_0_1)
end

function var_0_0.setData(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._buildingUid = arg_13_1
	arg_13_0._itemId = arg_13_2.id

	arg_13_0:setItem()
	arg_13_0:changeCount(var_0_1)
end

function var_0_0.setItem(arg_14_0)
	if not arg_14_0._itemId then
		return
	end

	if not arg_14_0._itemIcon then
		arg_14_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_14_0._goitem)

		arg_14_0._itemIcon:isShowQuality(false)
	end

	arg_14_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, arg_14_0._itemId)

	local var_14_0 = arg_14_0._itemIcon:getRare()
	local var_14_1 = RoomManufactureEnum.RareImageMap[var_14_0]

	UISpriteSetMgr.instance:setCritterSprite(arg_14_0._imgquality, var_14_1)

	local var_14_2, var_14_3 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, arg_14_0._itemId, true)

	arg_14_0._simageicon:LoadImage(var_14_3)

	arg_14_0._txtname.text = ItemConfig.instance:getItemNameById(arg_14_0._itemId)
end

function var_0_0.changeCount(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getMaxCount()

	if var_15_0 < var_0_1 then
		var_15_0 = var_0_1
	end

	arg_15_1 = Mathf.Clamp(arg_15_1, var_0_1, var_15_0)
	arg_15_0._count = arg_15_1

	if arg_15_2 then
		arg_15_0._inputvalue:SetText(arg_15_1)
	else
		arg_15_0._inputvalue:SetTextWithoutNotify(tostring(arg_15_1))
	end

	arg_15_0:refreshCount()
end

function var_0_0.refreshCount(arg_16_0)
	local var_16_0 = arg_16_0:getMaxCount()

	arg_16_0._txthas.text = string.format("%s/%s", arg_16_0._count, var_16_0)

	local var_16_1 = arg_16_0:checkCount()

	ZProj.UGUIHelper.SetGrayscale(arg_16_0._btnuse.gameObject, not var_16_1)
end

function var_0_0.getMaxCount(arg_17_0)
	return (ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_17_0._itemId))
end

function var_0_0.checkCount(arg_18_0)
	local var_18_0 = false
	local var_18_1 = arg_18_0:getMaxCount()

	if arg_18_0._count and var_0_1 <= arg_18_0._count and var_18_1 >= arg_18_0._count then
		var_18_0 = true
	end

	return var_18_0
end

function var_0_0.onDestroy(arg_19_0)
	arg_19_0._simageicon:UnLoadImage()
end

return var_0_0
