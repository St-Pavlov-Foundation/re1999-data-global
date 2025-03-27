module("modules.logic.turnback.view.TurnbackTaskItem", package.seeall)

slot0 = class("TurnbackTaskItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gocommon = gohelper.findChild(slot1, "#go_common")
	slot0._goline = gohelper.findChild(slot1, "#go_common/#go_line")
	slot0._simagebg = gohelper.findChildSingleImage(slot1, "#go_common/#simage_bg")
	slot0._txttaskdes = gohelper.findChildText(slot1, "#go_common/info/#txt_taskdes")
	slot0._txtprocess = gohelper.findChildText(slot1, "#go_common/info/#txt_process")
	slot0._scrollreward = gohelper.findChild(slot1, "#go_common/#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gorewardContent = gohelper.findChild(slot1, "#go_common/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gonotget = gohelper.findChild(slot1, "#go_common/#go_notget")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot1, "#go_common/#go_notget/#btn_goto")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot1, "#go_common/#go_notget/#btn_canget")
	slot0._godoing = gohelper.findChild(slot1, "#go_common/#go_notget/#go_doing")
	slot0._goget = gohelper.findChild(slot1, "#go_common/#go_get")
	slot0._goreddot = gohelper.findChild(slot1, "#go_common/#go_reddot")
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._rewardTab = {}
end

function slot0.addEventListeners(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0._btncanget:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.mo = slot1
	slot0._scrollreward.parentGameObject = slot0._view._csListScroll.gameObject
	slot0._txttaskdes.text = slot0.mo.config.desc
	slot0._txtprocess.text = string.format(slot0.mo.progress < slot0.mo.config.maxProgress and "<color=#d97373>%s/%s</color>" or "%s/%s", slot0.mo.progress, slot0.mo.config.maxProgress)

	gohelper.setActive(slot0._goline, slot0._index ~= 1)
	gohelper.setActive(slot0._btngoto.gameObject, slot0.mo.progress < slot0.mo.config.maxProgress and slot0.mo.config.jumpId > 0)
	gohelper.setActive(slot0._godoing.gameObject, slot3 < slot4 and slot0.mo.config.jumpId == 0)
	gohelper.setActive(slot0._btncanget.gameObject, slot4 <= slot3 and slot0.mo.finishCount == 0)
	gohelper.setActive(slot0._goreddot, false)
	gohelper.setActive(slot0._goget, slot0.mo.finishCount > 0)

	for slot9 = 1, #string.split(slot0.mo.config.bonus, "|") do
		if not slot0._rewardTab[slot9] then
			table.insert(slot0._rewardTab, IconMgr.instance:getCommonPropItemIcon(slot0._gorewardContent))
		end

		slot11 = string.split(slot5[slot9], "#")

		slot10:setMOValue(slot11[1], slot11[2], slot11[3])
		slot10:setPropItemScale(0.6)
		slot10:setHideLvAndBreakFlag(true)
		slot10:hideEquipLvAndBreak(true)
		slot10:setCountFontSize(51)
		gohelper.setActive(slot10.go, true)
	end

	for slot9 = #slot5 + 1, #slot0._rewardTab do
		gohelper.setActive(slot0._rewardTab[slot9].go, false)
	end

	slot0._scrollreward.horizontalNormalizedPosition = 0

	slot0._animator:Play(UIAnimationName.Idle, 0, 0)
end

function slot0._btngotoOnClick(slot0)
	if slot0.mo.config.jumpId ~= 0 then
		GameFacade.jump(slot1)
	end
end

function slot0._btncangetOnClick(slot0)
	if not TurnbackModel.instance:isInOpenTime() then
		return
	end

	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(slot0.finishTask, slot0, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, slot0._index)
	slot0._animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function slot0.finishTask(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(slot0.mo.id)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)
end

return slot0
