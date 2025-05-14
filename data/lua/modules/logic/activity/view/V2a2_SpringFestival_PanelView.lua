﻿module("modules.logic.activity.view.V2a2_SpringFestival_PanelView", package.seeall)

local var_0_0 = class("V2a2_SpringFestival_PanelView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDec = gohelper.findChildText(arg_1_0.viewGO, "Root/image_DecBG/#txt_Dec")
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_NormalBG")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_canget")
	arg_1_0._goFinishedBG = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_FinishedBG")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtLimitTime.text = ""

	arg_9_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:internal_set_actId(arg_10_0.viewParam.actId)
	arg_10_0:internal_onOpen()
	arg_10_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_12_0)
	Activity101SignViewBase._internal_onDestroy(arg_12_0)
	arg_12_0:_clearTimeTick()
end

function var_0_0._clearTimeTick(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshTimeTick, arg_13_0)
end

function var_0_0.onRefresh(arg_14_0)
	arg_14_0:_refreshList()
	arg_14_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_15_0)
	arg_15_0._txtLimitTime.text = arg_15_0:getRemainTimeStr()
end

return var_0_0
