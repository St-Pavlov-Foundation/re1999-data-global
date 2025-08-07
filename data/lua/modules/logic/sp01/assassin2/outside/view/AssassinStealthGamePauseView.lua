module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGamePauseView", package.seeall)

local var_0_0 = class("AssassinStealthGamePauseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btnback = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/btnLayout/#btn_back", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btnreset = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/btnLayout/#btn_reset", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btnexit = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/btnLayout/#btn_exit", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btnabandon = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/btnLayout/#btn_abandon", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btnabandon:AddClickListener(arg_2_0._btnabandonOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnexit:RemoveClickListener()
	arg_3_0._btnabandon:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnbackOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmBack, MsgBoxEnum.BoxType.Yes_No, arg_4_0._confirmBack, nil, nil, arg_4_0, nil)
end

function var_0_0._confirmBack(arg_5_0)
	AssassinStealthGameController.instance:recoverAssassinStealthGame()
	arg_5_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmReset, MsgBoxEnum.BoxType.Yes_No, arg_6_0._confirmReset, nil, nil, arg_6_0, nil)
end

function var_0_0._confirmReset(arg_7_0)
	AssassinStealthGameController.instance:resetGame()
	arg_7_0:closeThis()
end

function var_0_0._btnexitOnClick(arg_8_0)
	AssassinStealthGameController.instance:exitGame()
	arg_8_0:closeThis()
end

function var_0_0._btnabandonOnClick(arg_9_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmAbandon, MsgBoxEnum.BoxType.Yes_No, arg_9_0._confirmAbandon, nil, nil, arg_9_0, nil)
end

function var_0_0._confirmAbandon(arg_10_0)
	AssassinStealthGameController.instance:abandonGame()
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	gohelper.setActive(arg_11_0._btnexit, false)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
