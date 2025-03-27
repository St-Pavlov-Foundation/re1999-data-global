module("modules.logic.turnback.view.new.view.TurnbackNewTaskItem", package.seeall)

slot0 = class("TurnbackNewTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._scrollrewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._goRewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0._godaily = gohelper.findChild(slot0.viewGO, "#go_normal/#go_daily")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0.rewardItemList = {}
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

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

function slot0._btnnotfinishbgOnClick(slot0)
	if slot0.taskMo.config.jumpId ~= 0 then
		GameFacade.jump(slot1)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(slot0.finishTask, slot0, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, slot0._index)
	slot0.animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function slot0.finishTask(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(slot0.taskMo.id)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1
	slot0._scrollrewards.parentGameObject = slot0._view._csListScroll.gameObject

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.getAll)

	slot0.co = slot0.taskMo.config
	slot0._txttaskdes.text = slot0.co.desc
	slot0._txtnum.text = slot0.taskMo.progress
	slot0._txttotal.text = slot0.co.maxProgress

	gohelper.setActive(slot0._godaily, slot0.taskMo.config.loopType == 1)

	if slot0.taskMo.finishCount > 0 then
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._goallfinish, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0._btnfinishbg.gameObject, true)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._goallfinish, false)
	else
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(slot0._goallfinish, false)
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
	end

	slot0:refreshRewardItems()
end

function slot0.refreshRewardItems(slot0)
	if string.nilorempty(slot0.co.bonus) then
		gohelper.setActive(slot0._scrollrewards.gameObject, false)

		return
	end

	gohelper.setActive(slot0._scrollrewards.gameObject, true)

	slot6 = "#"

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true, "|", slot6)) do
		if not slot0.rewardItemList[slot6] then
			slot11 = IconMgr.instance:getCommonPropItemIcon(slot0._goRewardContent)

			slot11:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
			table.insert(slot0.rewardItemList, slot11)
		else
			slot11:setMOValue(slot8, slot9, slot10, nil, true)
		end

		slot11:setCountFontSize(40)
		slot11:showStackableNum2()
		slot11:isShowEffect(true)
		gohelper.setActive(slot11.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot6].go, false)
	end

	slot0._scrollrewards.horizontalNormalizedPosition = 0

	slot0.animator:Play(UIAnimationName.Idle, 0, 0)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.finishTask, slot0)
end

return slot0
