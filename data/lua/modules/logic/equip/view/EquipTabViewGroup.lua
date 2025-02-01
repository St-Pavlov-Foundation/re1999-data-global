module("modules.logic.equip.view.EquipTabViewGroup", package.seeall)

slot0 = class("EquipTabViewGroup", TabViewGroup)

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.playCloseAnimation(slot0)
	if slot0:_hasLoaded(slot0._curTabId) then
		if isTypeOf(slot0._tabViews[slot0._curTabId], MultiView) then
			slot1:callChildrenFunc("playCloseAnimation")
		else
			slot1:playCloseAnimation()
		end
	end
end

return slot0
