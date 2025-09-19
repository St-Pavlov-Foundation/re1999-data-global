module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftItem", package.seeall)

local var_0_0 = class("V2a9_LinkGiftItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.go = arg_1_1
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "#txt_price")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_0.viewGO, "#go_soldout")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "#go_canget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnclick then
		arg_3_0._btnclick:RemoveClickListener()
	end
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._charageGoodsCfg and arg_4_0._packageGoodsMO then
		if ViewMgr.instance:isOpen(ViewName.SummonADView) then
			StoreController.instance:openPackageStoreGoodsView(arg_4_0._packageGoodsMO)
		else
			StoreController.instance:openStoreView(arg_4_0._charageGoodsCfg.belongStoreId, arg_4_0._charageGoodsCfg.id)
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._charageGoodsCfg = arg_6_1
	arg_6_0._packageGoodsMO = arg_6_1 and StoreModel.instance:getGoodsMO(arg_6_1.id)

	gohelper.setActive(arg_6_0.go, arg_6_1 ~= nil)

	local var_6_0 = arg_6_0._packageGoodsMO and arg_6_0._packageGoodsMO.buyCount > 0
	local var_6_1 = arg_6_0._packageGoodsMO and arg_6_0._packageGoodsMO.id
	local var_6_2 = var_6_0 and StoreCharageConditionalHelper.isCharageTaskFinish(var_6_1)
	local var_6_3 = var_6_0 and StoreCharageConditionalHelper.isCharageTaskNotFinish(var_6_1)

	gohelper.setActive(arg_6_0._gosoldout, var_6_2)
	gohelper.setActive(arg_6_0._gocanget, var_6_3)

	if var_6_1 and arg_6_0._txtprice then
		arg_6_0._txtprice.text = StoreModel.instance:getCostPriceFull(var_6_1)
	end

	if var_6_0 and var_6_1 then
		local var_6_4 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.V2a9_LinkGiftItemGoodsAnim .. var_6_1)

		if var_6_3 then
			arg_6_0:_playGoAnimByKey(arg_6_0._gocanget, var_6_4 .. "_gocanget")
		end

		if var_6_2 then
			arg_6_0:_playGoAnimByKey(arg_6_0._gosoldout, var_6_4 .. "_gosoldout")
		end
	end
end

function var_0_0._playGoAnimByKey(arg_7_0, arg_7_1, arg_7_2)
	if PlayerPrefsHelper.getNumber(arg_7_2, 0) ~= 1 then
		PlayerPrefsHelper.setNumber(arg_7_2, 1)

		if arg_7_1 then
			local var_7_0 = arg_7_1:GetComponent(gohelper.Type_Animator)

			if var_7_0 then
				var_7_0:Play("open", 0, 0)
			end
		end
	end
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:removeEvents()
	arg_8_0:__onDispose()
end

return var_0_0
