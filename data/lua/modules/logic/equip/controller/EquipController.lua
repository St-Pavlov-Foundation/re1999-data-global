module("modules.logic.equip.controller.EquipController", package.seeall)

slot0 = class("EquipController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openEquipStrengthenAlertView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipStrengthenAlertView, slot1, slot2)
end

function slot0.openEquipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipView, slot1, slot2)
end

function slot0.openEquipBreakResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipBreakResultView, slot1, slot2)
end

function slot0.openEquipSkillLevelUpView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipSkillLevelUpView, slot1, slot2)
end

function slot0.openEquipSkillTipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipSkillTipView, slot1, slot2)
end

function slot0.closeEquipSkillTipView(slot0)
	ViewMgr.instance:closeView(ViewName.EquipSkillTipView)
end

function slot0.openEquipInfoTeamView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.EquipInfoTeamShowView, slot1)
end

function slot0.openEquipTeamView(slot0, slot1, slot2)
	EquipTeamListModel.instance:openTeamEquip(slot1, slot2.heroMO)
	ViewMgr.instance:openView(ViewName.EquipTeamView, slot2)
end

function slot0.openEquipTeamShowView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EquipTeamShowView, slot1, slot2)
end

function slot0.openEquipDecomposeView(slot0)
	ViewMgr.instance:openView(ViewName.EquipDecomposeView)
end

function slot0.closeEquipTeamShowView(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.EquipTeamShowView, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
