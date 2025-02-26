module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeView", package.seeall)

slot0 = class("V1a6_CachotUpgradeView", BaseView)

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
	slot0._gopresetcontent = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/#go_presetcontent")
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
	slot0._goupgrade = gohelper.findChild(slot0.viewGO, "bottom/#go_upgrade")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#go_upgrade/#btn_upgrade")
	slot0._txtupgrade = gohelper.findChildText(slot0.viewGO, "bottom/#go_upgrade/#btn_upgrade/txt_upgrade")
	slot0._txtupgradecost = gohelper.findChildText(slot0.viewGO, "bottom/#go_upgrade/#txt_upgradecost")
	slot0._gogiveup = gohelper.findChild(slot0.viewGO, "bottom/#go_giveup")
	slot0._btngiveup = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#go_giveup/#btn_giveup")
	slot0._txtgiveupcost = gohelper.findChildText(slot0.viewGO, "bottom/#go_giveup/#txt_giveupcost")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnswitch2:AddClickListener(slot0._btnswitch2OnClick, slot0)
	slot0._btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0)
	slot0._btngiveup:AddClickListener(slot0._btngiveupOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitch:RemoveClickListener()
	slot0._btnswitch2:RemoveClickListener()
	slot0._btnupgrade:RemoveClickListener()
	slot0._btngiveup:RemoveClickListener()
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

function slot0._btngiveupOnClick(slot0)
	if not slot0._anyCanUpgrade then
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0.closeThis, slot0)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox06, MsgBoxEnum.BoxType.Yes_No, function ()
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, uv0.viewParam.eventId, uv0.closeThis, uv0)
	end)
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

function slot0._btnupgradeOnClick(slot0)
	if not slot0._nextConfig then
		GameFacade.showToast(ToastEnum.V1a6CachotToast06)

		return
	end

	if slot0._nextConfig and slot0._rogueInfo.currency < slot0._nextConfig.cost then
		GameFacade.showToast(ToastEnum.V1a6CachotToast05)

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0._selectedTeamItem:getSeatIndex(), slot0._onSelectEnd, slot0)
end

function slot0._onSelectEnd(slot0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnSeatUpgradeSuccess)
end

function slot0._initPresetItemList(slot0)
	if slot0._presetItemList then
		return
	end

	slot0._presetItemList = slot0:getUserDataTb_()

	for slot5 = 1, V1a6_CachotEnum.HeroCountInGroup do
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gopresetcontent, "item" .. tostring(slot5)), V1a6_CachotTeamItem)
		slot0._presetItemList[slot5] = slot7

		slot7:setSelectEnable(true)
	end
end

function slot0._updatePresetItemList(slot0)
	slot0._anyCanUpgrade = false

	for slot4, slot5 in ipairs(slot0._presetItemList) do
		slot6 = V1a6_CachotHeroSingleGroupModel.instance:getById(slot4)
		slot7 = V1a6_CachotTeamModel.instance:getSeatLevel(slot4)

		V1a6_CachotTeamModel.instance:setSeatInfo(slot4, slot7, slot6)
		slot5:onUpdateMO(slot6)

		if lua_rogue_field.configDict[slot7 + 1] then
			if slot0._rogueInfo.currency < slot9.cost then
				slot5:setCost(string.format("<color=#D97373>-%s</color>", slot9.cost))
			else
				slot5:setCost("-" .. slot9.cost)

				slot0._anyCanUpgrade = true
			end
		else
			slot5:setCost()
		end
	end
end

function slot0._selectItem(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._presetItemList) do
		slot10 = slot1 and slot6 == slot1 or slot2 and slot7:getMo() == slot2

		slot7:setSelected(slot10)

		if slot10 then
			slot0._selectedIndex = slot6

			slot0:_showSeatInfo(slot7)
		end
	end
end

function slot0._setQuality(slot0, slot1, slot2, slot3, slot4)
	if not slot0[slot4] then
		slot0[slot4] = slot0:getUserDataTb_()

		for slot11 = 1, slot1.transform.childCount do
			slot12 = slot6:GetChild(slot11 - 1)
			slot5[slot12.name] = slot12

			for slot17 = 0, slot12:GetComponentsInChildren(gohelper.Type_Image, true).Length - 1 do
				slot13[slot17].maskable = true
			end
		end
	end

	for slot10, slot11 in pairs(slot5) do
		gohelper.setActive(slot11, slot10 == "effect_0" .. slot3)
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot2, "v1a6_cachot_quality_0" .. slot3)
end

function slot0._showSeatInfo(slot0, slot1)
	gohelper.setActive(slot0._gonormal, false)
	gohelper.setActive(slot0._gofull, false)

	slot2 = slot1:getSeatIndex()
	slot0._selectedTeamItem = slot1
	slot0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(slot2))
	slot5 = lua_rogue_field.configDict[V1a6_CachotTeamModel.instance:getSeatLevel(slot2) + 1]
	slot0._nextConfig = slot5

	gohelper.setActive(slot0._txtupgradecost, slot5)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnupgrade.gameObject, slot5 == nil)
	ZProj.UGUIHelper.SetGrayscale(slot0._txtupgrade.gameObject, slot5 == nil)

	if not slot5 then
		gohelper.setActive(slot0._gofull, true)

		return
	end

	gohelper.setActive(slot0._gonormal, true)

	slot6 = lua_rogue_field.configDict[slot3]

	slot0:_setQuality(slot0._goqualityeffect1, slot0._imagequality1, slot3, "effectListKey1")
	slot0:_setQuality(slot0._goqualityeffect2, slot0._imagequality2, slot4, "effectListKey2")

	slot0._txtbreaklevel1.text = "Lv." .. slot6.equipLevel
	slot0._txtbreaklevel2.text = "Lv." .. slot5.equipLevel
	slot0._txttalentlevel1.text = "Lv." .. slot6.talentLevel
	slot0._txttalentlevel2.text = "Lv." .. slot5.talentLevel
	slot8 = 6

	if slot1:getHeroMo() then
		slot8 = CharacterEnum.Star[slot7.config.rare]
	end

	slot0._roleStarNum.text = tostring(slot8)

	for slot12, slot13 in ipairs(slot0._roleStarList) do
		gohelper.setActive(slot13, slot12 <= slot8)
	end

	slot9 = slot0:_getLevelKey(slot8)

	slot0:_showDetailLevel(slot6[slot9], slot0._txtlevel1, slot0._rankList1)

	slot13 = slot0._txtlevel2
	slot14 = slot0._rankList2

	slot0:_showDetailLevel(slot5[slot9], slot13, slot14)

	for slot13, slot14 in ipairs(slot0._detailItemList) do
		slot0:_updateDetailItem(slot14, slot6, slot5, slot0:_getLevelKey(slot14.starNum))
	end

	if slot0._rogueInfo.currency < slot5.cost then
		slot0._txtupgradecost.text = string.format("<color=#D97373>-%s</color>", slot5.cost)
	else
		slot0._txtupgradecost.text = string.format("<color=#E6E5E1>-%s</color>", slot5.cost)
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
	slot0:_showDetailLevel(slot2[slot4], slot1.lv1, slot1._rankList1)
	slot0:_showDetailLevel(slot3[slot4], slot1.lv2, slot1._rankList2)
end

function slot0._showDetailLevel(slot0, slot1, slot2, slot3)
	slot4, slot5 = HeroConfig.instance:getShowLevel(slot1)
	slot2.text = "Lv." .. slot4

	for slot9, slot10 in ipairs(slot3) do
		gohelper.setActive(slot10, slot9 == slot5 - 1)
	end
end

function slot0._editableInitView(slot0)
	slot0:_initRoleLevelInfo()
	slot0:_initDetailItemList()
	gohelper.setActive(slot0._txtgiveupcost, false)

	slot0._animator = slot0.viewGO:GetComponent("Animator")
	slot0._detailAnimator = slot0._godetails:GetComponent("Animator")
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
	slot4.lvnum.text = tostring(slot2)
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

function slot0.onOpen(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	V1a6_CachotTeamModel.instance:clearSeatInfos()
	slot0:_initPresetItemList()
	slot0:_updatePresetItemList()
	slot0:_selectItem(1)
	slot0:_showUpSwitch(false)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, slot0._onClickTeamItem, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnSeatUpgradeSuccess, slot0._onSeatUpgradeSuccess, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotUpgradeResultView then
		slot0._animator.enabled = true

		slot0._animator:Play("close", 0, 0)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotUpgradeResultView then
		slot0._animator.enabled = true

		slot0._animator:Play("back", 0, 0)
		slot0:_updatePresetItemList()
		slot0:_selectItem(slot0._selectedIndex)
	end
end

function slot0._onSeatUpgradeSuccess(slot0)
	for slot4, slot5 in ipairs(slot0._presetItemList) do
		V1a6_CachotTeamModel.instance:setSeatInfo(slot4, V1a6_CachotTeamModel.instance:getSeatLevel(slot4), V1a6_CachotHeroSingleGroupModel.instance:getById(slot4))
	end

	V1a6_CachotController.instance:openV1a6_CachotUpgradeResultView({
		teamItemMo = slot0._selectedTeamItem:getMo(),
		seatIndex = slot0._selectedTeamItem:getSeatIndex()
	})
end

function slot0._onClickTeamItem(slot0, slot1)
	slot0._animator.enabled = true

	slot0._animator:Play("switch", 0, 0)
	slot0:_showUpSwitch(false)
	gohelper.setActive(slot0._godetails, false)
	TaskDispatcher.cancelTask(slot0._hideDetail, slot0)
	slot0:_selectItem(nil, slot1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._hideDetail, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
