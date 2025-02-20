module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallItem", package.seeall)

slot0 = class("TowerAssistBossTalentTallItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.imgTalent = gohelper.findChildImage(slot0.viewGO, "Title/#image_TalentIcon")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Title/#txt_Title")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "#txt_Descr")

	SkillHelper.addHyperLinkClick(slot0.txtDesc, slot0._onHyperLinkClick, slot0)

	slot0.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.txtDesc.gameObject, FixTmpBreakLine)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot2 = slot0._mo.config
	slot0.txtTitle.text = slot2.nodeName
	slot0.txtDesc.text = SkillHelper.buildDesc(slot2.nodeDesc)

	slot0.descFixTmpBreakLine:refreshTmpContent(slot0.txtDesc)
	TowerConfig.instance:setTalentImg(slot0.imgTalent, slot2)
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(slot1), slot2)
end

function slot0.onDestroyView(slot0)
end

return slot0
