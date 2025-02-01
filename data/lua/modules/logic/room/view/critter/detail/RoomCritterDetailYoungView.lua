module("modules.logic.room.view.critter.detail.RoomCritterDetailYoungView", package.seeall)

slot0 = class("RoomCritterDetailYoungView", RoomCritterDetailView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._goyoung = gohelper.findChild(slot0.viewGO, "#go_young")
	slot0._scrollcritter = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/#scroll_critter")
	slot0._gocritteritem = gohelper.findChild(slot0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem")
	slot0._gocrittericon = gohelper.findChild(slot0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem/#go_crittericon")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")
	slot0._imagesort = gohelper.findChildImage(slot0.viewGO, "#go_young/Left/#go_detail/#image_sort")
	slot0._txtsort = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#image_sort/#txt_sort")
	slot0._txttag1 = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag1")
	slot0._txttag2 = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag2")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/#go_detail/#scroll_des")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/base/#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/#scroll_base/viewport/content/#go_baseitem")
	slot0._btnattrclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_young/Left/base/basetips/#btn_attrclose")
	slot0._scrolltipbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	slot0._gobasetipsitem = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/skill/#scroll_skill")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	slot0._gocritterlive2d = gohelper.findChild(slot0.viewGO, "#go_young/Right/#go_critterlive2d")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail/starList")
	slot0._gotipbase = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/basetips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnattrclose:AddClickListener(slot0._btnattrcloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnattrclose:RemoveClickListener()
end

function slot0._btnattrcloseOnClick(slot0)
	gohelper.setActive(slot0._gotipbase.gameObject, false)
end

function slot0._btnLockOnClick(slot0)
	CritterRpc.instance:sendLockCritterRequest(slot0._critterMo.uid, not slot0._critterMo.lock, slot0.refreshLock, slot0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if slot0._goLock then
		slot0._lockbtn = SLFramework.UGUI.UIClickListener.Get(gohelper.findChild(slot0._goLock, "clickarea"))

		slot0._lockbtn:AddClickListener(slot0._btnLockOnClick, slot0)
	end
end

function slot0.onOpen(slot0)
	slot0._critterMo = slot0.viewParam.critterMo
	slot0._critterMoList = slot0.viewParam.critterMos

	if slot0._critterMoList then
		gohelper.setActive(slot0._scrollcritter.gameObject, true)

		slot0._selectCritterIndex = 1
		slot0._critterMo = slot0._critterMoList and slot0._critterMoList[slot0._selectCritterIndex]

		slot0:setCritter()
	else
		gohelper.setActive(slot0._scrollcritter.gameObject, false)
	end

	if not slot0._critterMo then
		return
	end

	gohelper.setActive(slot0._gobaseitem.gameObject, false)
	gohelper.setActive(slot0._goskillItem.gameObject, false)

	if slot0._goLock then
		gohelper.setActive(slot0._goLock.gameObject, not slot0.viewParam.isPreview)
	end

	slot0:onRefresh()
	slot0:initAttrInfo()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function slot0.onRefresh(slot0)
	if slot0._critterMoList then
		slot0._critterMo = slot0._critterMoList and slot0._critterMoList[slot0._selectCritterIndex]
	else
		slot0._critterMo = slot0.viewParam.critterMo
	end

	uv0.super.onRefresh(slot0)
end

function slot0.setCritter(slot0)
	if not slot0._scrollcritter or not slot0._critterMoList then
		return
	end

	for slot5 = 1, #slot0._critterMoList do
		slot6 = slot0._critterMoList[slot5]

		if not slot0:getCritterItem(slot5)._critterIcon then
			slot7._critterIcon = IconMgr.instance:getCommonCritterIcon(slot7.critterGo)
		end

		slot7._critterIcon:onUpdateMO(slot6, true)
		slot7._critterIcon:hideMood()
		slot7._critterIcon:setSelectUIVisible(slot5 == slot0._selectCritterIndex)
		slot7._critterIcon:onSelect(slot5 == slot0._selectCritterIndex)
		slot7._critterIcon:setCustomClick(slot0._btnCritterOnClick, slot0, slot5)
		gohelper.setActive(slot7.line, slot5 < slot1)
	end

	if slot0._critterItems then
		for slot5, slot6 in ipairs(slot0._critterItems) do
			gohelper.setActive(slot6.go, slot5 <= slot1)
		end
	end
end

function slot0._btnCritterOnClick(slot0, slot1)
	slot0._selectCritterIndex = slot1

	if slot0._critterItems then
		for slot5, slot6 in ipairs(slot0._critterItems) do
			slot6._critterIcon:setSelectUIVisible(slot5 == slot0._selectCritterIndex)
			slot6._critterIcon:onSelect(slot5 == slot0._selectCritterIndex)
		end
	end

	gohelper.setActive(slot0._gotipbase.gameObject, false)
	slot0:onRefresh()
end

function slot0.getCritterItem(slot0, slot1)
	if not slot0._critterItems then
		slot0._critterItems = slot0:getUserDataTb_()
	end

	if not slot0._critterItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gocritteritem)
		slot0._critterItems[slot1] = {
			go = slot3,
			critterGo = gohelper.findChild(slot3, "#go_crittericon"),
			line = gohelper.findChild(slot3, "line")
		}
	end

	return slot2
end

function slot0.getAttrRatio(slot0, slot1, slot2)
	if slot0.viewParam.isPreview then
		if CritterIncubateModel.instance:getSelectParentCritterMoByid(slot0._critterMo:getDefineId()) and slot4:getAttributeInfoByType(slot1) then
			if math.floor((slot2:getRate() - slot5:getRate()) * 100) / 100 == 0 then
				return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_attr_rate"), slot7)
			else
				return GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(slot8 > 0 and "room_preview_critter_attr_add_ratio" or "room_preview_critter_attr_reduce_ratio"), slot7, slot8)
			end
		end
	else
		return slot2:getRateStr()
	end
end

return slot0
