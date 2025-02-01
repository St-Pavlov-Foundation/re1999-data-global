module("modules.logic.task.view.TaskNoviceActItem", package.seeall)

slot0 = class("TaskNoviceActItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._tag = slot2
	slot0._gounselect = gohelper.findChild(slot1, "unselected")
	slot0._gounselecticon = gohelper.findChild(slot1, "unselected/icon")
	slot0._gounselectlock = gohelper.findChild(slot1, "unselected/lock")
	slot0._txtunselectTitle = gohelper.findChildText(slot0._gounselect, "act")
	slot0._goselect = gohelper.findChild(slot1, "selected")
	slot0._goselecticon = gohelper.findChild(slot1, "selected/icon")
	slot0._goselectlock = gohelper.findChild(slot1, "selected/lock")
	slot0._txtselectTitle = gohelper.findChildText(slot0._goselect, "act")
	slot0._btnClick = gohelper.getClickWithAudio(gohelper.findChild(slot1, "click"))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._goselected, false)
	gohelper.setActive(slot0._gounselected, false)
	slot0._btnClick:AddClickListener(slot0._btnActItemOnClick, slot0)
	TaskController.instance:registerCallback(TaskEvent.RefreshActState, slot0._refreshItem, slot0)
	slot0:_refreshItem()
end

function slot0._btnActItemOnClick(slot0)
	if slot0._tag == TaskModel.instance:getNoviceTaskCurSelectStage() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_act)

	if slot0._tag <= TaskModel.instance:getNoviceTaskMaxUnlockStage() then
		TaskModel.instance:setNoviceTaskCurStage(slot0._tag)
	end

	TaskModel.instance:setNoviceTaskCurSelectStage(slot0._tag)
	TaskModel.instance:setRefreshCount(TaskModel.instance:getRefreshCount() + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, {
		isActClick = true
	})
	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, {
		num = 0,
		taskType = TaskEnum.TaskType.Novice,
		force = slot0._tag <= slot1
	})
end

function slot0._refreshItem(slot0, slot1)
	slot2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	slot3 = TaskModel.instance:getNoviceTaskCurStage()

	gohelper.setActive(slot0._goselect, TaskModel.instance:getNoviceTaskCurSelectStage() == slot0._tag)
	gohelper.setActive(slot0._gounselect, slot4 ~= slot0._tag)
	gohelper.setActive(slot0._goselectlock, slot2 < slot0._tag)
	gohelper.setActive(slot0._gounselectlock, slot2 < slot0._tag)
	gohelper.setActive(slot0._goselecticon, slot0._tag == slot2)
	gohelper.setActive(slot0._gounselecticon, slot0._tag == slot2)

	slot0._txtunselectTitle.text = "Act." .. tostring(slot0._tag)
	slot0._txtselectTitle.text = "Act." .. tostring(slot0._tag)

	ZProj.UGUIHelper.SetColorAlpha(slot0._txtunselectTitle, slot2 < slot0._tag and 0.6 or 0.7)
end

function slot0.destroy(slot0)
	gohelper.destroy(slot0.go)
	slot0._btnClick:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, slot0._refreshItem, slot0)
end

return slot0
