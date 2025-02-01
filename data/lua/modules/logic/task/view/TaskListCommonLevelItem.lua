module("modules.logic.task.view.TaskListCommonLevelItem", package.seeall)

slot0 = class("TaskListCommonLevelItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._tag = gohelper.findChildText(slot1, "tag")
	slot0._goflagcontent = gohelper.findChild(slot1, "flagitem")
	slot0._goflag = gohelper.findChild(slot1, "flagitem/#go_flag")
	slot0._scrollreward = gohelper.findChild(slot1, "rewarditem"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gorewardcontent = gohelper.findChild(slot1, "rewarditem/viewport/content")
	slot0._gomaskbg = gohelper.findChild(slot1, "go_maskbg")
	slot0._gomask = gohelper.findChild(slot1, "go_maskbg/maskcontainer")
	slot0._itemAni = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._itemAni.enabled = false
	slot0._maskAni = slot0._gomaskbg:GetComponent(typeof(UnityEngine.Animator))
	slot0._maskAni.enabled = false
	slot0._maskCanvasGroup = slot0._gomaskbg:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._getAct = 0
	slot0._gocanvasgroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._scrollreward.parentGameObject = slot2

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCheckPlayRewardGet, slot0)
end

function slot0._onPlayActState(slot0, slot1)
	if slot1.taskType == TaskEnum.TaskType.Novice or slot1.num < 1 then
		return
	end

	if slot0._taskType ~= slot1.taskType then
		return
	end

	TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)

	if slot0:_getAddNum(slot1.num) < 1 then
		return
	end

	slot0._totalAct = slot0._getAct + slot2

	if slot2 > 0 then
		slot0._flagupdateCount = 0

		TaskDispatcher.runRepeat(slot0._flagPlayUpdate, slot0, 0.06, slot2)
	end
end

function slot0._getAddNum(slot0, slot1)
	if slot0._index <= TaskModel.instance:getTaskActivityMO(slot0._taskType).defineId then
		return 0
	end

	slot3 = 0
	slot4 = 0

	for slot9 = slot2.defineId + 1, slot0._index do
		slot5 = 0 + TaskConfig.instance:gettaskactivitybonusCO(slot0._taskType, slot9).needActivity
	end

	slot6 = TaskConfig.instance:gettaskactivitybonusCO(slot0._taskType, slot0._index).needActivity

	return slot2.value - slot2.gainValue + slot1 - slot5 >= 0 and (slot0._index == slot2.defineId + 1 and slot6 - (slot2.value - slot2.gainValue) or slot6) or slot0._index == slot2.defineId + 1 and slot1 or slot1 + slot2.value - slot2.gainValue - (slot5 - slot6)
end

function slot0._flagPlayUpdate(slot0)
	slot0._flagupdateCount = slot0._flagupdateCount + 1

	if slot0._flagupdateCount + slot0._getAct > #slot0._flags then
		TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)

		return
	end

	gohelper.setActive(slot0._flags[slot0._flagupdateCount + slot0._getAct].go, true)
	slot0._flags[slot0._flagupdateCount + slot0._getAct].ani:Play("play")

	if slot0._totalAct <= slot0._flagupdateCount + slot0._getAct then
		for slot4 = slot0._getAct, slot0._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(slot0._flags[slot4 + 1].img, "logo_huoyuedu")
		end

		slot0._getAct = slot0._totalAct

		if TaskConfig.instance:gettaskactivitybonusCO(slot0._taskType, slot0._index).needActivity <= slot0._getAct then
			slot0._needOpen = true
		end

		TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)
	end
end

function slot0._onCheckPlayRewardGet(slot0, slot1)
	if slot1 == ViewName.CommonPropView and slot0._needOpen and slot0._maskCanvasGroup then
		slot0._maskCanvasGroup.alpha = 1
		slot0._maskAni.enabled = true

		slot0._maskAni:Play(UIAnimationName.Open)

		slot0._needOpen = false
	end
end

function slot0.setItem(slot0, slot1, slot2, slot3, slot4)
	slot0._index = slot1
	slot0._mo = slot2
	slot0._taskType = slot3

	TaskController.instance:registerCallback(TaskEvent.RefreshActState, slot0._onPlayActState, slot0)

	slot5 = TaskModel.instance:getTaskActivityMO(slot0._taskType)

	for slot11 = 1, #TaskConfig.instance:getTaskActivityBonusConfig(slot0._taskType) do
		slot6 = 0 + slot7[slot11].needActivity
	end

	if slot0._index <= slot5.defineId and slot5.value < slot6 then
		slot0._maskCanvasGroup.alpha = 1
		slot0._maskAni.enabled = true

		if slot4 then
			slot0._maskAni:Play(UIAnimationName.Open)
		else
			slot0._maskAni:Play(UIAnimationName.Idle)
		end
	else
		slot0._maskCanvasGroup.alpha = 0
		slot0._itemAni.enabled = true
		slot0._gocanvasgroup.alpha = 1
	end

	slot0._tag.text = string.format("%02d", slot0._index)

	if slot4 then
		slot0._gocanvasgroup.alpha = 0
		slot0._itemAni.enabled = false

		TaskDispatcher.runDelay(slot0._playStartAni, slot0, 0.04 * (slot0._index - (TaskModel.instance:getMaxStage(slot0._taskType) - (TaskModel.instance:getTaskActivityMO(slot0._taskType).defineId + 1) >= 5 and slot9 - 1 or slot8 - 5) + 1))
	else
		slot0._gocanvasgroup.alpha = 1
		slot0._itemAni.enabled = true

		slot0._itemAni:Play(UIAnimationName.Idle)
		slot0:_setFlagItem()
		slot0:_setRewardItem()
	end
end

function slot0.showAllComplete(slot0)
	slot0._maskCanvasGroup.alpha = 1

	slot0._maskAni:Play(UIAnimationName.Idle)
	gohelper.setActive(slot0._gomask, false)
end

function slot0._playStartAni(slot0)
	slot0._gocanvasgroup.alpha = 1
	slot0._itemAni.enabled = true

	slot0._itemAni:Play(UIAnimationName.Open)
	slot0:_setFlagItem(true)
	slot0:_setRewardItem()
end

function slot0._setFlagItem(slot0, slot1)
	if slot0._flags then
		for slot5, slot6 in pairs(slot0._flags) do
			gohelper.destroy(slot6.go)
		end
	end

	slot0._getAct = 0
	slot0._flags = slot0:getUserDataTb_()

	if slot0._index <= TaskModel.instance:getTaskActivityMO(slot0._taskType).defineId then
		slot0._getAct = TaskConfig.instance:gettaskactivitybonusCO(slot0._taskType, slot0._index).needActivity
	elseif slot0._index == slot3.defineId + 1 then
		slot0._getAct = slot3.value - slot3.gainValue
	end

	for slot7 = 1, slot2 do
		slot8 = gohelper.cloneInPlace(slot0._goflag.gameObject)

		gohelper.setActive(slot8, not slot1)

		slot9 = {
			go = slot8
		}
		slot9.idle = gohelper.findChild(slot9.go, "idle")

		gohelper.setActive(slot9.idle, true)

		slot9.img = gohelper.findChildImage(slot9.go, "idle")

		UISpriteSetMgr.instance:setCommonSprite(slot9.img, slot7 <= slot0._getAct and "logo_huoyuedu" or "logo_huoyuedu_dis")

		slot9.play = gohelper.findChild(slot9.go, "play")

		gohelper.setActive(slot9.play, false)

		slot9.ani = slot9.go:GetComponent(typeof(UnityEngine.Animator))

		slot9.ani:Play(UIAnimationName.Idle)
		table.insert(slot0._flags, slot9)
	end

	slot0._flagopenCount = 0

	if slot1 then
		TaskDispatcher.cancelTask(slot0._flagOpenUpdate, slot0)
		TaskDispatcher.runRepeat(slot0._flagOpenUpdate, slot0, 0.03, slot2)
	end
end

function slot0._flagOpenUpdate(slot0)
	slot0._flagopenCount = slot0._flagopenCount + 1

	gohelper.setActive(slot0._flags[slot0._flagopenCount].go, true)
	slot0._flags[slot0._flagopenCount].ani:Play(UIAnimationName.Open)
end

function slot0._setRewardItem(slot0)
	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			gohelper.destroy(slot5.go)
			slot5:onDestroy()
		end
	end

	slot0._rewardItems = slot0:getUserDataTb_()
	slot5 = slot0._index

	for slot5 = 1, #string.split(TaskConfig.instance:gettaskactivitybonusCO(slot0._taskType, slot5).bonus, "|") do
		slot0._rewardItems[slot5] = IconMgr.instance:getCommonPropItemIcon(slot0._gorewardcontent)
		slot6 = string.splitToNumber(slot1[slot5], "#")

		slot0._rewardItems[slot5]:setMOValue(slot6[1], slot6[2], slot6[3], nil, true)
		transformhelper.setLocalScale(slot0._rewardItems[slot5].go.transform, 0.6, 0.6, 1)
		slot0._rewardItems[slot5]:setCountFontSize(50)
		slot0._rewardItems[slot5]:showStackableNum2()
		slot0._rewardItems[slot5]:isShowEffect(true)
		slot0._rewardItems[slot5]:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot5]:hideEquipLvAndBreak(true)
		gohelper.setActive(slot0._rewardItems[slot5].go, true)
	end
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._playStartAni, slot0)
	TaskDispatcher.cancelTask(slot0._flagOpenUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, slot0._onPlayActState, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCheckPlayRewardGet, slot0)

	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			gohelper.destroy(slot5.go)
			slot5:onDestroy()
		end

		slot0._rewardItems = nil
	end

	if slot0._flags then
		for slot4, slot5 in pairs(slot0._flags) do
			gohelper.destroy(slot5.go)
		end

		slot0._flags = nil
	end
end

return slot0
