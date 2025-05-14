module("modules.logic.login.view.NickNameConfirmView", package.seeall)

local var_0_0 = class("NickNameConfirmView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageinputnamebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_inputnamebg")
	arg_1_0._simageconfirmbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_confirmbg")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#simage_inputnamebg/#txt_name")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go/#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go/#btn_no")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
end

function var_0_0._btnyesOnClick(arg_4_0)
	PlayerRpc.instance:sendRenameRequest(arg_4_0.sendRenameParam.name, arg_4_0.sendRenameParam.guideId, arg_4_0.sendRenameParam.stepId)
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmYes)
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:closeThis()
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmNo)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	arg_6_0._simageconfirmbg:LoadImage(ResUrl.getNickNameIcon("shifouquerendi_003"))
	arg_6_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, arg_6_0.closeThis, arg_6_0)
	arg_6_0:addEventCb(PlayerController.instance, PlayerEvent.RenameReplyFail, arg_6_0._btnnoOnClick, arg_6_0)
	gohelper.addUIClickAudio(arg_6_0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(arg_6_0._btnno.gameObject, AudioEnum.UI.Play_UI_OperaHouse)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	PostProcessingMgr.instance:setBlurWeight(1)

	arg_8_0.sendRenameParam = arg_8_0.viewParam
	arg_8_0._txtname.text = arg_8_0.sendRenameParam.name

	NavigateMgr.instance:addEscape(ViewName.NicknameConfirmView, arg_8_0._btnnoOnClick, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._simageconfirmbg:UnLoadImage()
	arg_9_0._simageinputnamebg:UnLoadImage()
end

function var_0_0.onDestroyView(arg_10_0)
	PostProcessingMgr.instance:setBlurWeight(0)
end

return var_0_0
