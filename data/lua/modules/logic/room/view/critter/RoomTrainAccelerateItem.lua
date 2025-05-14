module("modules.logic.room.view.critter.RoomTrainAccelerateItem", package.seeall)

local var_0_0 = class("RoomTrainAccelerateItem", ListScrollCellExtend)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "#go_use")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_sub")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_use/valuebg/#input_value")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_max")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_use/hasCount/#simage_icon")
	arg_1_0._txthas = gohelper.findChildText(arg_1_0.viewGO, "#go_use/hasCount/#txt_has")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_use")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
end

function var_0_0._btnminOnClick(arg_4_0)
	arg_4_0:changeCount(var_0_1)
end

function var_0_0._btnsubOnClick(arg_5_0)
	arg_5_0:changeCount(arg_5_0._count - 1)
end

function var_0_0._onInputValueChange(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(arg_6_1) or var_0_1

	arg_6_0:changeCount(var_6_0)
end

function var_0_0._btnaddOnClick(arg_7_0)
	arg_7_0:changeCount(arg_7_0._count + 1)
end

function var_0_0._btnmaxOnClick(arg_8_0)
	local var_8_0 = arg_8_0:getMaxCount()

	arg_8_0:changeCount(var_8_0)
end

function var_0_0._btnuseOnClick(arg_9_0)
	if arg_9_0:checkCount() then
		if arg_9_0._critterMO.trainInfo:getCurCdTime() < arg_9_0._count * arg_9_0._accelerateTime then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainFastForwardExceed, MsgBoxEnum.BoxType.Yes_No, arg_9_0._yesToSendFasetForward, nil, nil, arg_9_0, nil, nil)

			return
		end

		RoomCritterController.instance:sendFastForwardTrain(arg_9_0._critterUid, arg_9_0._itemId, arg_9_0._count)
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function var_0_0._yesToSendFasetForward(arg_10_0)
	if arg_10_0:checkCount() then
		RoomCritterController.instance:sendFastForwardTrain(arg_10_0._critterUid, arg_10_0._itemId, arg_10_0._count)
	end
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0._editableAddEvents(arg_12_0)
	if arg_12_0._view and arg_12_0._view.viewContainer then
		arg_12_0._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, arg_12_0._opTranCdTimeUpdate, arg_12_0)
		arg_12_0._view.viewContainer:registerCallback(CritterEvent.FastForwardTrainReply, arg_12_0._opFastForwardTrainReply, arg_12_0)
	end
end

function var_0_0._editableRemoveEvents(arg_13_0)
	if arg_13_0._view and arg_13_0._view.viewContainer then
		arg_13_0._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, arg_13_0._opTranCdTimeUpdate, arg_13_0)
		arg_13_0._view.viewContainer:unregisterCallback(CritterEvent.FastForwardTrainReply, arg_13_0._opFastForwardTrainReply, arg_13_0)
	end
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	return
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0._opTranCdTimeUpdate(arg_17_0)
	if arg_17_0:getUseMaxCount() < arg_17_0._count then
		-- block empty
	end
end

function var_0_0._opFastForwardTrainReply(arg_18_0)
	arg_18_0:changeCount(var_0_1)
	arg_18_0:refreshCount()
end

function var_0_0.setData(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._critterUid = arg_19_1
	arg_19_0._itemId = arg_19_2
	arg_19_0._itemCfg = ItemConfig.instance:getItemCo(arg_19_2)
	arg_19_0._accelerateTime = 0

	if arg_19_0._itemCfg then
		arg_19_0._accelerateTime = tonumber(arg_19_0._itemCfg.effect)
	end

	arg_19_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_19_0._critterUid)

	arg_19_0:setItem()
	arg_19_0:changeCount(var_0_1)
end

function var_0_0.setItem(arg_20_0)
	if not arg_20_0._itemId then
		return
	end

	if not arg_20_0._itemIcon then
		arg_20_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_20_0._goitem)
	end

	local var_20_0, var_20_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, arg_20_0._itemId, true)

	arg_20_0._simageicon:LoadImage(var_20_1)
	arg_20_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, arg_20_0._itemId)

	arg_20_0._txtname.text = ItemConfig.instance:getItemNameById(arg_20_0._itemId)
end

function var_0_0.changeCount(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getMaxCount()
	local var_21_1 = arg_21_0:getUseMaxCount()

	if var_21_1 < arg_21_1 then
		arg_21_1 = var_21_1
	end

	if arg_21_1 < var_0_1 then
		arg_21_1 = var_0_1
	end

	if var_21_0 < arg_21_1 then
		arg_21_1 = var_21_0
	end

	arg_21_0._count = arg_21_1

	if arg_21_2 then
		arg_21_0._inputvalue:SetText(arg_21_1)
	else
		arg_21_0._inputvalue:SetTextWithoutNotify(tostring(arg_21_1))
	end

	arg_21_0:refreshCount()

	if arg_21_0._view then
		arg_21_0._view:setPreviewForwardTime(arg_21_0._count * arg_21_0._accelerateTime)
	end
end

function var_0_0.refreshCount(arg_22_0)
	local var_22_0 = arg_22_0:getMaxCount()

	arg_22_0._txthas.text = string.format("%s/%s", arg_22_0._count, var_22_0)

	local var_22_1 = arg_22_0:checkCount()

	ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnuse.gameObject, not var_22_1)
end

function var_0_0.getUseMaxCount(arg_23_0)
	if not arg_23_0._accelerateTime or arg_23_0._accelerateTime <= 0 then
		return 0
	end

	if arg_23_0._critterMO then
		local var_23_0 = arg_23_0._critterMO.trainInfo:getCurCdTime()

		return math.ceil(var_23_0 / arg_23_0._accelerateTime)
	end

	return 0
end

function var_0_0.getMaxCount(arg_24_0)
	return (ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_24_0._itemId))
end

function var_0_0.checkCount(arg_25_0)
	local var_25_0 = false
	local var_25_1 = arg_25_0:getMaxCount()

	if arg_25_0._count and var_0_1 <= arg_25_0._count and var_25_1 >= arg_25_0._count then
		var_25_0 = true
	end

	return var_25_0
end

return var_0_0
