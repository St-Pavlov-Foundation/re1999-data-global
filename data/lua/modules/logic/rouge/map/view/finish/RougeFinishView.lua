module("modules.logic.rouge.map.view.finish.RougeFinishView", package.seeall)

slot0 = class("RougeFinishView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofailed = gohelper.findChild(slot0.viewGO, "#go_failed")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0.sending then
		return
	end

	if slot0.closeed then
		return
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.simageSuccess = gohelper.findChildSingleImage(slot0.viewGO, "#go_success")
	slot0.simageFail = gohelper.findChildSingleImage(slot0.viewGO, "#go_failed")
	slot0.succAnimator = slot0._gosuccess:GetComponent(gohelper.Type_Animator)
	slot0.failAnimator = slot0._gofailed:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)
end

function slot0.onOpen(slot0)
	slot0.sending = true
	slot0.callbackId = RougeRpc.instance:sendRougeEndRequest(slot0.onReceiveMsg, slot0)
	slot1 = slot0.viewParam == RougeMapEnum.FinishEnum.Finish

	gohelper.setActive(slot0._gosuccess, slot1)
	gohelper.setActive(slot0._gofailed, not slot1)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.VictoryOpen)
		slot0.simageSuccess:LoadImage("singlebg/rouge/team/rouge_team_successbg.png")
	else
		AudioMgr.instance:trigger(AudioEnum.UI.FailOpen)
		slot0.simageFail:LoadImage("singlebg/rouge/team/rouge_team_failbg.png")
	end
end

function slot0.onReceiveMsg(slot0)
	slot0.sending = false
end

function slot0.onClose(slot0)
	slot0.closeed = true

	RougeRpc.instance:removeCallbackById(slot0.callbackId)
	(slot0.viewParam == RougeMapEnum.FinishEnum.Finish and slot0.succAnimator or slot0.failAnimator):Play("close", 0, 0)
	RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(RougeOutsideModel.instance:season())
end

function slot0.onDestroyView(slot0)
	slot0.simageSuccess:UnLoadImage()
	slot0.simageFail:UnLoadImage()
end

return slot0
