module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlanetItem", package.seeall)

slot0 = class("VersionActivity1_3AstrologyPlanetItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._imagePlanetSelected = gohelper.findChildImage(slot0.viewGO, "#go_Selected/#image_PlanetSelected")
	slot0._txtNumSelected = gohelper.findChildText(slot0.viewGO, "#go_Selected/#txt_NumSelected")
	slot0._goUnSelected = gohelper.findChild(slot0.viewGO, "#go_UnSelected")
	slot0._imagePlanetUnSelected = gohelper.findChildImage(slot0.viewGO, "#go_UnSelected/#image_PlanetUnSelected")
	slot0._txtNumUnSelected = gohelper.findChildText(slot0.viewGO, "#go_UnSelected/#txt_NumUnSelected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

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
	slot0._astrologySelectView:setSelected(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._id = slot1[1]
	slot0._astrologySelectView = slot1[2]
	slot0._mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot0._id)
end

function slot0.getPlanetMo(slot0)
	return slot0._mo
end

function slot0.getId(slot0)
	return slot0._id
end

function slot0._editableInitView(slot0)
	slot1 = "v1a3_astrology_planet" .. slot0._id

	UISpriteSetMgr.instance:setV1a3AstrologySprite(slot0._imagePlanetSelected, slot1)
	UISpriteSetMgr.instance:setV1a3AstrologySprite(slot0._imagePlanetUnSelected, slot1, nil, slot0._imagePlanetUnSelected.color.a)
	slot0:updateNum()
end

function slot0.setSelected(slot0, slot1)
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goSelected, slot0._isSelected)
	gohelper.setActive(slot0._goUnSelected, not slot0._isSelected)
end

function slot0.isSelected(slot0)
	return slot0._isSelected
end

function slot0.updateNum(slot0)
	slot2 = string.format("%s%s", luaLang("multiple"), slot0._mo.num)
	slot0._txtNumSelected.text = slot2
	slot0._txtNumUnSelected.text = slot2
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
