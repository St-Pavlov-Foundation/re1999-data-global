module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteRewardItem", package.seeall)

slot0 = class("ActivityQuoteRewardItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.imageIcon = gohelper.findChildSingleImage(slot0.go, "simage_icon")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rarebg")
	slot0.textCount = gohelper.findChildText(slot0.go, "txt_count")
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)

	if slot1.maxProgress <= slot1.progress then
		slot0.textCount.text = string.format("%s/%s", slot1.progress, slot1.maxProgress)
	else
		slot0.textCount.text = string.format("<color=#ff8949>%s</color>/%s", slot1.progress, slot1.maxProgress)
	end

	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, tonumber(slot1.listenerParam))

	UISpriteSetMgr.instance:setVersionActivityTrade_1_2Sprite(slot0.imageRare, "bg_wupindi_" .. tostring(slot2.rare and slot2.rare or 5))
	slot0.imageIcon:LoadImage(slot3)
end

function slot0.destory(slot0)
	slot0.imageIcon:UnLoadImage()
	slot0:__onDispose()
end

return slot0
