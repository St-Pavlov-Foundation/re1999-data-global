module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyTipView", package.seeall)

local var_0_0 = class("PinballCurrencyTipView", BaseView)

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
	else
		arg_4_0._rootTrans.pivot = Vector2(0, 0)
	end

	local var_4_0 = recthelper.rectToRelativeAnchorPos(arg_4_0.viewParam.pos, arg_4_0.viewGO.transform.parent)

	recthelper.setAnchor(arg_4_0._rootTrans, var_4_0.x, var_4_0.y)

	if arg_4_0.viewParam.isMarbals then
		local var_4_1 = arg_4_0.viewParam.type
		local var_4_2 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_4_1]

		if not var_4_2 then
			return
		end

		arg_4_0._txtdesc.text = var_4_2.desc
	else
		local var_4_3 = arg_4_0.viewParam.type
		local var_4_4 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_4_3]

		if not var_4_4 then
			return
		end

		arg_4_0._txtdesc.text = var_4_4.tips
	end
end

return var_0_0
