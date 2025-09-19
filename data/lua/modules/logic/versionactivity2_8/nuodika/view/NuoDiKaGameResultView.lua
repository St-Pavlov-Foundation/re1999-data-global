module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameResultView", package.seeall)

local var_0_0 = class("NuoDiKaGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._txtstage = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_stage")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_name")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_finish")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_restart")
	arg_1_0._btnsuccessClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_successClick")
	arg_1_0._goTargetParent = gohelper.findChild(arg_1_0.viewGO, "targets")

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
	arg_4_0._tipType = NuoDiKaEnum.ResultTipType.Quit

	arg_4_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	arg_5_0._tipType = NuoDiKaEnum.ResultTipType.Restart

	arg_5_0:closeThis()
end

function var_0_0._btnsuccessClickOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._tipType = NuoDiKaEnum.ResultTipType.None
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.isSuccess

	if var_9_0 then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_game_fail_tip)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_game_success_tip)
	end

	gohelper.setActive(arg_9_0._gosuccess, var_9_0)
	gohelper.setActive(arg_9_0._goTargetParent, var_9_0)
	gohelper.setActive(arg_9_0._gofail, not var_9_0)
	gohelper.setActive(arg_9_0._gobtn, not var_9_0)
	gohelper.setActive(arg_9_0._btnsuccessClick, var_9_0)

	local var_9_1 = NuoDiKaModel.instance:getCurEpisode()
	local var_9_2 = NuoDiKaConfig.instance:getEpisodeCo(VersionActivity2_8Enum.ActivityId.NuoDiKa, var_9_1)

	arg_9_0._txtname.text = var_9_2.name
	arg_9_0._txtstage.text = string.format("%02d", NuoDiKaModel.instance:getCurEpisodeIndex())
end

function var_0_0.onClose(arg_10_0)
	if arg_10_0.viewParam.isSuccess then
		if arg_10_0.viewParam.callback then
			arg_10_0.viewParam.callback(arg_10_0.viewParam.callbackObj)
		end
	elseif arg_10_0.viewParam.callback then
		arg_10_0.viewParam.callback(arg_10_0.viewParam.callbackObj, arg_10_0._tipType)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
