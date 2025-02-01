module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsView", package.seeall)

slot0 = class("V1a6_CachotNormalStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "root/propinfo/#simage_icon")
	slot0._imageiconbg = gohelper.findChildImage(slot0.viewGO, "root/propinfo/#image_iconbg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/propinfo/#image_icon")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "root/propinfo/scroll_info/Viewport/Content/#txt_goodsUseDesc")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "root/propinfo/#txt_goodsNameCn")
	slot0._txtorginalcost = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_buy")
	slot0._goenchantlist = gohelper.findChild(slot0.viewGO, "root/propinfo/#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.viewGO, "root/propinfo/#go_enchantlist/#go_hole")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnBuy:AddClickListener(slot0.onBuyClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
end

slot1 = "#6F3C0F"
slot2 = "#2B4E6C"

function slot0.onOpen(slot0)
	slot0._enoughCoin = slot0.viewParam.price <= V1a6_CachotModel.instance:getRogueInfo().coin

	if slot2 < slot1.price then
		slot0._txtorginalcost.text = string.format("<color=#BF2E11>%s</color>", slot1.price)
	else
		slot0._txtorginalcost.text = slot1.price
	end

	gohelper.setActive(slot0._simageicon, false)
	gohelper.setActive(slot0._goenchantlist, false)

	slot0._imageicon.enabled = false

	if slot1.creator ~= 0 then
		gohelper.setActive(slot0._simageicon, true)
		gohelper.setActive(slot0._goenchantlist, true)

		slot3 = lua_rogue_collection.configDict[slot1.creator]
		slot0._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(slot3, nil, uv0, uv1)
		slot0._txtname.text = slot3.name

		slot0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot3.icon))
		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageiconbg, lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1].iconbg)
		V1a6_CachotCollectionHelper.createCollectionHoles(slot3, slot0._goenchantlist, slot0._gohole)
	elseif slot1.event ~= 0 then
		slot0._imageicon.enabled = true
		slot3, slot4 = V1a6_CachotEventConfig.instance:getDescCoByEventId(slot1.event)

		if slot3 then
			slot0._txtname.text = slot3.title
			slot0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(slot4 or slot3.desc, uv0, uv1)

			UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageicon, slot3.icon)
			UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageiconbg, slot3.iconbg)
		else
			logError("未处理事件 " .. slot1.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. slot1.id)
	end
end

function slot0.onBuyClick(slot0)
	if not slot0._enoughCoin then
		GameFacade.showToast(ToastEnum.V1a6CachotToast09)

		return
	end

	RogueRpc.instance:sendBuyRogueGoodsRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.id, 1, slot0.closeThis, slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
