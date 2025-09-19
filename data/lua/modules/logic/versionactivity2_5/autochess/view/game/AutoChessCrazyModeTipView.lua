module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessCrazyModeTipView", package.seeall)

local var_0_0 = class("AutoChessCrazyModeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolldec = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_dec")
	arg_1_0._txtModeTip = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_dec/viewport/#txt_ModeTip")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = AutoChessModel.instance.actId
	local var_6_1 = ActivityConfig.instance:getActivityCo(var_6_0)

	arg_6_0._txtModeTip.text = var_6_1.actDesc
end

function var_0_0.onClose(arg_7_0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger28302)
end

return var_0_0
