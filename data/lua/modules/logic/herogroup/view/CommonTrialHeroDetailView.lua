module("modules.logic.herogroup.view.CommonTrialHeroDetailView", package.seeall)

slot0 = class("CommonTrialHeroDetailView", SummonHeroDetailView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	uv0.super.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	uv0.super.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	gohelper.setActive(slot0._btnClose, false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/attribute"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/exskill"), false)
end

return slot0
