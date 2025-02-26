module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordView", package.seeall)

slot0 = class("AiZiLaRecordView", BaseView)

function slot0.onInitView(slot0)
	slot0._goLeftTabContent = gohelper.findChild(slot0.viewGO, "scroll_Left/Viewport/#go_LeftTabContent")
	slot0._goLeftTabItem = gohelper.findChild(slot0.viewGO, "#go_LeftTabItem")
	slot0._goRecordItem = gohelper.findChild(slot0.viewGO, "#go_RecordItem")
	slot0._scrollRight = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Right")
	slot0._goRightItemContent = gohelper.findChild(slot0.viewGO, "#scroll_Right/Viewport/#go_RightItemContent")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "#go_Arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goLeftTabItem, false)
	gohelper.setActive(slot0._goRecordItem, false)
	slot0._scrollRight:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.UISelectRecordTabItem, slot0._onSelectRecordTabItem, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot0._recordMOList = {}
	slot3 = AiZiLaModel.instance
	slot4 = slot3

	tabletool.addValues(slot0._recordMOList, slot3.getRecordMOList(slot4))

	slot0._selectRecordMO = slot0._recordMOList[1]

	for slot4, slot5 in ipairs(slot0._recordMOList) do
		if slot5:isUnLock() then
			slot0._selectRecordMO = slot5

			break
		end
	end

	slot0._initSelectRecordMO = slot0._selectRecordMO

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper4)
end

function slot0.onClose(slot0)
	slot0:_finishRed(slot0._initSelectRecordMO)
end

function slot0.onDestroyView(slot0)
	slot0._scrollRight:RemoveOnValueChanged()
end

function slot0._getSelectGroupMOList(slot0)
	return slot0._selectRecordMO and slot0._selectRecordMO:getRroupMOList()
end

function slot0._onSelectRecordTabItem(slot0, slot1)
	if not slot1 or slot0._selectRecordMO and slot0._selectRecordMO.id == slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0._recordMOList) do
		if slot6.id == slot1 then
			slot0._selectRecordMO = slot6

			slot0:refreshUI()
			slot0:_finishRed(slot6)

			return
		end
	end
end

function slot0._onScrollValueChanged(slot0, slot1)
	slot2 = gohelper.getRemindFourNumberFloat(slot0._scrollRight.verticalNormalizedPosition) > 0

	gohelper.setActive(slot0._goArrow, slot2)

	if not slot2 then
		slot0:_finishRed(slot0._selectRecordMO)
	end
end

function slot0.refreshUI(slot0)
	gohelper.CreateObjList(slot0, slot0._onRecordTabItem, slot0._recordMOList, slot0._goLeftTabContent, slot0._goLeftTabItem, AiZiLaRecordTabItem)
	slot0:_refreshRecordUI()
end

function slot0._refreshRecordUI(slot0)
	slot1 = {}

	tabletool.addValues(slot1, slot0:_getSelectGroupMOList())
	gohelper.CreateObjList(slot0, slot0._onRecordItem, slot1, slot0._goRightItemContent, slot0._goRecordItem, AiZiLaRecordItem)
end

function slot0._onRecordTabItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:onSelect(slot0._selectRecordMO and slot2 and slot0._selectRecordMO.id == slot2.id)
end

function slot0._onRecordItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
end

function slot0._finishRed(slot0, slot1)
	if slot1 and slot1:isHasRed() then
		slot1:finishRed()
		AiZiLaModel.instance:checkRecordRed()
	end
end

return slot0
