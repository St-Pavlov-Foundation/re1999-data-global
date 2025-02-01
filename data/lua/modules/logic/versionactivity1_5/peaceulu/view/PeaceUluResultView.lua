module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluResultView", package.seeall)

slot0 = class("PeaceUluResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "tips/#txt_tips")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_restart")
	slot0._canvasGroupRestart = slot0._btnrestart.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroupQuitegame = slot0._btnquitgame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gorestarticon = gohelper.findChild(slot0.viewGO, "#btn_restart/icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#btn_restart/icon/#txt_Num")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.reInitResultView, slot0._reInitUI, slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnexitOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btncontinueOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.reInitResultView, slot0._reInitUI, slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
end

function slot0._btnexitOnClick(slot0)
	slot0._animator:Play("close", 0, 0)
	slot0._animator:Update(0)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
end

function slot0._btncontinueOnClick(slot0)
	if not PeaceUluModel.instance:checkCanPlay() then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function slot0._editableInitView(slot0)
end

function slot0._reInitUI(slot0)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._gofail, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()

	if slot0._cannotPlay then
		slot0._animator:Play("open1", 0, 0)
		slot0._animator:Update(0)
	else
		slot0._animator:Play("open", 0, 0)
		slot0._animator:Update(0)
	end

	slot0.viewContainer:getNavigateButtonView():setParam({
		true,
		true,
		false
	})
	PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function slot0._killTween(slot0)
end

function slot0.refreshUI(slot0)
	slot2 = nil

	if PeaceUluModel.instance:getGameRes() == PeaceUluEnum.GameResult.Win then
		slot2 = true

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Win)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
	elseif slot1 == PeaceUluEnum.GameResult.Fail then
		slot2 = false

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Fail)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.ui_settleaccounts_lose)
	end

	if slot2 then
		slot0._txttips.text = luaLang("p_v1a5_peaceulu_resultview_txt_tips1")
	else
		slot0._txttips.text = luaLang("p_v1a5_peaceulu_resultview_txt_tips2")
	end

	gohelper.setActive(slot0._gosuccess, slot2)
	gohelper.setActive(slot0._gofail, not slot2)

	slot0._cannotPlay = PeaceUluModel.instance:getGameHaveTimes() == 0 and true or false
	slot0._txtnum.text = string.format("<color=#DB8542>%s</color>", slot4) .. "/" .. PeaceUluConfig.instance:getGameTimes()

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onOpenResultView)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
