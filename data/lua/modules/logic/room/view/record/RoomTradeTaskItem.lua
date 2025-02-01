module("modules.logic.room.view.record.RoomTradeTaskItem", package.seeall)

slot0 = class("RoomTradeTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txttask = gohelper.findChildText(slot0.viewGO, "#txt_task")
	slot0._gofinish1 = gohelper.findChild(slot0.viewGO, "#txt_task/#go_finish1")
	slot0._txttaskprogress = gohelper.findChildText(slot0.viewGO, "#txt_taskprogress")
	slot0._gofinish2 = gohelper.findChild(slot0.viewGO, "#go_finish2")
	slot0._gojump = gohelper.findChild(slot0.viewGO, "#go_jump")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_jump/#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	if slot0._mo then
		RoomJumpController.instance:jumpFormTaskView(slot0._mo.co.jumpId)
	end
end

function slot0._editableInitView(slot0)
	slot0._txtLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0._txttask, " ")
end

function slot0.activeGo(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

slot1 = {
	offest = 50,
	height = 100,
	descWidthMax = 556,
	progressWidthMax = 300,
	spacing = 10,
	width = 662
}

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot1 then
		if slot1.co then
			slot2 = slot1.co.desc
			slot7 = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("room_trade_progress"), slot1.co.maxProgress <= slot1.progress and "#000000" or "#A75A29", slot3, slot4)

			slot0:_setItemHeight(slot2, slot7)

			slot0._txttask.text = slot2
			slot0._txttaskprogress.text = slot7
		end

		slot0:_refreshFinish()
	end
end

function slot0._setItemHeight(slot0, slot1, slot2)
	slot3 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txttask, slot1)
	slot4 = 100

	if not slot0._mo.hasFinish then
		slot4 = math.min(SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txttaskprogress, slot2), uv0.progressWidthMax)
	end

	slot5 = slot0._txtLineHeight
	slot6 = uv0.width - slot4

	recthelper.setWidth(slot0._txttask.transform, slot6)

	if slot6 < slot3 then
		slot5 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0._txttask, slot1)
	end

	recthelper.setWidth(slot0._txttaskprogress.transform, slot4)
	recthelper.setHeight(slot0._txttaskprogress.transform, slot0._txtLineHeight)
	recthelper.setHeight(slot0._txttask.transform, slot5)
	recthelper.setHeight(slot0.viewGO.transform, slot5 + uv0.offest)
end

function slot0.getNextItemAnchorY(slot0, slot1)
	slot1 = slot1 < 0 and slot1 + uv0.spacing or -uv0.spacing

	recthelper.setAnchorY(slot0.viewGO.transform, slot1)

	return slot1 - recthelper.getHeight(slot0.viewGO.transform)
end

function slot0._refreshFinish(slot0)
	if slot0._mo.hasFinish then
		if slot0._mo.new then
			slot0:playFinishAnim()
		else
			slot0:_activeFinishTask(true)
		end
	else
		slot0:_activeFinishTask(false)
	end
end

function slot0.playFinishAnim(slot0)
	slot0:_activeFinishTask(true)
end

function slot0._activeFinishTask(slot0, slot1)
	for slot5 = 1, 2 do
		gohelper.setActive(slot0["_gofinish" .. slot5], slot1)
	end

	slot2 = slot0._txttask.color
	slot0._txttask.color = Color(slot2.r, slot2.b, slot2.g, slot1 and 0.5 or 1)

	UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot1 and "room_task_point2" or "room_task_point1")
	gohelper.setActive(slot0._txttaskprogress.gameObject, not slot1)
	gohelper.setActive(slot0._gojump.gameObject, not string.nilorempty(slot0._mo.co.jumpId) and not slot1)
end

return slot0
