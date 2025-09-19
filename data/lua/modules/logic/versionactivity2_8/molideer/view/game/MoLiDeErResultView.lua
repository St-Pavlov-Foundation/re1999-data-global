module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultView", package.seeall)

local var_0_0 = class("MoLiDeErResultView", BaseView)

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
	arg_1_0._goTargetParent = gohelper.findChild(arg_1_0.viewGO, "targets")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnsuccessClick:AddClickListener(arg_2_0._btnsuccessClickOnClick, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, arg_2_0.onGameExit, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, arg_2_0.onGameReset, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnsuccessClick:RemoveClickListener()
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, arg_3_0.onGameExit, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, arg_3_0.onGameReset, arg_3_0)
end

function var_0_0._btnquitgameOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	MoLiDeErGameController.instance:onFailRestart()
end

function var_0_0._btnsuccessClickOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._targetItemList = {}

	local var_7_0 = arg_7_0._gotargetitem.transform.parent.gameObject

	for iter_7_0 = 1, 2 do
		local var_7_1 = gohelper.clone(arg_7_0._gotargetitem, var_7_0)
		local var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, MoLiDeErResultTargetItem)

		arg_7_0._targetItemList[iter_7_0] = var_7_2
	end

	gohelper.setActive(arg_7_0._gotargetitem, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._gameInfoMo
	local var_10_1 = var_10_0.passStar > 0

	if var_10_1 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_pkls_challenge_fail)
	end

	arg_10_0.isSuccess = var_10_1

	gohelper.setActive(arg_10_0._gosuccess, var_10_1)
	gohelper.setActive(arg_10_0._goTargetParent, var_10_1)
	gohelper.setActive(arg_10_0._gofail, not var_10_1)
	gohelper.setActive(arg_10_0._gobtn, not var_10_1)
	gohelper.setActive(arg_10_0._btnsuccessClick, var_10_1)

	local var_10_2 = MoLiDeErModel.instance:getCurEpisode()

	arg_10_0._txtname.text = var_10_2.name
	arg_10_0._txtstage.text = "01"

	local var_10_3 = var_10_0.isExtraStar
	local var_10_4 = MoLiDeErGameModel.instance:getCurGameConfig()
	local var_10_5 = arg_10_0._targetItemList

	var_10_5[1]:refreshUI(var_10_4.winConditionStr, var_10_4.winCondition, var_10_0.passStar and var_10_0.passStar >= 1, true)
	var_10_5[2]:refreshUI(var_10_4.extraConditionStr, var_10_4.extraCondition, var_10_3, false)
end

function var_0_0.onGameExit(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onGameReset(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0.isSuccess then
		MoLiDeErGameController.instance:onSuccessExit()
		MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Win)
	else
		MoLiDeErGameController.instance:onFailExit()
		MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Lose)
	end
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
