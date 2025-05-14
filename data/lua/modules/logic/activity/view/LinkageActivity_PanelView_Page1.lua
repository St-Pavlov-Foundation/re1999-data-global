module("modules.logic.activity.view.LinkageActivity_PanelView_Page1", package.seeall)

local var_0_0 = class("LinkageActivity_PanelView_Page1", LinkageActivity_Page1)

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

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
	arg_5_0:setActive(false)
end

function var_0_0._btnbuyOnClick(arg_6_0)
	arg_6_0:jump()
end

function var_0_0._btnChangeOnClick(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	var_0_0.super.onUpdateMO(arg_8_0, arg_8_1)

	arg_8_0._txtdurationTime.text = arg_8_0:getDurationTimeStr()
end

return var_0_0
