module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardItem", package.seeall)

local var_0_0 = class("ActivityTradeBargainRewardItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.btnNotEnough = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_unable")
	arg_1_0.btnGet = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_get")
	arg_1_0.goHasReceive = gohelper.findChild(arg_1_0.go, "go_hasreceive")
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.go, "scroll_reward")
	arg_1_0.scroll = arg_1_0.goScroll:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.scroll.parentGameObject = arg_1_2
	arg_1_0.goIconContainer = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/Content")
	arg_1_0.txtDesc = gohelper.findChildText(arg_1_0.go, "txt_desc")
	arg_1_0.goMask = gohelper.findChild(arg_1_0.go, "go_blackmask")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.go, "bg")
	arg_1_0.rewardIcons = {}

	arg_1_0:addClickCb(arg_1_0.btnGet, arg_1_0.onClickGetReward, arg_1_0)
	arg_1_0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	arg_1_0._simageclickbg = gohelper.findChildSingleImage(arg_1_0.go, "click/bg")

	arg_1_0._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1

	if not arg_2_1 then
		gohelper.setActive(arg_2_0.go, false)

		return
	end

	gohelper.setActive(arg_2_0.go, true)
	arg_2_0.anim:Play(UIAnimationName.Idle)

	local var_2_0 = arg_2_1:getStatus()

	gohelper.setActive(arg_2_0.btnNotEnough.gameObject, var_2_0 == Activity117Enum.Status.NotEnough)
	gohelper.setActive(arg_2_0.btnGet.gameObject, var_2_0 == Activity117Enum.Status.CanGet)
	gohelper.setActive(arg_2_0.goHasReceive, var_2_0 == Activity117Enum.Status.AlreadyGot)
	gohelper.setActive(arg_2_0.goMask, var_2_0 == Activity117Enum.Status.AlreadyGot)

	arg_2_0.txtDesc.text = formatLuaLang("versionactivity_1_2_117desc_1", arg_2_1.needScore)

	arg_2_0:refreshRewardIcons(arg_2_1)
end

function var_0_0.refreshRewardIcons(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.rewardItems

	for iter_3_0 = 1, math.max(#var_3_0, #arg_3_0.rewardIcons) do
		local var_3_1 = arg_3_0:getOrCreateRewardIcon(iter_3_0)

		arg_3_0:refreshRewardIcon(var_3_1, var_3_0[iter_3_0])
	end
end

function var_0_0.refreshRewardIcon(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 then
		gohelper.setActive(arg_4_1.go, false)

		return
	end

	gohelper.setActive(arg_4_1.go, true)
	arg_4_1.comp:setMOValue(arg_4_2[1], arg_4_2[2], arg_4_2[3], nil, true)
	arg_4_1.comp:setScale(0.59)
	arg_4_1.comp:setCountFontSize(45)
end

function var_0_0.getOrCreateRewardIcon(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.rewardIcons[arg_5_1]

	if not var_5_0 then
		var_5_0 = arg_5_0:getUserDataTb_()
		var_5_0.comp = IconMgr.instance:getCommonItemIcon(arg_5_0.goIconContainer)
		var_5_0.go = var_5_0.comp.gameObject
		arg_5_0.rewardIcons[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.onClickGetReward(arg_6_0)
	if not arg_6_0.data then
		return
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	arg_6_0:onFinish()
	TaskDispatcher.runDelay(arg_6_0._sendGetBonus, arg_6_0, 0.6)
end

function var_0_0.onFinish(arg_7_0)
	arg_7_0.anim:Play(UIAnimationName.Finish)
end

function var_0_0._sendGetBonus(arg_8_0)
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(arg_8_0.data.actId, {
		arg_8_0.data.id
	})
end

function var_0_0.destory(arg_9_0)
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(arg_9_0._sendGetBonus, arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageclickbg:UnLoadImage()
	arg_9_0:__onDispose()
end

return var_0_0
