module("modules.logic.equip.view.EquipTeamHeroGroupItem", package.seeall)

slot0 = class("EquipTeamHeroGroupItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#simage_icon")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_info/#rare")
	slot0._txtequipnamecn = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_equipnamecn")
	slot0._txtequipnameen = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_equipnameen")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#simage_bg")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._equipMO then
		EquipController.instance:openEquipTeamShowView({
			slot0._equipMO.uid,
			true
		})
	end
end

function slot0._editableInitView(slot0)
	slot0._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._equipMO = EquipModel.instance:getEquip(EquipTeamListModel.instance:getTeamEquip()[1])

	slot0:showEquip()
end

function slot0.setHeroGroupType(slot0)
	slot0._heroGroupType = true
end

function slot0.showEquip(slot0)
	slot1 = slot0._equipMO ~= nil

	gohelper.setActive(slot0._simageicon.gameObject, slot1)

	if slot1 then
		slot0._simageicon:LoadImage(ResUrl.getEquipSuit(slot0._equipMO.config.icon))
		slot0._simagebg:LoadImage(ResUrl.getEquipBg("bg_xinxiangzhezhao.png"))

		slot0._txtequipnamecn.text = slot0._equipMO.config.name
		slot0._txtequipnameen.text = slot0._equipMO.config.name_en

		SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare, slot0._rareLineColor[slot0._equipMO.config.rare])
	end

	gohelper.setActive(slot0._goinfo, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagebg:UnLoadImage()
end

return slot0
