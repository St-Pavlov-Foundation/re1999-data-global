module("modules.logic.fightresistancetip.view.FightResistanceTipView", package.seeall)

slot0 = class("FightResistanceTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goresistance = gohelper.findChild(slot0.viewGO, "#go_resistance")
	slot0._scrollresistance = gohelper.findChildScrollRect(slot0.viewGO, "#go_resistance/#scroll_resistance")
	slot0._goresistanceitem = gohelper.findChild(slot0.viewGO, "#go_resistance/#scroll_resistance/viewport/content/#go_resistanceitem")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_resistance/#scroll_resistance/viewport/content")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closedetail")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosedetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclosedetailOnClick(slot0)
	slot0:hideDescTip()
end

slot0.Interval = 10
slot0.MaxHeight = 535

function slot0._editableInitView(slot0)
	slot0.goDetailClose = slot0._btnclosedetail.gameObject

	gohelper.setActive(slot0._goresistanceitem, false)
	slot0:hideDescTip()

	slot0.rectTrResistance = slot0._goresistance:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrTips = slot0._gotips:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrScrollResistance = slot0._scrollresistance:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrContent = slot0._gocontent:GetComponent(gohelper.Type_RectTransform)
	slot0.itemList = {}
	slot0.rectTrViewGo = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrView = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.viewWidth = recthelper.getWidth(slot0.rectTrView)
	slot0.resistanceWidth = recthelper.getWidth(slot0.rectTrResistance)
	slot0.tipWidth = recthelper.getWidth(slot0.rectTrTips)
end

function slot0.onOpen(slot0)
	slot0.screenPos = slot0.viewParam.screenPos

	slot0:buildResistanceList(slot0.viewParam.resistanceDict)
	slot0:refreshResistanceItem()
	slot0:setAnchor()
	slot0:calculateMaxHeight()
	slot0:changeScrollHeight()
end

function slot0.buildResistanceList(slot0, slot1)
	slot0.resistanceList = slot0.resistanceList or {}
	slot0.resistanceDict = slot0.resistanceDict or {}

	tabletool.clear(slot0.resistanceList)
	tabletool.clear(slot0.resistanceDict)

	if not slot1 then
		return
	end

	slot0:buildResistanceListByReToughness(slot1, FightEnum.Resistance.controlResilience)
	slot0:buildResistanceListByReToughness(slot1, FightEnum.Resistance.delExPointResilience)
	slot0:buildResistanceListByReToughness(slot1, FightEnum.Resistance.stressUpResilience)
	slot0:buildResistanceListByResistanceDict(slot1)
end

function slot0.buildResistanceListByReToughness(slot0, slot1, slot2)
	slot3 = FightEnum.ToughnessToResistance[slot2]
	slot0.tempResistanceList = slot0.tempResistanceList or {}

	tabletool.clear(slot0.tempResistanceList)

	if slot0:getResistanceValue(slot1, slot2) and slot4 > 0 then
		table.insert(slot0.resistanceList, {
			resistanceId = slot2,
			value = slot4
		})

		slot0.resistanceDict[slot2] = true

		for slot8, slot9 in ipairs(slot3) do
			table.insert(slot0.tempResistanceList, {
				resistanceId = slot9,
				value = slot0:getResistanceValue(slot1, slot9)
			})

			slot0.resistanceDict[slot9] = true
		end

		table.sort(slot0.tempResistanceList, uv0.sortResistance)

		for slot8, slot9 in ipairs(slot0.tempResistanceList) do
			table.insert(slot0.resistanceList, slot9)
		end
	end
end

function slot0.buildResistanceListByResistanceDict(slot0, slot1)
	slot0.tempResistanceList = slot0.tempResistanceList or {}

	tabletool.clear(slot0.tempResistanceList)

	for slot5, slot6 in pairs(slot1) do
		if slot6 > 0 and FightEnum.Resistance[slot5] and not slot0.resistanceDict[slot7] then
			table.insert(slot0.tempResistanceList, {
				resistanceId = slot7,
				value = slot0:getResistanceValue(slot1, slot7)
			})

			slot0.resistanceDict[slot7] = true
		end
	end

	if #slot0.tempResistanceList > 0 then
		table.sort(slot0.tempResistanceList, uv0.sortResistance)

		for slot5, slot6 in ipairs(slot0.tempResistanceList) do
			table.insert(slot0.resistanceList, slot6)
		end
	end
end

function slot0.getResistanceValue(slot0, slot1, slot2)
	return FightHelper.getResistanceKeyById(slot2) and slot1[slot3] or 0
end

function slot0.refreshResistanceItem(slot0)
	for slot4, slot5 in pairs(slot0.resistanceList) do
		slot6 = slot0.itemList[slot4] or slot0:createResistanceItem()

		gohelper.setActive(slot6.go, true)

		slot7 = lua_character_attribute.configDict[slot5.resistanceId]

		UISpriteSetMgr.instance:setBuffSprite(slot6.imageIcon, slot7.icon)

		slot6.attrCo = slot7
		slot6.txtName.text = slot7.name
		slot6.txtValue.text = string.format("%s%%", math.floor(slot5.value / 10))
	end

	for slot4 = #slot0.resistanceList + 1, #slot0.itemList do
		gohelper.setActive(slot0.itemList[slot4].go, false)
	end

	slot0._scrollresistance.horizontalNormalizedPosition = 1
end

function slot0.calculateMaxHeight(slot0)
	slot0.maxHeight = recthelper.getHeight(slot0.rectTrViewGo) - math.abs(recthelper.getAnchorY(slot0.rectTrResistance)) - 50
end

function slot0.setAnchor(slot0)
	slot1, slot2 = recthelper.screenPosToAnchorPos2(slot0.screenPos, slot0.rectTrView)

	recthelper.setAnchor(slot0.rectTrResistance, slot1, slot2)

	if slot0.tipWidth <= slot0.viewWidth - (math.abs(slot1) + uv0.Interval + slot0.resistanceWidth) then
		recthelper.setAnchor(slot0.rectTrTips, slot1 - slot0.resistanceWidth - uv0.Interval, slot2)
	else
		recthelper.setAnchor(slot0.rectTrTips, slot1 + uv0.Interval + slot0.tipWidth, slot2)
	end
end

function slot0.changeScrollHeight(slot0)
	recthelper.setHeight(slot0.rectTrScrollResistance, math.min(recthelper.getHeight(slot0.rectTrContent), slot0.maxHeight))
end

function slot0.createResistanceItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goresistanceitem)
	slot1.imageIcon = gohelper.findChildImage(slot1.go, "#image_icon")
	slot1.txtName = gohelper.findChildText(slot1.go, "#txt_name")
	slot1.txtValue = gohelper.findChildText(slot1.go, "#txt_value")
	slot1.btnDetails = gohelper.findChildClickWithDefaultAudio(slot1.go, "#txt_name/icon/#btn_details")

	slot1.btnDetails:AddClickListener(slot0.onClickResistanceItem, slot0, slot1)
	table.insert(slot0.itemList, slot1)

	return slot1
end

function slot0.onClickResistanceItem(slot0, slot1)
	slot0:showDescTip()

	slot2 = slot1.attrCo
	slot0._txtname.text = slot2.name
	slot0._txtdesc.text = slot2.desc
end

function slot0.showDescTip(slot0)
	gohelper.setActive(slot0.goDetailClose, true)
	gohelper.setActive(slot0._gotips, true)
end

function slot0.hideDescTip(slot0)
	gohelper.setActive(slot0.goDetailClose, false)
	gohelper.setActive(slot0._gotips, false)
end

function slot0.sortResistance(slot0, slot1)
	if slot0.value ~= slot1.value then
		return slot1.value < slot0.value
	end

	return lua_character_attribute.configDict[slot0.resistanceId].sortId < lua_character_attribute.configDict[slot1.resistanceId].sortId
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.btnDetails:RemoveClickListener()
	end

	slot0.itemList = nil
end

return slot0
