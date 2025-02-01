module("modules.logic.fight.view.FightViewDragChangeSubHero", package.seeall)

slot0 = class("FightViewDragChangeSubHero", BaseView)

function slot0.onInitView(slot0)
	slot0._containerGO = gohelper.findChild(slot0.viewGO, "root/changeSub")

	gohelper.setActive(slot0._containerGO, false)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

return slot0
