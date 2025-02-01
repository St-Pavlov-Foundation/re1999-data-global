module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg")
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
	slot0._simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("v1a5_dungeonmaptask_tipbg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_showTaskList(slot0.viewParam.episodeId)

	slot0._txtopen.text = luaLang("v1a5_revival_task_finish_tip")
end

function slot0._showTaskList(slot0, slot1)
	if string.nilorempty(DungeonConfig.instance:getEpisodeCO(slot1).elementList) then
		return
	end

	slot4 = string.splitToNumber(slot3, "#")
	slot0._listCount = #slot4

	for slot8, slot9 in ipairs(slot4) do
		slot11 = MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._gotaskitem), VersionActivity1_5DungeonMapTaskItem)

		slot11:setParam({
			slot8,
			slot9
		})
		gohelper.setActive(slot11.viewGO, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
