module("modules.logic.activity.view.LinkageActivity_PanelViewBase", package.seeall)

local var_0_0 = class("LinkageActivity_PanelViewBase", LinkageActivity_BaseView)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0._inited = false

	arg_1_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function var_0_0.onDestroyView(arg_2_0)
	var_0_0.super.onDestroyView(arg_2_0)

	arg_2_0._inited = false
end

function var_0_0.onUpdateParam(arg_3_0)
	arg_3_0:_refresh()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:internal_set_actId(arg_4_0.viewParam.actId)

	if not arg_4_0._inited then
		arg_4_0:internal_onOpen()

		arg_4_0._inited = true
	else
		arg_4_0:_refresh()
	end
end

function var_0_0.addEvents(arg_5_0)
	var_0_0.super.addEvents(arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	var_0_0.super.removeEvents(arg_6_0)
end

return var_0_0
