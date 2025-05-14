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
	arg_1_0._btnAttr = gohelper.findChildButtonWithAudio(arg_1_0.goAssistBoss, "boss/AttrBuff")
	arg_1_0.btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_replayready/Reset")
	arg_1_0._goreplayready = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_replayready")
	arg_1_0._dropherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.goBossRoot, "#go_Arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnAttr:AddClickListener(arg_2_0._btnAttrOnClick, arg_2_0)
	arg_2_0.btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_2_0._checkRestrictBoss, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_2_0._checkRestrictBoss, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.onResetSubEpisode, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0._onTowerUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnAttr:RemoveClickListener()
	arg_3_0.btnReset:RemoveClickListener()
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

function var_0_0._onResetTalent(arg_9_0, arg_9_1)
	arg_9_0:refreshTalent()
end

function var_0_0._onActiveTalent(arg_10_0, arg_10_1)
	arg_10_0:refreshTalent()
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onResetSubEpisode(arg_12_0)
	TowerModel.instance:refreshHeroGroupInfo()
	arg_12_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshUI()
	arg_14_0:_checkRestrictBoss()
end

function var_0_0.refreshUI(arg_15_0)
	local var_15_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_15_1 = var_15_0:getAssistBossId()
	local var_15_2 = TowerModel.instance:getRecordFightParam()

	gohelper.setActive(arg_15_0._dropherogroup, not var_15_2.isHeroGroupLock and var_15_2.towerType ~= TowerEnum.TowerType.Boss)
	gohelper.setActive(arg_15_0._goreplayready, var_15_2.isHeroGroupLock)

	if TowerController.instance:isBossTowerOpen() then
		if var_15_2.towerType == TowerEnum.TowerType.Boss then
			local var_15_3 = TowerConfig.instance:getBossTowerConfig(var_15_2.towerId)

			var_15_1 = not TowerAssistBossModel.instance:getById(var_15_3.bossId) and 0 or var_15_3.bossId

			var_15_0:setAssistBossId(var_15_1)

			var_15_1 = var_15_3.bossId
		end
	else
		var_15_1 = 0

		var_15_0:setAssistBossId(var_15_1)
	end

	arg_15_0.bossId = var_15_1

	arg_15_0:refreshBoss()
end

function var_0_0.refreshBoss(arg_16_0)
	local var_16_0 = TowerConfig.instance:getAssistBossConfig(arg_16_0.bossId)

	gohelper.setActive(arg_16_0.goEmpty, var_16_0 == nil)
	gohelper.setActive(arg_16_0._btnAttr, var_16_0 ~= nil)
	gohelper.setActive(arg_16_0.goBossRoot, var_16_0 ~= nil)

	if var_16_0 then
		arg_16_0.txtName.text = var_16_0.name

		UISpriteSetMgr.instance:setCommonSprite(arg_16_0.imgCareer, string.format("lssx_%s", var_16_0.career))

		local var_16_1 = TowerAssistBossModel.instance:getById(arg_16_0.bossId)

		if not var_16_1 then
			HeroGroupModel.instance:getCurGroupMO():setAssistBossId(0)
			gohelper.setActive(arg_16_0.goLev, false)

			arg_16_0.txtLev.text = ""
		else
			gohelper.setActive(arg_16_0.goLev, true)

			arg_16_0.txtLev.text = tostring(var_16_1.level)
		end

		arg_16_0.simageBoss:LoadImage(var_16_0.bossPic)
	end

	local var_16_2 = TowerController.instance:isBossTowerOpen()
	local var_16_3 = TowerModel.instance:getRecordFightParam()
	local var_16_4 = var_16_3.towerType == TowerEnum.TowerType.Boss
	local var_16_5 = var_16_2 and var_16_0 == nil and not var_16_4 and not var_16_3.isHeroGroupLock

	gohelper.setActive(arg_16_0.goAdd, var_16_5)
	arg_16_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_17_0)
	if TowerConfig.instance:getAssistBossConfig(arg_17_0.bossId) then
		local var_17_0 = TowerAssistBossModel.instance:getById(arg_17_0.bossId)

		gohelper.setActive(arg_17_0.goArrow, var_17_0 and var_17_0:hasTalentCanActive() or false)
	else
		gohelper.setActive(arg_17_0.goArrow, false)
	end
end

function var_0_0._checkRestrictBoss(arg_18_0)
	local var_18_0 = TowerModel.instance:getRecordFightParam()

	if var_18_0.isHeroGroupLock then
		return
	end

	if TowerModel.instance:isBossLocked(arg_18_0.bossId) then
		return
	end

	if TowerModel.instance:isBossBan(arg_18_0.bossId) or TowerModel.instance:isLimitTowerBossBan(var_18_0.towerType, var_18_0.towerId, arg_18_0.bossId) then
		UIBlockMgr.instance:startBlock("removeTowerBoss")
		TaskDispatcher.runDelay(arg_18_0._removeTowerBoss, arg_18_0, 1.5)
	end
end

function var_0_0._removeTowerBoss(arg_19_0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")

	local var_19_0 = TowerModel.instance:getRecordFightParam()

	if TowerModel.instance:isBossBan(arg_19_0.bossId) or TowerModel.instance:isLimitTowerBossBan(var_19_0.towerType, var_19_0.towerId, arg_19_0.bossId) then
		arg_19_0.bossId = 0

		HeroGroupModel.instance:getCurGroupMO():setAssistBossId(arg_19_0.bossId)
		arg_19_0:refreshBoss()
	end
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")
	TaskDispatcher.cancelTask(arg_21_0._removeTowerBoss, arg_21_0)
end

return var_0_0
