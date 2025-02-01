module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskView", package.seeall)

slot0 = class("VersionActivityPushBoxTaskView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_heroicon")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tasklist")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_hero")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btnclose2OnClick, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, slot0._onReceiveTaskRewardReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:_showTaskList()
	slot0._simageheroicon:LoadImage(ResUrl.getVersionActivityIcon("pushbox/img_lihui_rw"))
	slot0._simagebg2:LoadImage(ResUrl.getVersionActivityIcon("pushbox/bg_rwdi2"))
end

function slot0._showTaskList(slot0)
	slot0._task_list = PushBoxEpisodeConfig.instance:getTaskList()

	PushBoxTaskListModel.instance:initData(slot0._task_list)
	PushBoxTaskListModel.instance:sortData()
	PushBoxTaskListModel.instance:refreshData()
	gohelper.addChild(slot0.viewGO, slot0._gotaskitem)
	gohelper.setActive(slot0._gotaskitem, false)
	TaskDispatcher.runDelay(slot0._showTaskItem, slot0, 0.2)
end

function slot0._showTaskItem(slot0)
	slot0:com_createObjList(slot0._onItemShow, PushBoxTaskListModel.instance.data, gohelper.findChild(slot0.viewGO, "#scroll_tasklist/Viewport/Content"), slot0._gotaskitem, nil, 0.1)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	if not slot0._item_list then
		slot0._item_list = {}
	end

	slot4 = false

	if not slot0._item_list[slot3] then
		slot4 = true
		slot0._item_list[slot3] = slot0:openSubView(PushBoxTaskItem, slot1)
	end

	slot0._item_list[slot3]:_refreshData(slot2)

	if slot4 then
		slot0._item_list[slot3]:playOpenAni(slot3)
	end
end

function slot0._onReceiveTaskRewardReply(slot0)
	slot0:_showTaskList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showTaskItem, slot0, 0.2)

	slot0._item_list = nil

	PushBoxTaskListModel.instance:clearData()
end

function slot0.onDestroyView(slot0)
	slot0._simageheroicon:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
