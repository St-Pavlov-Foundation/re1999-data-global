module("modules.logic.seasonver.act123.view2_3.Season123_2_3RecordWindow", package.seeall)

slot0 = class("Season123_2_3RecordWindow", BaseView)
slot1 = 5
slot2 = 0.06
slot3 = 0.2

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gobestrecorditem = gohelper.findChild(slot0.viewGO, "#go_bestrecorditem")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_recordlist/Viewport/Content")
	slot0._gorecorditem = gohelper.findChild(slot0.viewGO, "#scroll_recordlist/Viewport/Content/#go_recorditem")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")

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
	slot0:onClickModalMask()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorecorditem, false)
end

function slot0.onOpen(slot0)
	if Season123RecordModel.instance:getRecordList(true) and #slot1 > 0 then
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gobestrecorditem, Season123_2_3RecordWindowItem):onUpdateMO(slot1[1])
		gohelper.setActive(slot0._gobestrecorditem, true)
	else
		gohelper.setActive(slot0._gobestrecorditem, false)
	end

	if Season123RecordModel.instance:getRecordList(false) and #slot2 > 0 then
		gohelper.setActive(slot0._goempty, false)
		UIBlockMgr.instance:startBlock(slot0.viewName .. "itemPlayAnim")
		gohelper.CreateObjList(slot0, slot0._onRecordItemLoad, slot2, slot0._goContent, slot0._gorecorditem, Season123_2_3RecordWindowItem)
		TaskDispatcher.runDelay(slot0._onItemPlayAnimFinish, slot0, uv0 * uv1 + uv2)
	else
		gohelper.setActive(slot0._goempty, true)
	end
end

function slot0._onRecordItemLoad(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	slot4 = slot3
	slot5 = true

	if uv0 < slot3 then
		slot4 = uv0
		slot5 = false
	end

	if not slot2.isEmpty then
		slot1:onLoad(slot4 * uv1, slot5)
	end

	slot1:onUpdateMO(slot2)
end

function slot0._onItemPlayAnimFinish(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "itemPlayAnim")
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onItemPlayAnimFinish, slot0)
	slot0:_onItemPlayAnimFinish()
end

function slot0.onDestroyView(slot0)
end

return slot0
