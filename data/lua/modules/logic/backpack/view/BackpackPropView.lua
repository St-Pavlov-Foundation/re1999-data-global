module("modules.logic.backpack.view.BackpackPropView", package.seeall)

slot0 = class("BackpackPropView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0._updateItemList, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = BackpackModel.instance:getCurCategoryId() or ItemEnum.CategoryType.Material

	slot0.viewContainer:setCurrentSelectCategoryId(slot1)
	BackpackPropListModel.instance:setCategoryPropItemList(BackpackModel.instance:getCategoryItemlist(slot1))
end

function slot0._updateItemList(slot0)
	slot0._itemList = BackpackModel.instance:getBackpackList()

	BackpackModel.instance:setBackpackItemList(slot0._itemList)
	slot0:onOpen()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._updateItemList, slot0)
end

return slot0
