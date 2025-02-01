module("modules.logic.fight.view.FightHideUIView", package.seeall)

slot0 = class("FightHideUIView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnsGo = gohelper.findChild(slot0.viewGO, "root/btns")
	slot0._imgRoundGo = gohelper.findChild(slot0.viewGO, "root/topLeftContent/imgRound")
end

function slot0.addEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkHideUI, slot0)
	slot0:_checkHideUI()
end

function slot0._checkHideUI(slot0)
	gohelper.setActive(slot0._btnsGo, GMFightShowState.topRightPause)
	gohelper.setActive(slot0._imgRoundGo, GMFightShowState.topRightRound)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkHideUI, slot0)
end

return slot0
