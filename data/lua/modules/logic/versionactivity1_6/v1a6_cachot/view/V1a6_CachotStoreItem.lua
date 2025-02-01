module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreItem", package.seeall)

slot0 = class("V1a6_CachotStoreItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtname = gohelper.findChildTextMesh(slot1, "txt_name")
	slot0._txtcost = gohelper.findChildTextMesh(slot1, "txt_cost")
	slot0._gosoldout = gohelper.findChild(slot1, "go_soldout")
	slot0._simageicon = gohelper.findChildSingleImage(slot1, "simage_icon")
	slot0._imageicon = gohelper.findChildImage(slot1, "image_icon")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "btn_click")
	slot0._goenchantlist = gohelper.findChild(slot1, "go_enchantlist")
	slot0._gohole = gohelper.findChild(slot1, "go_enchantlist/go_hole")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClickItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._simageicon, false)
	gohelper.setActive(slot0._goenchantlist, false)

	slot0._imageicon.enabled = false

	if lua_rogue_goods.configDict[slot1.id].creator ~= 0 then
		gohelper.setActive(slot0._simageicon, true)

		if not lua_rogue_collection.configDict[slot2.creator] then
			logError("商店出售不存在的藏品" .. slot2.creator)

			return
		end

		slot0._txtname.text = slot3.name

		slot0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot3.icon))
		gohelper.setActive(slot0._goenchantlist, true)
		V1a6_CachotCollectionHelper.createCollectionHoles(slot3, slot0._goenchantlist, slot0._gohole)
	elseif slot2.event ~= 0 then
		slot0._imageicon.enabled = true

		if V1a6_CachotEventConfig.instance:getDescCoByEventId(slot2.event) then
			slot0._txtname.text = slot3.title

			UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageicon, slot3.icon)
		else
			logError("未处理事件 " .. slot2.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. slot2.id)
	end

	slot0._txtcost.text = slot2.price

	gohelper.setActive(slot0._gosoldout, slot1.buyCount > 0)
end

function slot0._onClickItem(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_CachotNormalStoreGoodsView, lua_rogue_goods.configDict[slot0._mo.id])
end

function slot0.onDestroy(slot0)
	if slot0._simageicon then
		slot0._simageicon:UnLoadImage()
	end
end

return slot0
