module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeResultView", package.seeall)

slot0 = class("V1a6_CachotUpgradeResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "top/#simage_title")
	slot0._gohope = gohelper.findChild(slot0.viewGO, "top/#go_hope")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "top/#go_hope/bg/#go_progress")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "top/#go_hope/#txt_num1")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "top/#go_hope/#txt_num2")
	slot0._goshop = gohelper.findChild(slot0.viewGO, "top/#go_shop")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "top/#go_shop/#simage_icon")
	slot0._txtshopnum = gohelper.findChildText(slot0.viewGO, "top/#go_shop/#txt_shopnum")
	slot0._goteampresetitem = gohelper.findChild(slot0.viewGO, "#go_teampresetitem")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "right/#go_normal")
	slot0._txtorder = gohelper.findChildText(slot0.viewGO, "right/#go_normal/#txt_order")
	slot0._goqualityeffect1 = gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect1")
	slot0._imagequality1 = gohelper.findChildImage(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality1")
	slot0._goqualityeffect2 = gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect2")
	slot0._imagequality2 = gohelper.findChildImage(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	slot0._txtlevel1 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1")
	slot0._txtlevel2 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level2")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch")
	slot0._btnswitch2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch2")
	slot0._godetails = gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details")
	slot0._godetailitem = gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details/#go_detailitem")
	slot0._txtbreaklevel1 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel1")
	slot0._txtbreaklevel2 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel2")
	slot0._txttalentlevel1 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel1")
	slot0._txttalentlevel2 = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel2")
	slot0._gofull = gohelper.findChild(slot0.viewGO, "right/#go_full")
	slot0._goupgraded = gohelper.findChild(slot0.viewGO, "bottom/#go_upgraded")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnswitch2:AddClickListener(slot0._btnswitch2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btnswitch2:RemoveClickListener()
end

function slot0._btnswitchOnClick(slot0)
	slot0._detailAnimator:Play("close", 0, 0)
	slot0:_showUpSwitch(false)
	TaskDispatcher.cancelTask(slot0._hideDetail, slot0)
	TaskDispatcher.runDelay(slot0._hideDetail, slot0, 0.16)
end

function slot0._hideDetail(slot0)
	gohelper.setActive(slot0._godetails, false)
end

function slot0._btnswitch2OnClick(slot0)
	gohelper.setActive(slot0._godetails, true)
	slot0:_showUpSwitch(true)
	slot0._detailAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(slot0._hideDetail, slot0)
end

function slot0._showUpSwitch(slot0, slot1)
	gohelper.setActive(slot0._btnswitch, slot1)
	gohelper.setActive(slot0._btnswitch2, not slot1)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:_initRoleLevelInfo()
	slot0:_initDetailItemList()

	slot0._detailAnimator = slot0._godetails:GetComponent("Animator")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update)
end

function slot0._initRoleLevelInfo(slot0)
	slot0._roleStarList = slot0:getUserDataTb_()
	slot0._roleStarNum = gohelper.findChildText(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/#txt_num")

	for slot6 = 1, 1 do
		slot0._roleStarList[slot6] = gohelper.findChild(gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/rare"), "go_rare" .. slot6)
	end

	slot0._rankList1 = slot0:getUserDataTb_()
	slot0._rankList2 = slot0:getUserDataTb_()

	for slot6 = 1, 3 do
		table.insert(slot0._rankList1, gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1/rankobj/rank" .. slot6))
		table.insert(slot0._rankList2, gohelper.findChild(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/rankobj/rank" .. slot6))
	end
end

function slot0._initPresetItem(slot0)
	slot0._presetItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goteampresetitem), V1a6_CachotTeamItem)
end

function slot0._initDetailItemList(slot0)
	slot0._detailItemList = slot0:getUserDataTb_()
	slot1 = {}

	for slot5 = 6, 1, -1 do
		table.insert(slot1, slot5)
	end

	gohelper.CreateObjList(slot0, slot0._initDetailItem, slot1, slot0._godetails, slot0._godetailitem)
end

function slot0._initDetailItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.starNum = slot2
	slot4.lv1 = gohelper.findChildText(slot1, "txt_level1")
	slot4.lv2 = gohelper.findChildText(slot1, "txt_level2")
	slot4.lvnum = gohelper.findChildText(slot1, "#txt_num")
	slot8 = slot2
	slot4.lvnum.text = tostring(slot8)
	slot4._rankList1 = slot0:getUserDataTb_()
	slot4._rankList2 = slot0:getUserDataTb_()

	for slot8 = 1, 3 do
		table.insert(slot4._rankList1, gohelper.findChild(slot1, "txt_level1/rankobj/rank" .. slot8))
		table.insert(slot4._rankList2, gohelper.findChild(slot1, "rankobj/rank" .. slot8))
	end

	for slot9 = 1, 1 do
		gohelper.setActive(gohelper.findChild(slot1, "rare/go_rare" .. slot9), slot9 <= slot2)
	end

	gohelper.setActive(slot1, true)

	slot0._detailItemList[slot3] = slot4

	if slot3 == 6 then
		gohelper.setActive(slot1, false)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._teamItemMo = slot0.viewParam and slot0.viewParam.teamItemMo
	slot0._seatIndex = slot0.viewParam and slot0.viewParam.seatIndex
	slot0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(slot0._seatIndex))
	slot0._quality = gohelper.findChildImage(slot0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	slot0._qualityEffectList = slot0:getUserDataTb_()

	for slot6 = 1, slot0._goqualityeffect2.transform.childCount do
		slot7 = slot1:GetChild(slot6 - 1)
		slot0._qualityEffectList[slot7.name] = slot7
		slot12 = true

		for slot12 = 0, slot7:GetComponentsInChildren(gohelper.Type_Image, slot12).Length - 1 do
			slot8[slot12].maskable = true
		end
	end

	slot0:_initPresetItem()
	slot0._presetItem:onUpdateMO(slot0._teamItemMo)
	slot0:_showSeatInfo()
	slot0:_showUpSwitch(false)
end

function slot0._showSeatInfo(slot0)
	slot0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(slot0._seatIndex))
	slot2 = V1a6_CachotTeamModel.instance:getSeatLevel(slot0._seatIndex)
	slot3 = lua_rogue_field.configDict[slot2]
	slot9 = slot2
	slot8 = "v1a6_cachot_quality_0" .. slot9

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagequality2, slot8)

	for slot8, slot9 in pairs(slot0._qualityEffectList) do
		gohelper.setActive(slot9, slot8 == "effect_0" .. slot2)
	end

	slot0._txtbreaklevel2.text = "Lv." .. slot3.equipLevel
	slot0._txttalentlevel2.text = "Lv." .. slot3.talentLevel
	slot6 = 6

	if slot0._teamItemMo:getHeroMO() then
		slot6 = CharacterEnum.Star[slot5.config.rare]
	end

	slot10 = slot6
	slot0._roleStarNum.text = tostring(slot10)

	for slot10, slot11 in ipairs(slot0._roleStarList) do
		gohelper.setActive(slot11, slot10 <= slot6)
	end

	slot11 = slot3[slot0:_getLevelKey(slot6)]
	slot12 = slot0._txtlevel2

	slot0:_showDetailLevel(slot11, slot12, slot0._rankList2)

	for slot11, slot12 in ipairs(slot0._detailItemList) do
		slot0:_updateDetailItem(slot12, slot3, nil, slot0:_getLevelKey(slot12.starNum))
	end
end

function slot0._getLevelKey(slot0, slot1)
	if slot1 >= 5 then
		return "level" .. slot1
	else
		return "level4"
	end
end

function slot0._updateDetailItem(slot0, slot1, slot2, slot3, slot4)
	slot0:_showDetailLevel(slot2[slot4], slot1.lv2, slot1._rankList2)
end

function slot0._showDetailLevel(slot0, slot1, slot2, slot3)
	slot4, slot5 = HeroConfig.instance:getShowLevel(slot1)
	slot2.text = "Lv." .. slot4

	for slot9, slot10 in ipairs(slot3) do
		gohelper.setActive(slot10, slot9 == slot5 - 1)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._hideDetail, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
