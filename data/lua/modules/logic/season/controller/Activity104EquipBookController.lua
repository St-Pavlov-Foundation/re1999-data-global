module("modules.logic.season.controller.Activity104EquipBookController", package.seeall)

slot0 = class("Activity104EquipBookController", BaseController)

function slot0.onOpenView(slot0, slot1)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104EquipItemBookModel.instance:initDatas(slot1)
end

function slot0.onCloseView(slot0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104EquipItemBookModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemBookModel.instance:clear()
end

function slot0.changeSelect(slot0, slot1)
	Activity104EquipItemBookModel.instance:setSelectItemId(slot1)
	Activity104EquipItemBookModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104Event.OnBookChangeSelectNotify)
end

function slot0.handleItemChanged(slot0)
	Activity104EquipItemBookModel.instance:initList()
	Activity104EquipItemBookModel.instance:setSelectItemId(Activity104EquipItemBookModel.instance.curSelectItemId)
	slot0:notifyUpdateView()
end

function slot0.notifyUpdateView(slot0)
	Activity104EquipItemBookModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104Event.OnBookUpdateNotify)
end

function slot0.setSelectTag(slot0, slot1)
	if Activity104EquipItemBookModel.instance.tagModel then
		Activity104EquipItemBookModel.instance.tagModel:selectTagIndex(slot1)
		slot0:handleItemChanged()
	end
end

function slot0.getFilterModel(slot0)
	return Activity104EquipItemBookModel.instance.tagModel
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
