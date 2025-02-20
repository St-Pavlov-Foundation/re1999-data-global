module("modules.logic.gm.view.GMAddItemView", package.seeall)

slot0 = class("GMAddItemView", BaseView)
slot0.LevelType = "人物等级"
slot0.HeroAttr = "英雄提升"
slot0.ClickItem = "ClickItem"
slot0.Return = "Return"

function slot0.ctor(slot0)
	slot0._allItems = nil
	slot0._itemListView = nil
	slot0._rootType = nil
	slot0.RootTypes = {
		{
			name = "物品",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Item
		},
		{
			name = "装备",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Equip
		},
		{
			name = "货币",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Currency
		},
		{
			name = "体力药",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PowerPotion
		},
		{
			numTips = "目标等级",
			name = "人物等级",
			isRoot = 0,
			type = uv0.LevelType
		},
		{
			numTips = "增加经验值",
			name = "人物经验",
			isRoot = 0,
			type = MaterialEnum.MaterialType.Exp
		},
		{
			name = "英雄",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Hero
		},
		{
			name = "英雄提升",
			isRoot = 1,
			type = uv0.HeroAttr
		},
		{
			name = "英雄皮肤",
			isRoot = 1,
			type = MaterialEnum.MaterialType.HeroSkin
		},
		{
			name = "英雄信赖值",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Faith
		},
		{
			name = "主角技能",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PlayerCloth
		},
		{
			name = "主角技能经验",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PlayerClothExp
		},
		{
			name = "小屋建筑",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Building
		},
		{
			name = "小屋配方",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Formula
		},
		{
			name = "地块包",
			isRoot = 1,
			type = MaterialEnum.MaterialType.BlockPackage
		}
	}
end

function slot0._checkBuildItems(slot0)
	function slot1(slot0, slot1, slot2, slot3)
		for slot7 = 1, #slot1 do
			slot8 = slot1[slot7]

			table.insert(slot0, {
				itemId = slot8.id,
				itemIdStr = tostring(slot8.id),
				type = slot2,
				name = slot8.name,
				rare = slot8.rare,
				numTips = slot3
			})
		end
	end

	if slot0._allItems == nil then
		slot0._allItems = {}

		table.insert(slot0._allItems, {
			itemId = 0,
			name = "ALL",
			numTips = "<size=25>等级#洞悉#共鸣#塑造</size>",
			itemIdStr = "0",
			rare = 5,
			type = uv0.HeroAttr
		})
		slot1(slot0._allItems, lua_item.configList, MaterialEnum.MaterialType.Item, "物品数量")
		slot1(slot0._allItems, lua_equip.configList, MaterialEnum.MaterialType.Equip, "装备数量")
		slot1(slot0._allItems, lua_currency.configList, MaterialEnum.MaterialType.Currency, "货币数量")
		slot1(slot0._allItems, lua_power_item.configList, MaterialEnum.MaterialType.PowerPotion, "体力药数量")
		slot1(slot0._allItems, lua_character.configList, MaterialEnum.MaterialType.Hero, "英雄数量")
		slot1(slot0._allItems, lua_skin.configList, MaterialEnum.MaterialType.HeroSkin, "英雄服装数量")
		slot1(slot0._allItems, lua_character.configList, MaterialEnum.MaterialType.Faith, "增加英雄信赖值")
		slot1(slot0._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerCloth, "服装数量")
		slot1(slot0._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerClothExp, "增加服装经验值")
		slot1(slot0._allItems, lua_room_building.configList, MaterialEnum.MaterialType.Building, "1")
		slot1(slot0._allItems, lua_formula.configList, MaterialEnum.MaterialType.Formula, "1")
		slot1(slot0._allItems, lua_character.configList, uv0.HeroAttr, "<size=25>等级#洞悉#共鸣#塑造</size>")
		slot1(slot0._allItems, lua_block_package.configList, MaterialEnum.MaterialType.BlockPackage, "数量（不用填）")
	end
end

function slot0.onInitView(slot0)
	slot0._maskGO = gohelper.findChild(slot0.viewGO, "addItem")
	slot0._inpItem = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item2/inpItem")
	slot0._txtNumPlaceholder = gohelper.findChildText(slot0.viewGO, "viewport/content/item2/inpNum/Placeholder")

	slot0:_hideScroll()
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._inpItem.gameObject):AddClickListener(slot0._onClickInpItem, slot0, nil)
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):AddClickListener(slot0._onClickMask, slot0, nil)
	slot0._inpItem:AddOnValueChanged(slot0._onInpValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):RemoveClickListener()
	slot0._inpItem:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	GMController.instance:registerCallback(uv0.ClickItem, slot0._onClickItem, slot0)
	GMController.instance:registerCallback(uv0.Return, slot0._onClickReturn, slot0)
end

function slot0.onClose(slot0)
	GMController.instance:unregisterCallback(uv0.ClickItem, slot0._onClickItem, slot0)
	GMController.instance:unregisterCallback(uv0.Return, slot0._onClickReturn, slot0)
end

function slot0._onClickInpItem(slot0)
	slot0:_showScroll()
end

function slot0._onClickMask(slot0)
	slot0:_hideScroll()
end

function slot0._showScroll(slot0)
	gohelper.setActive(slot0._maskGO, true)
	slot0:_checkBuildItems()

	slot0._rootType = nil

	slot0:_showDefaultItems()
end

function slot0._hideScroll(slot0)
	gohelper.setActive(slot0._maskGO, false)

	slot0._rootType = nil

	GMAddItemModel.instance:clear()
end

function slot0._onClickItem(slot0, slot1)
	if slot1.isRoot == 1 then
		slot0._rootType = slot1.type

		slot0:_showTargetItems()
	else
		slot0._inpItem:SetText(slot1.type .. "#" .. (slot1.itemIdStr or ""))
		slot0:_hideScroll()
	end

	slot0._txtNumPlaceholder.text = string.nilorempty(slot1.numTips) and "Num" or slot1.numTips
end

function slot0._onClickReturn(slot0, slot1)
	slot0._rootType = nil

	slot0:_showDefaultItems()
end

function slot0._onInpValueChanged(slot0, slot1)
	slot0._rootType = nil

	if string.nilorempty(slot1) then
		slot0:_showDefaultItems()
	else
		slot0:_showTargetItems()
	end
end

function slot0._showDefaultItems(slot0)
	GMAddItemModel.instance:setList(slot0.RootTypes)
end

function slot0._showTargetItems(slot0)
	if not slot0._allItems then
		return
	end

	if slot0._rootType then
		slot1 = 2
		slot6 = {
			id = 1,
			name = "返回",
			type = 0
		}

		table.insert({}, slot6)

		for slot6 = 1, #slot0._allItems do
			if slot0._allItems[slot6].type == slot0._rootType then
				slot7.id = slot1
				slot1 = slot1 + 1

				table.insert(slot2, slot7)
			end
		end

		GMAddItemModel.instance:setList(slot2)
	elseif not string.nilorempty(slot0._inpItem:GetText()) then
		slot2 = 1
		slot3 = {}

		for slot7 = 1, #slot0._allItems do
			if string.find(slot0._allItems[slot7].name, slot1) or string.find(slot8.itemIdStr, slot1) then
				slot8.id = slot2
				slot2 = slot2 + 1

				table.insert(slot3, slot8)
			end
		end

		GMAddItemModel.instance:setList(slot3)
	else
		GMAddItemModel.instance:setList(slot0.RootTypes)
	end
end

return slot0
