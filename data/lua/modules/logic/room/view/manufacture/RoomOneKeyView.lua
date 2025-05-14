module("modules.logic.room.view.manufacture.RoomOneKeyView", package.seeall)

local var_0_0 = class("RoomOneKeyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_fill")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._goAddPop = gohelper.findChild(arg_1_0.viewGO, "right/#go_addPop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfill:AddClickListener(arg_2_0._btnfillOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_2_0.refreshCustomizeItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfill:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_3_0.refreshCustomizeItem, arg_3_0)
end

function var_0_0._btnfillOnClick(arg_4_0)
	ManufactureController.instance:oneKeyManufactureItem(arg_4_0.curOneKeyType)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnclickOnClick(arg_6_0, arg_6_1)
	if arg_6_0.curOneKeyType and arg_6_0.curOneKeyType == arg_6_1 then
		return
	end

	local var_6_0
	local var_6_1 = arg_6_1 == RoomManufactureEnum.OneKeyType.Customize

	if arg_6_0.curOneKeyType and var_6_1 then
		var_6_0 = "left"
	elseif arg_6_0.curOneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		var_6_0 = "back"
	end

	if arg_6_0._viewAnimator and not string.nilorempty(var_6_0) then
		arg_6_0._viewAnimator.enabled = true

		arg_6_0._viewAnimator:Play(var_6_0, 0, 0)
	end

	arg_6_0:setAddPopActive(var_6_1)

	arg_6_0.curOneKeyType = arg_6_1

	if arg_6_0.optionItemDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.optionItemDict) do
			gohelper.setActive(iter_6_1.goselected, iter_6_0 == arg_6_1)
		end
	end
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._viewAnimator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_8_0:clearOptionItem()

	for iter_8_0, iter_8_1 in pairs(RoomManufactureEnum.OneKeyType) do
		local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "root/#scroll_option/Viewport/Content/#go_type" .. iter_8_1)

		arg_8_0.optionItemDict[iter_8_1] = arg_8_0:createOptionItem(var_8_0, iter_8_1)
	end

	local var_8_1 = ManufactureModel.instance:getRecordOneKeyType()

	arg_8_0:_btnclickOnClick(var_8_1)
end

function var_0_0.createOptionItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.oneKeyType = arg_9_2
	var_9_0.txtdesc = gohelper.findChildText(arg_9_1, "#txt_desc")
	var_9_0.godesc = var_9_0.txtdesc.gameObject
	var_9_0.goselected = gohelper.findChild(arg_9_1, "selectdBg/#go_selected")
	var_9_0.btnclick = gohelper.findChildClickWithAudio(arg_9_1, "#btn_click")

	var_9_0.btnclick:AddClickListener(arg_9_0._btnclickOnClick, arg_9_0, arg_9_2)

	var_9_0.gohasItem = gohelper.findChild(arg_9_1, "#go_hasItem")

	if not gohelper.isNil(var_9_0.gohasItem) then
		var_9_0.rarebg = gohelper.findChildImage(arg_9_1, "#go_hasItem/#image_quality")
		var_9_0.itemicon = gohelper.findChildSingleImage(arg_9_1, "#go_hasItem/#image_quality/#simage_productionIcon")
		var_9_0.txtitemname = gohelper.findChildText(arg_9_1, "#go_hasItem/#image_quality/#txt_name")
		var_9_0.txtitemnum = gohelper.findChildText(arg_9_1, "#go_hasItem/#txt_num")
	end

	return var_9_0
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	if not RoomTradeModel.instance:isGetOrderInfo() then
		RoomRpc.instance:sendGetOrderInfoRequest()
	end

	arg_11_0:refreshCustomizeItem()
end

function var_0_0.refreshCustomizeItem(arg_12_0)
	local var_12_0 = arg_12_0.optionItemDict[RoomManufactureEnum.OneKeyType.Customize]

	if not var_12_0 or gohelper.isNil(var_12_0.gohasItem) then
		return
	end

	local var_12_1, var_12_2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if var_12_1 then
		local var_12_3 = ManufactureConfig.instance:getItemId(var_12_1)
		local var_12_4, var_12_5 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_12_3)
		local var_12_6 = RoomManufactureEnum.RareImageMap[var_12_4.rare]

		UISpriteSetMgr.instance:setCritterSprite(var_12_0.rarebg, var_12_6)

		var_12_5 = ManufactureConfig.instance:getBatchIconPath(var_12_1) or var_12_5

		var_12_0.itemicon:LoadImage(var_12_5)

		local var_12_7 = ManufactureConfig.instance:getManufactureItemName(var_12_1)
		local var_12_8 = string.split(var_12_7, "*")

		var_12_0.txtitemname.text = var_12_8[1]
		var_12_0.txtitemnum.text = luaLang("multiple") .. var_12_2
	end

	gohelper.setActive(var_12_0.gohasItem, var_12_1)
	gohelper.setActive(var_12_0.godesc, not var_12_1)
end

function var_0_0.setAddPopActive(arg_13_0, arg_13_1)
	if arg_13_0.isShowAddPop == arg_13_1 then
		return
	end

	local var_13_0 = arg_13_0.isShowAddPop

	arg_13_0.isShowAddPop = arg_13_1

	local var_13_1 = arg_13_0.isShowAddPop and "#B97B45" or "#ACACAC"
	local var_13_2 = arg_13_0.optionItemDict[RoomManufactureEnum.OneKeyType.Customize]

	if var_13_2 then
		UIColorHelper.set(var_13_2.txtdesc, var_13_1)
		UIColorHelper.set(var_13_2.txtitemname, var_13_1)
	end

	gohelper.setActive(arg_13_0._goAddPop, arg_13_0.isShowAddPop)

	if var_13_0 and not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		arg_13_0:_btnclickOnClick(RoomManufactureEnum.OneKeyType.ShortTime)
	end
end

function var_0_0.clearOptionItem(arg_14_0)
	if arg_14_0.optionItemDict then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.optionItemDict) do
			if iter_14_1.itemicon then
				iter_14_1.itemicon:UnLoadImage()

				iter_14_1.itemicon = nil
			end

			if iter_14_1.btnclick then
				iter_14_1.btnclick:RemoveClickListener()
			end
		end
	end

	arg_14_0.optionItemDict = {}
end

function var_0_0.onClose(arg_15_0)
	OneKeyAddPopListModel.instance:resetSelectManufactureItemFromCache()
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0:clearOptionItem()
end

return var_0_0
