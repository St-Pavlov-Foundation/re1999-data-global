module("modules.logic.seasonver.act123.controller.Season123EquipBookController", package.seeall)

slot0 = class("Season123EquipBookController", BaseController)

function slot0.changeSelect(slot0, slot1)
	Season123EquipBookModel.instance:setCurSelectItemId(slot1)
	Season123EquipBookModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123Event.OnEquipBookItemChangeSelect)
end

function slot0.setSelectTag(slot0, slot1)
	if Season123EquipBookModel.instance.tagModel then
		Season123EquipBookModel.instance.tagModel:selectTagIndex(slot1)
		slot0:handleItemChange()
	end
end

function slot0.handleItemChange(slot0)
	Season123EquipBookModel.instance:initList()
	Season123EquipBookModel.instance:setCurSelectItemId(Season123EquipBookModel.instance.curSelectItemId)

	if not Season123EquipBookModel.instance.curSelectItemId then
		Season123EquipBookModel.instance:selectFirstCard()
	end

	Season123EquipBookModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123Event.OnRefleshEquipBookView)
end

function slot0.onCloseView(slot0)
	Season123EquipBookModel.instance:flushRecord()
	Season123EquipBookModel.instance:clear()
	Season123DecomposeModel.instance:release()
	Season123DecomposeModel.instance:clear()
end

function slot0.openBatchDecomposeView(slot0, slot1)
	Season123DecomposeModel.instance:initDatas(slot1)
	Season123ViewHelper.openView(slot1, "BatchDecomposeView", {
		actId = slot1
	})
end

function slot0.clearItemSelectState(slot0)
	Season123DecomposeModel.instance:clearCurSelectItem()
	slot0:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
end

slot0.instance = slot0.New()

return slot0
