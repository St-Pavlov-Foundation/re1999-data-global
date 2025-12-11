module("modules.logic.herogrouppreset.view.HeroGroupPresetModifyNameView", package.seeall)

local var_0_0 = class("HeroGroupPresetModifyNameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnSure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "message/#input_signature")
	arg_1_0._btncleanname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "message/#btn_cleanname")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_leftbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onBtnClose, arg_2_0)
	arg_2_0._btnSure:AddClickListener(arg_2_0._onBtnSure, arg_2_0)
	arg_2_0._btncleanname:AddClickListener(arg_2_0._onBtnClean, arg_2_0)
	arg_2_0._input:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnSure:RemoveClickListener()
	arg_3_0._btncleanname:RemoveClickListener()
	arg_3_0._input:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_4_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0._onBtnClose(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onBtnClean(arg_7_0)
	arg_7_0._input:SetText("")
end

function var_0_0._onBtnSure(arg_8_0)
	local var_8_0 = arg_8_0._input:GetText()

	if string.nilorempty(var_8_0) then
		return
	end

	if GameUtil.utf8len(var_8_0) > 10 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	local var_8_1 = arg_8_0.viewParam.addCallback
	local var_8_2 = arg_8_0.viewParam.callbackObj

	if var_8_1 and var_8_2 then
		HeroGroupRpc.instance:sendCheckHeroGroupNameRequest(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
			if arg_9_1 ~= 0 then
				return
			end

			var_8_1(var_8_2, var_8_0)
		end)

		return
	end

	local var_8_3 = arg_8_0.viewParam.groupId
	local var_8_4 = arg_8_0.viewParam.subId

	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(var_8_3, var_8_4, var_8_0, var_0_0.UpdateHeroGroupNameRequest)
end

function var_0_0.UpdateHeroGroupNameRequest(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	HeroGroupPresetHeroGroupNameController.instance:setName(arg_10_2.currentSelect, arg_10_2.name, arg_10_2.id)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UpdateGroupName, arg_10_2.currentSelect)
	ViewMgr.instance:closeView(ViewName.HeroGroupPresetModifyNameView)
end

function var_0_0._onValueChanged(arg_11_0)
	local var_11_0 = arg_11_0._input:GetText()

	gohelper.setActive(arg_11_0._btncleanname, not string.nilorempty(var_11_0))
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	local var_12_0 = arg_12_0.viewParam.name

	arg_12_0._input:SetText(var_12_0)
	gohelper.setActive(arg_12_0._btncleanname, not string.nilorempty(var_12_0))
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
