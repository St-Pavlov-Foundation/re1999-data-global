module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskItem", package.seeall)

slot0 = class("SportsNewsTaskItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.go, "#simage_normalbg")
	slot0._txtprogress = gohelper.findChildText(slot0.go, "progress/#txt_num")
	slot0._txtmaxprogress = gohelper.findChildText(slot0.go, "progress/#txt_num/#txt_total")
	slot0._scrolltaskdes = gohelper.findChildScrollRect(slot0.go, "#scroll_taskdes")
	slot0._txttaskdes = gohelper.findChildText(slot0.go, "#scroll_taskdes/Viewport/#txt_taskdes")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.go, "#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.go, "#scroll_rewards/Viewport/content/#go_rewards")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.go, "#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.go, "#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.go, "#go_allfinish")
	slot0._anim = slot0.go:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0._index = slot1
	slot0.go = slot2
	slot0.view = slot3

	slot0:onInitView()
	slot0:addEvents()
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	slot0:removeEvents()
	slot0:onDestroyView()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onFinishAnimCompleted, slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.go)
	slot0._iconList = {}
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._iconList) do
		gohelper.setActive(slot5.go, true)
		gohelper.destroy(slot5.go)
	end

	slot0._iconList = nil
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_playAnim(UIAnimationName.Idle, 0, 0)
	slot0:refreshInfo()
	slot0:refreshAllRewardIcons()
end

function slot0.refreshInfo(slot0)
	slot1 = slot0._mo.config
	slot2 = slot0._mo.taskMO
	slot0._txttaskdes.text = slot1.desc
	slot0._txtprogress.text = tostring(slot0._mo:getProgress())
	slot0._txtmaxprogress.text = tostring(slot1.maxProgress)

	if slot0._mo:isLock() then
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._goallfinish, false)
	else
		slot0:refreshButtonRunning()
	end

	slot0._scrolltaskdes.horizontalNormalizedPosition = 0
end

function slot0.refreshButtonRunning(slot0)
	if slot0._mo:alreadyGotReward() then
		slot0:refreshWhenFinished()
	else
		slot1 = slot0._mo:isFinished()

		gohelper.setActive(slot0._btnnotfinishbg.gameObject, not slot1)
		gohelper.setActive(slot0._btnfinishbg.gameObject, slot1)
		gohelper.setActive(slot0._goallfinish, false)
	end
end

function slot0.refreshWhenFinished(slot0)
	gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
	gohelper.setActive(slot0._btnfinishbg.gameObject, false)
	gohelper.setActive(slot0._goallfinish, true)
end

function slot0.refreshAllRewardIcons(slot0)
	slot0:hideAllRewardIcon()

	for slot5 = 1, #string.split(slot0._mo.config.bonus, "|") do
		slot6 = slot0:getOrCreateIcon(slot5)

		gohelper.setActive(slot6.go, true)

		slot7 = string.splitToNumber(slot1[slot5], "#")

		slot6.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot6.itemIcon:isShowCount(slot7[1] ~= MaterialEnum.MaterialType.Hero)
		slot6.itemIcon:setCountFontSize(40)
		slot6.itemIcon:showStackableNum2()
		slot6.itemIcon:setHideLvAndBreakFlag(true)
		slot6.itemIcon:hideEquipLvAndBreak(true)

		if slot7[1] == 9 and slot6.itemIcon and slot6.itemIcon._equipIcon and slot6.itemIcon._equipIcon.viewGO and gohelper.findChildImage(slot6.itemIcon._equipIcon.viewGO, "bg") then
			UISpriteSetMgr.instance:setCommonSprite(slot8, "bgequip3")
		end
	end

	slot0._scrollrewards.horizontalNormalizedPosition = 0
end

function slot0.getOrCreateIcon(slot0, slot1)
	if not slot0._iconList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gorewarditem)

		gohelper.setActive(slot2.go, true)

		slot2.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot2.go)
		slot0._iconList[slot1] = slot2
	end

	return slot2
end

function slot0.hideAllRewardIcon(slot0)
	for slot4, slot5 in pairs(slot0._iconList) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0._btnnotfinishbgOnClick(slot0)
	if ActivityWarmUpModel.instance:getOrderMo(slot0._mo.config.orderid) and slot1.cfg.jumpId ~= 0 then
		SportsNewsController.instance:jumpToFinishTask(slot1, slot0.jumpCallback, slot0)
	else
		ActivityWarmUpController.instance:switchTab(slot0._mo.config.openDay)
		ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
	end
end

function slot0.jumpCallback(slot0)
end

slot0.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function slot0._btnfinishbgOnClick(slot0)
	slot0:refreshWhenFinished()
	slot0:_playAnim(UIAnimationName.Finish, 0, 0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)
	TaskDispatcher.runDelay(slot0.onFinishAnimCompleted, slot0, 0.4)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function slot0.onFinishAnimCompleted(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	gohelper.setActive(slot0._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
end

function slot0.getOrderCo(slot0, slot1)
	return Activity106Config.instance:getActivityWarmUpOrderCo(VersionActivity1_5Enum.ActivityId.SportsNews, slot1)
end

function slot0._playOpenInner(slot0)
	gohelper.setActive(slot0.go, true)
	slot0:_playAnim(UIAnimationName.Open, 0, 0)
end

function slot0._playAnim(slot0, slot1, ...)
	if slot0._anim then
		slot0._anim:Play(slot1, ...)
	end
end

return slot0
