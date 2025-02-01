module("modules.logic.rouge.view.RougeItemNodeBase", package.seeall)

slot0 = class("RougeItemNodeBase", UserDataDispose)
slot1 = table.insert

function slot0.ctor(slot0, slot1)
	assert(isTypeOf(slot1, RougeSimpleItemBase), "[RougeItemNodeBase] ctor failed: parent must inherited from RougeSimpleItemBase type(parent)=" .. (slot1.__cname or "nil"))
	slot0:__onInit()

	slot0._parent = slot1
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEventListeners()
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.staticData(slot0)
	if not slot0._parent then
		return
	end

	return slot0._parent._staticData
end

function slot0.parent(slot0)
	return slot0._parent
end

function slot0.baseViewContainer(slot0)
	if not slot0:staticData() then
		return
	end

	return slot1.baseViewContainer
end

function slot0.dispatchEvent(slot0, slot1, ...)
	if not slot0._parent then
		logWarn("dispatchEvent")

		return
	end

	if not slot0:baseViewContainer() then
		return
	end

	slot2:dispatchEvent(slot1, ...)
end

function slot0.index(slot0)
	if not slot0._parent then
		return
	end

	return slot0._parent:index()
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.posX(slot0)
	if not slot0._parent then
		return
	end

	return slot0._parent:posX()
end

function slot0.posY(slot0)
	if not slot0._parent then
		return
	end

	return slot0._parent:posY()
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

function slot0.onUpdateMO(slot0, slot1)
	slot0:setData(slot1)
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.onDestroyView(slot0)
	slot0:removeEventListeners()
	slot0:__onDispose()
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
end

return slot0
