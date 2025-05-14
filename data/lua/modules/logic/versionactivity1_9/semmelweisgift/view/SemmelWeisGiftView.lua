module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftView", package.seeall)

local var_0_0 = class("SemmelWeisGiftView", DecalogPresentView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_Claim/#go_Received")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._btnClaimOnClick(arg_2_0)
	SemmelWeisGiftController.instance:receiveSemmelWeisGift()
end

function var_0_0.refreshReceiveStatus(arg_3_0)
	local var_3_0 = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local var_3_1 = SemmelWeisGiftModel.REWARD_INDEX
	local var_3_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_3_0, var_3_1)

	gohelper.setActive(arg_3_0._goNormal, var_3_2)
	gohelper.setActive(arg_3_0._goHasReceived, not var_3_2)
end

function var_0_0.refreshRemainTime(arg_4_0)
	local var_4_0 = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0):getRemainTimeStr3(false, true)

	arg_4_0._txtremainTime.text = string.format(luaLang("remain"), var_4_1)
end

return var_0_0
