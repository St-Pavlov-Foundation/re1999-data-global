module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameView", package.seeall)

local var_0_0 = class("TowerBossTalentModifyNameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeView")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_leftbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "message/#input_signature")
	arg_1_0._txttext = gohelper.findChildText(arg_1_0.viewGO, "message/#input_signature/textarea/#txt_text")
	arg_1_0._btncleanname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "message/#btn_cleanname")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseView:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._btncleanname:AddClickListener(arg_2_0._btncleannameOnClick, arg_2_0)
	arg_2_0._input:AddOnValueChanged(arg_2_0._onInputValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseView:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._btncleanname:RemoveClickListener()
	arg_3_0._input:RemoveOnValueChanged()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = arg_5_0._input:GetText()

	if string.nilorempty(var_5_0) then
		return
	end

	if GameUtil.utf8len(var_5_0) > 6 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	local var_5_1 = GameUtil.trimInput(var_5_0)

	TowerRpc.instance:sendTowerRenameTalentPlanRequest(arg_5_0.bossId, var_5_1, arg_5_0._onRenameTalentReply, arg_5_0)
end

function var_0_0._onRenameTalentReply(arg_6_0)
	arg_6_0:_btncloseOnClick()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
end

function var_0_0._btncleannameOnClick(arg_7_0)
	arg_7_0._input:SetText("")
end

function var_0_0._onInputValueChanged(arg_8_0)
	local var_8_0 = arg_8_0._input:GetText()

	gohelper.setActive(arg_8_0._btncleanname, not string.nilorempty(var_8_0))
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_9_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.bossId = arg_10_0.viewParam.bossId
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagerightbg:UnLoadImage()
	arg_11_0._simageleftbg:UnLoadImage()
end

return var_0_0
