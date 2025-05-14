module("modules.logic.social.view.SocialRemarkTipView", package.seeall)

local var_0_0 = class("SocialRemarkTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "main/bg/#simage_left")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "main/bg/#simage_right")
	arg_1_0._inputsignature = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "main/bg/textArea/#input_signature")
	arg_1_0._btncleanname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/bg/textArea/#btn_cleanname")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/bg/btnnode/#btn_cancel")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/bg/btnnode/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncleanname:AddClickListener(arg_2_0._clickClean, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._clickConfirm, arg_2_0)
	arg_2_0._inputsignature:AddOnValueChanged(arg_2_0._onValueChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncleanname:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._inputsignature:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_4_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_4_0._simagebg2 = gohelper.findChildSingleImage(arg_4_0.viewGO, "main/bg/#simage_bg2")
end

function var_0_0._clickConfirm(arg_5_0)
	FriendRpc.instance:changeDesc(arg_5_0.viewParam.userId, arg_5_0._inputsignature:GetText())
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._inputsignature:SetText(arg_6_0.viewParam.desc)
	gohelper.setActive(arg_6_0._btncleanname, not string.nilorempty(arg_6_0.viewParam.desc))
end

function var_0_0._clickClean(arg_7_0)
	arg_7_0._inputsignature:SetText("")
end

function var_0_0._onValueChange(arg_8_0)
	local var_8_0 = arg_8_0._inputsignature:GetText()
	local var_8_1 = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)
	local var_8_2 = GameUtil.utf8sub(var_8_0, 1, math.min(GameUtil.utf8len(var_8_0), var_8_1))

	gohelper.setActive(arg_8_0._btncleanname, not string.nilorempty(var_8_2))

	if var_8_2 == var_8_0 then
		return
	end

	arg_8_0._inputsignature:SetText(var_8_2)
end

return var_0_0
