module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateTaskView", package.seeall)

slot0 = class("EliminateTaskView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.UpdateTask, slot0.refreshRight, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now())
end

function slot0.refreshRight(slot0)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()
	EliminateTaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
