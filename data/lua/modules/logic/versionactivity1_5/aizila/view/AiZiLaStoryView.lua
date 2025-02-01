module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryView", package.seeall)

slot0 = class("AiZiLaStoryView", BaseView)

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

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btnCloseOnClick, slot0)
	end

	slot0._episodeId = slot0.viewParam.episodeId
	slot0._actId = slot0.viewParam.actId
	slot0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(slot0._actId, slot0._episodeId)

	AiZiLaStoryListModel.instance:init(slot0._actId, slot0._episodeId)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagePanelBG:UnLoadImage()
end

function slot0.refreshUI(slot0)
	if slot0._episodeCfg then
		slot0._txtTitle.text = slot0._episodeCfg.name
		slot0._txtTitleEn.text = slot0._episodeCfg.nameen
	end
end

return slot0
