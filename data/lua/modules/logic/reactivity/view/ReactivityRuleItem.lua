module("modules.logic.reactivity.view.ReactivityRuleItem", package.seeall)

slot0 = class("ReactivityRuleItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.reward1 = slot0:createReward(gohelper.findChild(slot1, "#reward1"))
	slot0.reward2 = slot0:createReward(gohelper.findChild(slot1, "#reward2"))
end

function slot0.createReward(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.imageBg = gohelper.findChildImage(slot1, "image_bg")
	slot2.simageReward = gohelper.findChildSingleImage(slot1, "simage_reward")
	slot2.imageCircle = gohelper.findChildImage(slot1, "image_circle")
	slot2.txtCount = gohelper.findChildTextMesh(slot1, "txt_rewardcount")
	slot2.btn = gohelper.findButtonWithAudio(slot1)

	slot2.btn:AddClickListener(uv0.onClickItem, slot2)

	return slot2
end

function slot0.onClickItem(slot0)
	if not slot0.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0.data.type, slot0.data.id, false)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = string.splitToNumber(slot1.price, "#")

	slot0:updateReward(slot0.reward1, {
		quantity = 1,
		type = slot1.typeId,
		id = slot1.itemId
	})
	slot0:updateReward(slot0.reward2, {
		type = slot3[1],
		id = slot3[2],
		quantity = slot3[3]
	})
end

function slot0.updateReward(slot0, slot1, slot2)
	slot1.data = slot2
	slot1.txtCount.text = string.format("<size=25>×</size>%s", slot2.quantity)
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2.type, slot2.id)

	slot1.simageReward:LoadImage(slot4)
	UISpriteSetMgr.instance:setUiFBSprite(slot1.imageBg, "bg_pinjidi_" .. slot3.rare)
	UISpriteSetMgr.instance:setUiFBSprite(slot1.imageCircle, "bg_pinjidi_lanse_" .. slot3.rare)
end

function slot0.destoryReward(slot0, slot1)
	slot1.simageReward:UnLoadImage()
	slot1.btn:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0:destoryReward(slot0.reward1)
	slot0:destoryReward(slot0.reward2)
end

return slot0
