module("modules.logic.rouge.map.view.finish.RougeFinishView", package.seeall)

local var_0_0 = class("RougeFinishView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofailed = gohelper.findChild(arg_1_0.viewGO, "#go_failed")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if arg_4_0.sending then
		return
	end

	if arg_4_0.closeed then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.simageSuccess = gohelper.findChildSingleImage(arg_5_0.viewGO, "#go_success")
	arg_5_0.simageFail = gohelper.findChildSingleImage(arg_5_0.viewGO, "#go_failed")
	arg_5_0.succAnimator = arg_5_0._gosuccess:GetComponent(gohelper.Type_Animator)
	arg_5_0.failAnimator = arg_5_0._gofailed:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(arg_5_0.viewName, RougeMapHelper.blockEsc)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.sending = true
	arg_6_0.callbackId = RougeRpc.instance:sendRougeEndRequest(arg_6_0.onReceiveMsg, arg_6_0)

	local var_6_0 = arg_6_0.viewParam == RougeMapEnum.FinishEnum.Finish

	gohelper.setActive(arg_6_0._gosuccess, var_6_0)
	gohelper.setActive(arg_6_0._gofailed, not var_6_0)

	if var_6_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.VictoryOpen)
		arg_6_0.simageSuccess:LoadImage("singlebg/rouge/team/rouge_team_successbg.png")
	else
		AudioMgr.instance:trigger(AudioEnum.UI.FailOpen)
		arg_6_0.simageFail:LoadImage("singlebg/rouge/team/rouge_team_failbg.png")
	end
end

function var_0_0.onReceiveMsg(arg_7_0)
	arg_7_0.sending = false
end

function var_0_0.onClose(arg_8_0)
	arg_8_0.closeed = true

	RougeRpc.instance:removeCallbackById(arg_8_0.callbackId)
	;(arg_8_0.viewParam == RougeMapEnum.FinishEnum.Finish and arg_8_0.succAnimator or arg_8_0.failAnimator):Play("close", 0, 0)

	local var_8_0 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(var_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.simageSuccess:UnLoadImage()
	arg_9_0.simageFail:UnLoadImage()
end

return var_0_0
