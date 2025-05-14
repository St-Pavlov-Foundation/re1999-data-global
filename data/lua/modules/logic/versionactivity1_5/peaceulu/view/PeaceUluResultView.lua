module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluResultView", package.seeall)

local var_0_0 = class("PeaceUluResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "tips/#txt_tips")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_restart")
	arg_1_0._canvasGroupRestart = arg_1_0._btnrestart.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._canvasGroupQuitegame = arg_1_0._btnquitgame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gorestarticon = gohelper.findChild(arg_1_0.viewGO, "#btn_restart/icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#btn_restart/icon/#txt_Num")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.reInitResultView, arg_2_0._reInitUI, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btncontinueOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.reInitResultView, arg_3_0._reInitUI, arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0._btnexitOnClick(arg_4_0)
	arg_4_0._animator:Play("close", 0, 0)
	arg_4_0._animator:Update(0)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
end

function var_0_0._btncontinueOnClick(arg_5_0)
	if not PeaceUluModel.instance:checkCanPlay() then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._reInitUI(arg_7_0)
	gohelper.setActive(arg_7_0._gosuccess, false)
	gohelper.setActive(arg_7_0._gofail, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshUI()

	if arg_9_0._cannotPlay then
		arg_9_0._animator:Play("open1", 0, 0)
		arg_9_0._animator:Update(0)
	else
		arg_9_0._animator:Play("open", 0, 0)
		arg_9_0._animator:Update(0)
	end

	arg_9_0.viewContainer:getNavigateButtonView():setParam({
		true,
		true,
		false
	})
	PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function var_0_0._killTween(arg_10_0)
	return
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = PeaceUluModel.instance:getGameRes()
	local var_11_1

	if var_11_0 == PeaceUluEnum.GameResult.Win then
		var_11_1 = true

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Win)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
	elseif var_11_0 == PeaceUluEnum.GameResult.Fail then
		var_11_1 = false

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Fail)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.ui_settleaccounts_lose)
	end

	if var_11_1 then
		arg_11_0._txttips.text = luaLang("p_v1a5_peaceulu_resultview_txt_tips1")
	else
		arg_11_0._txttips.text = luaLang("p_v1a5_peaceulu_resultview_txt_tips2")
	end

	gohelper.setActive(arg_11_0._gosuccess, var_11_1)
	gohelper.setActive(arg_11_0._gofail, not var_11_1)

	local var_11_2 = PeaceUluConfig.instance:getGameTimes()
	local var_11_3 = PeaceUluModel.instance:getGameHaveTimes()

	arg_11_0._cannotPlay = var_11_3 == 0 and true or false
	arg_11_0._txtnum.text = string.format("<color=#DB8542>%s</color>", var_11_3) .. "/" .. var_11_2

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onOpenResultView)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
