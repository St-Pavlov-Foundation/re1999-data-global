module("modules.logic.tower.view.TowerMainView", package.seeall)

slot0 = class("TowerMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "centerTitle/#txt_title")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "centerTitle/#txt_titleEn")
	slot0._goupdateTime = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_updateTime")
	slot0._golimitTimeUpdateTime = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime")
	slot0._txtlimitTimeUpdateTime = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	slot0._golimitTimeHasNew = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeHasNew")
	slot0._btnlimitTime = gohelper.findChildButtonWithAudio(slot0.viewGO, "limitTimeEpisode/#btn_limitTime")
	slot0._gobossHandbook = gohelper.findChild(slot0.viewGO, "bossHandbook")
	slot0._btnbossHandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "bossHandbook/#btn_bossHandbook")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "reward")
	slot0._imagerewardIcon = gohelper.findChildImage(slot0.viewGO, "reward/#image_rewardIcon")
	slot0._txttotalTaskNum = gohelper.findChildText(slot0.viewGO, "reward/#txt_totalTaskNum")
	slot0._txtcurTaskNum = gohelper.findChildText(slot0.viewGO, "reward/#txt_totalTaskNum/#txt_curTaskNum")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "reward/#btn_reward")
	slot0._gobossUpdateTime = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossUpdateTime")
	slot0._txtbossUpdateTime = gohelper.findChildText(slot0.viewGO, "bossEpisode/#go_bossUpdateTime/#txt_bossUpdateTime")
	slot0._gobossHasNew = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossHasNew")
	slot0._btnboss = gohelper.findChildButtonWithAudio(slot0.viewGO, "bossEpisode/#btn_boss")
	slot0._gobossContent = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent")
	slot0._gobossItem = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	slot0._gobossLockTips = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_locktips")
	slot0._txtaltitudeNum = gohelper.findChildText(slot0.viewGO, "permanentEpisode/progress/#txt_altitudeNum")
	slot0._goprogressContent = gohelper.findChild(slot0.viewGO, "permanentEpisode/progress/#go_progressContent")
	slot0._goprogressItem = gohelper.findChild(slot0.viewGO, "permanentEpisode/progress/#go_progressContent/#go_progressItem")
	slot0._btnpermanent = gohelper.findChildButtonWithAudio(slot0.viewGO, "permanentEpisode/#btn_permanent")
	slot0._goticket = gohelper.findChild(slot0.viewGO, "permanentEpisode/ticket")
	slot0._imageticket = gohelper.findChildImage(slot0.viewGO, "permanentEpisode/ticket/#image_ticket")
	slot0._txtticketNum = gohelper.findChildText(slot0.viewGO, "permanentEpisode/ticket/#txt_ticketNum")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._golimitTimeLockTips = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips")
	slot0._txtlimitTimeLockTips = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips/#txt_limitTimeLockTips")
	slot0._gobossLockTips = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossLockTips")
	slot0._txtbossLockTips = gohelper.findChildText(slot0.viewGO, "bossEpisode/#go_bossLockTips/#txt_bossLockTips")
	slot0._gopermanentReddot = gohelper.findChild(slot0.viewGO, "permanentEpisode/#go_permanenetReddot")
	slot0._gotaskReddot = gohelper.findChild(slot0.viewGO, "reward/#go_taskReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlimitTime:AddClickListener(slot0._btnlimitTimeOnClick, slot0)
	slot0._btnbossHandbook:AddClickListener(slot0._btnbossHandbookOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnboss:AddClickListener(slot0._btnbossOnClick, slot0)
	slot0._btnpermanent:AddClickListener(slot0._btnpermanentOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyReresh, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshRewardTaskInfo, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshPermanentInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlimitTime:RemoveClickListener()
	slot0._btnbossHandbook:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnboss:RemoveClickListener()
	slot0._btnpermanent:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyReresh, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshRewardTaskInfo, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshPermanentInfo, slot0)
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
end

function slot0._btnlimitTimeOnClick(slot0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	if not TowerController.instance:isTimeLimitTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum))

		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function slot0._btnbossHandbookOnClick(slot0)
	TowerController.instance:openAssistBossView()
end

function slot0._btnrewardOnClick(slot0)
	TowerController.instance:openTowerTaskView()
end

function slot0._btnbossOnClick(slot0)
	if not TowerController.instance:isBossTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen))

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function slot0._btnpermanentOnClick(slot0)
	TowerController.instance:openTowerPermanentView()
end

function slot0._editableInitView(slot0)
	slot0.bossItemTab = slot0:getUserDataTb_()
end

function slot0.onDailyReresh(slot0)
	slot0:refreshUI()
end

function slot0.onLocalKeyChange(slot0)
	slot0:refreshBossNewTag()
end

function slot0.onUpdateParam(slot0)
	slot0:checkJump()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	slot0:checkJump()
	slot0:refreshUI()
	slot0:initReddot()
end

function slot0.initReddot(slot0)
	RedDotController.instance:addRedDot(slot0._gopermanentReddot, RedDotEnum.DotNode.PermanentTower)
	RedDotController.instance:addRedDot(slot0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function slot0.refreshUI(slot0)
	slot0:refreshPermanentInfo()
	slot0:initTaskInfo()
	slot0:refreshRewardTaskInfo()
	slot0:refreshBossInfo()
	slot0:refreshBossNewTag()
	slot0:refreshEntranceUI()
	slot0:refreshTowerState()
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
	TaskDispatcher.runRepeat(slot0.refreshTowerState, slot0, 1)
end

function slot0.checkJump(slot0)
	if not slot0.viewParam then
		return
	end

	slot1 = TowerModel.instance:getRecordFightParam()

	if slot0.viewParam.jumpId == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(slot1) > 0 and slot1.towerType == TowerEnum.TowerType.Normal then
			TowerPermanentModel.instance:setLastPassLayer(slot1.layerId)
			TowerController.instance:openTowerPermanentView(slot1)
		else
			slot0:_btnpermanentOnClick()
		end
	elseif slot2 == TowerEnum.JumpId.TowerBoss then
		if not slot0.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, slot0.viewParam.towerId, {
				passLayerId = slot0.viewParam.passLayerId
			})
		end
	elseif slot2 == TowerEnum.JumpId.TowerLimited then
		slot0:_btnlimitTimeOnClick()
	end

	if slot0.viewParam.jumpId then
		slot0.viewParam.jumpId = nil
	end
end

function slot0.refreshEntranceUI(slot0)
	gohelper.setActive(slot0._gobossHandbook, tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHandbookOpen)) <= TowerPermanentModel.instance:getCurPermanentPassLayer())
	gohelper.setActive(slot0._goreward, tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)) <= slot2 and tabletool.len(TowerTaskModel.instance.limitTimeTaskList) + tabletool.len(TowerTaskModel.instance.bossTaskList) > 0)
	gohelper.setActive(slot0._goticket, tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)) <= slot2)
end

function slot0.initTaskInfo(slot0)
	TowerTaskModel.instance:setTaskInfoList(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {})
end

function slot0.refreshPermanentInfo(slot0)
	slot0._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", TowerModel.instance:getMopUpTimes(), TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes))

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageticket, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon) .. "_1", true)

	slot0.curPassLayer = TowerPermanentModel.instance.curPassLayer
	slot4 = TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer)
	slot5 = TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer + 1)

	if TowerPermanentModel.instance:getCurPassEpisodeId() == 0 then
		slot0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		slot0._txtaltitudeNum.text = DungeonConfig.instance:getEpisodeCO(slot6).name
	end

	slot9 = slot5 and slot5.stageId or (slot4 and slot4.stageId or 1) + 1
	slot10 = {}

	for slot14 = 1, TowerPermanentModel.instance:getStageCount() do
		table.insert(slot10, {
			curstageId = slot8 == slot9 and slot8 or slot9
		})
	end

	gohelper.CreateObjList(slot0, slot0.progressItemShow, slot10, slot0._goprogressContent, slot0._goprogressItem)
end

function slot0.progressItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_normal"), slot2.curstageId <= slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_finish"), slot3 < slot6)
end

function slot0.refreshRewardTaskInfo(slot0)
	slot0._txtcurTaskNum.text, slot0._txttotalTaskNum.text = TowerTaskModel.instance:getTotalTaskRewardCount()
end

function slot0.refreshBossInfo(slot0)
	slot0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(slot0, slot0.bossItemShow, TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open), slot0._gobossContent, slot0._gobossItem)

	slot2 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(slot0._gobossContent, slot2)
	gohelper.setActive(slot0._gobossLockTips, not slot2)
end

function slot0.refreshBossNewTag(slot0)
	gohelper.setActive(slot0._gobossHasNew, TowerModel.instance:hasNewBossOpen())
end

function slot0.bossItemShow(slot0, slot1, slot2, slot3)
	if not slot0.bossItemTab[slot3] then
		slot0.bossItemTab[slot3] = {}
	end

	slot4.go = slot1
	slot4.simageEnemy = gohelper.findChildSingleImage(slot4.go, "Mask/image_bossIcon")
	slot4.goSelected = gohelper.findChild(slot4.go, "#go_Selected")

	slot4.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(TowerConfig.instance:getBossTowerConfig(slot2.id).bossId).skinId) and slot8.headIcon))
	gohelper.setActive(slot4.goSelected, not slot0.bossEpisodeMo:isPassAllUnlockLayers(slot2.id))
end

function slot0.refreshTowerState(slot0)
	slot2 = TowerController.instance:isTimeLimitTowerOpen()
	slot3 = TowerEnum.LockKey
	slot4 = 0

	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		slot3 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, slot1.id, slot1, TowerEnum.LockKey)
		slot4 = slot1.nextTime / 1000 - ServerTime.now()
		slot5, slot6 = TimeUtil.secondToRoughTime2(slot4)
		slot0._txtlimitTimeUpdateTime.text = slot4 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			slot5,
			slot6
		}) or ""
	end

	slot5 = not slot3 or slot3 == TowerEnum.LockKey

	gohelper.setActive(slot0._golimitTimeHasNew, slot5 and slot2 and slot1)
	gohelper.setActive(slot0._golimitTimeUpdateTime, not slot5 and slot2 and slot1 and slot4 > 0)

	slot6 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not slot1 then
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited) then
			slot9, slot10 = TimeUtil.secondToRoughTime2(slot7.nextTime / 1000 - ServerTime.now())
			slot0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot9,
				slot10
			})
		else
			slot0._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not slot2 then
		slot0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			slot6 * 10
		})
	end

	gohelper.setActive(slot0._golimitTimeLockTips, not slot1 or not slot2)

	slot7 = TowerModel.instance:hasNewBossOpen()
	slot8 = TowerController.instance:isBossTowerOpen()
	slot9 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	slot11 = -1

	for slot15, slot16 in ipairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
		if slot11 > slot16.nextTime / 1000 - ServerTime.now() or slot11 <= 0 then
			slot11 = slot17
		end
	end

	slot12, slot13 = TimeUtil.secondToRoughTime2(slot11)
	slot0._txtbossUpdateTime.text = slot11 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		slot12,
		slot13
	}) or ""

	gohelper.setActive(slot0._gobossHasNew, slot7 and slot8 and slot9)
	gohelper.setActive(slot0._gobossUpdateTime, not slot7 and slot8 and slot9 and slot11 > 0)
	gohelper.setActive(slot0._gobossContent, slot8)

	slot14 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not slot9 then
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss) then
			slot17, slot18 = TimeUtil.secondToRoughTime2(slot15.nextTime / 1000 - ServerTime.now())
			slot0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot17,
				slot18
			})
		else
			slot0._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not slot8 then
		slot0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			slot14 * 10
		})
	end

	gohelper.setActive(slot0._gobossLockTips, not slot9 or not slot8)
end

function slot0.onClose(slot0)
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.bossItemTab) do
		slot5.simageEnemy:UnLoadImage()
	end
end

return slot0
