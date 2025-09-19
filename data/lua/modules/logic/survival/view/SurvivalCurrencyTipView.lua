module("modules.logic.survival.view.SurvivalCurrencyTipView", package.seeall)

local var_0_0 = class("SurvivalCurrencyTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._rootTrans = gohelper.findChild(arg_1_0.viewGO, "root").transform
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	if arg_4_0.viewParam.arrow == "BL" then
		arg_4_0._rootTrans.pivot = Vector2(1, 1)
	elseif arg_4_0.viewParam.arrow == "BR" then
		arg_4_0._rootTrans.pivot = Vector2(0, 1)
	else
		arg_4_0._rootTrans.pivot = Vector2(0, 0)
	end

	local var_4_0 = recthelper.rectToRelativeAnchorPos(arg_4_0.viewParam.pos, arg_4_0.viewGO.transform.parent)

	recthelper.setAnchor(arg_4_0._rootTrans, var_4_0.x, var_4_0.y)

	if arg_4_0.viewParam.txt then
		arg_4_0._txtdesc.text = arg_4_0.viewParam.txt
	else
		local var_4_1 = arg_4_0.viewParam.id
		local var_4_2 = lua_survival_item.configDict[var_4_1]

		arg_4_0._txtdesc.text = var_4_2 and var_4_2.desc1 or ""
	end
end

return var_0_0
