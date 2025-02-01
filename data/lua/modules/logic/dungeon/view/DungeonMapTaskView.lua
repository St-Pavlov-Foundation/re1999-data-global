module("modules.logic.dungeon.view.DungeonMapTaskView", package.seeall)

slot0 = class("DungeonMapTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._gotasklist = gohelper.findChild(slot0.viewGO, "#go_tasklist")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_taskitem")
	slot0._txtopen = gohelper.findChildText(slot0.viewGO, "#go_tipbg/#txt_open")
	slot0._gotipsbg = gohelper.findChild(slot0.viewGO, "#go_tipbg")

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
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickGuidepost)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	slot1 = slot0.viewParam.viewParam

	slot0:_showTaskList(slot1)

	slot3 = lua_episode.configDict[DungeonConfig.instance:getUnlockEpisodeId(slot1)]
	slot4 = DungeonConfig.instance:getChapterCO(slot3.chapterId)

	if slot3 and slot4 then
		slot5 = slot4.chapterIndex
		slot6, slot7 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot4.id, slot3.id)

		if slot7 == DungeonEnum.EpisodeType.Sp then
			slot5 = "SP"
		end

		slot8 = string.format("%s-%s", slot5, slot6)
		slot0._txtopen.text = string.format(lua_language_coder.configDict.dungeonmaptaskview_open.lang)
	end
end

function slot0._showTaskList(slot0, slot1)
	slot3 = string.splitToNumber(DungeonConfig.instance:getElementList(slot1), "#")
	slot0._listCount = #slot3

	for slot7, slot8 in ipairs(slot3) do
		slot10 = MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._gotaskitem), DungeonMapTaskItem)

		slot10:setParam({
			slot7,
			slot8
		})
		gohelper.setActive(slot10.viewGO, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return slot0
