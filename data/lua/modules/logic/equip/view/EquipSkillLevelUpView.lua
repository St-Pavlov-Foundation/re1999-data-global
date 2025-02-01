module("modules.logic.equip.view.EquipSkillLevelUpView", package.seeall)

slot0 = class("EquipSkillLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtcurleveldesc2 = gohelper.findChildText(slot0.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill/#txt_curleveldesc2")
	slot0._txtnextleveldesc2 = gohelper.findChildText(slot0.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill/#txt_nextleveldesc2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocurbaseskill = gohelper.findChild(slot0.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill")
	slot0._txtcurlevel = gohelper.findChildText(slot0.viewGO, "#go_rootinfo/info/curleveldesc/#txt_curlevel")
	slot0._gonextbaseskill = gohelper.findChild(slot0.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill")
	slot0._txtnextlevel = gohelper.findChildText(slot0.viewGO, "#go_rootinfo/info/nextleveldesc/#txt_nextlevel")
	slot0._gorootinfo = gohelper.findChild(slot0.viewGO, "#go_rootinfo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipLevelUpView)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._txtcurleveldesc2.gameObject, false)
	gohelper.setActive(slot0._txtnextleveldesc2.gameObject, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._equip_mo = slot0.viewParam[1]
	slot0.last_refine_lv = slot0.viewParam[2]
	slot0._txtcurlevel.text = "<size=22>Lv.</size>" .. slot0.last_refine_lv
	slot0._txtnextlevel.text = "<size=22>Lv.</size>" .. slot0._equip_mo.refineLv

	slot0:_showBaseSkillDes({
		rootGo = slot0._gocurbaseskill,
		txtBaseDes = slot0._txtcurleveldesc2,
		skillType = slot0._equip_mo.equipId,
		refineLv = slot0.last_refine_lv
	})
	slot0:_showBaseSkillDes({
		rootGo = slot0._gonextbaseskill,
		txtBaseDes = slot0._txtnextleveldesc2,
		skillType = slot0._equip_mo.equipId,
		refineLv = slot0._equip_mo.refineLv
	})
end

function slot0._showBaseSkillDes(slot0, slot1)
	if #EquipHelper.getEquipSkillDescList(slot1.skillType, slot1.refineLv, "#D9A06F") == 0 then
		gohelper.setActive(slot1.rootGo, false)
	else
		gohelper.setActive(slot1.rootGo, true)

		slot3, slot4 = nil

		for slot8, slot9 in ipairs(slot2) do
			slot3 = gohelper.cloneInPlace(slot1.txtBaseDes.gameObject, "item_" .. slot8):GetComponent(gohelper.Type_TextMesh)
			slot3.text = slot9

			gohelper.setActive(slot3.gameObject, true)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
