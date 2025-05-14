module("modules.logic.act189.view.ShortenAct_PanelView", package.seeall)

local var_0_0 = class("ShortenAct_PanelView", ShortenActView_impl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/right/limittimebg/#txt_time")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#simage_title")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_tasklist")
	arg_1_0._go28days = gohelper.findChild(arg_1_0.viewGO, "root/#go_28days")
	arg_1_0._go35days = gohelper.findChild(arg_1_0.viewGO, "root/#go_35days")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
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
	var_0_0.super._editableInitView(arg_9_0)
end

return var_0_0
