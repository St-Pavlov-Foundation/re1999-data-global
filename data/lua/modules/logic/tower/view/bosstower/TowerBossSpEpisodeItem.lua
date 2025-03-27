module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeItem", package.seeall)

slot0 = class("TowerBossSpEpisodeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.transform = slot1.transform
	slot0.goOpen = gohelper.findChild(slot0.viewGO, "goOpen")
	slot0.goUnopen = gohelper.findChild(slot0.viewGO, "goUnopen")
	slot0.goSelect1 = gohelper.findChild(slot0.viewGO, "goOpen/goSelect")
	slot0.goSelect2 = gohelper.findChild(slot0.viewGO, "goOpen/goSelect2")
	slot0.txtCurEpisode = gohelper.findChildTextMesh(slot0.viewGO, "goOpen/txtCurEpisode")
	slot0.goLock = gohelper.findChild(slot0.viewGO, "goOpen/goLock")
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.viewGO)
	slot0.towerType = TowerEnum.TowerType.Boss
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0._onBtnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeClickCb(slot0.btnClick)
end

function slot0._onBtnClick(slot0)
	slot0.parentView:onClickEpisode(slot0.layerId)
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	slot0.parentView = slot3
	slot0.layerId = slot1
	slot0.index = slot2

	if not slot1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot6 = slot0.parentView.towerMo:isSpLayerOpen(slot0.layerId)

	gohelper.setActive(slot0.goUnopen, not slot6)
	gohelper.setActive(slot0.goOpen, slot6)

	if slot6 then
		slot0.txtCurEpisode.text = tostring(slot2)

		gohelper.setActive(slot0.goLock, not slot4:isLayerUnlock(slot0.layerId, slot0.parentView.episodeMo))
		slot0:updateSelect()
	end
end

function slot0.updateSelect(slot0)
	if not slot0.layerId then
		return
	end

	slot1 = slot0.parentView:isSelectEpisode(slot0.layerId)

	gohelper.setActive(slot0.goSelect1, slot1)
	gohelper.setActive(slot0.goSelect2, slot1)

	slot2 = slot1 and 1 or 0.85

	transformhelper.setLocalScale(slot0.transform, slot2, slot2, 1)
end

function slot0.onDestroy(slot0)
end

return slot0
