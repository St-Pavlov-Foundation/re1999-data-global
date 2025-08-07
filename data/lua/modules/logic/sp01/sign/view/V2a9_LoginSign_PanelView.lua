module("modules.logic.sp01.sign.view.V2a9_LoginSign_PanelView", package.seeall)

local var_0_0 = class("V2a9_LoginSign_PanelView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._btnClose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnClose2:AddClickListener(arg_2_0._btnClose2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnClose2:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnClose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txtLimitTime.text = ""
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:internal_set_actId(arg_7_0.viewParam and arg_7_0.viewParam.actId)
	arg_7_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_7_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_7_0._refreshTimeTick, arg_7_0, 1)
end

function var_0_0._updateScrollViewPos(arg_8_0)
	if arg_8_0._isFirst then
		return
	end

	arg_8_0._isFirst = true
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._isFirst = nil

	TaskDispatcher.cancelTask(arg_9_0._refreshTimeTick, arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
end

function var_0_0.onRefresh(arg_11_0)
	arg_11_0:_refreshList()
	arg_11_0:_updateScrollViewPos()
	arg_11_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_12_0)
	arg_12_0._txtLimitTime.text = arg_12_0:getRemainTimeStr()
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0:getRewardCouldGetIndex()
	local var_13_2 = arg_13_0.viewContainer:getCsListScroll()
	local var_13_3 = arg_13_0.viewContainer:getListScrollParam()
	local var_13_4 = var_13_3.cellWidth
	local var_13_5 = var_13_3.cellSpaceH

	if var_13_1 <= 4 then
		var_13_1 = var_13_1 - 4
	else
		var_13_1 = 10
	end

	local var_13_6 = (var_13_4 + var_13_5) * math.max(0, var_13_1)

	var_13_2.HorizontalScrollPixel = math.max(0, var_13_6)

	var_13_2:UpdateCells(false)
end

return var_0_0
