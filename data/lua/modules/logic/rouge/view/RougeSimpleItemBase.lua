module("modules.logic.rouge.view.RougeSimpleItemBase", package.seeall)

slot0 = class("RougeSimpleItemBase", ListScrollCellExtend)
slot1 = table.insert
slot2 = ZProj.UGUIHelper

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._staticData = {}

	if slot1 then
		slot0._staticData.baseViewContainer = slot1.baseViewContainer
		slot0._staticData.parent = slot1.parent
	end
end

function slot0.init(slot0, ...)
	uv0.super.init(slot0, ...)
	slot0:addEventListeners()
end

function slot0.onInitView(slot0)
	slot0:_editableInitView()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setData(slot1)
end

function slot0.parent(slot0)
	return slot0._staticData.parent
end

function slot0.baseViewContainer(slot0)
	return slot0._staticData.baseViewContainer
end

function slot0._assetGetViewContainer(slot0)
	return assert(slot0:baseViewContainer(), "please assign baseViewContainer by ctorParam on ctor")
end

function slot0._assetGetParent(slot0)
	return assert(slot0:parent(), "please assign parent by ctorParam on ctor")
end

function slot0.regEvent(slot0, slot1, slot2, slot3)
	if not slot0._parent then
		logWarn("regEvent")

		return
	end

	slot0:_assetGetViewContainer():registerCallback(slot1, slot2, slot3)
end

function slot0.unregEvent(slot0, slot1, slot2, slot3)
	if not slot0._parent then
		logWarn("unregEvent")

		return
	end

	slot0:_assetGetViewContainer():unregisterCallback(slot1, slot2, slot3)
end

function slot0.dispatchEvent(slot0, slot1, ...)
	if not slot0:baseViewContainer() then
		return
	end

	slot2:dispatchEvent(slot1, ...)
end

function slot0.isSelected(slot0)
	return slot0._staticData.isSelected
end

function slot0.setSelected(slot0, slot1)
	if slot0:isSelected() == slot1 then
		return
	end

	slot0:onSelect(slot1)
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.index(slot0)
	return slot0._index
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.posX(slot0)
	return recthelper.getAnchorX(slot0._trans)
end

function slot0.posY(slot0)
	return recthelper.getAnchorY(slot0._trans)
end

function slot0.transform(slot0)
	return slot0._trans
end

function slot0.setAsLastSibling(slot0)
	slot0._trans:SetAsLastSibling()
end

function slot0.setAsFirstSibling(slot0)
	slot0._trans:SetAsFirstSibling()
end

function slot0.setSiblingIndex(slot0, slot1)
	slot0._trans:SetSiblingIndex(slot1)
end

function slot0._onSetScrollParentGameObject(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	if not slot0:baseViewContainer() then
		return
	end

	if gohelper.isNil(slot2:getScrollViewGo()) then
		return
	end

	slot1.parentGameObject = slot3
end

function slot0._fillUserDataTb(slot0, slot1, slot2, slot3)
	while not gohelper.isNil(slot0[slot1 .. 1]) do
		if slot2 then
			uv0(slot2, slot5.gameObject)
		end

		if slot3 then
			uv0(slot3, slot5)
		end

		slot5 = slot0[slot1 .. slot4 + 1]
	end
end

function slot0._editableInitView(slot0)
	slot0._trans = slot0.viewGO.transform
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
end

function slot0.refresh(slot0)
	slot0:onUpdateMO(slot0._mo)
end

function slot0.onDestroyView(slot0)
	slot0:removeEventListeners()
	uv0.super.onDestroyView(slot0)
end

function slot0.setGrayscale(slot0, slot1, slot2)
	uv0.SetGrayscale(slot1, slot2)
end

return slot0
