module("modules.logic.story.view.StoryLogView", package.seeall)

slot0 = class("StoryLogView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_close")
	slot0._scrolllog = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_log")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	StoryLogListModel.instance:setLogList(StoryModel.instance:getLog())

	slot0._scrolllog.verticalNormalizedPosition = 0
end

function slot0.onClose(slot0)
	AudioEffectMgr.instance:stopAudio(StoryLogListModel.instance:getPlayingLogAudioId(), 0)
end

function slot0.onDestroyView(slot0)
end

return slot0
