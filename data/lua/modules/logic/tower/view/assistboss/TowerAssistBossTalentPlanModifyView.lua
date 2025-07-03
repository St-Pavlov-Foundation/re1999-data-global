module("modules.logic.tower.view.assistboss.TowerAssistBossTalentPlanModifyView", package.seeall)

local var_0_0 = class("TowerAssistBossTalentPlanModifyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBtnReset = gohelper.findChild(arg_1_0.viewGO, "BOSS/layout/btn_reset")
	arg_1_0._btnHideTalentPlan = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_hideTalentPlan")
	arg_1_0._goTalentPlanSelect = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect")
	arg_1_0._btnShowTalentPlan = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "talentPlanSelect/#btn_showTalentPlan")
	arg_1_0._txtTalentPlanName = gohelper.findChildTextMesh(arg_1_0.viewGO, "talentPlanSelect/#btn_showTalentPlan/#txt_talentPlanName")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#btn_showTalentPlan/#go_arrow")
	arg_1_0._btnChangeName = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "talentPlanSelect/#btn_changeName")
	arg_1_0._goModifyIcon = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#btn_changeName/#go_modifyIcon")
	arg_1_0._goAutoIcon = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#btn_changeName/#go_autoIcon")
	arg_1_0._goTalentPlanContent = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#go_talentPlanContent")
	arg_1_0._goTalentPlanItem = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#go_talentPlanContent/#go_talentPlanItem")
	arg_1_0._goTalentPlanTip = gohelper.findChild(arg_1_0.viewGO, "talentPlanSelect/#go_talentPlanTip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnShowTalentPlan:AddClickListener(arg_2_0._onBtnShowTalentPlan, arg_2_0)
	arg_2_0._btnHideTalentPlan:AddClickListener(arg_2_0._onBtnHideTalentPlan, arg_2_0)
	arg_2_0._btnChangeName:AddClickListener(arg_2_0._onBtnChangeName, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ChangeTalentPlan, arg_2_0.changeTalentPlan, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, arg_2_0.RenameTalentPlan, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnShowTalentPlan:RemoveClickListener()
	arg_3_0._btnHideTalentPlan:RemoveClickListener()
	arg_3_0._btnChangeName:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ChangeTalentPlan, arg_3_0.changeTalentPlan, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, arg_3_0.RenameTalentPlan, arg_3_0)
end

function var_0_0._onBtnChangeName(arg_4_0)
	if arg_4_0.curSelectTalentPlanData.isAutoPlan == 1 then
		return
	end

	local var_4_0 = {
		bossId = arg_4_0.bossId
	}

	ViewMgr.instance:openView(ViewName.TowerBossTalentModifyNameView, var_4_0)
end

function var_0_0._onBtnShowTalentPlan(arg_5_0)
	if not arg_5_0.isShowTalentPlane then
		arg_5_0:showTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_activity_dog_page)
	else
		arg_5_0:hideTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
	end
end

function var_0_0._onBtnHideTalentPlan(arg_6_0)
	arg_6_0:hideTalentPlane()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
end

function var_0_0.showTalentPlane(arg_7_0)
	gohelper.setActive(arg_7_0._goTalentPlanContent, true)
	gohelper.setActive(arg_7_0._btnHideTalentPlan.gameObject, true)
	transformhelper.setLocalScale(arg_7_0._goArrow.transform, 1, -1, 1)

	arg_7_0.isShowTalentPlane = true
end

function var_0_0.hideTalentPlane(arg_8_0)
	gohelper.setActive(arg_8_0._goTalentPlanContent, false)
	gohelper.setActive(arg_8_0._btnHideTalentPlan.gameObject, false)
	transformhelper.setLocalScale(arg_8_0._goArrow.transform, 1, 1, 1)

	arg_8_0.isShowTalentPlane = false
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.talentPlanItemList = arg_9_0:getUserDataTb_()
	arg_9_0.curSelectTalentPlanData = nil

	gohelper.setActive(arg_9_0._goTalentPlanItem, false)
	arg_9_0:hideTalentPlane()

	arg_9_0.isShowTalentPlane = false
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:initData()
	arg_11_0:initTalentPlan()
	arg_11_0:createOrRefreshTalentPlanItem()
	arg_11_0:initCurSelectItem()
	arg_11_0:_onBtnHideTalentPlan()
end

function var_0_0.initData(arg_12_0)
	arg_12_0.bossId = arg_12_0.viewParam.bossId
	arg_12_0.bossMo = TowerAssistBossModel.instance:getBoss(arg_12_0.bossId)
	arg_12_0.bossLevel = arg_12_0.bossMo.level
	arg_12_0.talentTree = arg_12_0.bossMo:getTalentTree()
end

function var_0_0.initTalentPlan(arg_13_0)
	arg_13_0.talentPlanDataMap = arg_13_0:getUserDataTb_()
	arg_13_0.talentPlanDataList = arg_13_0:getUserDataTb_()

	local var_13_0 = TowerModel.instance:getCurTowerType()

	arg_13_0.isTeach = var_13_0 and var_13_0 == TowerEnum.TowerType.Boss and arg_13_0.bossMo.trialLevel > 0
	arg_13_0.isTempBoss = var_13_0 and var_13_0 == TowerEnum.TowerType.Boss and arg_13_0.bossMo:getTempState()

	local var_13_1 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

	arg_13_0.isLimitedTrial = var_13_0 and var_13_0 == TowerEnum.TowerType.Limited and arg_13_0.bossMo.trialLevel > 0 and var_13_1 > arg_13_0.bossMo.level

	gohelper.setActive(arg_13_0._goTalentPlanSelect, true)

	if arg_13_0.isTeach then
		local var_13_2 = arg_13_0.bossMo.trialTalentPlan
		local var_13_3 = TowerConfig.instance:getTalentPlanConfig(arg_13_0.bossId, var_13_2)

		arg_13_0:addAutoTalentPlan({
			var_13_3
		})
	elseif arg_13_0.isLimitedTrial then
		arg_13_0:addAutoTalentPlan()
	elseif arg_13_0.isTempBoss then
		gohelper.setActive(arg_13_0._goTalentPlanSelect, false)
	else
		arg_13_0:addAutoTalentPlan()
		arg_13_0:addCustomTalentPlan()
	end

	table.sort(arg_13_0.talentPlanDataList, function(arg_14_0, arg_14_1)
		if arg_14_0.isAutoPlan ~= arg_14_1.isAutoPlan then
			return arg_14_0.isAutoPlan > arg_14_1.isAutoPlan
		end

		return arg_14_0.planId < arg_14_1.planId
	end)
end

function var_0_0.addAutoTalentPlan(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or TowerConfig.instance:getAllTalentPlanConfig(arg_15_0.bossId)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = {
			planId = iter_15_1.planId
		}

		var_15_1.talentIds = TowerConfig.instance:getTalentPlanNodeIds(arg_15_0.bossId, var_15_1.planId, arg_15_0.bossLevel)
		var_15_1.planName = iter_15_1.planName
		var_15_1.isAutoPlan = 1
		arg_15_0.talentPlanDataMap[var_15_1.planId] = var_15_1

		table.insert(arg_15_0.talentPlanDataList, var_15_1)
	end
end

function var_0_0.addCustomTalentPlan(arg_16_0)
	local var_16_0 = arg_16_0.bossMo:getTalentPlanInfos()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_1 = {
			planId = iter_16_1.planId,
			talentIds = iter_16_1.talentIds,
			planName = iter_16_1.planName
		}

		var_16_1.isAutoPlan = 0
		arg_16_0.talentPlanDataMap[var_16_1.planId] = var_16_1

		table.insert(arg_16_0.talentPlanDataList, var_16_1)
	end
end

function var_0_0.createOrRefreshTalentPlanItem(arg_17_0)
	for iter_17_0 = 1, #arg_17_0.talentPlanDataList do
		local var_17_0 = arg_17_0.talentPlanItemList[iter_17_0]

		if not var_17_0 then
			var_17_0 = {
				data = arg_17_0.talentPlanDataList[iter_17_0],
				go = gohelper.cloneInPlace(arg_17_0._goTalentPlanItem)
			}
			var_17_0.goSelect = gohelper.findChild(var_17_0.go, "go_select")
			var_17_0.goAutoTypeIcon = gohelper.findChild(var_17_0.go, "txt_planName/go_autoTypeIcon")
			var_17_0.txtPlanName = gohelper.findChildTextMesh(var_17_0.go, "txt_planName")
			var_17_0.btnClick = gohelper.findChildClickWithAudio(var_17_0.go, "btn_click")

			var_17_0.btnClick:AddClickListener(arg_17_0.onTalentPlanItemClick, arg_17_0, var_17_0)

			arg_17_0.talentPlanItemList[iter_17_0] = var_17_0
		end

		gohelper.setActive(var_17_0.go, true)

		local var_17_1 = var_17_0.data.isAutoPlan == 1

		SLFramework.UGUI.GuiHelper.SetColor(var_17_0.txtPlanName, var_17_1 and "#EFB785" or "#C3BEB6")

		var_17_0.txtPlanName.text = var_17_0.data.planName

		gohelper.setActive(var_17_0.goAutoTypeIcon, var_17_1)
	end
end

function var_0_0.initCurSelectItem(arg_18_0)
	if arg_18_0.isTempBoss then
		gohelper.setActive(arg_18_0._goBtnReset, false)

		if not arg_18_0.isTeach then
			return
		end
	end

	local var_18_0 = 0

	if arg_18_0.isTeach then
		var_18_0 = arg_18_0.bossMo.trialTalentPlan
	elseif arg_18_0.isLimitedTrial then
		var_18_0 = TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(arg_18_0.bossMo)
	else
		var_18_0 = arg_18_0.bossMo:getCurUseTalentPlan()
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.talentPlanDataList) do
		if iter_18_1.planId == var_18_0 then
			arg_18_0.curSelectTalentPlanData = iter_18_1

			break
		end
	end

	if not arg_18_0.curSelectTalentPlanData then
		logError("当前保存的天赋id不存在： " .. var_18_0)

		arg_18_0.curSelectTalentPlanData = arg_18_0.talentPlanDataList[1]
	end

	arg_18_0:refreshPlanUI(arg_18_0.curSelectTalentPlanData)
end

function var_0_0.onTalentPlanItemClick(arg_19_0, arg_19_1)
	if arg_19_0.curSelectTalentPlanData and arg_19_0.curSelectTalentPlanData.planId == arg_19_1.data.planId then
		arg_19_0:_onBtnHideTalentPlan()

		return
	end

	arg_19_0.curSelectTalentPlanData = arg_19_1.data

	if arg_19_0.isLimitedTrial then
		local var_19_0 = {
			planId = arg_19_0.curSelectTalentPlanData.planId
		}
		local var_19_1 = TowerAssistBossModel.instance:getLimitedTrialBossSaveKey(arg_19_0.bossMo)

		TowerController.instance:setPlayerPrefs(var_19_1, arg_19_0.curSelectTalentPlanData.planId)
		arg_19_0:changeTalentPlan(var_19_0)
	elseif arg_19_0.isTeach or arg_19_0.isTempBoss then
		-- block empty
	else
		TowerRpc.instance:sendTowerChangeTalentPlanRequest(arg_19_0.bossId, arg_19_1.data.planId)
	end

	arg_19_0:_onBtnHideTalentPlan()
end

function var_0_0.changeTalentPlan(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.planId

	arg_20_0.curSelectTalentPlanData = arg_20_0.talentPlanDataMap[var_20_0]

	arg_20_0:refreshPlanUI(arg_20_0.curSelectTalentPlanData)
	arg_20_0.bossMo:setCurUseTalentPlan(arg_20_0.curSelectTalentPlanData.planId, arg_20_0.isLimitedTrial)
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTalent)
	GameFacade.showToast(ToastEnum.TowerBossTalentPlanChange)
end

function var_0_0.refreshPlanUI(arg_21_0, arg_21_1)
	arg_21_0.curSelectTalentPlanData = arg_21_1

	for iter_21_0, iter_21_1 in pairs(arg_21_0.talentPlanItemList) do
		local var_21_0 = iter_21_1.data.isAutoPlan == 1
		local var_21_1 = iter_21_1.data.planId == arg_21_1.planId

		gohelper.setActive(iter_21_1.goSelect, var_21_1)

		if var_21_0 then
			SLFramework.UGUI.GuiHelper.SetColor(iter_21_1.txtPlanName, "#EFB785")
		else
			SLFramework.UGUI.GuiHelper.SetColor(iter_21_1.txtPlanName, var_21_1 and "#EAF8FF" or "#C3BEB6")
		end
	end

	local var_21_2 = arg_21_0.curSelectTalentPlanData.isAutoPlan == 1

	arg_21_0._txtTalentPlanName.text = arg_21_0.curSelectTalentPlanData.planName

	gohelper.setActive(arg_21_0._goModifyIcon, not var_21_2)
	gohelper.setActive(arg_21_0._goAutoIcon, var_21_2)
	gohelper.setActive(arg_21_0._goTalentPlanTip, var_21_2)
	gohelper.setActive(arg_21_0._goBtnReset, not var_21_2)
	TowerAssistBossTalentListModel.instance:setAutoTalentState(var_21_2)
end

function var_0_0.saveLimitedTalent(arg_22_0)
	local var_22_0 = arg_22_0:getLimitedTrialBossSaveKey(arg_22_0.bossMO)

	TowerController.instance:setPlayerPrefs(var_22_0, arg_22_0.curSelectTalentPlanData.planId)
end

function var_0_0.RenameTalentPlan(arg_23_0, arg_23_1)
	arg_23_0.curSelectTalentPlanData.planName = arg_23_1

	for iter_23_0, iter_23_1 in pairs(arg_23_0.talentPlanItemList) do
		if iter_23_1.data.planId == arg_23_0.curSelectTalentPlanData.planId then
			iter_23_1.txtPlanName.text = arg_23_1

			break
		end
	end

	arg_23_0._txtTalentPlanName.text = arg_23_1
end

function var_0_0.onClose(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.talentPlanItemList) do
		iter_24_1.btnClick:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
