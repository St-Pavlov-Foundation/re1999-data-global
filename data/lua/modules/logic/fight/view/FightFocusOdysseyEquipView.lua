module("modules.logic.fight.view.FightFocusOdysseyEquipView", package.seeall)

local var_0_0 = class("FightFocusOdysseyEquipView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.collectionObjList = {}
	arg_1_0.simage_iconList = {}
	arg_1_0.img_rareList = {}

	for iter_1_0 = 1, 2 do
		table.insert(arg_1_0.collectionObjList, gohelper.findChild(arg_1_0.viewGO, "root/collection" .. iter_1_0))
		table.insert(arg_1_0.simage_iconList, gohelper.findChildSingleImage(arg_1_0.viewGO, "root/collection" .. iter_1_0 .. "/simage_Icon"))
		table.insert(arg_1_0.img_rareList, gohelper.findChildImage(arg_1_0.viewGO, "root/collection" .. iter_1_0 .. "/image_Rare"))
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.entityMO = arg_3_1
end

function var_0_0.refreshEntityMO(arg_4_0, arg_4_1)
	arg_4_0.entityMO = arg_4_1

	if arg_4_0.viewGO then
		arg_4_0:refreshCollection()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]
	arg_5_0.customData = arg_5_0.customData or FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act128Sp]

	arg_5_0:refreshCollection()
end

function var_0_0.refreshCollection(arg_6_0)
	if arg_6_0.entityMO:isEnemySide() then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	local var_6_0 = arg_6_0.customData.customUnitId2Equip
	local var_6_1

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if tonumber(iter_6_0) == arg_6_0.entityMO.customUnitId then
			var_6_1 = iter_6_1

			break
		end
	end

	if not var_6_1 then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	if #var_6_1 == 0 then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_6_0.viewGO, true)

	for iter_6_2 = 1, #arg_6_0.collectionObjList do
		local var_6_2 = arg_6_0.collectionObjList[iter_6_2]
		local var_6_3 = var_6_1[iter_6_2]

		if var_6_3 then
			gohelper.setActive(var_6_2, true)

			local var_6_4 = lua_odyssey_item.configDict[var_6_3]

			UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_6_0.img_rareList[iter_6_2], "odyssey_item_quality" .. var_6_4.rare)

			if var_6_4.type == OdysseyEnum.ItemType.Item then
				arg_6_0.simage_iconList[iter_6_2]:LoadImage(ResUrl.getPropItemIcon(var_6_4.icon))
			elseif var_6_4.type == OdysseyEnum.ItemType.Equip then
				arg_6_0.simage_iconList[iter_6_2]:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(var_6_4.icon))
			end

			local var_6_5 = gohelper.getClickWithDefaultAudio(var_6_2)

			arg_6_0:com_registClick(var_6_5, arg_6_0.onItemClick, var_6_3)
		else
			gohelper.setActive(var_6_2, false)
		end
	end
end

function var_0_0.onItemClick(arg_7_0, arg_7_1)
	OdysseyController.instance:showItemTipView({
		itemId = arg_7_1
	})
end

return var_0_0
