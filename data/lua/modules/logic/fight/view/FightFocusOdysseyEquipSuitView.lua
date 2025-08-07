module("modules.logic.fight.view.FightFocusOdysseyEquipSuitView", package.seeall)

local var_0_0 = class("FightFocusOdysseyEquipSuitView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.itemRoot = gohelper.findChild(arg_1_0.viewGO, "root/suit")
	arg_1_0.itemObj = gohelper.findChild(arg_1_0.viewGO, "root/suit/item")
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
		arg_4_0:refreshData()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]
	arg_5_0.customData = arg_5_0.customData or FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act128Sp]

	arg_5_0:refreshData()
end

function var_0_0.refreshData(arg_6_0)
	if arg_6_0.entityMO:isEnemySide() then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	local var_6_0 = arg_6_0.customData.equipSuit2Level
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1 > 0 then
			local var_6_2 = {
				suitId = tonumber(iter_6_0),
				level = iter_6_1
			}

			table.insert(var_6_1, var_6_2)
		end
	end

	table.sort(var_6_1, function(arg_7_0, arg_7_1)
		return arg_7_0.suitId < arg_7_1.suitId
	end)

	if #var_6_1 == 0 then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_6_0.viewGO, true)
	arg_6_0:com_createObjList(arg_6_0.onItemShow, var_6_1, arg_6_0.itemRoot, arg_6_0.itemObj)
end

function var_0_0.onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = OdysseyConfig.instance:getEquipSuitConfig(arg_8_2.suitId)
	local var_8_1 = gohelper.findChildImage(arg_8_1, "#image_icon")

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_8_1, var_8_0.icon)

	local var_8_2 = gohelper.findChildClick(arg_8_1, "#btn_click")

	arg_8_0:com_registClick(var_8_2, arg_8_0.onItemClick, arg_8_2)
end

function var_0_0.onItemClick(arg_9_0, arg_9_1)
	arg_9_1.bagType = OdysseyEnum.BagType.FightPrepare

	OdysseyController.instance:openSuitTipsView(arg_9_1)
end

return var_0_0
