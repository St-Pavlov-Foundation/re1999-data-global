module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.Va_1_2_CharacterTipView", package.seeall)

slot0 = class("Va_1_2_CharacterTipView", CharacterTipView)

function slot0.onInitView(slot0)
	slot0._goattributetip = gohelper.findChild(slot0.viewGO, "#go_attributetip")
	slot0._btnbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	slot0._goattributecontent = gohelper.findChild(slot0.viewGO, "#go_attributetip/scrollview/viewport/content")
	slot0._godetailcontent = gohelper.findChild(slot0.viewGO, "#go_attributetip/#go_detailContent")
	slot0._goattributecontentitem = gohelper.findChild(slot0.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	slot0._gopassiveskilltip = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip")
	slot0._goeffectdesc = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	slot0._goeffectdescitem = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	slot0._gomask1 = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	slot0._simageshadow = gohelper.findChildSingleImage(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	slot0._btnclosepassivetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbg:AddClickListener(slot0._btnbgOnClick, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onDragCallHandler, slot0)
	slot0._btnclosepassivetip:AddClickListener(slot0._btnclosepassivetipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbg:RemoveClickListener()
	slot0._scrollview:RemoveOnValueChanged()
	slot0._btnclosepassivetip:RemoveClickListener()
end

function slot0.refreshBaseAttrItem(slot0, slot1, slot2)
	slot5 = slot0:getTalentValues(slot2)
	slot6 = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for slot10, slot11 in ipairs(CharacterEnum.BaseAttrIdList) do
		gohelper.setActive(gohelper.findChild(slot0._attnormalitems[slot10].value.gameObject, "img_up"), slot6[slot11])

		slot13 = HeroConfig.instance:getHeroAttributeCO(slot11)
		slot0._attnormalitems[slot10].value.text = slot3[slot11]
		slot0._attnormalitems[slot10].addValue.text = slot0:getEquipAddBaseValues(slot1, slot0:getBaseAttrValueList(slot2))[slot11] + (slot5[slot11] and slot5[slot11].value or 0) + (slot6[slot11] or 0) == 0 and "" or "+" .. slot14
		slot0._attnormalitems[slot10].name.text = slot13.name

		CharacterController.instance:SetAttriIcon(slot0._attnormalitems[slot10].icon, slot11, GameUtil.parseColor("#323c34"))

		if slot13.isShowTips == 1 then
			slot16 = gohelper.getClick(slot0._attnormalitems[slot10].detail)

			slot16:AddClickListener(slot0.showDetail, slot0, {
				attributeId = slot13.id,
				icon = slot11,
				go = slot0._attnormalitems[slot10].go
			})
			table.insert(slot0._detailClickItems, slot16)
			gohelper.setActive(slot0._attnormalitems[slot10].detail, true)
		else
			gohelper.setActive(slot0._attnormalitems[slot10].detail, false)
		end

		if slot0._attnormalitems[slot10].withDesc then
			slot15, slot16 = slot0:calculateTechnic(slot3[CharacterEnum.AttrId.Technic], slot2)
			slot0._attnormalitems[slot10].desc.text = GameUtil.getSubPlaceholderLuaLang(CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc), {
				slot15,
				slot16
			})
		end
	end
end

function slot0.refreshUpAttrItem(slot0, slot1, slot2)
	slot6 = slot0:getTalentValues(slot2)
	slot7, slot8 = slot0:calculateTechnic(slot0:getBaseAttrValueList(slot2)[CharacterEnum.AttrId.Technic], slot2)
	slot9 = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for slot13, slot14 in ipairs(CharacterEnum.UpAttrIdList) do
		gohelper.setActive(gohelper.findChild(slot0._attrupperitems[slot13].value.gameObject, "img_up"), slot9[slot14])
		gohelper.setActive(slot0._attrupperitems[slot13].go, true)

		slot16 = HeroConfig.instance:getHeroAttributeCO(slot14)
		slot17 = slot0:getEquipBreakAddAttrValues(slot1)[slot14] + (slot6[slot14] and slot6[slot14].value or 0) + (slot9[slot14] or 0) / 10

		if slot14 == CharacterEnum.AttrId.Cri then
			slot18 = (slot0:_getTotalUpAttributes(slot2)[slot14] or 0) / 10 + slot7
		end

		if slot14 == CharacterEnum.AttrId.CriDmg then
			slot18 = slot18 + slot8
		end

		slot0._attrupperitems[slot13].value.text = tostring(GameUtil.noMoreThanOneDecimalPlace(slot18)) .. "%"
		slot0._attrupperitems[slot13].addValue.text = slot17 == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(slot17)) .. "%"
		slot0._attrupperitems[slot13].name.text = slot16.name

		CharacterController.instance:SetAttriIcon(slot0._attrupperitems[slot13].icon, slot14, CharacterTipView.AttrColor)

		if slot16.isShowTips == 1 then
			slot20 = gohelper.getClick(slot0._attrupperitems[slot13].detail)

			slot20:AddClickListener(slot0.showDetail, slot0, {
				attributeId = slot16.id,
				icon = slot14,
				go = slot0._attrupperitems[slot13].go
			})
			table.insert(slot0._detailClickItems, slot20)
			gohelper.setActive(slot0._attrupperitems[slot13].detail, true)
		else
			gohelper.setActive(slot0._attrupperitems[slot13].detail, false)
		end
	end
end

return slot0
