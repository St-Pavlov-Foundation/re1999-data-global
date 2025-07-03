module("modules.logic.tower.view.bosstower.TowerBossSelectItem", package.seeall)

local var_0_0 = class("TowerBossSelectItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/namebg/#txt_name")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_boss")
	arg_1_0.simageShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_shadow")
	arg_1_0.goNew = gohelper.findChild(arg_1_0.viewGO, "root/tips/new")
	arg_1_0.goSp = gohelper.findChild(arg_1_0.viewGO, "root/tips/sp")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
	arg_1_0.btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_detail")
	arg_1_0.goTime = gohelper.findChild(arg_1_0.viewGO, "root/timebg")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/timebg/#txt_time")
	arg_1_0.goLev = gohelper.findChild(arg_1_0.viewGO, "root/level")
	arg_1_0.txtLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/level/levelbg/#txt_level")
	arg_1_0.spNodeList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0.spNodeList[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, string.format("root/level/%s", iter_1_0))
	end

	arg_1_0.goProgress = gohelper.findChild(arg_1_0.viewGO, "root/progress")
	arg_1_0.taskList = {}

	for iter_1_1 = 1, 4 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0.viewGO, string.format("root/progress/%s", iter_1_1))
		var_1_0.goLight = gohelper.findChild(var_1_0.go, "light")
		arg_1_0.taskList[iter_1_1] = var_1_0
	end

	arg_1_0.towerType = TowerEnum.TowerType.Boss
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onBtnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDetail, arg_2_0._onBtnDetail, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClick)
	arg_3_0:removeClickCb(arg_3_0.btnDetail)
end

function var_0_0._onBtnDetail(arg_4_0)
	if arg_4_0.towerConfig then
		TowerController.instance:openAssistBossView(arg_4_0.towerConfig.bossId)
	end
end

function var_0_0._onBtnClick(arg_5_0)
	TowerController.instance:openBossTowerEpisodeView(arg_5_0.towerType, arg_5_0.towerId)
	arg_5_0:checkClearTag()
end

function var_0_0.updateItem(arg_6_0, arg_6_1)
	arg_6_0.towerOpenMo = arg_6_1
	arg_6_0.towerId = arg_6_1 and arg_6_1.towerId

	if not arg_6_0.towerId then
		gohelper.setActive(arg_6_0.viewGO, false)
		arg_6_0:clearTime()

		return
	end

	gohelper.setActive(arg_6_0.viewGO, true)

	arg_6_0.towerInfo = TowerModel.instance:getTowerInfoById(arg_6_0.towerType, arg_6_0.towerId)
	arg_6_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_6_0.towerId)
	arg_6_0.bossInfo = TowerAssistBossModel.instance:getById(arg_6_0.towerConfig.bossId)
	arg_6_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_6_0.towerType)
	arg_6_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_6_0.towerConfig.bossId)
	arg_6_0.txtName.text = arg_6_0.towerConfig.name

	arg_6_0.simageBoss:LoadImage(arg_6_0.bossConfig.bossPic)
	arg_6_0.simageShadow:LoadImage(arg_6_0.bossConfig.bossShadowPic)
	arg_6_0:refreshLev()
	arg_6_0:refreshTask()
	arg_6_0:refreshTag()
end

function var_0_0.refreshLev(arg_7_0)
	if arg_7_0.bossInfo and not arg_7_0.bossInfo:getTempState() then
		gohelper.setActive(arg_7_0.goLev, true)

		arg_7_0.txtLev.text = arg_7_0.bossInfo.level

		local var_7_0 = arg_7_0.episodeMo:getSpEpisodes(arg_7_0.towerId)
		local var_7_1 = 0

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if arg_7_0.towerInfo:isLayerPass(iter_7_1, arg_7_0.episodeMo) then
				var_7_1 = var_7_1 + 1
			end
		end

		for iter_7_2 = 1, #arg_7_0.spNodeList do
			gohelper.setActive(arg_7_0.spNodeList[iter_7_2], iter_7_2 <= var_7_1)
		end
	else
		gohelper.setActive(arg_7_0.goLev, false)
	end
end

function var_0_0.refreshTask(arg_8_0)
	local var_8_0 = TowerTaskModel.instance:getBossTaskList(arg_8_0.towerId)

	if var_8_0 and #var_8_0 > 0 then
		gohelper.setActive(arg_8_0.goProgress, true)

		local var_8_1 = 0

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if TowerTaskModel.instance:isTaskFinishedById(iter_8_1.id) then
				var_8_1 = var_8_1 + 1
			end
		end

		local var_8_2 = var_8_0 and #var_8_0 or 0

		for iter_8_2 = 1, #arg_8_0.taskList do
			local var_8_3 = arg_8_0.taskList[iter_8_2]

			if iter_8_2 <= var_8_2 then
				gohelper.setActive(var_8_3.go, true)
				gohelper.setActive(var_8_3.goLight, iter_8_2 <= var_8_1)
			else
				gohelper.setActive(var_8_3.go, false)
			end
		end
	else
		gohelper.setActive(arg_8_0.goProgress, false)
	end
end

function var_0_0.refreshTime(arg_9_0)
	local var_9_0 = TowerConfig.instance:getBossTimeTowerConfig(arg_9_0.towerId, arg_9_0.towerOpenMo.round)

	if var_9_0 and var_9_0.taskGroupId > 0 and arg_9_0.towerOpenMo.taskEndTime > 0 then
		arg_9_0:_refreshTime()
		TaskDispatcher.cancelTask(arg_9_0._refreshTime, arg_9_0)
		TaskDispatcher.runRepeat(arg_9_0._refreshTime, arg_9_0, 1)
	else
		arg_9_0:clearTime()
	end
end

function var_0_0._refreshTime(arg_10_0)
	gohelper.setActive(arg_10_0.goTime, true)

	local var_10_0, var_10_1 = arg_10_0.towerOpenMo:getTaskRemainTime(true)

	if var_10_0 then
		arg_10_0.txtTime.text = var_10_0 .. var_10_1
	else
		arg_10_0:clearTime()
	end
end

function var_0_0.clearTime(arg_11_0)
	gohelper.setActive(arg_11_0.goTime, false)
	TaskDispatcher.cancelTask(arg_11_0._refreshTime, arg_11_0)
end

function var_0_0.refreshTag(arg_12_0)
	local var_12_0 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, arg_12_0.towerId, arg_12_0.towerOpenMo, TowerEnum.LockKey) == TowerEnum.LockKey

	gohelper.setActive(arg_12_0.goNew, var_12_0)

	if var_12_0 then
		gohelper.setActive(arg_12_0.goSp, false)

		return
	end

	local var_12_1 = arg_12_0.towerInfo:hasNewSpLayer(arg_12_0.towerOpenMo)

	gohelper.setActive(arg_12_0.goSp, var_12_1)
end

function var_0_0.checkClearTag(arg_13_0)
	if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, arg_13_0.towerId, arg_13_0.towerOpenMo, TowerEnum.LockKey) == TowerEnum.LockKey then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, arg_13_0.towerId, arg_13_0.towerOpenMo, TowerEnum.UnlockKey)

		return
	end

	if arg_13_0.towerInfo:hasNewSpLayer(arg_13_0.towerOpenMo) then
		arg_13_0.towerInfo:clearSpLayerNewTag(arg_13_0.towerOpenMo)
	end
end

function var_0_0.onDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._refreshTime, arg_14_0)
	arg_14_0.simageBoss:UnLoadImage()
	arg_14_0.simageShadow:UnLoadImage()
end

return var_0_0
