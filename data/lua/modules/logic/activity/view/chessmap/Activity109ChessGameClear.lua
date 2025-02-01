module("modules.logic.activity.view.chessmap.Activity109ChessGameClear", package.seeall)

slot0 = class("Activity109ChessGameClear", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
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

return slot0
