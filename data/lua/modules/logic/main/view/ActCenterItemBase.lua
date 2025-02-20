module("modules.logic.main.view.ActCenterItemBase", package.seeall)

slot0 = class("ActCenterItemBase", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0._imgitem = gohelper.findChildImage(slot1, "bg")
	slot0._btnitem = gohelper.findChildClick(slot1, "bg")
	slot0._goactivityreddot = gohelper.findChild(slot1, "go_activityreddot")
	slot0._txttheme = gohelper.findChildText(slot1, "txt_theme")
	slot0._godeadline = gohelper.findChild(slot1, "#go_deadline")
	slot0._txttime = gohelper.findChildText(slot1, "#go_deadline/#txt_time")
	slot0.go = slot1
	slot0._transform = slot1.transform

	slot0:onInit(slot1)
	slot0:_addEvent()
	gohelper.setActive(slot1, true)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvent()
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)
	slot0:onDestroy()
	slot0:__onDispose()
end

function slot0._addEvent(slot0)
	slot0._btnitem:AddClickListener(slot0.onClick, slot0)
	slot0:onAddEvent()
end

function slot0._removeEvent(slot0)
	slot0._btnitem:RemoveClickListener()
	slot0:onRemoveEvent()
end

function slot0._onOpen(slot0, ...)
	slot0:onOpen(...)
end

function slot0.refresh(slot0, ...)
	if not slot0.__isFirst then
		slot0:_onOpen(...)

		slot0.__isFirst = true
	end

	slot0:onRefresh(...)
end

function slot0._addNotEventRedDot(slot0, slot1, slot2)
	slot0._redDot = RedDotController.instance:addNotEventRedDot(slot0._goactivityreddot, slot1, slot2)
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot and slot0._redDot.isShowRedDot
end

function slot0._setMainSprite(slot0, slot1)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, slot1)
end

function slot0.setSiblingIndex(slot0, slot1)
	slot0._transform:SetSiblingIndex(slot1)
end

function slot0._refreshRedDot(slot0)
	if slot0._redDot then
		slot0._redDot:refreshRedDot()
	end
end

function slot0.setCustomData(slot0, slot1)
	slot0._data = slot1
end

function slot0.getCustomData(slot0)
	return slot0._data
end

function slot0.onInit(slot0, slot1)
end

function slot0.onDestroy(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onRefresh(slot0, ...)
	slot0:refreshRedDot()
end

function slot0.onAddEvent(slot0)
end

function slot0.onRemoveEvent(slot0)
end

function slot0.onClick(slot0)
	assert(false, "please override 'onClick' function!!")
end

return slot0
