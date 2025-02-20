module("modules.logic.versionactivity1_4.act130.view.Activity130CollectView", package.seeall)

slot0 = class("Activity130CollectView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnCloseMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_CloseMask")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "BG/#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/txt_Title")
	slot0._goquestion = gohelper.findChild(slot0.viewGO, "Question")
	slot0._txtQuestion = gohelper.findChildText(slot0.viewGO, "Question/#txt_Question")
	slot0._scrollChapterList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_ChapterList")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_ChapterList/Viewport/Content")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "#go_Empty")
	slot0._txtEmpty = gohelper.findChildText(slot0.viewGO, "#go_Empty/#txt_Empty")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnCloseMask:AddClickListener(slot0._btnCloseMaskOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnCloseMask:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(ViewName.Activity130CollectView, slot0._btnCloseOnClick, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._collectItems = {}
	slot0._config = Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId())

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	gohelper.setActive(slot0._goquestion, Activity130Model.instance:getEpisodeOperGroupId(slot0._config.episodeId) ~= 0)

	if slot1 ~= 0 then
		slot0._txtQuestion.text = Activity130Config.instance:getActivity130DecryptCo(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getDecryptIdByGroupId(Activity130Model.instance:getEpisodeOperGroupId(slot0._config.episodeId))).puzzleTxt
	end

	if #Activity130Model.instance:getCollects(slot0._config.episodeId) < 1 then
		gohelper.setActive(slot0._goEmpty, true)
		gohelper.setActive(slot0._scrollChapterList.gameObject, false)

		slot3, slot4 = Activity130Model.instance:getEpisodeTaskTip(slot0._config.episodeId)

		if slot3 ~= 0 then
			slot0._txtEmpty.text = Activity130Config.instance:getActivity130DialogCo(slot3, slot4).content
		end

		return
	end

	gohelper.setActive(slot0._goEmpty, false)

	slot6 = true

	gohelper.setActive(slot0._scrollChapterList.gameObject, slot6)

	for slot6, slot7 in pairs(slot0._collectItems) do
		slot7:hideItems()
	end

	for slot6 = 1, #slot2 do
		if not slot0._collectItems[slot6] then
			slot8 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent, "item" .. tostring(slot6))
			slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot8, Activity130CollectItem)

			slot9:init(slot8)
			table.insert(slot0._collectItems, slot9)
		end

		slot0._collectItems[slot6]:setItem(Activity130Config.instance:getActivity130OperateGroupCos(VersionActivity1_4Enum.ActivityId.Role37, slot1)[slot2[slot6]], slot6)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
