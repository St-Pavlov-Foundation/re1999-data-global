module("modules.logic.versionactivity2_8.activity2nd.view.SkinCouponTipView", package.seeall)

local var_0_0 = class("SkinCouponTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "root/#go_reward")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._itemMo = arg_7_0.viewParam and arg_7_0.viewParam[1]
	arg_7_0._item = arg_7_0:getUserDataTb_()
	arg_7_0._itemcomp = IconMgr.instance:getCommonPropItemIcon(arg_7_0._goreward)

	if arg_7_0._itemMo then
		arg_7_0._itemcomp:setMOValue(arg_7_0._itemMo.materilType, arg_7_0._itemMo.materilId, arg_7_0._itemMo.quantity, nil, true)
		arg_7_0._itemcomp:isShowCount(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
