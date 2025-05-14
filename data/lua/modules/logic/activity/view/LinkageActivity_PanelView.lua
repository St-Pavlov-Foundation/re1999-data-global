module("modules.logic.activity.view.LinkageActivity_PanelView", package.seeall)

local var_0_0 = class("LinkageActivity_PanelView", LinkageActivity_PanelViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageLogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Logo")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._refreshTimeTick, arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtLimitTime.text = ""
	arg_8_0._pageGo1 = gohelper.findChild(arg_8_0.viewGO, "Page1")
	arg_8_0._pageGo2 = gohelper.findChild(arg_8_0.viewGO, "Page2")
end

function var_0_0.onStart(arg_9_0)
	arg_9_0:addPage(1, arg_9_0._pageGo1, LinkageActivity_PanelView_Page1)
	arg_9_0:addPage(2, arg_9_0._pageGo2, LinkageActivity_PanelView_Page2)
	arg_9_0:selectedPage(2)
end

function var_0_0.onRefresh(arg_10_0)
	var_0_0.super.onRefresh(arg_10_0)
	arg_10_0:_refreshTimeTick()
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

function var_0_0._refreshTimeTick(arg_12_0)
	arg_12_0._txtLimitTime.text = arg_12_0:getRemainTimeStr()
end

return var_0_0
