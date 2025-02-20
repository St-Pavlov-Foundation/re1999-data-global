module("modules.logic.fight.view.indicator.FightIndicatorBaseView", package.seeall)

slot0 = class("FightIndicatorBaseView", UserDataDispose)

function slot0.initView(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0._indicatorMgrView = slot1
	slot0.indicatorId = slot2
	slot0.totalIndicatorNum = slot3 or 0
	slot0.viewGO = slot0._indicatorMgrView.viewGO
	slot0.goIndicatorRoot = gohelper.findChild(slot0.viewGO, "root/indicator_container")
end

function slot0.startLoadPrefab(slot0)
end

function slot0.onIndicatorChange(slot0)
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
