module("modules.logic.room.view.gift.RoomBlockGiftThemeItem", package.seeall)

local var_0_0 = class("RoomBlockGiftThemeItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.gotitle = arg_1_1.gotitle
	arg_1_0.goBlockItem = arg_1_1.goBlockItem
	arg_1_0.goBuildingItem = arg_1_1.goBuildingItem
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.itemRoot = gohelper.findChild(arg_2_1, "item")

	local var_2_0 = gohelper.clone(arg_2_0.gotitle, arg_2_1)

	arg_2_0.txttitle = gohelper.findChildText(var_2_0, "#txt_styleName")
	arg_2_0.txttitleNum = gohelper.findChildText(var_2_0, "#txt_styleName/#txt_num")

	gohelper.setSibling(var_2_0, 0)
	gohelper.setActive(var_2_0, true)

	arg_2_0._gridlayout = arg_2_0.itemRoot:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, arg_3_0._refreshSelect, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, arg_4_0._refreshSelect, arg_4_0)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RoomConfig.instance:getThemeConfig(arg_5_1.themeId)

	arg_5_0.moList = arg_5_1.moList
	arg_5_0.subType = arg_5_2

	local var_5_1
	local var_5_2
	local var_5_3
	local var_5_4
	local var_5_5 = RoomBlockGiftEnum.SubTypeInfo[arg_5_2]
	local var_5_6 = var_5_5.CellSize[1]
	local var_5_7 = var_5_5.CellSize[2]
	local var_5_8 = var_5_5.CellSpacing[1] - 15
	local var_5_9 = var_5_5.CellSpacing[2]

	arg_5_0._gridlayout.cellSize = Vector2(var_5_6, var_5_7)
	arg_5_0._gridlayout.spacing = Vector2(var_5_8, var_5_9)

	if arg_5_0.moList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.moList) do
			local var_5_10 = arg_5_0:_isBuilding(arg_5_2) and arg_5_0:_getBuildingItem(iter_5_0) or arg_5_0:_getBlockItem(iter_5_0)

			var_5_10:onUpdateMO(iter_5_1)

			local var_5_11 = iter_5_1.isSelect

			var_5_10:onSelect(var_5_11)
		end

		if arg_5_0._blockItems then
			for iter_5_2, iter_5_3 in ipairs(arg_5_0._blockItems) do
				local var_5_12 = not arg_5_0:_isBuilding(arg_5_2) and iter_5_2 <= #arg_5_0.moList

				iter_5_3:setActive(var_5_12)
			end
		end

		if arg_5_0._buildingItems then
			for iter_5_4, iter_5_5 in ipairs(arg_5_0._buildingItems) do
				local var_5_13 = arg_5_0:_isBuilding(arg_5_2) and iter_5_4 <= #arg_5_0.moList

				iter_5_5:setActive(var_5_13)
			end
		end
	end

	arg_5_0.txttitle.text = var_5_0.name

	local var_5_14 = arg_5_0.moList and RoomBlockBuildingGiftModel.instance:getThemeColloctCount(arg_5_0.moList) or 0
	local var_5_15 = arg_5_0.moList and #arg_5_0.moList or 0
	local var_5_16 = var_5_14 == var_5_15 and "roomblockgift_colloctcount2" or "roomblockgift_colloctcount1"

	arg_5_0.txttitleNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(var_5_16), var_5_14, var_5_15)
end

function var_0_0._isBuilding(arg_6_0, arg_6_1)
	return arg_6_1 == RoomBlockGiftEnum.SubType[2]
end

function var_0_0._getBlockItem(arg_7_0, arg_7_1)
	if not arg_7_0._blockItems then
		arg_7_0._blockItems = arg_7_0:getUserDataTb_()
	end

	local var_7_0 = arg_7_0._blockItems[arg_7_1]

	if not var_7_0 then
		local var_7_1 = gohelper.clone(arg_7_0.goBlockItem, arg_7_0.itemRoot)

		var_7_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, RoomBlockGiftPackageItem)
		arg_7_0._blockItems[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0._getBuildingItem(arg_8_0, arg_8_1)
	if not arg_8_0._buildingItems then
		arg_8_0._buildingItems = arg_8_0:getUserDataTb_()
	end

	local var_8_0 = arg_8_0._buildingItems[arg_8_1]

	if not var_8_0 then
		local var_8_1 = gohelper.clone(arg_8_0.goBuildingItem, arg_8_0.itemRoot)

		var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, RoomBlockGiftBuildingItem)
		arg_8_0._buildingItems[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0._refreshSelect(arg_9_0)
	if arg_9_0.moList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.moList) do
			local var_9_0 = arg_9_0:_isBuilding(arg_9_0.subType) and arg_9_0:_getBuildingItem(iter_9_0) or arg_9_0:_getBlockItem(iter_9_0)
			local var_9_1 = iter_9_1.isSelect

			var_9_0:onSelect(var_9_1)
		end
	end
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.go, arg_10_1)
end

return var_0_0
