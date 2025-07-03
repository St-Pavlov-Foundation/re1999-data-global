module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultView", package.seeall)

local var_0_0 = class("CooperGarlandResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
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
	arg_2_0._btnsuccessClick:AddClickListener(arg_2_0._btnsuccessClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnsuccessClick:RemoveClickListener()
end

function var_0_0._btnquitgameOnClick(arg_4_0)
	CooperGarlandStatHelper.instance:sendGameExit(arg_4_0.viewName)
	CooperGarlandController.instance:exitGame()
	arg_4_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	CooperGarlandStatHelper.instance:sendMapReset(arg_5_0.viewName)
	CooperGarlandController.instance:resetGame()
	arg_5_0:closeThis()
end

function var_0_0._btnsuccessClickOnClick(arg_6_0)
	CooperGarlandController.instance:exitGame()
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.isWin

	gohelper.setActive(arg_9_0._gosuccess, var_9_0)
	gohelper.setActive(arg_9_0._btnsuccessClick, var_9_0)
	gohelper.setActive(arg_9_0._gofail, not var_9_0)
	gohelper.setActive(arg_9_0._gobtn, not var_9_0)
	gohelper.setActive(arg_9_0._gotargetitem, var_9_0)
	gohelper.setActive(arg_9_0._gofinish, var_9_0)
	gohelper.setActive(arg_9_0._gounfinish, not var_9_0)

	local var_9_1 = var_9_0 and AudioEnum2_7.CooperGarland.play_ui_pkls_endpoint_arrival or AudioEnum2_7.CooperGarland.play_ui_pkls_challenge_fail

	AudioMgr.instance:trigger(var_9_1)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
