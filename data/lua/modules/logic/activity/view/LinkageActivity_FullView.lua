module("modules.logic.activity.view.LinkageActivity_FullView", package.seeall)

local var_0_0 = class("LinkageActivity_FullView", LinkageActivity_FullViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._simageLogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Logo")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
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

local var_0_1 = {
	SkinShop = 1,
	Sign = 2
}

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtLimitTime.text = ""
	arg_5_0._pageGo1 = gohelper.findChild(arg_5_0.viewGO, "Root/Page1")
	arg_5_0._pageGo2 = gohelper.findChild(arg_5_0.viewGO, "Root/Page2")
end

function var_0_0.onDestroyView(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
	var_0_0.super.onDestroyView(arg_6_0)
end

function var_0_0.onStart(arg_7_0)
	arg_7_0:addPage(var_0_1.SkinShop, arg_7_0._pageGo1, LinkageActivity_FullView_Page1)
	arg_7_0:addPage(var_0_1.Sign, arg_7_0._pageGo2, LinkageActivity_FullView_Page2)

	if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(arg_7_0:actId()) then
		arg_7_0:selectedPage_Sign()
	else
		arg_7_0:selectedPage_SkinShop()
	end
end

function var_0_0.onRefresh(arg_8_0)
	var_0_0.super.onRefresh(arg_8_0)
	arg_8_0:_refreshTimeTick()
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._refreshTimeTick, arg_8_0, 1)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshTimeTick, arg_9_0)
end

function var_0_0._refreshTimeTick(arg_10_0)
	arg_10_0._txtLimitTime.text = arg_10_0:getRemainTimeStr()
end

function var_0_0.selectedPage_Sign(arg_11_0)
	arg_11_0:selectedPage(var_0_1.Sign)
end

function var_0_0.selectedPage_SkinShop(arg_12_0)
	arg_12_0:selectedPage(var_0_1.SkinShop)
end

return var_0_0
