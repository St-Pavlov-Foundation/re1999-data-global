module("modules.logic.room.view.common.RoomStoreGoodsTipItem", package.seeall)

local var_0_0 = class("RoomStoreGoodsTipItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goeprice = gohelper.findChild(arg_4_0.viewGO, "go_price")
	arg_4_0._gofinish = gohelper.findChild(arg_4_0.viewGO, "go_finish")
	arg_4_0._txtgold = gohelper.findChildText(arg_4_0.viewGO, "go_price/txt_gold")
	arg_4_0._imagegold = gohelper.findChildImage(arg_4_0.viewGO, "go_price/node/image_gold")
	arg_4_0._txtname = gohelper.findChildText(arg_4_0.viewGO, "txt_name")
	arg_4_0._txtnum = gohelper.findChildText(arg_4_0.viewGO, "txt_num")
	arg_4_0._imgbg = arg_4_0.viewGO:GetComponent(gohelper.Type_Image)
	arg_4_0._txtowner = gohelper.findChildText(arg_4_0.viewGO, "go_finish/txt_owner")
	arg_4_0._parenttrs = arg_4_0.viewGO.transform.parent
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = arg_5_0._roomStoreItemMO:getItemQuantity()
	local var_5_1 = arg_5_0._roomStoreItemMO:getNeedNum()
	local var_5_2 = var_5_1 <= var_5_0

	gohelper.setActive(arg_5_0._goeprice, not var_5_2)
	gohelper.setActive(arg_5_0._gofinish, var_5_2)

	if var_5_2 then
		arg_5_0._txtowner.text = string.format(luaLang("roommaterialtipview_owner"), tostring(var_5_0))
	end

	local var_5_3 = arg_5_0._roomStoreItemMO:getItemConfig()

	arg_5_0._txtname.text = var_5_3 and var_5_3.name or ""
	arg_5_0._txtnum.text = arg_5_0:_getStateStr(var_5_1, var_5_0)

	if not var_5_2 then
		local var_5_4 = arg_5_0._roomStoreItemMO:checkShowTicket()
		local var_5_5 = not RoomStoreItemListModel.instance:getIsSelectCurrency() and var_5_4
		local var_5_6
		local var_5_7 = RoomStoreItemListModel.instance:getCostId()

		if not var_5_5 then
			local var_5_8 = arg_5_0._roomStoreItemMO:getCostById(var_5_7 or 1)
			local var_5_9 = var_5_8.itemType
			local var_5_10 = var_5_8.itemId
			local var_5_11, var_5_12 = ItemModel.instance:getItemConfigAndIcon(var_5_9, var_5_10)

			var_5_6 = var_5_11.icon
		else
			var_5_6 = arg_5_0._roomStoreItemMO:getTicketId()
		end

		local var_5_13 = string.format("%s_1", var_5_6)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_5_0._imagegold, var_5_13)

		if not var_5_5 then
			arg_5_0._txtgold.text = arg_5_0._roomStoreItemMO:getTotalPriceByCostId(var_5_7)
		else
			arg_5_0._txtgold.text = 1
		end
	end
end

function var_0_0._getStateStr(arg_6_0, arg_6_1, arg_6_2)
	return string.format("%s/%s", arg_6_2, arg_6_1)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._roomStoreItemMO = arg_7_1

	arg_7_0:_refreshUI()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
