module("modules.logic.tower.view.bosstower.TowerBossEpisodeLeftView", package.seeall)

local var_0_0 = class("TowerBossEpisodeLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnHandBook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/#btn_HandBook")
	arg_1_0.goUp = gohelper.findChild(arg_1_0.viewGO, "root/Left/#btn_HandBook/#go_up")
	arg_1_0.bossIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Left/Pass/Head/Mask/image_bossIcon")
	arg_1_0.btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/Pass")
	arg_1_0.txtPassLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/Pass/#txt_PassLevel")
	arg_1_0.taskList = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0.viewGO, string.format("root/Left/Pass/Point/%s", iter_1_0))
		var_1_0.goLight = gohelper.findChild(var_1_0.go, "#go_PointFG")
		arg_1_0.taskList[iter_1_0] = var_1_0
	end

	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "root/Left/Pass/#go_RedPoint")

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
		TowerController.instance:openAssistBossView()

		return
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

	gohelper.setActive(arg_16_0.btnTask, var_16_0 ~= 0)

	if var_16_0 == 0 then
		return
	end

	local var_16_1 = TowerConfig.instance:getTaskListByGroupId(var_16_0)
	local var_16_2 = 0

	if var_16_1 then
		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			if TowerTaskModel.instance:isTaskFinishedById(iter_16_1) then
				var_16_2 = var_16_2 + 1
			end
		end
	end

	local var_16_3 = var_16_1 and #var_16_1 or 0

	for iter_16_2 = 1, #arg_16_0.taskList do
		local var_16_4 = arg_16_0.taskList[iter_16_2]

		if iter_16_2 <= var_16_3 then
			gohelper.setActive(var_16_4.go, true)
			gohelper.setActive(var_16_4.goLight, iter_16_2 <= var_16_2)
		else
			gohelper.setActive(var_16_4.go, false)
		end
	end
end

function var_0_0.refreshTalent(arg_17_0)
	if not arg_17_0.towerConfig then
		return
	end

	local var_17_0 = TowerAssistBossModel.instance:getById(arg_17_0.towerConfig.bossId)
	local var_17_1 = var_17_0 and var_17_0:hasTalentCanActive() or false

	gohelper.setActive(arg_17_0.goUp, var_17_1)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0.bossIcon:UnLoadImage()
end

return var_0_0
