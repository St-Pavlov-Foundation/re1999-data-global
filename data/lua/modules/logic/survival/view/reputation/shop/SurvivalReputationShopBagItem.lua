module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopBagItem", package.seeall)

local var_0_0 = class("SurvivalReputationShopBagItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.go_item = gohelper.findChild(arg_2_0.viewGO, "#go_item")
	arg_2_0.btn_click = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_click")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btn_click, arg_3_0.onClick, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.onClickCallBack then
		arg_4_0.onClickCallBack(arg_4_0.onClickContext, arg_4_0)
	end
end

function var_0_0.updateMo(arg_5_0, arg_5_1)
	arg_5_0.viewContainer = arg_5_1.viewContainer
	arg_5_0.onClickCallBack = arg_5_1.onClickCallBack
	arg_5_0.onClickContext = arg_5_1.onClickContext

	arg_5_0:refreshBagItem(arg_5_1.survivalShopItemMo)
end

function var_0_0.refreshBagItem(arg_6_0, arg_6_1)
	arg_6_0.survivalShopItemMo = arg_6_1

	if not arg_6_0.survivalBagItem then
		local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes.survivalmapbagitem
		local var_6_1 = arg_6_0.viewContainer:getResInst(var_6_0, arg_6_0.go_item)

		arg_6_0.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, SurvivalBagItem)
	end

	arg_6_0.survivalBagItem:updateMo(arg_6_0.survivalShopItemMo, {
		jumpAdd = true
	})
	arg_6_0.survivalBagItem:setReputationShopStyle({
		isShowFreeReward = false,
		isCanGet = false,
		isReceive = arg_6_0.survivalShopItemMo.count <= 0,
		price = arg_6_0.survivalShopItemMo:getBuyPrice()
	})

	arg_6_0.survivalShopItemMo = arg_6_1
end

return var_0_0
