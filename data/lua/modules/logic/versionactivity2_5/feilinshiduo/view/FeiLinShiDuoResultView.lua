module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoResultView", package.seeall)

local var_0_0 = class("FeiLinShiDuoResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_finish")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_restart")
	arg_1_0._btnsuccessClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_successClick")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnsuccessClick:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnsuccessClick:RemoveClickListener()
end

function var_0_0._btnquitgameOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.FeiLinShiDuoGameView, false, true)
	arg_4_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.ResultResetGame)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)

	arg_8_0.isSuccess = arg_8_0.viewParam.isSuccess

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	gohelper.setActive(arg_9_0._gosuccess, arg_9_0.isSuccess)
	gohelper.setActive(arg_9_0._gofinish, arg_9_0.isSuccess)
	gohelper.setActive(arg_9_0._gobtn, not arg_9_0.isSuccess)
	gohelper.setActive(arg_9_0._gofail, not arg_9_0.isSuccess)
	gohelper.setActive(arg_9_0._gounfinish, not arg_9_0.isSuccess)
	gohelper.setActive(arg_9_0._btnsuccessClick.gameObject, arg_9_0.isSuccess)

	arg_9_0._txttaskdesc.text = luaLang("act185_gametarget")

	if arg_9_0.isSuccess then
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_challenge_fail)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
