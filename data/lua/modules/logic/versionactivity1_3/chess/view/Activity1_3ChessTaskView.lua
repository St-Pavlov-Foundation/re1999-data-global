module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskView", package.seeall)

slot0 = class("Activity1_3ChessTaskView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_TaskList/Viewport/Content")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnnotfinishbgOnClick(slot0)
end

function slot0._btnfinishbgOnClick(slot0)
end

function slot0._btngetallOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_mission_fullbg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, slot0._onGotoTaskEpisode, slot0)
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function slot0._oneClaimReward(slot0)
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function slot0._onFinishTask(slot0, slot1)
	if Activity122TaskListModel.instance:getById(slot1) then
		Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
	end
end

function slot0._onGotoTaskEpisode(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
