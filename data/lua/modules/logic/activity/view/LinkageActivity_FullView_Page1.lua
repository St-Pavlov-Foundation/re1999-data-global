module("modules.logic.activity.view.LinkageActivity_FullView_Page1", package.seeall)

local var_0_0 = class("LinkageActivity_FullView_Page1", LinkageActivity_Page1)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._simagesignature1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role1/#simage_signature1")
	arg_1_0._simagesignature2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role2/#simage_signature2")
	arg_1_0._txtdurationTime = gohelper.findChildText(arg_1_0.viewGO, "view/right/time/#txt_durationTime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy")
	arg_1_0._btnChange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Change")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnChange:AddClickListener(arg_2_0._btnChangeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnChange:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._txtdurationTime.text = ""

	arg_5_0:setActive(false)
end

function var_0_0._btnbuyOnClick(arg_6_0)
	arg_6_0:jump()
end

function var_0_0._btnChangeOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	arg_7_0:selectedPage(2)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	var_0_0.super.onUpdateMO(arg_8_0, arg_8_1)

	arg_8_0._txtdurationTime.text = arg_8_0:getDurationTimeStr()
end

return var_0_0
