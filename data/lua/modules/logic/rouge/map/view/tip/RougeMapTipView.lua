module("modules.logic.rouge.map.view.tip.RougeMapTipView", package.seeall)

local var_0_0 = class("RougeMapTipView", BaseView)

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
	arg_4_0.goTip = gohelper.findChild(arg_4_0.viewGO, "#go_tip")
	arg_4_0.txtTip = gohelper.findChildText(arg_4_0.viewGO, "#go_tip/#txt_Tips")

	gohelper.setActive(arg_4_0.goTip, false)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onShowTip, arg_4_0.onShowTip, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onHideTip, arg_4_0.onHideTip, arg_4_0)

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)

	arg_4_0.animator:Play("close", 0, 1)
end

function var_0_0.onShowTip(arg_5_0, arg_5_1)
	arg_5_0.txtTip.text = arg_5_1

	arg_5_0.animator:Play("open", 0, 0)
end

function var_0_0.onHideTip(arg_6_0)
	arg_6_0.animator:Play("close", 0, 0)
end

return var_0_0
