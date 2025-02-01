module("modules.logic.versionactivity1_5.act142.view.Activity142StoryView", package.seeall)

slot0 = class("Activity142StoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollChapterList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_storylist")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_blackbg/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	Activity142StoryListModel.instance:init(slot0.viewParam.actId, slot0.viewParam.episodeId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
