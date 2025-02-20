module("modules.logic.room.view.topright.RoomViewTopRightBaseItem", package.seeall)

slot0 = class("RoomViewTopRightBaseItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._param = slot1
	slot0._parent = slot0._param.parent
	slot0._index = slot0._param.index
end

function slot0.init(slot0, slot1)
	slot0._bgType = 2
	slot0.go = slot1
	slot0._resourceItem = slot0:getUserDataTb_()
	slot0._resourceItem.go = slot0.go
	slot3 = slot0._resourceItem.go
	slot5 = slot3
	slot0._resourceItem.canvasGroup = slot3.GetComponent(slot5, typeof(UnityEngine.CanvasGroup))

	for slot5 = 1, 2 do
		gohelper.setActive(gohelper.findChild(slot0._resourceItem.go, "bg" .. slot5), slot5 == slot0._bgType)
	end

	slot0._resourceItem.txtquantity = gohelper.findChildText(slot0._resourceItem.go, "txt_quantity")
	slot0._resourceItem.txtaddNum = gohelper.findChildText(slot0._resourceItem.go, "txt_quantity/txt_addNum")
	slot0._resourceItem.btnclick = gohelper.findChildButtonWithAudio(slot0._resourceItem.go, "btn_click")
	slot0._resourceItem.goflypos = gohelper.findChild(slot0._resourceItem.go, "go_flypos")
	slot0._resourceItem.goeffect = gohelper.findChild(slot0._resourceItem.go, "go_flypos/#flyvx")

	slot0._resourceItem.btnclick:AddClickListener(slot0._onClick, slot0)
	gohelper.setActive(slot0._resourceItem.go, true)
	gohelper.setActive(slot0._resourceItem.goflypos, true)
	gohelper.setActive(slot0._resourceItem.goeffect, false)
	gohelper.setActive(slot0._resourceItem.txtaddNum, false)

	slot0._canvasGroup = slot0.go:GetComponent(typeof(UnityEngine.CanvasGroup))

	if slot0._customOnInit then
		slot0:_customOnInit()
	end

	slot0:_refreshUI()
end

function slot0._setShow(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)

	slot0._canvasGroup.alpha = slot1 and 1 or 0
	slot0._canvasGroup.blocksRaycasts = slot1
end

function slot0._customOnInit(slot0)
end

function slot0._onClick(slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._refreshUI(slot0)
end

function slot0.onDestroy(slot0)
	slot0._resourceItem.btnclick:RemoveClickListener()

	if slot0._customOnDestory then
		slot0:_customOnDestory()
	end
end

function slot0._customOnDestory(slot0)
end

return slot0
