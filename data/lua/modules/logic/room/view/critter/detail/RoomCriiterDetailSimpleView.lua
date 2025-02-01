module("modules.logic.room.view.critter.detail.RoomCriiterDetailSimpleView", package.seeall)

slot0 = class("RoomCriiterDetailSimpleView", RoomCritterDetailView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagecard = gohelper.findChildSingleImage(slot0.viewGO, "#simage_card")
	slot0._imagesort = gohelper.findChildImage(slot0.viewGO, "#image_sort")
	slot0._txtsort = gohelper.findChildText(slot0.viewGO, "#image_sort/#txt_sort")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._gocrittericon = gohelper.findChild(slot0.viewGO, "critter/#go_crittericon")
	slot0._txttag1 = gohelper.findChildText(slot0.viewGO, "tag/#txt_tag1")
	slot0._txttag2 = gohelper.findChildText(slot0.viewGO, "tag/#txt_tag2")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_des")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#scroll_des/viewport/content/#txt_Desc")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "base/#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "base/#scroll_base/viewport/content/#go_baseitem")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "skill/#scroll_skill")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem")
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	slot0._txtskilldec = gohelper.findChildText(slot0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "starList")

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
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._critterMo = slot0.viewParam.critterMo

	gohelper.setActive(slot0._gobaseitem.gameObject, false)
	gohelper.setActive(slot0._goskillItem.gameObject, false)
	slot0:showInfo()
	slot0:setCritterIcon()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_ka2)
end

function slot0.onDestroyView(slot0)
	if slot0._simagecard then
		slot0._simagecard:UnLoadImage()
	end
end

function slot0.getAttrRatioColor(slot0)
	return "#222222", "#222222"
end

function slot0.setCritterIcon(slot0)
	if not slot0._critterIcon then
		slot0._critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
	end

	slot0._critterIcon:onUpdateMO(slot0._critterMo, true)
	slot0._critterIcon:hideMood()

	if slot0._simagecard then
		slot0._simagecard:LoadImage(ResUrl.getRoomCritterIcon(CritterConfig.instance:getCritterRareCfg(slot0._critterMo:getDefineCfg().rare).cardRes))
	end
end

function slot0.refrshCritterSpine(slot0)
end

return slot0
