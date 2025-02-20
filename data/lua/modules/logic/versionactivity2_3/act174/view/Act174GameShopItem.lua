module("modules.logic.versionactivity2_3.act174.view.Act174GameShopItem", package.seeall)

slot0 = class("Act174GameShopItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.anim = slot1:GetComponent(gohelper.Type_Animator)
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
	slot0.txtCost = gohelper.findChildText(slot1, "btn_Buy/txt_Cost")
	slot5 = "go_SellOut"
	slot0.goSoldOut = gohelper.findChild(slot1, slot5)

	for slot5 = 1, 7 do
		slot0["goType" .. slot5] = gohelper.findChild(slot1, "type" .. slot5)
	end

	slot0.roleItemList = {}

	for slot5 = 1, 3 do
		for slot9 = 1, slot5 do
			slot10 = gohelper.findChild(slot0["goType" .. slot5], "role" .. slot9)
			slot11 = slot0:getUserDataTb_()
			slot11.imageRare = gohelper.findChildImage(slot10, "rare")
			slot11.heroIcon = gohelper.findChildSingleImage(slot10, "heroicon")
			slot11.imageCareer = gohelper.findChildImage(slot10, "career")
			slot0.roleItemList[#slot0.roleItemList + 1] = slot11
		end
	end

	slot0.roleCareerList = {}

	for slot5 = 4, 7 do
		for slot9 = 1, 3 do
			slot0.roleCareerList[#slot0.roleCareerList + 1] = gohelper.findChildImage(gohelper.findChild(slot0["goType" .. slot5], slot9), "career")
		end
	end

	slot0.collectionRare = gohelper.findChildImage(slot0.goType4, "collection/rare")
	slot0.collectionIcon = gohelper.findChildSingleImage(slot0.goType4, "collection/collectionicon")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeClickCb(slot0.btnClick)
end

function slot0.onDestroy(slot0)
	slot0.collectionIcon:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.roleItemList) do
		slot5.heroIcon:UnLoadImage()
	end
end

function slot0.setData(slot0, slot1)
	slot0.goodInfo = slot1

	if slot1 then
		slot0.actId = Activity174Model.instance:getCurActId()
		slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
		slot0.type = slot0:inferBagType()

		slot0:refreshCost()
		table.sort(slot1.bagInfo.heroId, uv0.sortFunc)

		if slot0.type == 1 then
			slot0:refreshRoleItem(slot0.roleItemList[1], slot2[1])
		elseif slot0.type == 2 then
			slot0:refreshRoleItem(slot0.roleItemList[2], slot2[1])
			slot0:refreshRoleItem(slot0.roleItemList[3], slot2[2])
		elseif slot0.type == 3 then
			slot0:refreshRoleItem(slot0.roleItemList[4], slot2[1])
			slot0:refreshRoleItem(slot0.roleItemList[5], slot2[2])
			slot0:refreshRoleItem(slot0.roleItemList[6], slot2[3])
		elseif slot0.type == 4 then
			slot5 = lua_activity174_collection.configDict[slot1.bagInfo.itemId[1]]

			UISpriteSetMgr.instance:setAct174Sprite(slot0.collectionRare, "act174_propitembg_" .. slot5.rare)
			slot0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot5.icon))
		elseif slot0.type == 5 then
			slot0:refreshRoleCareer(slot0.roleCareerList[1], slot2[1])
		elseif slot0.type == 6 then
			slot0:refreshRoleCareer(slot0.roleCareerList[2], slot2[1])
			slot0:refreshRoleCareer(slot0.roleCareerList[3], slot2[2])
		elseif slot0.type == 7 then
			slot0:refreshRoleCareer(slot0.roleCareerList[4], slot2[1])
			slot0:refreshRoleCareer(slot0.roleCareerList[5], slot2[2])
			slot0:refreshRoleCareer(slot0.roleCareerList[6], slot2[3])
		end

		for slot6 = 1, 7 do
			gohelper.setActive(slot0["goType" .. slot6], slot6 == slot0.type)
		end
	end

	gohelper.setActive(slot0.go, slot1)
end

function slot0.refreshCost(slot0)
	slot1 = "#211F1F"

	if slot0.gameInfo.coin < slot0.goodInfo.buyCost then
		slot1 = "#be4343"
	end

	gohelper.setActive(slot0.goSoldOut, slot0.goodInfo.finish)
	SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, slot1)

	slot0.txtCost.text = slot2
end

function slot0.onClick(slot0)
	if slot0.goodInfo.finish then
		return
	end

	if slot0.type == 4 then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(slot0.goodInfo.bagInfo.itemId[1]),
			pos = Vector2.New(518, 0),
			showMask = true,
			goodInfo = slot0.goodInfo
		})
	elseif slot0.type == 1 or slot0.type == 2 or slot0.type == 3 then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Character1,
			co = slot0.goodInfo.bagInfo.heroId,
			pos = Vector2.New(479, 0),
			showMask = true,
			goodInfo = slot0.goodInfo
		})
	elseif slot0.type == 5 or slot0.type == 6 or slot0.type == 7 then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Character2,
			co = lua_activity174_bag.configDict[slot0.goodInfo.bagInfo.bagId],
			pos = Vector2.New(518, 0),
			showMask = true,
			goodInfo = slot0.goodInfo
		})
	end
end

function slot0.inferBagType(slot0)
	if lua_activity174_bag.configDict[slot0.goodInfo.bagInfo.bagId].type == Activity174Enum.BagType.Hero then
		if slot2.heroType == "quality" then
			return #slot1.heroId + 4
		end

		return #slot1.heroId
	elseif slot2.type == Activity174Enum.BagType.Collection then
		return 4
	end
end

function slot0.refreshRoleItem(slot0, slot1, slot2)
	slot3 = Activity174Config.instance:getRoleCo(slot2)

	slot1.heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot3.skinId))
	UISpriteSetMgr.instance:setCommonSprite(slot1.imageRare, "bgequip" .. tostring(CharacterEnum.Color[slot3.rare]))
	UISpriteSetMgr.instance:setCommonSprite(slot1.imageCareer, "lssx_" .. slot3.career)
end

function slot0.refreshRoleCareer(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setCommonSprite(slot1, "lssx_" .. Activity174Config.instance:getRoleCo(slot2).career)
end

function slot0.sortFunc(slot0, slot1)
	if Activity174Config.instance:getRoleCo(slot0).rare == Activity174Config.instance:getRoleCo(slot1).rare then
		return slot1 < slot0
	else
		return slot3.rare < slot2.rare
	end
end

return slot0
