module("modules.logic.main.view.MainThumbnailBannerContent", package.seeall)

slot0 = class("MainThumbnailBannerContent", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1.go
	slot0._config = slot1.config
	slot0._index = slot1.index

	transformhelper.setLocalPos(slot0._go.transform, slot1.pos, 0, 0)
end

function slot0.loadBanner(slot0)
	if slot0._isLoadedBanner then
		return
	end

	slot0._isLoadedBanner = true
	slot0._simagebanner = gohelper.findChildSingleImage(slot0._go, "#simage_banner")
	slot0._txtdesc = gohelper.findChildText(slot0._go, "#txt_des")

	slot0._simagebanner:LoadImage(ResUrl.getAdventureTaskLangPath(slot0._config.res))

	slot0._txtdesc.text = slot0._config.des
end

function slot0.updateItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._index == slot1 or slot0._index - slot1 == 1 then
		slot0:loadBanner()
	end
end

function slot0.destroy(slot0)
	if slot0._simagebanner then
		slot0._simagebanner:UnLoadImage()
	end
end

return slot0
