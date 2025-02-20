module("modules.logic.seasonver.act123.view2_3.Season123_2_3TaskView", package.seeall)

slot0 = class("Season123_2_3TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "top/#go_reward")
	slot0._gorewardunchoose = gohelper.findChild(slot0.viewGO, "top/#go_reward/#go_rewardunchoose")
	slot0._gorewardchoose = gohelper.findChild(slot0.viewGO, "top/#go_reward/#go_rewardchoose")
	slot0._gorewardreddot = gohelper.findChild(slot0.viewGO, "top/#go_reward/#go_rewardreddot")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_reward/#btn_reward")
	slot0._gotask = gohelper.findChild(slot0.viewGO, "top/#go_task")
	slot0._gotaskunchoose = gohelper.findChild(slot0.viewGO, "top/#go_task/#go_taskunchoose")
	slot0._gotaskchoose = gohelper.findChild(slot0.viewGO, "top/#go_task/#go_taskchoose")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "top/#go_task/#go_taskreddot")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_task/#btn_task")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tasklist")
	slot0._scrollmaplist = gohelper.findChildScrollRect(slot0.viewGO, "left/#go_maplist/#scroll_maplist")
	slot0._gomapcontent = gohelper.findChild(slot0.viewGO, "left/#go_maplist/#scroll_maplist/Viewport/#go_mapContent")
	slot0._gomaplist = gohelper.findChild(slot0.viewGO, "left/#go_maplist")
	slot0._btnarrowdown = gohelper.findChildButton(slot0.viewGO, "left/#go_maplist/#btn_arrowDown")
	slot0._btnarrowtop = gohelper.findChildButton(slot0.viewGO, "left/#go_maplist/#btn_arrowTop")
	slot0._goreddotdown = gohelper.findChild(slot0.viewGO, "left/#go_maplist/#btn_arrowDown/#go_reddotDown")
	slot0._goreddottop = gohelper.findChild(slot0.viewGO, "left/#go_maplist/#btn_arrowTop/#go_reddotTop")
	slot0._goscrollArea = gohelper.findChild(slot0.viewGO, "left/#go_maplist/#go_scrollArea")
	slot0._goachievement = gohelper.findChild(slot0.viewGO, "left/#go_achievement")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnarrowdown:AddClickListener(slot0._btnArrowDownOnClick, slot0)
	slot0._btnarrowtop:AddClickListener(slot0._btnArrowUpOnClick, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, slot0.refreshRedDot, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, slot0.moveScrollPos, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0._btnarrowdown:RemoveClickListener()
	slot0._btnarrowtop:RemoveClickListener()
	slot0:removeEventCb(Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.TaskUpdated, slot0.refreshRedDot, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, slot0.moveScrollPos, slot0)
end

slot0.TaskMaskTime = 0.65
slot0.TaskGetAnimTime = 0.567
slot0.StageMapItemCount = 6
slot0.moveDistance = 50

function slot0._btnrewardOnClick(slot0)
	slot0.curTaskType = Activity123Enum.TaskRewardViewType

	slot0:refreshUI()
end

function slot0._btntaskOnClick(slot0)
	slot0.curTaskType = Activity123Enum.TaskNormalType

	slot0:refreshUI()
end

function slot0._btnArrowDownOnClick(slot0)
	slot0.curStage = Mathf.Min(slot0.curStage + 1, uv0.StageMapItemCount)
	Season123TaskModel.instance.curStage = slot0.curStage

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function slot0._btnArrowUpOnClick(slot0)
	slot0.curStage = Mathf.Max(slot0.curStage - 1, 1)
	Season123TaskModel.instance.curStage = slot0.curStage

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0.scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	if slot3.y > 0 and Mathf.Abs((slot2.position - slot0.scrollStartPos).y) - uv0.moveDistance >= 0 then
		slot0:_btnArrowDownOnClick()
	elseif slot3.y < 0 and slot4 then
		slot0:_btnArrowUpOnClick()
	end
end

function slot0._editableInitView(slot0)
	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0.viewContainer.scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(uv0.TaskMaskTime - uv0.TaskGetAnimTime)

	slot0.stageMapItemTab = slot0:getUserDataTb_()
	slot0.layoutGroup = slot0._gomapcontent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	slot0.mapcontentRectTrans = slot0._gomapcontent:GetComponent(gohelper.Type_RectTransform)
	slot0.mapScroll = SLFramework.UGUI.UIDragListener.Get(slot0._goscrollArea)

	slot0.mapScroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0.mapScroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.stageId = slot0.viewParam.stage

	Season123TaskModel.instance:setTaskInfoList(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {})
	Season123TaskModel.instance:initStageAndTaskType()

	Season123TaskModel.instance.curStage = slot0.stageId ~= nil and slot0.stageId or Season123TaskModel.instance.curStage
	slot0.curTaskType = slot0.stageId ~= nil and Activity123Enum.TaskRewardViewType or slot0.curTaskType

	slot0:createStageMapItem()
	slot0:refreshUI()
	slot0:refreshArrowRedDot()
	UIBlockMgr.instance:startBlock("playEnterSeason123_2_3TaskViewAnim")
	TaskDispatcher.runDelay(slot0.endEnterAnimBlock, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function slot0.refreshUI(slot0)
	slot0.curStage = Season123TaskModel.instance.curStage
	slot1 = not slot0.curTaskType and Season123TaskModel.instance.curTaskType or slot0.curTaskType

	Season123TaskModel.instance:refreshList(slot1)

	slot0._scrolltasklist.verticalNormalizedPosition = 1

	gohelper.setActive(slot0._gorewardchoose, slot1 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(slot0._gorewardunchoose, slot1 == Activity123Enum.TaskNormalType)
	gohelper.setActive(slot0._gotaskchoose, slot1 == Activity123Enum.TaskNormalType)
	gohelper.setActive(slot0._gotaskunchoose, slot1 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(slot0._goachievement, slot1 == Activity123Enum.TaskNormalType)
	gohelper.setActive(slot0._scrollmaplist.gameObject, slot1 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(slot0._gomaplist, slot1 == Activity123Enum.TaskRewardViewType)
	slot0:refreshArrowUI()
	slot0:refreshRedDot()
	slot0:moveScrollPos()
end

function slot0.refreshRedDot(slot0)
	gohelper.setActive(slot0._gorewardreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskRewardViewType])
	gohelper.setActive(slot0._gotaskreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskNormalType])
end

function slot0.refreshArrowRedDot(slot0)
	slot3 = Mathf.Min(slot0.curStage + 1, uv0.StageMapItemCount)
	slot4 = false
	slot5 = false

	for slot9 = 1, #Season123TaskModel.instance:getHaveRewardTaskIndexList() do
		if Mathf.Max(slot0.curStage - 1, 1) - slot1[slot9] >= 0 then
			slot4 = true

			break
		end
	end

	for slot9 = 1, #slot1 do
		if slot1[slot9] - slot3 >= 0 then
			slot5 = true

			break
		end
	end

	gohelper.setActive(slot0._goreddotdown, slot3 - slot0.curStage > 0 and slot5)
	gohelper.setActive(slot0._goreddottop, slot0.curStage - slot2 > 0 and slot4)
end

function slot0.refreshArrowUI(slot0)
	gohelper.setActive(slot0._btnarrowdown.gameObject, slot0.curStage < uv0.StageMapItemCount)
	gohelper.setActive(slot0._btnarrowtop.gameObject, slot0.curStage > 1)
	slot0:refreshArrowRedDot()
end

function slot0._playGetRewardFinishAnim(slot0, slot1)
	if slot1 then
		slot0.removeIndexTab = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, uv0.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0.removeIndexTab)
end

function slot0.endEnterAnimBlock(slot0)
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_3TaskViewAnim")
end

function slot0.createStageMapItem(slot0)
	for slot4 = 1, uv0.StageMapItemCount do
		if not slot0.stageMapItemTab[slot4] then
			slot5 = {
				itemGO = gohelper.findChild(slot0._gomapcontent, "go_item" .. slot4)
			}
			slot5.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot5.itemGO, Season123_2_3TaskMapItem, {
				stage = slot4,
				actId = slot0.actId
			})
			slot5.height = recthelper.getHeight(slot5.itemGO:GetComponent(gohelper.Type_RectTransform))
			slot0.stageMapItemTab[slot4] = slot5
		end

		gohelper.setActive(slot5.itemGO, true)
		slot5.item:refreshUI()
	end
end

function slot0.moveScrollPos(slot0)
	slot0.curStage = Season123TaskModel.instance.curStage
	slot1 = recthelper.getHeight(slot0._scrollmaplist:GetComponent(gohelper.Type_RectTransform))
	slot2 = slot0.layoutGroup.spacing

	for slot7 = 1, slot0.curStage - 1 do
		slot3 = 0 + slot0.stageMapItemTab[slot7].height
	end

	slot8 = -slot1 / 2 + (slot0.curStage - 1) * slot2 + slot3 + slot0.stageMapItemTab[slot0.curStage].height / 2
	slot9 = 0.5
	slot0.scrollMoveTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.mapcontentRectTrans, slot8, slot9, slot0.refreshArrowUI, slot0)

	for slot8, slot9 in ipairs(slot0.stageMapItemTab) do
		slot9.item:setScale()
	end
end

function slot0.onClose(slot0)
	Season123TaskModel.instance:clear()
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_3TaskViewAnim")
	TaskDispatcher.cancelTask(slot0.endEnterAnimBlock, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)
	slot0.mapScroll:RemoveDragBeginListener()
	slot0.mapScroll:RemoveDragEndListener()
end

function slot0.onDestroyView(slot0)
	if slot0.scrollMoveTweenId then
		ZProj.TweenHelper.KillById(slot0.scrollMoveTweenId)
	end
end

return slot0
