module("modules.logic.tower.view.bosstower.TowerBossEpisodeLeftView", package.seeall)

local var_0_0 = class("TowerBossEpisodeLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnHandBook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/#btn_HandBook")
	arg_1_0.goUp = gohelper.findChild(arg_1_0.viewGO, "root/Left/#btn_HandBook/#go_up")
	arg_1_0.bossIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Left/Pass/Head/Mask/image_bossIcon")
	arg_1_0.btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/Pass")
	arg_1_0.txtPassLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/Pass/#txt_PassLevel")
	arg_1_0.txtTaskNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/Pass/#txt_taskNum")
	arg_1_0.taskList = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0.viewGO, string.format("root/Left/Pass/Point/%s", iter_1_0))
		var_1_0.goLight = gohelper.findChild(var_1_0.go, "#go_PointFG")
		arg_1_0.taskList[iter_1_0] = var_1_0
	end

	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "root/Left/Pass/#go_RedPoint")
	arg_1_0._goTaskTime = gohelper.findChild(arg_1_0.viewGO, "root/Left/Pass/time")
	arg_1_0._txtTaskTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/Pass/time/#txt_taskTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnHandBook, arg_2_0._onBtnHandBookClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTask, arg_2_0._onBtnTaskClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.onTowerTaskUpdated, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0._onTowerUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnHandBook)
	arg_3_0:removeClickCb(arg_3_0.btnTask)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.onTowerTaskUpdated, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0._onTowerUpdate, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onTowerUpdate(arg_5_0)
	TowerController.instance:checkTowerIsEnd(arg_5_0.towerType, arg_5_0.towerId)
end

function var_0_0._onBtnTaskClick(arg_6_0)
	TowerController.instance:openTowerTaskView({
		towerType = arg_6_0.towerType,
		towerId = arg_6_0.towerId
	})
end

function var_0_0._onBtnHandBookClick(arg_7_0)
	local var_7_0 = arg_7_0.towerConfig.bossId

	if TowerAssistBossModel.instance:getById(var_7_0) == nil then
		local var_7_1 = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(var_7_0)

		var_7_1:setTrialInfo(0, 0)
		var_7_1:refreshTalent()
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = var_7_0
	})
end

function var_0_0._onResetTalent(arg_8_0)
	arg_8_0:refreshTalent()
end

function var_0_0._onActiveTalent(arg_9_0)
	arg_9_0:refreshTalent()
end

function var_0_0.onTowerTaskUpdated(arg_10_0)
	arg_10_0:refreshTask()
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:refreshParam()
	arg_11_0:refreshView()
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	RedDotController.instance:addRedDot(arg_12_0._goTaskReddot, RedDotEnum.DotNode.TowerTask)
	arg_12_0:refreshParam()
	arg_12_0:refreshView()
end

function var_0_0.refreshParam(arg_13_0)
	arg_13_0.episodeConfig = arg_13_0.viewParam.episodeConfig
	arg_13_0.towerId = arg_13_0.episodeConfig.towerId
	arg_13_0.towerType = TowerEnum.TowerType.Boss
	arg_13_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_13_0.towerId)
	arg_13_0.towerInfo = TowerModel.instance:getTowerInfoById(arg_13_0.towerType, arg_13_0.towerId)
	arg_13_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_13_0.towerType)
end

function var_0_0.refreshView(arg_14_0)
	local var_14_0 = TowerConfig.instance:getAssistBossConfig(arg_14_0.towerConfig.bossId)
	local var_14_1 = FightConfig.instance:getSkinCO(var_14_0.skinId)

	arg_14_0.bossIcon:LoadImage(ResUrl.monsterHeadIcon(var_14_1 and var_14_1.headIcon))
	arg_14_0:refreshPassLayer()
	arg_14_0:refreshTask()
	arg_14_0:refreshTalent()
	arg_14_0:refreshTaskTime()
end

function var_0_0.refreshPassLayer(arg_15_0)
	local var_15_0 = TowerAssistBossModel.instance:getById(arg_15_0.towerConfig.bossId)
	local var_15_1 = var_15_0 and var_15_0.level or 0
	local var_15_2 = TowerConfig.instance:getAssistBossMaxLev(arg_15_0.towerConfig.bossId)
	local var_15_3 = string.format("<color=#dcae70>%s</color>", var_15_1)

	arg_15_0.txtPassLev.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), var_15_3, var_15_2)
end

function var_0_0.refreshTask(arg_16_0)
	local var_16_0 = arg_16_0.towerInfo:getTaskGroupId()
	local var_16_1 = TowerTaskModel.instance:getBossTaskList(arg_16_0.towerId)
	local var_16_2 = var_16_1 and #var_16_1 > 0 and var_16_0 ~= 0

	gohelper.setActive(arg_16_0.btnTask, var_16_2)

	if not var_16_2 then
		return
	end

	local var_16_3 = TowerConfig.instance:getTaskListByGroupId(var_16_0)
	local var_16_4 = 0

	if var_16_3 then
		for iter_16_0, iter_16_1 in pairs(var_16_3) do
			if TowerTaskModel.instance:isTaskFinishedById(iter_16_1) then
				var_16_4 = var_16_4 + 1
			end
		end
	end

	local var_16_5 = var_16_3 and #var_16_3 or 0

	for iter_16_2 = 1, #arg_16_0.taskList do
		local var_16_6 = arg_16_0.taskList[iter_16_2]

		if iter_16_2 <= var_16_5 then
			gohelper.setActive(var_16_6.go, true)
			gohelper.setActive(var_16_6.goLight, iter_16_2 <= var_16_4)
		else
			gohelper.setActive(var_16_6.go, false)
		end
	end

	arg_16_0.txtTaskNum.text = string.format("%s/%s", var_16_4, var_16_5)
end

function var_0_0.refreshTaskTime(arg_17_0)
	arg_17_0.towerOpenMo = TowerModel.instance:getTowerOpenInfo(arg_17_0.towerType, arg_17_0.towerId)

	local var_17_0 = TowerConfig.instance:getBossTimeTowerConfig(arg_17_0.towerId, arg_17_0.towerOpenMo.round)

	if var_17_0 and var_17_0.taskGroupId > 0 and arg_17_0.towerOpenMo.taskEndTime > 0 then
		arg_17_0:_refreshTaskTime()
		TaskDispatcher.cancelTask(arg_17_0._refreshTaskTime, arg_17_0)
		TaskDispatcher.runRepeat(arg_17_0._refreshTaskTime, arg_17_0, 1)
	else
		arg_17_0:clearTime()
	end
end

function var_0_0._refreshTaskTime(arg_18_0)
	gohelper.setActive(arg_18_0._goTaskTime, true)

	local var_18_0, var_18_1 = arg_18_0.towerOpenMo:getTaskRemainTime(true)

	if var_18_0 then
		arg_18_0._txtTaskTime.text = var_18_0 .. var_18_1
	else
		arg_18_0:clearTime()
	end
end

function var_0_0.clearTime(arg_19_0)
	gohelper.setActive(arg_19_0._goTaskTime, false)
	TaskDispatcher.cancelTask(arg_19_0._refreshTaskTime, arg_19_0)
end

function var_0_0.refreshTalent(arg_20_0)
	if not arg_20_0.towerConfig then
		return
	end

	local var_20_0 = TowerAssistBossModel.instance:getById(arg_20_0.towerConfig.bossId)
	local var_20_1 = var_20_0 and var_20_0:hasTalentCanActive() or false

	gohelper.setActive(arg_20_0.goUp, var_20_1)
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0.bossIcon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_22_0._refreshTaskTime, arg_22_0)
end

return var_0_0
