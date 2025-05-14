module("modules.logic.activity.view.ActivityTipView", package.seeall)

local var_0_0 = class("ActivityTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnbgclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bgclick")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._btnmask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tip/#btn_mask")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#txt_desc")
	arg_1_0._scrollruledesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tip/#scroll_ruledesc")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#scroll_ruledesc/Viewport/Content/#txt_tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbgclick:AddClickListener(arg_2_0._btnbgclickOnClick, arg_2_0)
	arg_2_0._btnmask:AddClickListener(arg_2_0._btnmaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbgclick:RemoveClickListener()
	arg_3_0._btnmask:RemoveClickListener()
end

function var_0_0._btnbgclickOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._viewName = nil
end

function var_0_0._btnmaskOnClick(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._refresh(arg_10_0)
	gohelper.addChild(arg_10_0.viewParam.rootGo, arg_10_0.viewGO)

	local var_10_0 = recthelper.getWidth(arg_10_0.viewParam.rootGo.transform)

	transformhelper.setLocalPosXY(arg_10_0._gotip.transform, var_10_0, 0)

	arg_10_0._txtdesc.text = arg_10_0.viewParam.title
	arg_10_0._txttip.text = arg_10_0.viewParam.desc
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
