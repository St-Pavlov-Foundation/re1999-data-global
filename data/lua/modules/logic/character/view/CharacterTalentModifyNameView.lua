module("modules.logic.character.view.CharacterTalentModifyNameView", package.seeall)

local var_0_0 = class("CharacterTalentModifyNameView", BaseView)

function var_0_0.trimInput_overseas(arg_1_0)
	if not arg_1_0 then
		return ""
	end

	return arg_1_0:match("^%s*(.-)%s*$")
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnClose = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "bottom/#btn_close")
	arg_2_0._btnSure = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "bottom/#btn_sure")
	arg_2_0._input = gohelper.findChildTextMeshInputField(arg_2_0.viewGO, "message/#input_signature")
	arg_2_0._btncleanname = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "message/#btn_cleanname")
	arg_2_0._simagerightbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "window/#simage_rightbg")
	arg_2_0._simageleftbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "window/#simage_leftbg")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnClose:AddClickListener(arg_3_0._onBtnClose, arg_3_0)
	arg_3_0._btnSure:AddClickListener(arg_3_0._onBtnSure, arg_3_0)
	arg_3_0._btncleanname:AddClickListener(arg_3_0._onBtnClean, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, arg_3_0._onRenameTalentTemplateReply, arg_3_0)
	arg_3_0._input:AddOnValueChanged(arg_3_0._onValueChanged, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnClose:RemoveClickListener()
	arg_4_0._btnSure:RemoveClickListener()
	arg_4_0._btncleanname:RemoveClickListener()
	arg_4_0._input:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_5_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0._onRenameTalentTemplateReply(arg_7_0)
	arg_7_0:_onBtnClose()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
end

function var_0_0._onBtnClose(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._onBtnClean(arg_9_0)
	arg_9_0._input:SetText("")
end

function var_0_0._onBtnSure(arg_10_0)
	local var_10_0 = arg_10_0._input:GetText()

	if string.nilorempty(var_10_0) then
		return
	end

	if GameUtil.utf8len(var_10_0) > 10 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	local var_10_1 = var_0_0.trimInput_overseas(var_10_0)

	if string.nilorempty(var_10_1) then
		return
	end

	HeroRpc.instance:RenameTalentTemplateRequest(arg_10_0._heroId, arg_10_0._templateId, var_10_1)
end

function var_0_0._onValueChanged(arg_11_0)
	local var_11_0 = arg_11_0._input:GetText()

	gohelper.setActive(arg_11_0._btncleanname, not string.nilorempty(var_11_0))
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	arg_12_0._heroId = arg_12_0.viewParam[1]
	arg_12_0._templateId = arg_12_0.viewParam[2]
	arg_12_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, arg_12_0._onFrame, arg_12_0._onFinish, arg_12_0, nil, EaseType.Linear)

	gohelper.setActive(arg_12_0._btncleanname, false)
end

function var_0_0._onFrame(arg_13_0, arg_13_1)
	PostProcessingMgr.instance:setBlurWeight(arg_13_1)
end

function var_0_0._onFinish(arg_14_0)
	PostProcessingMgr.instance:setBlurWeight(1)
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(arg_15_0._blurTweenId)

		arg_15_0._blurTweenId = nil
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagerightbg:UnLoadImage()
	arg_16_0._simageleftbg:UnLoadImage()
end

return var_0_0
