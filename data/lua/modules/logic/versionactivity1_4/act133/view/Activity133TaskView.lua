module("modules.logic.versionactivity1_4.act133.view.Activity133TaskView", package.seeall)

slot0 = class("Activity133TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "main/#simage_bg")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "main/#scroll_view")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "main/#scroll_view/Viewport/Content/#go_taskitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._initTaskMoList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._initTaskMoList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._initTaskMoList, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0.onDailyRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._initTaskMoList, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._initTaskMoList, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._initTaskMoList, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0.onDailyRefresh, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId[1]

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
	slot0:_initTaskMoList()
end

function slot0._initTaskMoList(slot0)
	Activity133TaskListModel.instance:sortTaskMoList()
end

function slot0.onDailyRefresh(slot0)
	Activity133Rpc.instance:sendGet133InfosRequest(VersionActivity1_4Enum.ActivityId.ShipRepair, slot0._initTaskMoList, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
