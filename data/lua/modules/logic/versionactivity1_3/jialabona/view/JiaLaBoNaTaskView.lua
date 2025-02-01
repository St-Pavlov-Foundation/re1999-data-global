module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaTaskView", package.seeall)

slot0 = class("JiaLaBoNaTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_mission_fullbg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
end

function slot0._oneClaimReward(slot0)
	Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
end

function slot0._onFinishTask(slot0, slot1)
	if Activity120TaskListModel.instance:getById(slot1) then
		Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
