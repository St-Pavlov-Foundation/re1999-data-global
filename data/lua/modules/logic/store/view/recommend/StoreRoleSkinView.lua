﻿module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

local var_0_0 = class("StoreRoleSkinView", StoreRecommendBaseSubView)

function var_0_0._getCostSymbolAndPrice(arg_1_0, arg_1_1)
	if not arg_1_1 or arg_1_1 == "" then
		return
	end

	local var_1_0 = string.splitToNumber(arg_1_1, "#")

	if type(var_1_0) ~= "table" and #var_1_0 < 2 then
		return
	end

	local var_1_1 = var_1_0[2]

	return PayModel.instance:getProductPrice(var_1_1), ""
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "view/#simage_bg")
	arg_2_0._simagesignature1 = gohelper.findChildSingleImage(arg_2_0.viewGO, "view/left/role1/#simage_signature1")
	arg_2_0._simagesignature2 = gohelper.findChildSingleImage(arg_2_0.viewGO, "view/left/role2/#simage_signature2")
	arg_2_0._txtdurationTime = gohelper.findChildText(arg_2_0.viewGO, "view/right/time/#txt_durationTime")
	arg_2_0._btnbuy = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "view/right/#btn_buy")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnbuy:AddClickListener(arg_3_0._btnbuyOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_5_0.config and arg_5_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_5_0.config and arg_5_0.config.name or "StoreRoleSkinView"
	})
	GameFacade.jumpByAdditionParam(arg_5_0.config.systemJumpCode)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txtprice = gohelper.findChildText(arg_6_0.viewGO, "view/left/#txt_price")
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	var_0_0.super.onOpen(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.config = arg_9_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	arg_9_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_9_0.config)

	if arg_9_0._txtprice then
		local var_9_0, var_9_1 = arg_9_0:_getCostSymbolAndPrice(arg_9_0.config.systemJumpCode)

		if var_9_0 then
			arg_9_0._txtprice.text = string.format("%s%s", var_9_0, var_9_1)
		end
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
