module("modules.logic.room.view.topright.RoomViewTopRightFishingItem", package.seeall)

local var_0_0 = class("RoomViewTopRightFishingItem", RoomViewTopRightMaterialItem)

function var_0_0._onClick(arg_1_0)
	if ItemModel.instance:getItemQuantity(arg_1_0._item.type, arg_1_0._item.id) >= (FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0) then
		GameFacade.showToast(ToastEnum.FishingCurrencyFull)

		return
	end

	FishingController.instance:openFishingExchange()
end

function var_0_0._setQuantity(arg_2_0, arg_2_1)
	arg_2_1 = math.floor(arg_2_1)

	local var_2_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true)
	local var_2_1 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), arg_2_1, var_2_0 or 0)

	arg_2_0._resourceItem.txtquantity.text = var_2_1
	arg_2_0._quantity = arg_2_1
end

function var_0_0._tweenFinishCallback(arg_3_0)
	local var_3_0 = ItemModel.instance:getItemQuantity(arg_3_0._item.type, arg_3_0._item.id)
	local var_3_1 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true)
	local var_3_2 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), var_3_0, var_3_1 or 0)

	arg_3_0._resourceItem.txtquantity.text = var_3_2
	arg_3_0._quantity = var_3_0
end

return var_0_0
