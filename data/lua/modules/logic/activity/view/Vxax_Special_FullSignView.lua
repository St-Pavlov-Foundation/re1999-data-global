module("modules.logic.activity.view.Vxax_Special_FullSignView", package.seeall)

local var_0_0 = class("Vxax_Special_FullSignView", Vxax_Special_BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)

	arg_4_0._inited = false

	arg_4_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtLimitTime.text = ""
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, 1)

	if not arg_6_0._inited then
		arg_6_0:internal_onOpen()

		arg_6_0._inited = true
	else
		arg_6_0:_refresh()
	end
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0:_clearTimeTick()
	var_0_0.super.onDestroyView(arg_8_0)
end

function var_0_0._clearTimeTick(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshTimeTick, arg_9_0)
end

function var_0_0.onRefresh(arg_10_0)
	arg_10_0:_refreshList()
	arg_10_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_11_0)
	arg_11_0._txtLimitTime.text = arg_11_0:getRemainTimeStr()
end

function var_0_0.onFindChind_RewardGo(arg_12_0, arg_12_1)
	return gohelper.findChild(arg_12_0.viewGO, "Root/reward/node" .. arg_12_1)
end

return var_0_0
