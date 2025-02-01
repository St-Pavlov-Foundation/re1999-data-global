module("modules.logic.versionactivity.view.VersionActivityTaskView", package.seeall)

slot0 = class("VersionActivityTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagedecorate2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decorate2")
	slot0._scrollleft = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_left")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_left/Viewport/Content/#go_item")
	slot0._txtgetcount = gohelper.findChildText(slot0.viewGO, "horizontal/totalprogress/#txt_getcount")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goitem, false)

	slot0.goTaskBonusContent = gohelper.findChild(slot0.viewGO, "#scroll_left/Viewport/Content")
	slot0.itemResPath = slot0.viewContainer:getSetting().otherRes[1]
	slot0.taskBonusItemList = {}

	slot0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnReceiveFinishTaskReply, slot0.onReceiveFinishTaskReply, slot0)
	VersionActivityTaskListModel.instance:initTaskList()
	slot0:setTaskBonusY()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshLeftUI()
	slot0:refreshRightUI()
end

function slot0.setTaskBonusY(slot0)
	slot1 = math.min(TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon).defineId, #TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon) - 5)

	transformhelper.setLocalPosXY(slot0.goTaskBonusContent.transform, 0, 165 * slot1)
	slot0.viewContainer:setTaskBonusScrollViewIndexOffset(slot1)
end

function slot0.refreshLeftUI(slot0)
	slot0:refreshTaskBonusItem()
end

function slot0.refreshRightUI(slot0)
	slot0._txtgetcount.text = string.format(" %s/%s", VersionActivityTaskListModel.instance:getGetRewardTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))

	VersionActivityTaskListModel.instance:sortTaskMoList()
	VersionActivityTaskListModel.instance:refreshList()
end

function slot0.refreshTaskBonusItem(slot0)
	VersionActivityTaskBonusListModel.instance:refreshList()
end

function slot0.onReceiveFinishTaskReply(slot0)
	slot0:refreshRightUI()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.AddTaskActivityBonus)
	TaskDispatcher.runDelay(slot0.onTaskBonusAnimationDone, slot0, 0.833)
end

function slot0.onTaskBonusAnimationDone(slot0)
	slot0:refreshLeftUI()
	slot0:setTaskBonusY()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onTaskBonusAnimationDone, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.taskBonusItemList) do
		slot5:onDestroyView()
	end

	slot0._simagebg:UnLoadImage()
end

return slot0
