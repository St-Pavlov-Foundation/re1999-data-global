module("modules.logic.sp01.sign.view.V2a9_LoginSign_FullView", package.seeall)

local var_0_0 = class("V2a9_LoginSign_FullView", Activity101SignViewBase)

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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtLimitTime.text = ""
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:internal_set_actId(arg_6_0.viewParam and arg_6_0.viewParam.actId)
	arg_6_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_6_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, 1)
end

function var_0_0._updateScrollViewPos(arg_7_0)
	if arg_7_0._isFirst then
		return
	end

	arg_7_0._isFirst = true
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._isFirst = nil

	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshTimeTick, arg_9_0)
end

function var_0_0.onRefresh(arg_10_0)
	arg_10_0:_refreshList()
	arg_10_0:_updateScrollViewPos()
	arg_10_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_11_0)
	arg_11_0._txtLimitTime.text = arg_11_0:getRemainTimeStr()
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0:getRewardCouldGetIndex()
	local var_12_2 = arg_12_0.viewContainer:getCsListScroll()
	local var_12_3 = arg_12_0.viewContainer:getListScrollParam()
	local var_12_4 = var_12_3.cellWidth
	local var_12_5 = var_12_3.cellSpaceH

	if var_12_1 <= 4 then
		var_12_1 = var_12_1 - 4
	else
		var_12_1 = 10
	end

	local var_12_6 = (var_12_4 + var_12_5) * math.max(0, var_12_1)

	var_12_2.HorizontalScrollPixel = math.max(0, var_12_6)

	var_12_2:UpdateCells(false)
end

return var_0_0
