module("modules.logic.tower.view.assistboss.TowerAssistBossItem", package.seeall)

slot0 = class("TowerAssistBossItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goOpen = gohelper.findChild(slot0.viewGO, "root/go_open")
	slot0.goLock = gohelper.findChild(slot0.viewGO, "root/go_lock")
	slot0.goSelected = gohelper.findChild(slot0.viewGO, "root/go_selected")
	slot0.goUnSelect = gohelper.findChild(slot0.viewGO, "root/go_unselect")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
	slot0.btnSure = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnSure")
	slot0.goSureBg = gohelper.findChild(slot0.viewGO, "root/btnSure/bg")
	slot0.btnCancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnCancel")
	slot0.goLevel = gohelper.findChild(slot0.viewGO, "root/level")
	slot0.txtLevel = gohelper.findChildTextMesh(slot0.viewGO, "root/level/#txt_level")
	slot0.goArrow = gohelper.findChild(slot0.viewGO, "root/level/#go_Arrow")
	slot0.itemList = {}

	slot0:createItem(slot0.goOpen)
	slot0:createItem(slot0.goLock)
	slot0:createItem(slot0.goSelected)
	slot0:createItem(slot0.goUnSelect)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onBtnClick, slot0)
	slot0:addClickCb(slot0.btnSure, slot0.onBtnSure, slot0)
	slot0:addClickCb(slot0.btnCancel, slot0.onBtnCancel, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnClick)
	slot0:removeClickCb(slot0.btnSure)
	slot0:removeClickCb(slot0.btnCancel)
end

function slot0._editableInitView(slot0)
end

function slot0._onResetTalent(slot0, slot1)
	slot0:refreshTalent()
end

function slot0._onActiveTalent(slot0, slot1)
	slot0:refreshTalent()
end

function slot0.onBtnSure(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.isLock == 1 then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	if slot2.towerType == TowerEnum.TowerType.Boss then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	if TowerModel.instance:isBossBan(slot0._mo.bossId) then
		GameFacade.showToast(ToastEnum.TowerAssistBossBan, slot0._mo.config.name)

		return
	end

	HeroGroupModel.instance:getCurGroupMO():setAssistBossId(slot0._mo.bossId)
	slot0:saveGroup()
end

function slot0.onBtnCancel(slot0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	if slot1.towerType == TowerEnum.TowerType.Boss then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	HeroGroupModel.instance:getCurGroupMO():setAssistBossId(0)
	slot0:saveGroup()
end

function slot0.saveGroup(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function slot0.onBtnClick(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.isLock == 1 then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = slot0._mo.bossId,
		isFromHeroGroup = slot0._mo.isFromHeroGroup
	})
end

function slot0.createItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.txtName = gohelper.findChildTextMesh(slot1, "name/#txt_name")
	slot2.imgCareer = gohelper.findChildImage(slot1, "career")
	slot2.simageBoss = gohelper.findChildSingleImage(slot1, "#simage_bossicon")
	slot2.goTxtOpen = gohelper.findChild(slot1, "toptips")
	slot0.itemList[slot1] = slot2
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = slot0.goOpen

	if slot1.isFromHeroGroup then
		slot3 = slot1.isSelect and slot0.goSelected or slot0.goUnSelect

		gohelper.setActive(slot0.btnSure, not slot1.isSelect)
		gohelper.setActive(slot0.btnCancel, slot1.isSelect)
		ZProj.UGUIHelper.SetGrayscale(slot0.goSureBg, slot1.isBanOrder == 1 or slot1.isLock == 1)
	else
		gohelper.setActive(slot0.btnSure, false)
		gohelper.setActive(slot0.btnCancel, false)
	end

	if slot2 then
		slot3 = slot0.goLock
	end

	for slot7, slot8 in pairs(slot0.itemList) do
		slot0:updateItem(slot8, slot3)
	end

	slot4 = not slot2

	gohelper.setActive(slot0.goLevel, slot4)

	if slot4 then
		slot0.txtLevel.text = tostring(slot0._mo.bossInfo.level)
	end

	slot0:refreshTalent()
end

function slot0.refreshTalent(slot0)
	gohelper.setActive(slot0.goArrow, slot0._mo.bossInfo and slot0._mo.bossInfo:hasTalentCanActive() or false)
end

function slot0.updateItem(slot0, slot1, slot2)
	slot3 = slot1.go == slot2

	gohelper.setActive(slot1.go, slot3)

	if not slot3 then
		return
	end

	slot1.txtName.text = slot0._mo.config.name

	UISpriteSetMgr.instance:setCommonSprite(slot1.imgCareer, string.format("lssx_%s", slot0._mo.config.career))
	slot1.simageBoss:LoadImage(slot0._mo.config.bossPic)
	gohelper.setActive(slot1.goTxtOpen, slot0._mo.isTowerOpen and not slot0._mo.isFromHeroGroup)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.itemList) do
		slot5.simageBoss:UnLoadImage()
	end
end

return slot0
