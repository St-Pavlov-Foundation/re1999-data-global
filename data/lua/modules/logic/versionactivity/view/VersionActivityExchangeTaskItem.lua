module("modules.logic.versionactivity.view.VersionActivityExchangeTaskItem", package.seeall)

local var_0_0 = class("VersionActivityExchangeTaskItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.viewGO = arg_1_1
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txtcurcount = gohelper.findChildText(arg_1_0.viewGO, "#txt_curcount")
	arg_1_0._txttotalcount = gohelper.findChildText(arg_1_0.viewGO, "#txt_totalcount")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._btnreceive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_receive")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnreceive:AddClickListener(arg_2_0._btnreceiveOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnreceive:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btnreceiveOnClick(arg_4_0)
	arg_4_0._animator:Play("finish")
	UIBlockMgr.instance:startBlock("VersionActivityExchangeTaskItem")
	TaskDispatcher.runDelay(arg_4_0.sendRewardRequest, arg_4_0, 0.6)
end

function var_0_0._btnjumpOnClick(arg_5_0)
	GameFacade.jump(arg_5_0.mo.config.jumpId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.icon = IconMgr.instance:getCommonItemIcon(arg_6_0._gorewards)

	arg_6_0.icon:setCountFontSize(36)
	arg_6_0._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("bg_rwdi"))

	arg_6_0._animator = arg_6_0.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.sendRewardRequest(arg_7_0)
	UIBlockMgr.instance:endBlock("VersionActivityExchangeTaskItem")
	Activity112Rpc.instance:sendReceiveAct112TaskRewardRequest(arg_7_0.mo.actId, arg_7_0.mo.id)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.mo = arg_8_1
	arg_8_0._txtdesc.text = arg_8_1.config.desc
	arg_8_0._txtcurcount.text = arg_8_1.progress
	arg_8_0._txttotalcount.text = arg_8_1.config.maxProgress

	arg_8_0:_setCurCountFontSize()

	local var_8_0 = GameUtil.splitString2(arg_8_1.config.bonus, true)[1]

	arg_8_0.icon:setMOValue(var_8_0[1], var_8_0[2], var_8_0[3])
	arg_8_0.icon:isShowCount(true)
	gohelper.setActive(arg_8_0._btnjump.gameObject, arg_8_1.config.maxProgress > arg_8_1.progress and arg_8_1.hasGetBonus == false)
	gohelper.setActive(arg_8_0._btnreceive.gameObject, arg_8_1.config.maxProgress <= arg_8_1.progress and arg_8_1.hasGetBonus == false)
	gohelper.setActive(arg_8_0._gofinish, arg_8_1.hasGetBonus)
	gohelper.setActive(arg_8_0._goblackmask, arg_8_1.hasGetBonus)

	if arg_8_3 then
		arg_8_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_8_0._animator:Update(0)

		local var_8_1 = arg_8_0._animator:GetCurrentAnimatorStateInfo(0).length

		if var_8_1 <= 0 then
			var_8_1 = 1
		end

		arg_8_0._animator:Play(UIAnimationName.Open, 0, -0.06 * (arg_8_2 - 1) / var_8_1)
		arg_8_0._animator:Update(0)
	else
		arg_8_0._animator:Play(UIAnimationName.Open, 0, 1)
		arg_8_0._animator:Update(0)
	end
end

function var_0_0._setCurCountFontSize(arg_9_0)
	local var_9_0 = 0.35
	local var_9_1 = 0.7
	local var_9_2 = var_9_1
	local var_9_3 = 6
	local var_9_4 = #arg_9_0._txtcurcount.text
	local var_9_5 = 3

	if var_9_5 < var_9_4 then
		var_9_2 = var_9_1 - (var_9_1 - var_9_0) / (var_9_3 - var_9_5) * (var_9_4 - var_9_5)
	end

	transformhelper.setLocalScale(arg_9_0._txtcurcount.transform, var_9_2, var_9_2, 1)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
end

return var_0_0
