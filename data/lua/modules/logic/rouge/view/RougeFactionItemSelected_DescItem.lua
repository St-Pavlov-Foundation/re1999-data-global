module("modules.logic.rouge.view.RougeFactionItemSelected_DescItem", package.seeall)

slot0 = class("RougeFactionItemSelected_DescItem", UserDataDispose)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._parent = slot1
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.index(slot0)
	return slot0._index
end

function slot0._editableInitView(slot0)
	slot0._txt = gohelper.findChildText(slot0.viewGO, "")

	slot0:setData(nil)
end

function slot0.setData(slot0, slot1)
	slot0._txt.text = slot1 or ""

	slot0:setActive(not string.nilorempty(slot1))
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.onDestroyView(slot0)
	slot0:__onDispose()
end

return slot0
