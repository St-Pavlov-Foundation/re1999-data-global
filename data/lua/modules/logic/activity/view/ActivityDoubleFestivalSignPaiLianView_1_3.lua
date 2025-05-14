module("modules.logic.activity.view.ActivityDoubleFestivalSignPaiLianView_1_3", package.seeall)

local var_0_0 = class("ActivityDoubleFestivalSignPaiLianView_1_3", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

local var_0_1 = ActivityEnum.Activity.DoubleFestivalSign_1_3

function var_0_0._btnemptyTopOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtLimitTime.text = ""

	arg_9_0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_halftitle"))
	arg_9_0._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_halfbg"))
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:internal_set_actId(var_0_1)
	arg_10_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_10_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._isFirst = nil

	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageTitle:UnLoadImage()
	arg_12_0._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_12_0._refreshTimeTick, arg_12_0)
end

function var_0_0.onRefresh(arg_13_0)
	arg_13_0:_refreshList()
	arg_13_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_14_0)
	arg_14_0._txtLimitTime.text = arg_14_0:getRemainTimeStr()
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:getRewardCouldGetIndex()
	local var_15_2 = arg_15_0.viewContainer:getCsListScroll()
	local var_15_3 = arg_15_0.viewContainer:getListScrollParam()
	local var_15_4 = var_15_3.cellWidth
	local var_15_5 = var_15_3.cellSpaceH

	if var_15_1 <= 4 then
		var_15_1 = var_15_1 - 4
	else
		var_15_1 = 10
	end

	local var_15_6 = (var_15_4 + var_15_5) * math.max(0, var_15_1)

	var_15_2.HorizontalScrollPixel = math.max(0, var_15_6)

	var_15_2:UpdateCells(false)
end

return var_0_0
