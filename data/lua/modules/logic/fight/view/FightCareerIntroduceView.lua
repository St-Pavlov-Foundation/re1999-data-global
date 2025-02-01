module("modules.logic.fight.view.FightCareerIntroduceView", package.seeall)

slot0 = class("FightCareerIntroduceView", BaseView)

function slot0.onInitView(slot0)
	slot0._goblackbg = gohelper.findChild(slot0.viewGO, "#go_blackbg")
	slot0._btnitem1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_item1")
	slot0._btnitem2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_item2")
	slot0._btnitem3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_item3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnitem1:AddClickListener(slot0._btnitem1OnClick, slot0)
	slot0._btnitem2:AddClickListener(slot0._btnitem2OnClick, slot0)
	slot0._btnitem3:AddClickListener(slot0._btnitem3OnClick, slot0)
	gohelper.getClickWithAudio(slot0._goblackbg):AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnitem1:RemoveClickListener()
	slot0._btnitem2:RemoveClickListener()
	slot0._btnitem3:RemoveClickListener()
	gohelper.getClickWithAudio(slot0._goblackbg):RemoveClickListener()
end

function slot0._btnitem1OnClick(slot0)
	slot0:_onItemClick()
end

function slot0._btnitem2OnClick(slot0)
	slot0:_onItemClick()
end

function slot0._btnitem3OnClick(slot0)
	slot0:_onItemClick()
end

function slot0._onItemClick(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView, {
		isGuide = true
	})
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
