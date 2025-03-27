module("modules.logic.tower.view.fight.TowerHeroGroupBossView", package.seeall)

slot0 = class("TowerHeroGroupBossView", BaseView)

function slot0.onInitView(slot0)
	slot0.goAssistBoss = gohelper.findChild(slot0.viewGO, "herogroupcontain/assistBoss")
	slot0.goBossRoot = gohelper.findChild(slot0.goAssistBoss, "boss/root")
	slot0.imgCareer = gohelper.findChildImage(slot0.goBossRoot, "career")
	slot0.goLev = gohelper.findChild(slot0.goBossRoot, "image_Lv")
	slot0.txtLev = gohelper.findChildTextMesh(slot0.goBossRoot, "lev")
	slot0.txtName = gohelper.findChildTextMesh(slot0.goBossRoot, "name")
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.goBossRoot, "icon")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.goAssistBoss, "boss/click")
	slot0.goAdd = gohelper.findChild(slot0.goAssistBoss, "boss/goAdd")
	slot0.goEmpty = gohelper.findChild(slot0.goAssistBoss, "boss/#go_Empty")
	slot0._btnAttr = gohelper.findChildButtonWithAudio(slot0.goAssistBoss, "boss/AttrBuff")
	slot0.btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_replayready/Reset")
	slot0._goreplayready = gohelper.findChild(slot0.viewGO, "#go_container/#go_replayready")
	slot0._dropherogroup = gohelper.findChildDropdown(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	slot0.goArrow = gohelper.findChild(slot0.goBossRoot, "#go_Arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0._btnAttr:AddClickListener(slot0._btnAttrOnClick, slot0)
	slot0.btnReset:AddClickListener(slot0._btnResetOnClick, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._checkRestrictBoss, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0.refreshUI, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshUI, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0._checkRestrictBoss, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.onResetSubEpisode, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0._onTowerUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnAttr:RemoveClickListener()
	slot0.btnReset:RemoveClickListener()
end

function slot0._onTowerUpdate(slot0)
	slot1 = TowerModel.instance:getRecordFightParam()

	TowerController.instance:checkTowerIsEnd(slot1.towerType, slot1.towerId)
end

function slot0._btnResetOnClick(slot0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		if slot1.towerType == TowerEnum.TowerType.Limited then
			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.sendTowerResetSubEpisodeRequest, nil, , slot0, nil, , TowerModel.instance:getTowerInfoById(slot1.towerType, slot1.towerId):getLayerScore(slot1.layerId))
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.sendTowerResetSubEpisodeRequest, nil, , slot0)
		end
	end
end

function slot0.sendTowerResetSubEpisodeRequest(slot0)
	if TowerModel.instance:getRecordFightParam().towerType == TowerEnum.TowerType.Limited then
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(slot1.towerType, slot1.towerId, slot1.layerId, 0)
	else
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(slot1.towerType, slot1.towerId, slot1.layerId, slot1.episodeId)
	end
end

function slot0._btnAttrOnClick(slot0)
	if not slot0.bossId or slot0.bossId == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossHeroGroupAttributeTipsView, {
		bossId = slot0.bossId
	})
end

function slot0._btnClickOnClick(slot0)
	if not TowerController.instance:isBossTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen))

		return
	end

	if TowerModel.instance:getRecordFightParam().isHeroGroupLock or slot2.towerType == TowerEnum.TowerType.Boss then
		if slot0.bossId and slot0.bossId > 0 then
			ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
				isFromHeroGroup = true,
				bossId = slot0.bossId
			})
		else
			GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		end
	else
		TowerController.instance:openAssistBossView(slot0.bossId, true, slot2.towerType, slot2.towerId)
	end
end

function slot0._onResetTalent(slot0, slot1)
	slot0:refreshTalent()
end

function slot0._onActiveTalent(slot0, slot1)
	slot0:refreshTalent()
end

function slot0._editableInitView(slot0)
end

function slot0.onResetSubEpisode(slot0)
	TowerModel.instance:refreshHeroGroupInfo()
	slot0:refreshUI()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	slot0:_checkRestrictBoss()
end

function slot0.refreshUI(slot0)
	slot2 = HeroGroupModel.instance:getCurGroupMO():getAssistBossId()

	gohelper.setActive(slot0._dropherogroup, not TowerModel.instance:getRecordFightParam().isHeroGroupLock and slot3.towerType ~= TowerEnum.TowerType.Boss)
	gohelper.setActive(slot0._goreplayready, slot3.isHeroGroupLock)

	if TowerController.instance:isBossTowerOpen() then
		if slot3.towerType == TowerEnum.TowerType.Boss then
			slot1:setAssistBossId(not TowerAssistBossModel.instance:getById(TowerConfig.instance:getBossTowerConfig(slot3.towerId).bossId) and 0 or slot6.bossId)

			slot2 = slot6.bossId
		end
	else
		slot1:setAssistBossId(0)
	end

	slot0.bossId = slot2

	slot0:refreshBoss()
end

function slot0.refreshBoss(slot0)
	gohelper.setActive(slot0.goEmpty, TowerConfig.instance:getAssistBossConfig(slot0.bossId) == nil)
	gohelper.setActive(slot0._btnAttr, slot1 ~= nil)
	gohelper.setActive(slot0.goBossRoot, slot1 ~= nil)

	if slot1 then
		slot0.txtName.text = slot1.name

		UISpriteSetMgr.instance:setCommonSprite(slot0.imgCareer, string.format("lssx_%s", slot1.career))

		if not TowerAssistBossModel.instance:getById(slot0.bossId) then
			HeroGroupModel.instance:getCurGroupMO():setAssistBossId(0)
			gohelper.setActive(slot0.goLev, false)

			slot0.txtLev.text = ""
		else
			gohelper.setActive(slot0.goLev, true)

			slot0.txtLev.text = tostring(slot2.level)
		end

		slot0.simageBoss:LoadImage(slot1.bossPic)
	end

	gohelper.setActive(slot0.goAdd, TowerController.instance:isBossTowerOpen() and slot1 == nil and not (TowerModel.instance:getRecordFightParam().towerType == TowerEnum.TowerType.Boss) and not slot3.isHeroGroupLock)
	slot0:refreshTalent()
end

function slot0.refreshTalent(slot0)
	if TowerConfig.instance:getAssistBossConfig(slot0.bossId) then
		gohelper.setActive(slot0.goArrow, TowerAssistBossModel.instance:getById(slot0.bossId) and slot2:hasTalentCanActive() or false)
	else
		gohelper.setActive(slot0.goArrow, false)
	end
end

function slot0._checkRestrictBoss(slot0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		return
	end

	if TowerModel.instance:isBossLocked(slot0.bossId) then
		return
	end

	if TowerModel.instance:isBossBan(slot0.bossId) or TowerModel.instance:isLimitTowerBossBan(slot1.towerType, slot1.towerId, slot0.bossId) then
		UIBlockMgr.instance:startBlock("removeTowerBoss")
		TaskDispatcher.runDelay(slot0._removeTowerBoss, slot0, 1.5)
	end
end

function slot0._removeTowerBoss(slot0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")

	slot1 = TowerModel.instance:getRecordFightParam()

	if TowerModel.instance:isBossBan(slot0.bossId) or TowerModel.instance:isLimitTowerBossBan(slot1.towerType, slot1.towerId, slot0.bossId) then
		slot0.bossId = 0

		HeroGroupModel.instance:getCurGroupMO():setAssistBossId(slot0.bossId)
		slot0:refreshBoss()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("removeTowerBoss")
	TaskDispatcher.cancelTask(slot0._removeTowerBoss, slot0)
end

return slot0
