module("modules.logic.tower.view.bosstower.TowerBossEpisodeLeftView", package.seeall)

slot0 = class("TowerBossEpisodeLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnHandBook = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/Left/#btn_HandBook")
	slot0.goUp = gohelper.findChild(slot0.viewGO, "root/Left/#btn_HandBook/#go_up")
	slot0.imgHead = gohelper.findChildImage(slot0.viewGO, "root/Left/Pass/Head/#image_PassHead")
	slot0.btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/Left/Pass")
	slot4 = "root/Left/Pass/#txt_PassLevel"
	slot0.txtPassLev = gohelper.findChildTextMesh(slot0.viewGO, slot4)
	slot0.taskList = {}

	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, string.format("root/Left/Pass/Point/%s", slot4))
		slot5.goLight = gohelper.findChild(slot5.go, "#go_PointFG")
		slot0.taskList[slot4] = slot5
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnHandBook, slot0._onBtnHandBookClick, slot0)
	slot0:addClickCb(slot0.btnTask, slot0._onBtnTaskClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnHandBook)
	slot0:removeClickCb(slot0.btnTask)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onBtnTaskClick(slot0)
end

function slot0._onBtnHandBookClick(slot0)
	if TowerAssistBossModel.instance:getById(slot0.towerConfig.bossId) == nil then
		TowerController.instance:openAssistBossView()

		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = slot1
	})
end

function slot0._onResetTalent(slot0)
	slot0:refreshTalent()
end

function slot0._onActiveTalent(slot0)
	slot0:refreshTalent()
end

function slot0.onTowerTaskUpdated(slot0)
	slot0:refreshTask()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.episodeConfig = slot0.viewParam.episodeConfig
	slot0.towerId = slot0.episodeConfig.towerId
	slot0.towerType = TowerEnum.TowerType.Boss
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.towerInfo = TowerModel.instance:getTowerInfoById(slot0.towerType, slot0.towerId)
	slot0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(slot0.towerType)
end

function slot0.refreshView(slot0)
	UISpriteSetMgr.instance:setTowerSprite(slot0.imgHead, string.format("towerbossepisodet_passheadicon%s", slot0.towerConfig.bossId))
	slot0:refreshPassLayer()
	slot0:refreshTask()
	slot0:refreshTalent()
end

function slot0.refreshPassLayer(slot0)
	slot2 = slot0.episodeMo:getLayerCount(slot0.towerId, slot0.viewContainer:isSp())
	slot0.txtPassLev.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerboss_passlayer"), string.format("<color=#dcae70>%s</color>", slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot0.towerInfo.passLayerId) % slot2), slot2)
end

function slot0.refreshTask(slot0)
	gohelper.setActive(slot0.btnTask, slot0.towerInfo:getTaskGroupId() ~= 0)

	if slot1 == 0 then
		return
	end

	slot3 = 0

	if TowerConfig.instance:getTaskListByGroupId(slot1) then
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

function slot0.refreshTalent(slot0)
	if not slot0.towerConfig then
		return
	end

	gohelper.setActive(slot0.goUp, TowerAssistBossModel.instance:getById(slot0.towerConfig.bossId) and slot1:hasTalentCanActive() or false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
