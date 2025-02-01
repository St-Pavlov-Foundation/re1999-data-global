module("modules.logic.rouge.view.RougeIllustrationListPage", package.seeall)

slot0 = class("RougeIllustrationListPage", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goList = slot0:getUserDataTb_()
	slot0._itemList = slot0:getUserDataTb_()

	for slot4 = 1, RougeEnum.IllustrationNumOfPage do
		slot0._goList[slot4] = gohelper.findChild(slot0.viewGO, tostring(slot4))
	end
end

function slot0._getItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot0._itemList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view.viewContainer:getResInst(slot0._view.viewContainer._viewSetting.otherRes[2], slot0._goList[slot1]), RougeIllustrationListItem)
	end

	return slot2
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0.viewGO, not slot1.isSplitSpace)

	if slot1.isSplitSpace then
		return
	end

	for slot5 = 1, RougeEnum.IllustrationNumOfPage do
		gohelper.setActive(slot0._goList[slot5], slot1[slot5] ~= nil)

		if slot6 then
			slot0:_getItem(slot5):onUpdateMO(slot6)
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
