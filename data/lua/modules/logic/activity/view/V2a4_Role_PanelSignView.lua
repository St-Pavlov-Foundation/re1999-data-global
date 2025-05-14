module("modules.logic.activity.view.V2a4_Role_PanelSignView", package.seeall)

local var_0_0 = class("V2a4_Role_PanelSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._simageTitle_glow = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/vx_effect/#simage_Title_glow")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
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

function var_0_0.onOpen(arg_9_0)
	arg_9_0._txtLimitTime.text = ""

	arg_9_0:internal_set_actId(arg_9_0.viewParam.actId)
	arg_9_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_9_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_9_0._refreshTimeTick, arg_9_0, 1)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	Activity101SignViewBase._internal_onDestroy(arg_11_0)
	arg_11_0._simagePanelBG:UnLoadImage()
	arg_11_0._simageTitle:UnLoadImage()
	arg_11_0._simageTitle_glow:UnLoadImage()
	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

function var_0_0.onRefresh(arg_12_0)
	arg_12_0:_refreshList()
	arg_12_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_13_0)
	arg_13_0._txtLimitTime.text = arg_13_0:getRemainTimeStr()
end

return var_0_0
