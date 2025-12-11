module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

local var_0_0 = class("StoreRoleSkinView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._simagesignature1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role1/#simage_signature1")
	arg_1_0._simagesignature2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role2/#simage_signature2")
	arg_1_0._txtdurationTime = gohelper.findChildText(arg_1_0.viewGO, "view/right/time/#txt_durationTime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_4_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_4_0.config and arg_4_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_4_0.config and arg_4_0.config.name or "StoreRoleSkinView",
		[StatEnum.EventProperties.RecommendPageRank] = arg_4_0:getTabIndex()
	})

	local var_4_0 = {}

	if arg_4_0.config.relations and not string.nilorempty(arg_4_0.config.relations) then
		local var_4_1 = string.split(arg_4_0.config.relations, "|")

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			local var_4_2 = string.splitToNumber(iter_4_1, "#")

			if var_4_2[1] == 5 then
				table.insert(var_4_0, var_4_2[2])
			end
		end
	end

	local var_4_3 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		local var_4_4 = StoreModel.instance:getGoodsMO(iter_4_3)

		if not var_4_4:alreadyHas() then
			table.insert(var_4_3, var_4_4)
		end
	end

	if #var_4_3 < 1 then
		return
	end

	if #var_4_0 == 1 then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = var_4_3[1]
		})
	elseif #var_4_3 > 0 then
		GameFacade.jumpByAdditionParam(arg_4_0.config.systemJumpCode .. "#" .. tostring(var_4_3[1].goodsId) .. "#1")
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtprice = gohelper.findChildText(arg_5_0.viewGO, "view/left/#txt_price")
	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
	arg_5_0._txtprice = gohelper.findChildText(arg_5_0.viewGO, "view/left/#txt_price")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.config = arg_8_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	arg_8_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_8_0.config)

	if arg_8_0._txtprice then
		local var_8_0, var_8_1 = arg_8_0:_getCostSymbolAndPrice(arg_8_0.config.systemJumpCode)

		if var_8_0 then
			arg_8_0._txtprice.text = string.format("%s%s", var_8_0, var_8_1)
		end
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0._getCostSymbolAndPrice(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == "" then
		return
	end

	local var_11_0 = string.splitToNumber(arg_11_1, "#")

	if type(var_11_0) ~= "table" and #var_11_0 < 2 then
		return
	end

	local var_11_1 = var_11_0[2]

	return PayModel.instance:getProductPrice(var_11_1), ""
end

return var_0_0
