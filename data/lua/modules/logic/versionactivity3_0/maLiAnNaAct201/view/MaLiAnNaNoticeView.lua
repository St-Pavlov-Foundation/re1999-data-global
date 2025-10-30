module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaNoticeView", package.seeall)

local var_0_0 = class("MaLiAnNaNoticeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goPaper = gohelper.findChild(arg_1_0.viewGO, "#go_Paper")
	arg_1_0._simagePaper3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Paper/Panel/#simage_Paper3")
	arg_1_0._simagePaper2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Paper/Panel/#simage_Paper2")
	arg_1_0._simagePaper1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Paper/Panel/#simage_Paper1")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Paper/Panel/#scroll_Descr")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Paper/Panel/#scroll_Descr/viewport/#txt_Descr")
	arg_1_0._goStart = gohelper.findChild(arg_1_0.viewGO, "#go_Start")
	arg_1_0._simageMaskBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Start/#simage_MaskBG")
	arg_1_0._simageStart = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Start/#simage_Start")
	arg_1_0._txtStart = gohelper.findChildText(arg_1_0.viewGO, "#go_Start/#txt_Start")

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

local var_0_1 = {
	showPaper = 1,
	showStart = 2
}

function var_0_0._btnCloseOnClick(arg_4_0)
	if arg_4_0._step == var_0_1.showPaper then
		arg_4_0._step = var_0_1.showStart

		arg_4_0:refresh()

		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._step = var_0_1.showPaper
	arg_7_0._config = Activity201MaLiAnNaGameModel.instance:getCurGameConfig()

	if string.nilorempty(arg_7_0._config.battledesc) then
		arg_7_0._step = var_0_1.showStart
	else
		arg_7_0._txtDescr.text = arg_7_0._config.battledesc
	end

	arg_7_0:refresh()
end

function var_0_0.refresh(arg_8_0)
	gohelper.setActive(arg_8_0._goPaper, arg_8_0._step == var_0_1.showPaper)
	gohelper.setActive(arg_8_0._goStart, arg_8_0._step == var_0_1.showStart)

	if arg_8_0._step == var_0_1.showStart then
		TaskDispatcher.runDelay(arg_8_0.closeThis, arg_8_0, 2.4)
		TaskDispatcher.runDelay(arg_8_0._playFireAudio, arg_8_0, 1)
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_fight_begin_1)
	end
end

function var_0_0._playFireAudio(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_fight_begin_2)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playFireAudio, arg_10_0)
	ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaGameView)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
