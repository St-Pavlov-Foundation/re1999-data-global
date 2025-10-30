module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaResultView", package.seeall)

local var_0_0 = class("MaLiAnNaResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._txtstage = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_stage")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_name")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_finish")
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
	arg_2_0._btnsuccessClick:AddClickListener(arg_2_0._btnsuccessClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnsuccessClick:RemoveClickListener()
end

function var_0_0._btnquitgameOnClick(arg_4_0)
	arg_4_0:_exitGame()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	arg_5_0._isReset = true

	Activity201MaLiAnNaGameController.instance:restartGame()
	arg_5_0:closeThis()
end

function var_0_0._btnsuccessClickOnClick(arg_6_0)
	arg_6_0:_exitGame()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._isReset = false

	local var_9_0 = Activity201MaLiAnNaGameController.instance:getCurEpisodeId()
	local var_9_1 = Activity201MaLiAnNaConfig.instance:getEpisodeCo(VersionActivity3_0Enum.ActivityId.MaLiAnNa, var_9_0)
	local var_9_2 = Activity201MaLiAnNaModel.instance:getEpisodeIndex(var_9_0)

	arg_9_0._txtname.text = var_9_1.name
	arg_9_0._txtstage.text = var_9_2
	arg_9_0.isWin = arg_9_0.viewParam.isWin

	gohelper.setActive(arg_9_0._btnsuccessClick.gameObject, arg_9_0.isWin)
	gohelper.setActive(arg_9_0._btnrestart.gameObject, not arg_9_0.isWin)
	gohelper.setActive(arg_9_0._btnquitgame.gameObject, not arg_9_0.isWin)
	gohelper.setActive(arg_9_0._gofail, false)
	gohelper.setActive(arg_9_0._gosuccess, false)
	TaskDispatcher.runDelay(arg_9_0._refreshView, arg_9_0, 0.5)
end

function var_0_0._refreshView(arg_10_0)
	gohelper.setActive(arg_10_0._gofail, not arg_10_0.isWin)
	gohelper.setActive(arg_10_0._gosuccess, arg_10_0.isWin)

	if arg_10_0.isWin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_pkls_challenge_fail)
	end
end

function var_0_0.onClose(arg_11_0)
	if not arg_11_0._isReset then
		ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaGameView)

		if arg_11_0.isWin then
			Activity201MaLiAnNaController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnBackToLevel)
			Activity201MaLiAnNaController.instance:dispatchEvent(Activity201MaLiAnNaEvent.EpisodeFinished)
		end
	end
end

function var_0_0._exitGame(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshView, arg_13_0)
end

return var_0_0
