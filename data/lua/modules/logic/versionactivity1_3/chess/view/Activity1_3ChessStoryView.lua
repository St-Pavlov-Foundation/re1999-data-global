module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryView", package.seeall)

slot0 = class("Activity1_3ChessStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title")
	slot0._scrollChapterList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_ChapterList")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._btncloseMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeMask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btncloseMask:AddClickListener(slot0._btncloseMaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btncloseMask:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title/txt_TitleEn")

	slot0._simagePanelBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_storybg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	Activity122StoryListModel.instance:init(slot0.viewParam.actId, slot0.viewParam.episodeId)

	slot0._txtTitle.text = Activity122Config.instance:getEpisodeCo(slot0.viewParam.actId, slot0.viewParam.episodeId) and slot1.name or ""
	slot0._txtTitleEn.text = slot1 and slot1.orderId or ""
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagePanelBG:UnLoadImage()
end

return slot0
