module("modules.logic.equip.view.EquipChooseView", package.seeall)

slot0 = class("EquipChooseView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_equip")
	slot0._gostrengthenbtns = gohelper.findChild(slot0.viewGO, "topright/#go_strengthenbtns")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "topright/#go_strengthenbtns/fast/#btn_fastadd")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "topright/#go_strengthenbtns/start/#btn_upgrade")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnupgrade:RemoveClickListener()
end

function slot0._btnfastaddOnClick(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenFast)
end

function slot0._btnupgradeOnClick(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenUpgrade)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	EquipChooseListModel.instance:setEquipList()
end

function slot0._refreshBtns(slot0)
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
