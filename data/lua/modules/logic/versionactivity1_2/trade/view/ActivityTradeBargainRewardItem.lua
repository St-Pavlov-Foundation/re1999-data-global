module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardItem", package.seeall)

slot0 = class("ActivityTradeBargainRewardItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0.btnNotEnough = gohelper.findChildButtonWithAudio(slot0.go, "btn_unable")
	slot0.btnGet = gohelper.findChildButtonWithAudio(slot0.go, "btn_get")
	slot0.goHasReceive = gohelper.findChild(slot0.go, "go_hasreceive")
	slot0.goScroll = gohelper.findChild(slot0.go, "scroll_reward")
	slot0.scroll = slot0.goScroll:GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.scroll.parentGameObject = slot2
	slot0.goIconContainer = gohelper.findChild(slot0.go, "scroll_reward/Viewport/Content")
	slot0.txtDesc = gohelper.findChildText(slot0.go, "txt_desc")
	slot0.goMask = gohelper.findChild(slot0.go, "go_blackmask")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.go, "bg")
	slot0.rewardIcons = {}

	slot0:addClickCb(slot0.btnGet, slot0.onClickGetReward, slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	slot0._simageclickbg = gohelper.findChildSingleImage(slot0.go, "click/bg")

	slot0._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)
	slot0.anim:Play(UIAnimationName.Idle)
	gohelper.setActive(slot0.btnNotEnough.gameObject, slot1:getStatus() == Activity117Enum.Status.NotEnough)
	gohelper.setActive(slot0.btnGet.gameObject, slot2 == Activity117Enum.Status.CanGet)
	gohelper.setActive(slot0.goHasReceive, slot2 == Activity117Enum.Status.AlreadyGot)
	gohelper.setActive(slot0.goMask, slot2 == Activity117Enum.Status.AlreadyGot)

	slot0.txtDesc.text = formatLuaLang("versionactivity_1_2_117desc_1", slot1.needScore)

	slot0:refreshRewardIcons(slot1)
end

function slot0.refreshRewardIcons(slot0, slot1)
	slot6 = #slot1.rewardItems

	for slot6 = 1, math.max(slot6, #slot0.rewardIcons) do
		slot0:refreshRewardIcon(slot0:getOrCreateRewardIcon(slot6), slot2[slot6])
	end
end

function slot0.refreshRewardIcon(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)
	slot1.comp:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
	slot1.comp:setScale(0.59)
	slot1.comp:setCountFontSize(45)
end

function slot0.getOrCreateRewardIcon(slot0, slot1)
	if not slot0.rewardIcons[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.comp = IconMgr.instance:getCommonItemIcon(slot0.goIconContainer)
		slot2.go = slot2.comp.gameObject
		slot0.rewardIcons[slot1] = slot2
	end

	return slot2
end

function slot0.onClickGetReward(slot0)
	if not slot0.data then
		return
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	slot0:onFinish()
	TaskDispatcher.runDelay(slot0._sendGetBonus, slot0, 0.6)
end

function slot0.onFinish(slot0)
	slot0.anim:Play(UIAnimationName.Finish)
end

function slot0._sendGetBonus(slot0)
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(slot0.data.actId, {
		slot0.data.id
	})
end

function slot0.destory(slot0)
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(slot0._sendGetBonus, slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageclickbg:UnLoadImage()
	slot0:__onDispose()
end

return slot0
