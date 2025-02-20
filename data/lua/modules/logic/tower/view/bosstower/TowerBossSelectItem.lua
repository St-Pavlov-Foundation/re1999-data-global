module("modules.logic.tower.view.bosstower.TowerBossSelectItem", package.seeall)

slot0 = class("TowerBossSelectItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "root/namebg/#txt_name")
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_boss")
	slot0.simageShadow = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_shadow")
	slot0.goNew = gohelper.findChild(slot0.viewGO, "root/tips/new")
	slot0.goSp = gohelper.findChild(slot0.viewGO, "root/tips/sp")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
	slot0.btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_detail")
	slot0.goTime = gohelper.findChild(slot0.viewGO, "root/timebg")
	slot0.txtTime = gohelper.findChildTextMesh(slot0.viewGO, "root/timebg/#txt_time")
	slot0.goLev = gohelper.findChild(slot0.viewGO, "root/level")
	slot5 = "root/level/levelbg/#txt_level"
	slot0.txtLev = gohelper.findChildTextMesh(slot0.viewGO, slot5)
	slot0.spNodeList = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0.spNodeList[slot5] = gohelper.findChild(slot0.viewGO, string.format("root/level/%s", slot5))
	end

	slot0.taskList = {}

	for slot5 = 1, 4 do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.findChild(slot0.viewGO, string.format("root/progress/%s", slot5))
		slot6.goLight = gohelper.findChild(slot6.go, "light")
		slot0.taskList[slot5] = slot6
	end

	slot0.towerType = TowerEnum.TowerType.Boss
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0._onBtnClick, slot0)
	slot0:addClickCb(slot0.btnDetail, slot0._onBtnDetail, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeClickCb(slot0.btnClick)
	slot0:removeClickCb(slot0.btnDetail)
end

function slot0._onBtnDetail(slot0)
	if slot0.towerConfig then
		TowerController.instance:openAssistBossView(slot0.towerConfig.bossId)
	end
end

function slot0._onBtnClick(slot0)
	TowerController.instance:openBossTowerEpisodeView(slot0.towerType, slot0.towerId)
	slot0:checkClearTag()
end

function slot0.updateItem(slot0, slot1)
	slot0.towerOpenMo = slot1
	slot0.towerId = slot1 and slot1.towerId

	if not slot0.towerId then
		gohelper.setActive(slot0.viewGO, false)
		slot0:clearTime()

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.towerInfo = TowerModel.instance:getTowerInfoById(slot0.towerType, slot0.towerId)
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.bossInfo = TowerAssistBossModel.instance:getById(slot0.towerConfig.bossId)
	slot0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(slot0.towerType)
	slot0.bossConfig = TowerConfig.instance:getAssistBossConfig(slot0.towerConfig.bossId)
	slot0.txtName.text = slot0.towerConfig.name

	slot0.simageBoss:LoadImage(slot0.bossConfig.bossPic)
	slot0.simageShadow:LoadImage(slot0.bossConfig.bossShadowPic)
	slot0:refreshLev()
	slot0:refreshTask()
	slot0:refreshTag()
end

function slot0.refreshLev(slot0)
	if slot0.bossInfo then
		gohelper.setActive(slot0.goLev, true)

		slot0.txtLev.text = slot0.bossInfo.level

		for slot6, slot7 in pairs(slot0.episodeMo:getSpEpisodes(slot0.towerId)) do
			if slot0.towerInfo:isLayerPass(slot7, slot0.episodeMo) then
				slot2 = 0 + 1
			end
		end

		for slot6 = 1, #slot0.spNodeList do
			gohelper.setActive(slot0.spNodeList[slot6], slot6 <= slot2)
		end
	else
		gohelper.setActive(slot0.goLev, false)
	end
end

function slot0.refreshTask(slot0)
	slot3 = 0

	if TowerConfig.instance:getTaskListByGroupId(slot0.towerInfo:getTaskGroupId()) then
		for slot7, slot8 in pairs(slot2) do
			if TowerTaskModel.instance:isTaskFinishedById(slot8) then
				slot3 = slot3 + 1
			end
		end
	end

	for slot8 = 1, #slot0.taskList do
		slot9 = slot0.taskList[slot8]

		if slot8 <= (slot2 and #slot2 or 0) then
			gohelper.setActive(slot9.go, true)
			gohelper.setActive(slot9.goLight, slot8 <= slot3)
		else
			gohelper.setActive(slot9.go, false)
		end
	end
end

function slot0.refreshTime(slot0, slot1)
	if slot0.towerId ~= slot1 then
		slot0:clearTime()

		return
	end

	gohelper.setActive(slot0.goTime, true)
	slot0:_refreshTime()
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
	TaskDispatcher.runRepeat(slot0._refreshTime, slot0, 1)
end

function slot0._refreshTime(slot0)
	if (slot0.towerOpenMo and slot0.towerOpenMo.nextTime or 0) * 0.001 - ServerTime.now() > 0 then
		slot0.txtTime.text = formatLuaLang("towerboss_nexttime", TimeUtil.getFormatTime1(slot3))
	else
		slot0:clearTime()
	end
end

function slot0.clearTime(slot0)
	gohelper.setActive(slot0.goTime, false)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0.refreshTag(slot0)
	slot2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, slot0.towerId, slot0.towerOpenMo, TowerEnum.LockKey) == TowerEnum.LockKey

	gohelper.setActive(slot0.goNew, slot2)

	if slot2 then
		gohelper.setActive(slot0.goSp, false)

		return
	end

	gohelper.setActive(slot0.goSp, slot0.towerInfo:hasNewSpLayer(slot0.towerOpenMo))
end

function slot0.checkClearTag(slot0)
	if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, slot0.towerId, slot0.towerOpenMo, TowerEnum.LockKey) == TowerEnum.LockKey then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, slot0.towerId, slot0.towerOpenMo, TowerEnum.UnlockKey)
	end

	if slot0.towerInfo:hasNewSpLayer(slot0.towerOpenMo) then
		slot0.towerInfo:clearSpLayerNewTag(slot0.towerOpenMo)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
	slot0.simageBoss:UnLoadImage()
	slot0.simageShadow:UnLoadImage()
end

return slot0
