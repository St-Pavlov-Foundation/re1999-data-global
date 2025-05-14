module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleView", package.seeall)

local var_0_0 = class("V2a1_BossRush_OfferRoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollChar = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Left/#scroll_Char")
	arg_1_0._scrollEffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Right/#scroll_Effect")
	arg_1_0._txtCharEffect = gohelper.findChildText(arg_1_0.viewGO, "root/Right/#scroll_Effect/Viewport/Content/Title/#txt_CharEffect")
	arg_1_0._txtEffect = gohelper.findChildText(arg_1_0.viewGO, "root/Right/#scroll_Effect/Viewport/Content/#txt_Effect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, arg_2_0._OnSelectEnhanceRole, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, arg_3_0._OnSelectEnhanceRole, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0._txtEffect.gameObject, false)
	BossRushEnhanceRoleViewListModel.instance:setListData()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0._OnSelectEnhanceRole(arg_9_0, arg_9_1)
	arg_9_0:refreshEnhanceEffect(arg_9_1)
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.refreshEnhanceEffect(arg_11_0, arg_11_1)
	local var_11_0 = HeroConfig.instance:getHeroCO(arg_11_1)
	local var_11_1 = luaLang("bossrush_enhance_role_title")

	arg_11_0._txtCharEffect.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_1, var_11_0.name)

	local var_11_2 = BossRushConfig.instance:getActRoleEnhanceCoById(arg_11_1).desc

	if not string.nilorempty(var_11_2) then
		local var_11_3 = string.split(var_11_2, "|")

		for iter_11_0 = 1, #var_11_3 do
			local var_11_4 = arg_11_0:_getEffectItem(iter_11_0)

			var_11_4:updateInfo(arg_11_0, var_11_3[iter_11_0], arg_11_1)
			gohelper.setActive(arg_11_0._effectList[iter_11_0].viewGO, true)

			local var_11_5 = iter_11_0 < #var_11_3

			var_11_4:activeLine(var_11_5)
		end

		for iter_11_1 = #var_11_3 + 1, #arg_11_0._effectList do
			gohelper.setActive(arg_11_0._effectList[iter_11_1].viewGO, false)
		end
	end
end

function var_0_0._getEffectItem(arg_12_0, arg_12_1)
	arg_12_0._effectList = arg_12_0._effectList or arg_12_0:getUserDataTb_()

	local var_12_0 = arg_12_0._effectList[arg_12_1]

	if not var_12_0 then
		var_12_0 = V2a1_BossRush_OfferRoleEffectItem.New()

		local var_12_1 = gohelper.cloneInPlace(arg_12_0._txtEffect.gameObject)

		var_12_0:initView(var_12_1)

		arg_12_0._effectList[arg_12_1] = var_12_0
	end

	return var_12_0
end

return var_0_0
