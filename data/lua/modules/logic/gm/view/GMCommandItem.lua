module("modules.logic.gm.view.GMCommandItem", package.seeall)

slot0 = class("GMCommandItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._mo = nil
	slot0._itemClick = SLFramework.UGUI.UIClickListener.Get(slot1)

	slot0._itemClick:AddClickListener(slot0._onClickItem, slot0)

	slot0._selectGO = gohelper.findChild(slot1, "imgSelect")
	slot0._txtName = gohelper.findChildText(slot1, "txtName")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtName.text = slot0._mo.id .. ". " .. slot0._mo.name
end

function slot0.onSelect(slot0, slot1)
	slot0._hasSelected = slot1

	gohelper.setActive(slot0._selectGO, slot1)
end

function slot0._onClickItem(slot0)
	GMController.instance:dispatchEvent(GMCommandView.ClickItem, slot0._mo)

	if slot0._hasSelected then
		GMController.instance:dispatchEvent(GMCommandView.ClickItemAgain, slot0._mo)
	end

	slot0._view:setSelect(slot0._mo)
end

function slot0.onDestroy(slot0)
	if slot0._itemClick then
		slot0._itemClick:RemoveClickListener()

		slot0._itemClick = nil
	end
end

return slot0
