module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaStoryView", package.seeall)

slot0 = class("LanShouPaStoryView", BaseView)

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
end

function slot0.onOpen(slot0)
	LanShouPaStoryListModel.instance:init(slot0.viewParam.actId, slot0.viewParam.episodeId)

	slot1 = Activity164Config.instance:getEpisodeCo(slot0.viewParam.actId, slot0.viewParam.episodeId)
	slot0._txtTitle.text = slot1 and slot1.name or ""
	slot0._txtTitleEn.text = string.format("STAGE %02d", tabletool.indexOf(Activity164Config.instance:getEpisodeCoList(slot0.viewParam.actId), slot1))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagePanelBG:UnLoadImage()
end

return slot0
