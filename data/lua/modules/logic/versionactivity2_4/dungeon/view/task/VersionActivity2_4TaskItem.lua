module("modules.logic.versionactivity2_4.dungeon.view.task.VersionActivity2_4TaskItem", package.seeall)

slot0 = class("VersionActivity2_4TaskItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0.txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0.txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0.txttaskdesc = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0.scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goRewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0.goFinished = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0.goDoing = gohelper.findChild(slot0.viewGO, "#go_normal/txt_finishing")
	slot0.btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0.goRunning = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_running")
	slot0.btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0.btnFinishAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall/#btn_getall")
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0.animatorPlayer:Play(UIAnimationName.Open)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0.btnFinish:AddClickListener(slot0._btnFinishOnClick, slot0)
	slot0.btnFinishAll:AddClickListener(slot0._btnFinishAllOnClick, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnClickFinishAllTask, slot0._onClickFinishAllTaskItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnNotFinish:RemoveClickListener()
	slot0.btnFinish:RemoveClickListener()
	slot0.btnFinishAll:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.OnClickFinishAllTask, slot0._onClickFinishAllTaskItem, slot0)
end

function slot0._btnNotFinishOnClick(slot0)
	if slot0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(slot0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4TaskView)
		end
	end
end

function slot0._onClickFinishAllTaskItem(slot0, slot1)
	if slot0.taskMo.getAll then
		return
	end

	if slot1 ~= VersionActivity2_4Enum.ActivityId.Dungeon or not slot0.taskMo.hasFinished then
		return
	end

	slot0.animator.speed = 1

	slot0.animatorPlayer:Play(UIAnimationName.Finish)
end

function slot0._btnFinishAllOnClick(slot0)
	slot0:_btnFinishOnClick()
end

slot0.FinishKey = "VersionActivity2_4TaskItem FinishKey"

function slot0._btnFinishOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0.FinishKey)

	if slot0.taskMo.getAll then
		TaskController.instance:dispatchEvent(TaskEvent.OnClickFinishAllTask, VersionActivity2_4Enum.ActivityId.Dungeon)
	end

	slot0.animator.speed = 1

	slot0.animatorPlayer:Play(UIAnimationName.Finish, slot0.firstAnimationDone, slot0)
end

function slot0.firstAnimationDone(slot0)
	slot1 = VersionActivity2_4TaskListModel.instance:getFinishedTaskIdxList()
	slot1[#slot1 + 1] = slot0._index

	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndexs(slot1, slot0.secondAnimationDone, slot0)
end

function slot0.secondAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.FinishKey)
	slot0.animatorPlayer:Play(UIAnimationName.Idle)

	if slot0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, , , , VersionActivity2_4Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.co.id)
	end
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.getAll)
	gohelper.setActive(slot0._gogetall, slot0.taskMo.getAll)

	if slot0.taskMo.getAll then
		slot0:refreshGetAllUI()
	else
		slot0:refreshNormalUI()
	end
end

function slot0.refreshNormalUI(slot0)
	slot0.co = slot0.taskMo.config
	slot0.txttaskdesc.text = slot0.co.desc
	slot0.txtnum.text = slot0.taskMo.progress
	slot0.txttotal.text = slot0.co.maxProgress

	if slot0.co.maxFinishCount <= slot0.taskMo.finishCount then
		gohelper.setActive(slot0.goDoing, false)
		gohelper.setActive(slot0.btnNotFinish, false)
		gohelper.setActive(slot0.goRunning, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0.btnFinish, true)
		gohelper.setActive(slot0.btnNotFinish, false)
		gohelper.setActive(slot0.goDoing, false)
		gohelper.setActive(slot0.goRunning, false)
		gohelper.setActive(slot0.goFinished, false)
	else
		if slot0.co.jumpId ~= 0 then
			gohelper.setActive(slot0.btnNotFinish, true)
			gohelper.setActive(slot0.goDoing, false)
			gohelper.setActive(slot0.goRunning, false)
		else
			gohelper.setActive(slot0.btnNotFinish, false)
			gohelper.setActive(slot0.goDoing, true)
			gohelper.setActive(slot0.goRunning, true)
		end

		gohelper.setActive(slot0.goFinished, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
	end

	slot0:refreshRewardItems()
end

function slot0.refreshRewardItems(slot0)
	if string.nilorempty(slot0.co.bonus) then
		gohelper.setActive(slot0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(slot0.scrollReward.gameObject, true)

	slot0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #GameUtil.splitString2(slot1, true, "|", "#") > 2

	for slot6, slot7 in ipairs(slot2) do
		if not slot0.rewardItemList[slot6] then
			slot11 = IconMgr.instance:getCommonPropItemIcon(slot0.goRewardContent)

			transformhelper.setLocalScale(slot11.go.transform, 1, 1, 1)
			slot11:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
			slot11:setCountFontSize(26)
			slot11:showStackableNum2()
			slot11:isShowEffect(true)
			table.insert(slot0.rewardItemList, slot11)
			transformhelper.setLocalScale(slot11:getItemIcon():getCountBg().transform, 1, 1.5, 1)
			transformhelper.setLocalScale(slot11:getItemIcon():getCount().transform, 1.5, 1.5, 1)
		else
			slot11:setMOValue(slot8, slot9, slot10, nil, true)
		end

		gohelper.setActive(slot11.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot6].go, false)
	end

	slot0.scrollReward.horizontalNormalizedPosition = 0
end

function slot0.refreshGetAllUI(slot0)
end

function slot0.canGetReward(slot0)
	return slot0.taskMo.finishCount < slot0.co.maxFinishCount and slot0.taskMo.hasFinished
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

function slot0.onDestroyView(slot0)
	slot0._simagenormalbg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()
end

return slot0
