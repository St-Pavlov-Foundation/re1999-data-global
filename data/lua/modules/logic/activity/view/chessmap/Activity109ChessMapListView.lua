module("modules.logic.activity.view.chessmap.Activity109ChessMapListView", package.seeall)

slot0 = class("Activity109ChessMapListView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/barqiandao_bj_009"))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0._btntaskOnClick(slot0)
	slot1 = Activity109ChessModel.instance:getActId()
	slot2 = Activity109ChessModel.instance:getMapId()
	slot3 = Activity109ChessModel.instance:getEpisodeId()

	Activity109ChessController.instance:startNewEpisode(1)
end

return slot0
