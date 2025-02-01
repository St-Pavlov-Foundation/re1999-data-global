module("modules.logic.store.view.StoreRoomTreeItem", package.seeall)

slot0 = class("StoreRoomTreeItem", TreeScrollCell)

function slot0.ctor(slot0)
	slot0._rootIndex = nil
	slot0._nodeIndex = nil
	slot0._go = nil
	slot0._view = nil
	slot0._isRoot = nil
	slot0._isNode = nil
	slot0.nodeItemList = {}
	slot0._firstUpdate = true
	slot0._animationStartTime = 0
	slot0.openduration = 0.6
	slot0.closeduration = 0.3
end

function slot0.initRoot(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1._go = gohelper.findChild(slot0._go, "root")
	slot1._gomain = gohelper.findChild(slot1._go, "#go_main")
	slot1._simagebg = gohelper.findChildSingleImage(slot1._go, "#go_main/#simage_bg")
	slot1._simageicon = gohelper.findChildSingleImage(slot1._go, "#go_main/#simage_icon")
	slot1._simagemask = gohelper.findChildSingleImage(slot1._go, "#go_main/#simage_mask")
	slot1._simagetitle = gohelper.findChildSingleImage(slot1._go, "#go_main/#simage_title")
	slot1._txttitle = gohelper.findChildText(slot1._go, "#go_main/left/#txt_title")
	slot1._gotheme = gohelper.findChild(slot1._go, "#go_main/left/#txt_title/#go_theme")
	slot1._txttype = gohelper.findChildText(slot1._go, "#go_main/left/#txt_title/#go_theme/#txt_type")
	slot1._goclicktype = gohelper.findChild(slot1._go, "#go_main/left/#txt_title/#go_theme/clickArea")
	slot1._gotag = gohelper.findChild(slot1._go, "#go_main/left/#txt_title/#go_Tag")
	slot1._txttag = gohelper.findChildText(slot1._go, "#go_main/left/#txt_title/#go_Tag/#txt_Tag")
	slot1._txtdesc = gohelper.findChildText(slot1._go, "#go_main/left/#txt_desc")
	slot1._txthuolinum = gohelper.findChildText(slot1._go, "#go_main/left/info/huoli/#txt_huolinum")
	slot1._txtblocknum = gohelper.findChildText(slot1._go, "#go_main/left/info/dikuai/#txt_dikuainum")
	slot1._btnbuy = gohelper.findChildButtonWithAudio(slot1._go, "#go_main/right/#btn_buy")
	slot1._txtcost1num = gohelper.findChildText(slot1._go, "#go_main/right/#btn_buy/bg/cost1/#txt_cost1num")
	slot1._imagecost1num = gohelper.findChildImage(slot1._go, "#go_main/right/#btn_buy/bg/cost1/icon")
	slot1._txtcost2num = gohelper.findChildText(slot1._go, "#go_main/right/#btn_buy/bg/cost2/#txt_cost2num")
	slot1._imagecost2num = gohelper.findChildImage(slot1._go, "#go_main/right/#btn_buy/bg/cost2/icon")
	slot1._godiscount = gohelper.findChild(slot1._go, "#go_main/right/#go_discount")
	slot1._golimit = gohelper.findChild(slot1._go, "#go_main/right/#go_limit")
	slot1._gohas = gohelper.findChild(slot1._go, "#go_main/right/#go_has")
	slot1._txtdiscount = gohelper.findChildText(slot1._go, "#go_main/right/#go_discount/bg/label/#txt_discount")
	slot1._goempty = gohelper.findChild(slot1._go, "#go_empty")
	slot0.root = slot1

	slot0.root._simagebg:LoadImage(ResUrl.getStoreWildness("img_taozhuang_bg"))
	slot0.root._simagetitle:LoadImage(ResUrl.getStoreWildness("img_deco_1"))
	slot0.root._simagemask:LoadImage(ResUrl.getStoreWildness("mask"))

	slot1._gonewtag = gohelper.findChild(slot1._go, "#go_main/#go_newtag")
	slot1._goremaintime = gohelper.findChild(slot1._go, "#go_main/#go_remaintime")
	slot1._txtremiantime = gohelper.findChildText(slot1._go, "#go_main/#go_remaintime/#txt_remaintime")
	slot0._animator = slot0._go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.initNode(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1._go = gohelper.findChild(slot0._go, "node")
	slot1._simagedetailbg = gohelper.findChildSingleImage(slot1._go, "#simage_detailbg")
	slot1._content = gohelper.findChild(slot1._go, "content")
	slot0.node = slot1
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0.root then
		if slot0.root._click then
			slot0.root._click:RemoveClickListener()
		end

		if slot0.root._clickType then
			slot0.root._clickType:RemoveClickListener()
		end

		slot0.root._btnbuy:RemoveClickListener()
		slot0.root._simagebg:UnLoadImage()
		slot0.root._simageicon:UnLoadImage()
		slot0.root._simagemask:UnLoadImage()
		slot0.root._simagetitle:UnLoadImage()
	end

	if next(slot0.nodeItemList) then
		for slot4, slot5 in ipairs(slot0.nodeItemList) do
			slot5.good:onDestroy()
		end

		slot0.nodeItemList = nil
	end
end

function slot0._onClick(slot0)
	if slot0._view:isExpand(slot0._rootIndex) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

		if slot0.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = false,
				index = slot0._rootIndex,
				itemHeight = recthelper.getHeight(slot0._go.transform)
			})
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)

		if slot0.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = true,
				index = slot0._rootIndex,
				itemHeight = recthelper.getHeight(slot0._go.transform)
			})
		end
	end

	slot0.root._mo:setNewRedDotKey()
end

function slot0._onBuyBtn(slot0, slot1)
	if slot1 then
		StoreController.instance:openNormalGoodsView(slot1)
	else
		logError("没找到rootmo")
	end

	slot0.root._mo:setNewRedDotKey()
	slot0:refreshNewTag()
end

function slot0._onClickType(slot0)
	if slot0.themeId then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = slot0.themeId
		})
	end

	slot0.root._mo:setNewRedDotKey()
	slot0:refreshNewTag()
end

function slot0._findThemeId(slot0, slot1)
	if not slot1 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if RoomConfig.instance:getThemeIdByItem(slot7[2], slot7[1]) then
			return slot8
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.refreshNewTag(slot0)
	slot1 = slot0.root._mo:checkShowNewRedDot()

	gohelper.setActive(slot0.root._gonewtag, slot1)

	if slot1 then
		recthelper.setAnchorX(slot0.root._txtremiantime.transform, -8)
	else
		recthelper.setAnchorX(slot0.root._txtremiantime.transform, -40)
	end
end

function slot0.onUpdateRootMO(slot0, slot1)
	slot2 = slot1.update

	if slot1.type and slot1.type == 0 then
		gohelper.setActive(slot0.root._gomain, false)
		gohelper.setActive(slot0.root._goempty, true)

		if slot0.root._click then
			slot0.root._click:RemoveClickListener()
		end

		if slot1.update then
			slot0._animationStartTime = Time.time
		end

		slot0:_refreshOpenAnimation()

		slot1.update = false
	else
		gohelper.setActive(slot0.root._gomain, true)
		gohelper.setActive(slot0.root._goempty, false)

		slot0.has = false
		slot0.root._mo = slot1

		gohelper.setActive(slot0.root._btnbuy.gameObject, true)
		gohelper.setActive(slot0.root._gohas, false)
		slot0.root._btnbuy:AddClickListener(slot0._onBuyBtn, slot0, slot0.root._mo)

		slot0.root._click = SLFramework.UGUI.UIClickListener.Get(slot0.root._go)
		slot0.root._clickType = SLFramework.UGUI.UIClickListener.Get(slot0.root._goclicktype)

		slot0.root._click:AddClickListener(slot0._onClick, slot0)
		slot0.root._clickType:AddClickListener(slot0._onClickType, slot0)

		slot3 = StoreConfig.instance:getGoodsConfig(slot1.goodsId)
		slot5 = GameUtil.splitString2(slot3.product, true)

		slot0.root._simageicon:LoadImage(slot3.bigImg)

		slot0.root._txttitle.text = string.format("「%s」", slot1.goodscn)
		slot0.root._txtdesc.text = GameUtil.splitString2(slot3.name)[1][2]

		if string.nilorempty(slot3.cost) then
			slot0.root._txtcost1num.text = luaLang("store_free")

			gohelper.setActive(slot0.root._imagecost1num.gameObject, false)
		else
			slot10 = string.splitToNumber(string.split(slot7, "|")[slot1.buyCount + 1] or slot8[#slot8], "#")
			slot0.cost1Quantity = slot10[3]
			slot13, slot14 = ItemModel.instance:getItemConfigAndIcon(slot10[1], slot10[2])

			UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.root._imagecost1num, string.format("%s_1", slot13.icon))
			gohelper.setActive(slot0.root._imagecost1num.gameObject, true)

			slot0.root._txtcost1num.text = slot0.cost1Quantity
		end

		if string.nilorempty(slot3.cost2) then
			gohelper.setActive(slot0.root._imagecost2num.gameObject, false)
		else
			slot11 = string.splitToNumber(string.split(slot8, "|")[slot1.buyCount + 1] or slot9[#slot9], "#")
			slot0.cost2Quantity = slot11[3]
			slot14, slot15 = ItemModel.instance:getItemConfigAndIcon(slot11[1], slot11[2])

			UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.root._imagecost2num, string.format("%s_1", slot14.icon))
			gohelper.setActive(slot0.root._imagecost2num.gameObject, true)

			slot0.root._txtcost2num.text = slot0.cost2Quantity
		end

		gohelper.setActive(slot0.root._godiscount, slot1.config.originalCost > 0)

		if not string.nilorempty(slot0.cost2Quantity) then
			slot0.root._txtdiscount.text = string.format("-%d%%", 100 - math.ceil(slot0.cost2Quantity / slot1.config.originalCost * 100))
		end

		slot10 = 0

		for slot14, slot15 in ipairs(slot5) do
			slot0.itemType = slot15[1]
			slot0.itemId = slot15[2]
			slot0.itemNum = slot15[3]

			if slot0.itemType == MaterialEnum.MaterialType.BlockPackage then
				if slot0.itemId and slot0.itemNum then
					slot9 = 0 + RoomConfig.instance:getBlockPackageFullDegree(slot0.itemId) * slot0.itemNum
					slot16 = RoomConfig.instance:getBlockListByPackageId(slot0.itemId) or {}

					for slot20 = 1, #slot16 do
						if slot16[slot20].ownType ~= RoomBlockEnum.OwnType.Special or RoomModel.instance:isHasBlockById(slot21.blockId) then
							slot10 = slot10 + 1
						end
					end

					if slot10 < 1 and #slot16 >= 1 then
						slot10 = 1
					end
				else
					logError("不存在值")
				end
			elseif slot0.itemType == MaterialEnum.MaterialType.Building then
				if slot0.itemId and slot0.itemNum then
					slot9 = slot9 + RoomConfig.instance:getBuildingConfig(slot0.itemId).buildDegree * slot0.itemNum
				else
					logError("不存在值")
				end
			end
		end

		slot0.root._txthuolinum.text = slot9
		slot0.root._txtblocknum.text = slot10
		slot11 = slot0:checkChildCanJump(slot1)

		gohelper.setActive(slot0.root._gotheme, not slot11)
		gohelper.setActive(slot0.root._gotag, slot11)
		gohelper.setActive(slot0.root._golimit, slot11)
		gohelper.setActive(slot0.root._btnbuy.gameObject, not slot11)

		if not slot11 then
			slot0.themeId = slot0:_findThemeId(slot5)

			gohelper.setActive(slot0.root._txttype.gameObject, slot0.themeId ~= nil)
			gohelper.setActive(slot0.root._goclicktype, slot0.themeId ~= nil)
		end

		slot0.has = slot1:alreadyHas()

		if slot0.has then
			gohelper.setActive(slot0.root._btnbuy.gameObject, false)
			gohelper.setActive(slot0.root._gohas, true)
			gohelper.setActive(slot0.root._golimit, false)
		end

		slot12 = slot1:checkShowNewRedDot()

		gohelper.setActive(slot0.root._gonewtag, slot12)

		if slot12 then
			recthelper.setAnchorX(slot0.root._txtremiantime.transform, -8)
		else
			recthelper.setAnchorX(slot0.root._txtremiantime.transform, -40)
		end

		slot13 = slot1:getOfflineTime()

		gohelper.setActive(slot0.root._goremaintime, slot13 > 0)

		if slot13 - ServerTime.now() > 3600 then
			slot15, slot16 = TimeUtil.secondToRoughTime(slot14)
			slot0.root._txtremiantime.text = formatLuaLang("remain", slot15 .. slot16)
		else
			slot0.root._txtremiantime.text = luaLang("not_enough_one_hour")
		end
	end

	if slot2 then
		slot0._animationStartTime = Time.time
	end

	if not slot1.isjump then
		slot0:_refreshOpenAnimation()
	end
end

function slot0.onUpdateNodeMO(slot0, slot1)
	slot0.node._simagedetailbg:LoadImage(ResUrl.getStoreWildness("img_zhankai_bg"))

	if next(slot0.nodeItemList) and slot0.nodeItemList.index ~= slot1.rootindex then
		for slot5, slot6 in ipairs(slot0.nodeItemList) do
			slot6.good:onDestroy()
		end

		gohelper.destroyAllChildren(slot0.node._content)

		slot0.nodeItemList = {}
	end

	if #slot0.nodeItemList ~= #slot1 then
		for slot5, slot6 in ipairs(slot0.nodeItemList) do
			slot6.good:onDestroy()
		end

		gohelper.destroyAllChildren(slot0.node._content)

		slot0.nodeItemList = {}
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot0.nodeItemList[slot5] == nil then
			slot7 = {
				parent = slot0.node._content
			}
			slot8 = slot0._view:getResInst("ui/viewres/store/normalstoregoodsitem.prefab", slot7.parent, "roomNode" .. slot5)
			slot7.good = MonoHelper.addNoUpdateLuaComOnceToGo(slot8, NormalStoreGoodsItem)

			slot7.good:hideOffflineTime()
			slot7.good:init(slot8)

			slot0.nodeItemList[slot5] = slot7
			slot0.nodeItemList.index = slot1.rootindex
		end

		slot7.good:onUpdateMO(slot6)
		gohelper.setActive(slot7.go, true)
	end
end

function slot0._refreshOpenAnimation(slot0)
	if not slot0._animator or not slot0._animator.gameObject.activeInHierarchy then
		return
	end

	slot1 = slot0:_getAnimationTime()
	slot0._animator.speed = 1

	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	slot0._animator:Update(0)

	if slot0._animator:GetCurrentAnimatorStateInfo(0).length <= 0 then
		slot3 = 1
	end

	slot0._animator:Play(UIAnimationName.Open, 0, (Time.time - slot1) / slot3)
	slot0._animator:Update(0)
end

function slot0._getAnimationTime(slot0)
	if not slot0._animationStartTime then
		return nil
	end

	return slot0._animationStartTime + 0.1 * slot0._rootIndex
end

function slot0.checkChildCanJump(slot0, slot1)
	if slot1.children and #slot1.children > 0 then
		for slot5, slot6 in ipairs(slot1.children) do
			if slot6.config.jumpId ~= 0 then
				return true
			end
		end
	end

	return false
end

return slot0
