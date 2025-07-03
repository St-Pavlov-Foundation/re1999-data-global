module("modules.logic.tower.view.bosstower.TowerBossSelectView", package.seeall)

local var_0_0 = class("TowerBossSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnbossHandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bossHandbook/#btn_bossHandbook")
	arg_1_0.bossContainer = gohelper.findChild(arg_1_0.viewGO, "root/bosscontainer")
	arg_1_0._gohandBookNewEffect = gohelper.findChild(arg_1_0.viewGO, "bossHandbook/#saoguang")
	arg_1_0._scrollBoss = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_boss")
	arg_1_0._gobossContent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_boss/Viewport/#go_bossContent")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_boss/Viewport/#go_bossContent/#go_bossItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbossHandbook:AddClickListener(arg_2_0._btnbossHandbookOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.onTowerTaskUpdated, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0.onTowerUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbossHandbook:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.onTowerTaskUpdated, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0.onTowerUpdate, arg_3_0)
end

function var_0_0._btnbossHandbookOnClick(arg_4_0)
	TowerController.instance:openAssistBossView()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gohandBookNewEffect, false)
	gohelper.setActive(arg_5_0._gobossItem, false)

	arg_5_0.itemList = arg_5_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	arg_7_0:refreshView()
	TaskDispatcher.runDelay(arg_7_0.checkShowEffect, arg_7_0, 0.6)
end

function var_0_0.onTowerTaskUpdated(arg_8_0)
	arg_8_0:refreshTask()
end

function var_0_0.onTowerUpdate(arg_9_0)
	arg_9_0:refreshView()
end

function var_0_0.onLocalKeyChange(arg_10_0)
	if arg_10_0.itemList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList) do
			iter_10_1.item:refreshTag()
		end
	end
end

function var_0_0.refreshView(arg_11_0)
	arg_11_0:refreshBossList()
	arg_11_0:refreshTime()
	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHandbookOpen)
	local var_12_1 = TowerPermanentModel.instance:getCurPermanentPassLayer()

	gohelper.setActive(arg_12_0._gobossHandbook, var_12_1 >= tonumber(var_12_0))
end

function var_0_0.refreshBossList(arg_13_0)
	arg_13_0.bossOpenMOList = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #arg_13_0.bossOpenMOList > 1 then
		table.sort(arg_13_0.bossOpenMOList, TowerAssistBossModel.sortBossList)
	end

	arg_13_0:initBossList()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.itemList) do
		iter_13_1.item:updateItem(arg_13_0.bossOpenMOList and arg_13_0.bossOpenMOList[iter_13_0])
	end
end

function var_0_0.initBossList(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.bossOpenMOList do
		local var_14_0 = arg_14_0.itemList[iter_14_0]

		if not var_14_0 then
			var_14_0 = {
				go = gohelper.clone(arg_14_0._gobossItem, arg_14_0._gobossContent)
			}
			var_14_0.item = arg_14_0:createItem(iter_14_0, var_14_0.go)
			arg_14_0.itemList[iter_14_0] = var_14_0
		end

		gohelper.setActive(var_14_0.go, true)

		var_14_0.go.name = "boss" .. arg_14_0.bossOpenMOList[iter_14_0].id
	end

	for iter_14_1 = #arg_14_0.bossOpenMOList + 1, #arg_14_0.itemList do
		gohelper.setActive(arg_14_0.itemList[iter_14_1].go, false)
	end

	arg_14_0._scrollBoss.horizontalNormalizedPosition = 0
end

function var_0_0.createItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes.itemRes
	local var_15_1 = arg_15_0.viewContainer:getResInst(var_15_0, arg_15_2)

	recthelper.setAnchorY(var_15_1.transform, arg_15_1 % 2 == 0 and -70 or 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, TowerBossSelectItem)
end

function var_0_0.refreshTime(arg_16_0)
	local var_16_0 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local var_16_1
	local var_16_2

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1.status == TowerEnum.TowerStatus.Open and (var_16_1 == nil or var_16_1 > iter_16_1.nextTime) then
			var_16_2 = iter_16_1.towerId
			var_16_1 = iter_16_1.nextTime
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.itemList) do
		iter_16_3.item:refreshTime(var_16_2)
	end
end

function var_0_0.refreshTask(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.itemList) do
		iter_17_1.item:refreshTask()
	end
end

function var_0_0.checkShowEffect(arg_18_0)
	local var_18_0 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 0) == 0

	gohelper.setActive(arg_18_0._gohandBookNewEffect, var_18_0)
end

function var_0_0.onClose(arg_19_0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 1)
	TaskDispatcher.cancelTask(arg_19_0.checkShowEffect, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	TowerModel.instance:cleanTrialData()
end

return var_0_0
