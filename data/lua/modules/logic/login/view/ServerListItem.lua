module("modules.logic.login.view.ServerListItem", package.seeall)

slot0 = class("ServerListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._serverStateGOList = {}

	for slot5 = 0, 2 do
		slot0._serverStateGOList[slot5] = gohelper.findChild(slot1, "imgState" .. slot5)
	end

	slot0._txtServerName = gohelper.findChildText(slot1, "Text")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtServerName.text = slot0._mo.name

	for slot5 = 0, 2 do
		gohelper.setActive(slot0._serverStateGOList[slot5], slot5 == slot0._mo.state)
	end
end

function slot0._onClick(slot0)
	LoginController.instance:dispatchEvent(LoginEvent.SelectServerItem, slot0._mo)
	slot0._view:closeThis()
end

return slot0
