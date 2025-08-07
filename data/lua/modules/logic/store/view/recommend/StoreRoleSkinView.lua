module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

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

	local var_5_0 = {}

	if arg_5_0.config.relations and not string.nilorempty(arg_5_0.config.relations) then
		local var_5_1 = string.split(arg_5_0.config.relations, "|")

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			local var_5_2 = string.splitToNumber(iter_5_1, "#")

			if var_5_2[1] == 5 then
				table.insert(var_5_0, var_5_2[2])
			end
		end
	end

	local var_5_3 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		local var_5_4 = StoreModel.instance:getGoodsMO(iter_5_3)

		if not var_5_4:isSoldOut() then
			table.insert(var_5_3, var_5_4)
		end
	end

	table.sort(var_5_3, function(arg_6_0, arg_6_1)
		return arg_6_0.goodsId < arg_6_1.goodsId
	end)

	if #var_5_3 < 1 then
		return
	end

	if #var_5_0 == 1 then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = var_5_3[1]
		})
	elseif #var_5_3 > 0 then
		GameFacade.jumpByAdditionParam(arg_5_0.config.systemJumpCode .. "#" .. tostring(var_5_3[1].goodsId) .. "#1")
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtprice = gohelper.findChildText(arg_7_0.viewGO, "view/left/#txt_price")
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)
	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0.config = arg_10_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	arg_10_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_10_0.config)

	if arg_10_0._txtprice then
		local var_10_0, var_10_1 = arg_10_0:_getCostSymbolAndPrice(arg_10_0.config.systemJumpCode)

		if var_10_0 then
			arg_10_0._txtprice.text = string.format("%s%s", var_10_0, var_10_1)
		end
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
