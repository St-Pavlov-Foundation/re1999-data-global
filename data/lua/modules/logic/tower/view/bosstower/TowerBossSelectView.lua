module("modules.logic.tower.view.bosstower.TowerBossSelectView", package.seeall)

local var_0_0 = class("TowerBossSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.bossContainer = gohelper.findChild(arg_1_0.viewGO, "root/bosscontainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.onTowerTaskUpdated, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0.onTowerUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.onTowerTaskUpdated, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0.onTowerUpdate, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	arg_6_0:refreshView()
end

function var_0_0.onTowerTaskUpdated(arg_7_0)
	arg_7_0:refreshTask()
end

function var_0_0.onTowerUpdate(arg_8_0)
	arg_8_0:refreshView()
end

function var_0_0.onLocalKeyChange(arg_9_0)
	if arg_9_0.itemList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
			iter_9_1:refreshTag()
		end
	end
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:refreshBossList()
	arg_10_0:refreshTime()
end

function var_0_0.refreshBossList(arg_11_0)
	arg_11_0:initBossList()

	local var_11_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #var_11_0 > 1 then
		table.sort(var_11_0, SortUtil.keyLower("towerId"))
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList) do
		iter_11_1:updateItem(var_11_0 and var_11_0[iter_11_0])
	end
end

function var_0_0.initBossList(arg_12_0)
	if arg_12_0.itemList then
		return
	end

	arg_12_0.itemList = {}

	for iter_12_0 = 1, 3 do
		arg_12_0.itemList[iter_12_0] = arg_12_0:createItem(iter_12_0)
	end
end

function var_0_0.createItem(arg_13_0, arg_13_1)
	local var_13_0 = gohelper.findChild(arg_13_0.bossContainer, string.format("boss%s", arg_13_1))
	local var_13_1 = arg_13_0.viewContainer:getSetting().otherRes.itemRes
	local var_13_2 = arg_13_0.viewContainer:getResInst(var_13_1, var_13_0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, TowerBossSelectItem)
end

function var_0_0.refreshTime(arg_14_0)
	local var_14_0 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local var_14_1
	local var_14_2

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1.status == TowerEnum.TowerStatus.Open and (var_14_1 == nil or var_14_1 > iter_14_1.nextTime) then
			var_14_2 = iter_14_1.towerId
			var_14_1 = iter_14_1.nextTime
		end
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.itemList) do
		iter_14_3:refreshTime(var_14_2)
	end
end

function var_0_0.refreshTask(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.itemList) do
		iter_15_1:refreshTask()
	end
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
