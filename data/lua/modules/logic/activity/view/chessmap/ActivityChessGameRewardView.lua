module("modules.logic.activity.view.chessmap.ActivityChessGameRewardView", package.seeall)

local var_0_0 = class("ActivityChessGameRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtrewardnamecn = gohelper.findChildText(arg_1_0.viewGO, "inforoot/#txt_rewardnamecn")
	arg_1_0._txtrewardnameen = gohelper.findChildText(arg_1_0.viewGO, "inforoot/#txt_rewardnamecn/#txt_rewardnameen")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
	arg_5_0._simageicon:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpItem)

	local var_6_0 = arg_6_0.viewParam.config

	if not string.nilorempty(var_6_0.showParam) then
		arg_6_0._simageicon:LoadImage(ResUrl.getVersionactivitychessIcon(var_6_0.showParam))
	end

	arg_6_0._txtrewardnamecn.text = var_6_0.name
	arg_6_0._txtrewardnameen.text = var_6_0.name_en or ""
end

function var_0_0.onClose(arg_7_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RewardIsClose)
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

return var_0_0
