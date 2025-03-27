module("modules.logic.tower.view.assistboss.TowerAssistBossView", package.seeall)

slot0 = class("TowerAssistBossView", BaseView)

function slot0.onInitView(slot0)
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "bg/txtTitle")
	slot0.content = gohelper.findChild(slot0.viewGO, "root/bosscontainer/Scroll/Viewport/Content")
	slot0.items = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onBtnStartClick(slot0)
end

function slot0.onTowerUpdate(slot0)
	TowerAssistBossListModel.instance:initList()
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	if slot0.viewParam then
		slot0.isFromHeroGroup = slot0.viewParam.isFromHeroGroup
		slot0.bossId = slot0.viewParam.bossId
	end

	TowerAssistBossListModel.instance:initList()

	if slot0.isFromHeroGroup then
		slot0:addHeroGroupEvent()
	else
		slot0:removeHeroGroupEvent()
	end
end

function slot0.refreshView(slot0)
	TowerAssistBossListModel.instance:refreshList(slot0.viewParam)

	for slot8 = 1, math.max(#TowerAssistBossListModel.instance:getList(), #slot0.items) do
		if not slot0.items[slot8] then
			slot0.items[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0.content, tostring(slot8)), TowerAssistBossItem)
		end

		gohelper.setActive(slot9.viewGO, slot1[slot8] ~= nil)

		if slot10 then
			slot9:onUpdateMO(slot10)
		end
	end
end

function slot0.addHeroGroupEvent(slot0)
	if slot0.hasAdd then
		return
	end

	slot0.hasAdd = true

	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0.refreshView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0.refreshView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0.refreshView, slot0)
end

function slot0.removeHeroGroupEvent(slot0)
	if not slot0.hasAdd then
		return
	end

	slot0.hasAdd = false

	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0.refreshView, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0.refreshView, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshView, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0.refreshView, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
