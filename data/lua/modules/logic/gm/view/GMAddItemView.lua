module("modules.logic.gm.view.GMAddItemView", package.seeall)

local var_0_0 = class("GMAddItemView", BaseView)

var_0_0.LevelType = "人物等级"
var_0_0.HeroAttr = "英雄提升"
var_0_0.ClickItem = "ClickItem"
var_0_0.Return = "Return"

function var_0_0.ctor(arg_1_0)
	arg_1_0._allItems = nil
	arg_1_0._itemListView = nil
	arg_1_0._rootType = nil
	arg_1_0.RootTypes = {
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
			type = var_0_0.LevelType
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
			type = var_0_0.HeroAttr
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

function var_0_0._checkBuildItems(arg_2_0)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		for iter_3_0 = 1, #arg_3_1 do
			local var_3_0 = arg_3_1[iter_3_0]
			local var_3_1 = var_3_0.rare

			table.insert(arg_3_0, {
				itemId = var_3_0.id,
				itemIdStr = tostring(var_3_0.id),
				type = arg_3_2,
				name = var_3_0.name,
				rare = var_3_1,
				numTips = arg_3_3
			})
		end
	end

	if arg_2_0._allItems == nil then
		arg_2_0._allItems = {}

		local var_2_1 = {
			itemId = 0,
			name = "ALL",
			numTips = "<size=25>等级#洞悉#共鸣#塑造</size>",
			itemIdStr = "0",
			rare = 5,
			type = var_0_0.HeroAttr
		}

		table.insert(arg_2_0._allItems, var_2_1)
		var_2_0(arg_2_0._allItems, lua_item.configList, MaterialEnum.MaterialType.Item, "物品数量")
		var_2_0(arg_2_0._allItems, lua_equip.configList, MaterialEnum.MaterialType.Equip, "装备数量")
		var_2_0(arg_2_0._allItems, lua_currency.configList, MaterialEnum.MaterialType.Currency, "货币数量")
		var_2_0(arg_2_0._allItems, lua_power_item.configList, MaterialEnum.MaterialType.PowerPotion, "体力药数量")
		var_2_0(arg_2_0._allItems, lua_character.configList, MaterialEnum.MaterialType.Hero, "英雄数量")
		var_2_0(arg_2_0._allItems, lua_skin.configList, MaterialEnum.MaterialType.HeroSkin, "英雄服装数量")
		var_2_0(arg_2_0._allItems, lua_character.configList, MaterialEnum.MaterialType.Faith, "增加英雄信赖值")
		var_2_0(arg_2_0._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerCloth, "服装数量")
		var_2_0(arg_2_0._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerClothExp, "增加服装经验值")
		var_2_0(arg_2_0._allItems, lua_room_building.configList, MaterialEnum.MaterialType.Building, "1")
		var_2_0(arg_2_0._allItems, lua_formula.configList, MaterialEnum.MaterialType.Formula, "1")
		var_2_0(arg_2_0._allItems, lua_character.configList, var_0_0.HeroAttr, "<size=25>等级#洞悉#共鸣#塑造</size>")
		var_2_0(arg_2_0._allItems, lua_block_package.configList, MaterialEnum.MaterialType.BlockPackage, "数量（不用填）")
	end
end

function var_0_0.onInitView(arg_4_0)
	arg_4_0._maskGO = gohelper.findChild(arg_4_0.viewGO, "addItem")
	arg_4_0._inpItem = gohelper.findChildTextMeshInputField(arg_4_0.viewGO, "viewport/content/item2/inpItem")
	arg_4_0._txtNumPlaceholder = gohelper.findChildText(arg_4_0.viewGO, "viewport/content/item2/inpNum/Placeholder")

	arg_4_0:_hideScroll()
end

function var_0_0.addEvents(arg_5_0)
	SLFramework.UGUI.UIClickListener.Get(arg_5_0._inpItem.gameObject):AddClickListener(arg_5_0._onClickInpItem, arg_5_0, nil)
	SLFramework.UGUI.UIClickListener.Get(arg_5_0._maskGO):AddClickListener(arg_5_0._onClickMask, arg_5_0, nil)
	arg_5_0._inpItem:AddOnValueChanged(arg_5_0._onInpValueChanged, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	SLFramework.UGUI.UIClickListener.Get(arg_6_0._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_6_0._maskGO):RemoveClickListener()
	arg_6_0._inpItem:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_7_0)
	GMController.instance:registerCallback(var_0_0.ClickItem, arg_7_0._onClickItem, arg_7_0)
	GMController.instance:registerCallback(var_0_0.Return, arg_7_0._onClickReturn, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	GMController.instance:unregisterCallback(var_0_0.ClickItem, arg_8_0._onClickItem, arg_8_0)
	GMController.instance:unregisterCallback(var_0_0.Return, arg_8_0._onClickReturn, arg_8_0)
end

function var_0_0._onClickInpItem(arg_9_0)
	arg_9_0:_showScroll()
end

function var_0_0._onClickMask(arg_10_0)
	arg_10_0:_hideScroll()
end

function var_0_0._showScroll(arg_11_0)
	gohelper.setActive(arg_11_0._maskGO, true)
	arg_11_0:_checkBuildItems()

	arg_11_0._rootType = nil

	arg_11_0:_showDefaultItems()
end

function var_0_0._hideScroll(arg_12_0)
	gohelper.setActive(arg_12_0._maskGO, false)

	arg_12_0._rootType = nil

	GMAddItemModel.instance:clear()
end

function var_0_0._onClickItem(arg_13_0, arg_13_1)
	if not arg_13_1.type then
		return
	end

	if arg_13_1.isRoot == 1 then
		arg_13_0._rootType = arg_13_1.type

		arg_13_0:_showTargetItems()
	else
		arg_13_0._inpItem:SetText(arg_13_1.type .. "#" .. (arg_13_1.itemIdStr or ""))
		arg_13_0:_hideScroll()
	end

	arg_13_0._txtNumPlaceholder.text = string.nilorempty(arg_13_1.numTips) and "Num" or arg_13_1.numTips
end

function var_0_0._onClickReturn(arg_14_0, arg_14_1)
	arg_14_0._rootType = nil

	arg_14_0:_showDefaultItems()
end

function var_0_0._onInpValueChanged(arg_15_0, arg_15_1)
	arg_15_0._rootType = nil

	if string.nilorempty(arg_15_1) then
		arg_15_0:_showDefaultItems()
	else
		arg_15_0:_showTargetItems()
	end
end

function var_0_0._showDefaultItems(arg_16_0)
	GMAddItemModel.instance:setList(arg_16_0.RootTypes)
end

function var_0_0._showTargetItems(arg_17_0)
	if not arg_17_0._allItems then
		return
	end

	if arg_17_0._rootType then
		local var_17_0 = 2
		local var_17_1 = {}

		table.insert(var_17_1, {
			id = 1,
			name = "返回",
			type = 0
		})

		for iter_17_0 = 1, #arg_17_0._allItems do
			local var_17_2 = arg_17_0._allItems[iter_17_0]

			if var_17_2.type == arg_17_0._rootType then
				var_17_2.id = var_17_0
				var_17_0 = var_17_0 + 1

				table.insert(var_17_1, var_17_2)
			end
		end

		GMAddItemModel.instance:setList(var_17_1)
	else
		local var_17_3 = arg_17_0._inpItem:GetText()

		if not string.nilorempty(var_17_3) then
			local var_17_4 = 1
			local var_17_5 = {}

			for iter_17_1 = 1, #arg_17_0._allItems do
				local var_17_6 = arg_17_0._allItems[iter_17_1]

				if string.find(var_17_6.name, var_17_3) or string.find(var_17_6.itemIdStr, var_17_3) then
					var_17_6.id = var_17_4
					var_17_4 = var_17_4 + 1

					table.insert(var_17_5, var_17_6)
				end
			end

			GMAddItemModel.instance:setList(var_17_5)
		else
			GMAddItemModel.instance:setList(arg_17_0.RootTypes)
		end
	end
end

return var_0_0
