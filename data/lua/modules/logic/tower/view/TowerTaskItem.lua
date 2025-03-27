module("modules.logic.tower.view.TowerTaskItem", package.seeall)

slot0 = class("TowerTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._golight = gohelper.findChild(slot0.viewGO, "#go_normal/progress/#go_light")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._goscrollRewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewardContent")
	slot0._btnnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_normal")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_canget")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_hasget")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnormal:AddClickListener(slot0._btnnormalOnClick, slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnormal:RemoveClickListener()
	slot0._btncanget:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
end

slot0.BlockKey = "TowerTaskItemRewardGetAnim"
slot0.TaskMaskTime = 0.65

function slot0._btnnormalOnClick(slot0)
	if not slot0.jumpId then
		return
	end

	GameFacade.jump(slot0.jumpId)
end

function slot0._btncangetOnClick(slot0)
	if not slot0.taskId and not slot0.mo.canGetAll then
		return
	end

	slot0._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	TowerController.instance:dispatchEvent(TowerEvent.OnTaskRewardGetFinish, slot0._index)
	TaskDispatcher.runDelay(slot0._onPlayActAniFinished, slot0, uv0.TaskMaskTime)
end

function slot0._btngetallOnClick(slot0)
	slot0:_btncangetOnClick()
end

function slot0._onPlayActAniFinished(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)

	if slot0.mo.canGetAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Tower, 0, TowerTaskModel.instance:getAllCanGetList(), nil, , 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.taskId)
	end

	UIBlockMgr.instance:endBlock(uv0.BlockKey)
end

function slot0._editableInitView(slot0)
	slot0.rewardItemTab = slot0:getUserDataTb_()
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._scrollrewards = slot0._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function slot0.onUpdateMO(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.mo = slot1
	slot0._scrollrewards.parentGameObject = slot0._view._csListScroll.gameObject

	if slot0.mo.canGetAll then
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._gogetall, true)
	else
		gohelper.setActive(slot0._gonormal, true)
		gohelper.setActive(slot0._gogetall, false)
		slot0:refreshNormal()
	end
end

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if TowerTaskModel.instance:getDelayPlayTime(slot0.mo) == -1 then
		slot0._animator:Play("idle", 0, 0)

		slot0._animator.speed = 1
	else
		slot0._animator:Play("open", 0, 0)

		slot0._animator.speed = 0

		TaskDispatcher.runDelay(slot0.onDelayPlayOpen, slot0, slot1)
	end
end

function slot0.onDelayPlayOpen(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._animator.speed = 1
end

function slot0.refreshNormal(slot0)
	slot0.taskId = slot0.mo.id
	slot0.config = slot0.mo.config
	slot0.jumpId = slot0.config.jumpId
	slot0._txttaskdes.text = slot0.config.desc

	slot0:refreshReward()
	slot0:refreshState()
end

function slot0.refreshReward(slot0)
	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.mo.config.bonus, true)) do
		if not slot0.rewardItemTab[slot6] then
			slot0.rewardItemTab[slot6] = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._gorewardContent)
			}
		end

		slot8.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3])
		slot8.itemIcon:isShowCount(true)
		slot8.itemIcon:setCountFontSize(40)
		slot8.itemIcon:showStackableNum2()
		slot8.itemIcon:setHideLvAndBreakFlag(true)
		slot8.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(slot8.itemIcon.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemTab do
		if slot0.rewardItemTab[slot6] then
			gohelper.setActive(slot7.itemIcon.go, false)
		end
	end
end

function slot0.refreshState(slot0)
	if TowerTaskModel.instance:isTaskFinished(slot0.mo) then
		gohelper.setActive(slot0._gohasget, true)
		gohelper.setActive(slot0._btnnormal.gameObject, false)
		gohelper.setActive(slot0._btncanget.gameObject, false)
		gohelper.setActive(slot0._golight, true)
	elseif slot0.mo.hasFinished then
		gohelper.setActive(slot0._gohasget, false)
		gohelper.setActive(slot0._btnnormal.gameObject, false)
		gohelper.setActive(slot0._btncanget.gameObject, true)
		gohelper.setActive(slot0._golight, true)
	else
		gohelper.setActive(slot0._gohasget, false)
		gohelper.setActive(slot0._btnnormal.gameObject, slot0.jumpId and slot0.jumpId > 0)
		gohelper.setActive(slot0._btncanget.gameObject, false)
		gohelper.setActive(slot0._golight, false)
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)

	if slot0.rewardItemTab then
		for slot4, slot5 in pairs(slot0.rewardItemTab) do
			if slot5.itemIcon then
				slot5.itemIcon:onDestroy()

				slot5.itemIcon = nil
			end
		end

		slot0.rewardItemTab = nil
	end

	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)
end

return slot0
