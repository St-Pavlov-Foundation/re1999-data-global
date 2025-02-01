module("modules.logic.main.view.MainThumbnailBannerSelectItem", package.seeall)

slot0 = class("MainThumbnailBannerSelectItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1.go
	slot0._pageIndex = slot1.index
	slot0._normalGo = gohelper.findChild(slot0._go, "#go_nomalstar")
	slot0._selectedGo = gohelper.findChild(slot0._go, "#go_lightstar")

	transformhelper.setLocalPos(slot0._go.transform, slot1.pos, 0, 0)
end

function slot0.updateItem(slot0, slot1, slot2)
	slot3 = slot0._pageIndex == slot1

	gohelper.setActive(slot0._selectedGo, slot3 and slot2 > 1)
	gohelper.setActive(slot0._normalGo, not slot3 and slot2 > 1)
end

function slot0.destroy(slot0)
end

return slot0
