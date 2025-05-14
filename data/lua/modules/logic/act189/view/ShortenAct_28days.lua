module("modules.logic.act189.view.ShortenAct_28days", package.seeall)

local var_0_0 = class("ShortenAct_28days", ShortenActStyleItem_impl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "2/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	var_0_0.super.onDestroyView(arg_6_0)
end

function var_0_0._btnclickOnClick(arg_7_0)
	BpController.instance:openBattlePassView()
end

return var_0_0
