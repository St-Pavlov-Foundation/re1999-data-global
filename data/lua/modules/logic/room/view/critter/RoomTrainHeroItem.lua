module("modules.logic.room.view.critter.RoomTrainHeroItem", package.seeall)

slot0 = class("RoomTrainHeroItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_name")
	slot0._txtquailty = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_quailty")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_content/head/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/head/#simage_icon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_content/#go_select")
	slot0._gogroup = gohelper.findChild(slot0.viewGO, "#go_content/#go_group")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_group/#go_baseitem")
	slot0._txtpreference = gohelper.findChildText(slot0.viewGO, "#go_content/#go_group/go_preferenceitem/#txt_preference")
	slot0._simagepreference = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#go_group/go_preferenceitem/#simage_preference")
	slot0._btnclickitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_clickitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclickitem:AddClickListener(slot0._btnclickitemOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclickitem:RemoveClickListener()
end

function slot0._btnclickitemOnClick(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectHero, slot0:getDataMO())
	end
end

function slot0._editableInitView(slot0)
	slot0._gopreferenceitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_group/go_preferenceitem")
	slot0._referenceCanvasGroup = gohelper.onceAddComponent(slot0._gopreferenceitem, typeof(UnityEngine.CanvasGroup))
	slot0._txtquailty.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	slot0._attrComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gobaseitem, RoomCritterAttrScrollCell)
	slot0._attrComp._view = slot0._view
	slot0._gograyList = {
		slot0._simagepreference.gameObject
	}
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getDataMO(slot0)
	return slot0._mo
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._attrComp:onDestroy()
end

function slot0.refreshUI(slot0)
	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot0._mo.skinConfig.headIcon))

	slot0._txtname.text = slot0._mo.heroConfig.name

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagerare, CritterEnum.QualityImageNameMap[slot0._mo.heroConfig.rare])

	slot0._txtpreference.text = slot0._mo:getPrefernectName()

	if slot0._mo.critterHeroConfig then
		slot0._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(slot0._mo.critterHeroConfig.critterIcon))
	end

	slot0._attrComp:onUpdateMO(slot0._mo:getAttributeInfoMO())

	slot0._referenceCanvasGroup.alpha = slot0:_isPreference() and 1 or 0.5
end

function slot0._isPreference(slot0)
	if slot0._mo and RoomTrainCritterListModel.instance:getById(RoomTrainCritterListModel.instance:getSelectId()) and slot0._mo:chcekPrefernectCritterId(slot2:getDefineId()) then
		return true
	end

	return false
end

slot0.prefabPath = "ui/viewres/room/critter/roomtrainheroitem.prefab"

return slot0
