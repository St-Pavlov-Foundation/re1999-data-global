module("modules.logic.activity.view.warmup.ActivityWarmUpTaskItem", package.seeall)

slot0 = class("ActivityWarmUpTaskItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#txt_taskdes")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#txt_progress")
	slot0._txtmaxprogress = gohelper.findChildText(slot0.viewGO, "#txt_maxprogress")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	slot0._goget = gohelper.findChild(slot0.viewGO, "#go_get")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "#go_notget")
	slot0._goblackmask = gohelper.findChild(slot0.viewGO, "#go_blackmask")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_notget/#btn_finishbg")

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

function slot0.initData(slot0, slot1, slot2)
	slot0._index = slot1
	slot0.viewGO = slot2

	slot0:onInitView()
	slot0:addEvents()
	gohelper.setActive(slot0.viewGO, false)
	slot0._animSelf:Play(UIAnimationName.Open, 0, 0)
end

function slot0.onDestroy(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.onFinishAnimCompleted, slot0)
	slot0:removeEvents()
	slot0:onDestroyView()
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("bg_rwdi"))

	slot0._animSelf = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animSelf.enabled = true
	slot0._iconList = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in pairs(slot0._iconList) do
		gohelper.setActive(slot5.go, true)
		gohelper.destroy(slot5.go)
	end

	slot0._iconList = nil
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

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
		gohelper.setActive(slot0._goblackmask, true)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
	else
		slot0:refreshButtonRunning()
	end
end

function slot0.refreshButtonRunning(slot0)
	if slot0._mo:alreadyGotReward() then
		slot0:refreshWhenFinished()
	else
		gohelper.setActive(slot0._goblackmask, false)

		if slot0._mo:isFinished() then
			gohelper.setActive(slot0._goget, false)
			gohelper.setActive(slot0._gonotget, true)
			gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
			gohelper.setActive(slot0._btnfinishbg.gameObject, true)
		else
			gohelper.setActive(slot0._goget, false)
			gohelper.setActive(slot0._gonotget, true)
			gohelper.setActive(slot0._btnnotfinishbg.gameObject, true)
			gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		end
	end
end

function slot0.refreshWhenFinished(slot0)
	gohelper.setActive(slot0._goblackmask, true)
	gohelper.setActive(slot0._goget, true)
	gohelper.setActive(slot0._gonotget, false)
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
	end
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
	ActivityWarmUpController.instance:switchTab(slot0._mo.config.openDay)
	ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
end

slot0.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function slot0._btnfinishbgOnClick(slot0)
	slot0:refreshWhenFinished()
	slot0._animSelf:Play("finish", 0, 0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)
	TaskDispatcher.runDelay(slot0.onFinishAnimCompleted, slot0, 0.4)
end

function slot0.onFinishAnimCompleted(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(slot0._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
end

return slot0
