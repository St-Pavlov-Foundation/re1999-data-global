module("modules.logic.activity.view.Vxax_Special_PanelSignView", package.seeall)

local var_0_0 = class("Vxax_Special_PanelSignView", Vxax_Special_BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#simage_FullBG/#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
	arg_4_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._txtLimitTime.text = ""
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:internal_set_actId(arg_11_0.viewParam.actId)
	arg_11_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_11_0._refreshTimeTick, arg_11_0, 1)

	if not arg_11_0._inited then
		arg_11_0:internal_onOpen()

		arg_11_0._inited = true
	else
		arg_11_0:_refresh()
	end
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:_clearTimeTick()
	var_0_0.super.onDestroyView(arg_13_0)
end

function var_0_0._clearTimeTick(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeTick, arg_14_0)
end

function var_0_0.onRefresh(arg_15_0)
	arg_15_0:_refreshList()
	arg_15_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_16_0)
	arg_16_0._txtLimitTime.text = arg_16_0:getRemainTimeStr()
end

function var_0_0.onFindChind_RewardGo(arg_17_0, arg_17_1)
	return gohelper.findChild(arg_17_0.viewGO, "Root/reward/node" .. arg_17_1)
end

return var_0_0
