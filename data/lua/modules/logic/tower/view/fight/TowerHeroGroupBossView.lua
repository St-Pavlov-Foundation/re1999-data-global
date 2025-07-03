module("modules.logic.tower.view.fight.TowerHeroGroupBossView", package.seeall)

local var_0_0 = class("TowerHeroGroupBossView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goAssistBoss = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/assistBoss")
	arg_1_0.goBossRoot = gohelper.findChild(arg_1_0.goAssistBoss, "boss/root")
	arg_1_0.imgCareer = gohelper.findChildImage(arg_1_0.goBossRoot, "career")
	arg_1_0.goLev = gohelper.findChild(arg_1_0.goBossRoot, "image_Lv")
	arg_1_0.txtLev = gohelper.findChildTextMesh(arg_1_0.goBossRoot, "lev")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.goBossRoot, "name")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.goBossRoot, "icon")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.goAssistBoss, "boss/click")
	arg_1_0.goAdd = gohelper.findChild(arg_1_0.goAssistBoss, "boss/goAdd")
	arg_1_0.goEmpty = gohelper.findChild(arg_1_0.goAssistBoss, "boss/#go_Empty")
	arg_1_0._btnAttr = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/assistBoss/boss/root/#btn_attr")
	arg_1_0.btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_replayready/Reset")
	arg_1_0._goreplayready = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_replayready")
	arg_1_0._dropherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	arg_1_0._gotalentPlane = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/assistBoss/boss/talentPlan")
	arg_1_0._txtTalentPlan = gohelper.findChildTextMesh(arg_1_0.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/txt_talentPlan")
	arg_1_0._btnTalentPlan = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/btn_talentPlan")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/#go_Arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnAttr:AddClickListener(arg_2_0._btnAttrOnClick, arg_2_0)
	arg_2_0.btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._btnTalentPlan:AddClickListener(arg_2_0._btnTalentPlanOnClick, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_2_0._checkRestrictBoss, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_2_0._checkRestrictBoss, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.onResetSubEpisode, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0._onTowerUpdate, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_2_0.refreshTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, arg_2_0.refreshTalent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnAttr:RemoveClickListener()
	arg_3_0.btnReset:RemoveClickListener()
	arg_3_0._btnTalentPlan:RemoveClickListener()
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._checkRestrictBoss, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_3_0._checkRestrictBoss, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.onResetSubEpisode, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0._onTowerUpdate, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_3_0.refreshTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, arg_3_0.refreshTalent, arg_3_0)
end

function var_0_0._onTowerUpdate(arg_4_0)
	local var_4_0 = TowerModel.instance:getRecordFightParam()

	TowerController.instance:checkTowerIsEnd(var_4_0.towerType, var_4_0.towerId)
end

function var_0_0._btnResetOnClick(arg_5_0)
	local var_5_0 = TowerModel.instance:getRecordFightParam()

	if var_5_0.isHeroGroupLock then
		if var_5_0.towerType == TowerEnum.TowerType.Limited then
			local var_5_1 = TowerModel.instance:getTowerInfoById(var_5_0.towerType, var_5_0.towerId):getLayerScore(var_5_0.layerId)

			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, arg_5_0.sendTowerResetSubEpisodeRequest, nil, nil, arg_5_0, nil, nil, var_5_1)
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, arg_5_0.sendTowerResetSubEpisodeRequest, nil, nil, arg_5_0)
		end
	end
end

function var_0_0.sendTowerResetSubEpisodeRequest(arg_6_0)
	local var_6_0 = TowerModel.instance:getRecordFightParam()

	if var_6_0.towerType == TowerEnum.TowerType.Limited then
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(var_6_0.towerType, var_6_0.towerId, var_6_0.layerId, 0)
	else
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(var_6_0.towerType, var_6_0.towerId, var_6_0.layerId, var_6_0.episodeId)
	end
end

function var_0_0._btnAttrOnClick(arg_7_0)
	if not arg_7_0.bossId or arg_7_0.bossId == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossHeroGroupAttributeTipsView, {
		bossId = arg_7_0.bossId
	})
end

function var_0_0._btnClickOnClick(arg_8_0)
	if not TowerController.instance:isBossTowerOpen() then
		local var_8_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_8_0)

		return
	end

	local var_8_1 = TowerModel.instance:getRecordFightParam()

	if var_8_1.isHeroGroupLock or var_8_1.towerType == TowerEnum.TowerType.Boss then
		if arg_8_0.bossId and arg_8_0.bossId > 0 then
			ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
				isFromHeroGroup = true,
				bossId = arg_8_0.bossId
			})
		else
			GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		end
	else
		TowerController.instance:openAssistBossView(arg_8_0.bossId, true, var_8_1.towerType, var_8_1.towerId)
	end
end

function var_0_0._btnTalentPlanOnClick(arg_9_0)
	if not arg_9_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentView, {
		bossId = arg_9_0.bossId,
		isFromHeroGroup = arg_9_0.isFromHeroGroup
	})
end

function var_0_0._onResetTalent(arg_10_0, arg_10_1)
	arg_10_0:refreshTalent()
end

function var_0_0._onActiveTalent(arg_11_0, arg_11_1)
	arg_11_0:refreshTalent()
end

function var_0_0._editableInitView(arg_12_0)
	return
end

function var_0_0.onResetSubEpisode(arg_13_0)
	TowerModel.instance:refreshHeroGroupInfo()
	arg_13_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:refreshUI()
	arg_15_0:_checkRestrictBoss()
end

function var_0_0.refreshUI(arg_16_0)
	local var_16_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_16_1 = var_16_0:getAssistBossId()
	local var_16_2 = TowerModel.instance:getRecordFightParam()

	TowerModel.instance:setCurTowerType(var_16_2.towerType)

	arg_16_0.isTeach = var_16_2.layerId == 0 and var_16_2.towerType == TowerEnum.TowerType.Boss

	gohelper.setActive(arg_16_0._dropherogroup, not var_16_2.isHeroGroupLock and var_16_2.towerType ~= TowerEnum.TowerType.Boss)
	gohelper.setActive(arg_16_0._goreplayready, var_16_2.isHeroGroupLock)

	if TowerController.instance:isBossTowerOpen() then
		if var_16_2.towerType == TowerEnum.TowerType.Boss and not arg_16_0.isTeach then
			local var_16_3 = TowerConfig.instance:getBossTowerConfig(var_16_2.towerId)
			local var_16_4 = TowerAssistBossModel.instance:getById(var_16_3.bossId)

			var_16_1 = not var_16_4 and 0 or var_16_4:getTempState() and 0 or var_16_3.bossId

			var_16_0:setAssistBossId(var_16_1)

			var_16_1 = var_16_3.bossId
		elseif arg_16_0.isTeach then
			local var_16_5 = TowerConfig.instance:getBossTowerConfig(var_16_2.towerId)

			var_16_0:setAssistBossId(var_16_5.bossId)

			var_16_1 = var_16_5.bossId
		end
	else
		var_16_1 = 0

		var_16_0:setAssistBossId(var_16_1)
	end

	local var_16_6 = TowerAssistBossModel.instance:getById(var_16_1)

	if var_16_2.towerType == TowerEnum.TowerType.Normal and (var_16_6 and var_16_6:getTempState() or not var_16_6) then
		arg_16_0.bossId = 0

		var_16_0:setAssistBossId(0)
	else
		arg_16_0.bossId = var_16_1
	end

	arg_16_0:refreshBoss()
end

function var_0_0.refreshBoss(arg_17_0)
	local var_17_0 = TowerConfig.instance:getAssistBossConfig(arg_17_0.bossId)
	local var_17_1 = TowerModel.instance:getRecordFightParam()

	gohelper.setActive(arg_17_0.goEmpty, var_17_0 == nil)
	gohelper.setActive(arg_17_0._btnAttr, var_17_0 ~= nil)
	gohelper.setActive(arg_17_0.goBossRoot, var_17_0 ~= nil)

	if var_17_0 then
		arg_17_0.txtName.text = var_17_0.name

		UISpriteSetMgr.instance:setCommonSprite(arg_17_0.imgCareer, string.format("lssx_%s", var_17_0.career))

		local var_17_2 = TowerAssistBossModel.instance:getById(arg_17_0.bossId)
		local var_17_3 = var_17_1.towerType == TowerEnum.TowerType.Limited

		if not var_17_2 then
			if var_17_3 then
				var_17_2 = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(arg_17_0.bossId)

				gohelper.setActive(arg_17_0.goLev, true)

				arg_17_0.txtLev.text = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel)
			elseif var_17_1.towerType == TowerEnum.TowerType.Boss then
				var_17_2 = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(arg_17_0.bossId)

				gohelper.setActive(arg_17_0.goLev, true)

				arg_17_0.txtLev.text = 1

				if arg_17_0.isTeach then
					local var_17_4 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
					local var_17_5 = TowerConfig.instance:getBossTeachConfig(var_17_1.towerId, var_17_1.difficulty)

					var_17_2:setTrialInfo(var_17_4, var_17_5.planId)

					arg_17_0.txtLev.text = var_17_4
				else
					var_17_2:setTrialInfo(0, 0)
				end

				var_17_2:refreshTalent()
			else
				HeroGroupModel.instance:getCurGroupMO():setAssistBossId(0)
				gohelper.setActive(arg_17_0.goLev, false)

				arg_17_0.txtLev.text = ""
			end
		else
			gohelper.setActive(arg_17_0.goLev, true)

			local var_17_6 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
			local var_17_7 = var_17_1.towerType == TowerEnum.TowerType.Limited and var_17_6 > var_17_2.level

			if arg_17_0.isTeach then
				local var_17_8 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
				local var_17_9 = TowerConfig.instance:getBossTeachConfig(var_17_1.towerId, var_17_1.difficulty)

				var_17_2:setTrialInfo(var_17_8, var_17_9.planId)
				var_17_2:refreshTalent()

				arg_17_0.txtLev.text = tostring(var_17_8)
			elseif var_17_7 then
				local var_17_10 = var_17_6
				local var_17_11 = TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(var_17_2)

				var_17_2:setTrialInfo(var_17_10, var_17_11)
				var_17_2:refreshTalent()

				arg_17_0.txtLev.text = tostring(Mathf.Max(var_17_10, 1))
			else
				var_17_2:setTrialInfo(0, 0)
				var_17_2:refreshTalent()

				arg_17_0.txtLev.text = tostring(Mathf.Max(var_17_2.level, 1))
			end
		end

		arg_17_0.simageBoss:LoadImage(var_17_0.bossPic)
	end

	local var_17_12 = TowerController.instance:isBossTowerOpen()
	local var_17_13 = var_17_1.towerType == TowerEnum.TowerType.Boss
	local var_17_14 = var_17_12 and var_17_0 == nil and not var_17_13 and not var_17_1.isHeroGroupLock

	gohelper.setActive(arg_17_0.goAdd, var_17_14)
	arg_17_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_18_0)
	local var_18_0 = TowerModel.instance:getRecordFightParam()
	local var_18_1 = TowerModel.instance:getCurTowerType()
	local var_18_2 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local var_18_3 = TowerAssistBossModel.instance:getById(arg_18_0.bossId)
	local var_18_4 = var_18_3 and var_18_1 and var_18_1 == TowerEnum.TowerType.Limited and var_18_3.trialLevel > 0 and var_18_2 > var_18_3.level

	if TowerConfig.instance:getAssistBossConfig(arg_18_0.bossId) and not arg_18_0.isTeach and not var_18_4 then
		gohelper.setActive(arg_18_0.goArrow, var_18_3 and var_18_3:hasTalentCanActive() or false)
	else
		gohelper.setActive(arg_18_0.goArrow, false)
	end

	local var_18_5 = 0
	local var_18_6 = ""
	local var_18_7 = false

	if var_18_3 then
		if arg_18_0.isTeach then
			local var_18_8 = var_18_3.trialTalentPlan

			var_18_6 = TowerConfig.instance:getTalentPlanConfig(arg_18_0.bossId, var_18_8).planName
		elseif var_18_4 then
			local var_18_9 = TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(var_18_3)

			var_18_6 = TowerConfig.instance:getTalentPlanConfig(arg_18_0.bossId, var_18_9).planName
		elseif var_18_0.towerType == TowerEnum.TowerType.Boss and var_18_3:getTempState() then
			var_18_7 = true
		else
			local var_18_10 = var_18_3:getCurUseTalentPlan()

			if var_18_10 <= tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount)) then
				local var_18_11 = var_18_3:getTalentPlanInfos()

				for iter_18_0, iter_18_1 in pairs(var_18_11) do
					if iter_18_1.planId == var_18_10 then
						var_18_6 = iter_18_1.planName

						break
					end
				end
			else
				var_18_6 = TowerConfig.instance:getTalentPlanConfig(arg_18_0.bossId, var_18_10).planName
			end
		end
	end

	gohelper.setActive(arg_18_0._gotalentPlane, var_18_3 and not var_18_7)

	arg_18_0._txtTalentPlan.text = var_18_6
end

function var_0_0._checkRestrictBoss(arg_19_0)
	local var_19_0 = TowerModel.instance:getRecordFightParam()

	if var_19_0.isHeroGroupLock then
		return
	end

	if TowerModel.instance:isBossLocked(arg_19_0.bossId) then
		return
	end

	if TowerModel.instance:isBossBan(arg_19_0.bossId) or TowerModel.instance:isLimitTowerBossBan(var_19_0.towerType, var_19_0.towerId, arg_19_0.bossId) then
		UIBlockMgr.instance:startBlock("removeTowerBoss")
		TaskDispatcher.runDelay(arg_19_0._removeTowerBoss, arg_19_0, 1.5)
	end
end

function var_0_0._removeTowerBoss(arg_20_0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")

	local var_20_0 = TowerModel.instance:getRecordFightParam()

	if TowerModel.instance:isBossBan(arg_20_0.bossId) or TowerModel.instance:isLimitTowerBossBan(var_20_0.towerType, var_20_0.towerId, arg_20_0.bossId) then
		arg_20_0.bossId = 0

		HeroGroupModel.instance:getCurGroupMO():setAssistBossId(arg_20_0.bossId)
		arg_20_0:refreshBoss()
	end
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")
	TaskDispatcher.cancelTask(arg_22_0._removeTowerBoss, arg_22_0)
end

return var_0_0
