module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

slot0 = class("FightBuffTipsView", BaseView)
slot1 = 635
slot2 = 597
slot3 = 300
slot4 = 141

function slot0._updateBuffDesc_overseas(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightBuffHelper.filterBuffType(tabletool.copy(slot0 and slot0:getBuffList() or {}), uv0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot5)
	table.sort(slot5, function (slot0, slot1)
		if slot0.time ~= slot1.time then
			return slot0.time < slot1.time
		end

		return slot0.id < slot1.id
	end)

	for slot9, slot10 in ipairs(slot1) do
		gohelper.setActive(slot10.go, false)
	end

	slot8 = -1
	slot9 = uv1
	slot10 = uv2
	slot11 = {}

	for slot15 = 1, slot5 and #slot5 or 0 do
		if lua_skill_buff.configDict[slot5[slot15].buffId] and slot17.isNoShow == 0 then
			if not slot1[0 + 1] then
				slot18 = slot3:getUserDataTb_()
				slot18.go = gohelper.cloneInPlace(slot2, "buff" .. slot7)
				slot18.getAnchorFunc = slot4
				slot18.viewClass = slot3

				table.insert(slot1, slot18)
			end

			slot19 = slot18.go
			slot8 = #slot1
			slot21 = gohelper.findChildText(slot19, "txt_desc")

			SkillHelper.addHyperLinkClick(slot21, uv0.onClickBuffHyperLink, slot18)

			slot23 = gohelper.findChild(slot19, "title")
			slot25 = gohelper.findChildText(slot23, "txt_name")
			slot29 = gohelper.findChildText(gohelper.findChild(slot23, "txt_name/go_tag"), "bg/txt_tagname")

			gohelper.setActive(slot19, true)
			gohelper.setActive(gohelper.findChild(slot19, "txt_desc/image_line"), true)

			slot11[#slot11 + 1] = slot21.transform
			slot11[#slot11 + 1] = slot23.transform
			slot11[#slot11 + 1] = slot19.transform
			slot11[#slot11 + 1] = slot21
			slot11[#slot11 + 1] = slot16
			slot32 = lua_skill_buff_desc.configDict[lua_skill_bufftype.configDict[slot17.typeId].type]

			uv0.showBuffTime(gohelper.findChildText(slot19, "title/txt_time"), slot16, slot17, slot0)

			slot25.text = slot17.name
			slot33 = slot25.preferredWidth

			if gohelper.findChildImage(slot19, "title/simage_icon") then
				UISpriteSetMgr.instance:setBuffSprite(slot26, slot17.iconId)
			end

			if slot32 then
				slot29.text = slot32.name
				slot33 = slot33 + slot29.preferredWidth
			end

			if uv3 < slot20.preferredWidth then
				slot33 = slot33 + math.max(0, slot34 - uv3)
			end

			if uv4 < slot33 then
				slot36 = uv2 + slot33 - uv4
				slot9 = math.max(slot9, slot36)
				slot10 = math.max(slot10, slot36)
			end

			gohelper.setActive(slot28, slot32)
		end
	end

	if #slot11 > 0 then
		for slot15 = 0, #slot11 - 1, 5 do
			slot18 = slot11[slot15 + 3]
			slot19 = slot11[slot15 + 4]
			slot20 = slot11[slot15 + 5]
			slot22 = lua_skill_buff.configDict[slot20.buffId]

			recthelper.setWidth(slot11[slot15 + 2], slot10 - 10)
			recthelper.setWidth(slot11[slot15 + 1], slot10 - 46)
			ZProj.UGUIHelper.RebuildLayout(slot18)
			recthelper.setWidth(slot18, slot10)

			slot19.text = FightBuffGetDescHelper.getBuffDesc(slot20)
			slot19.text = slot19.text

			recthelper.setHeight(slot18, slot19.preferredHeight + 52.1 + 10)
		end
	end

	for slot15 in pairs(slot11) do
		rawset(slot11, slot15, nil)
	end

	slot11 = nil

	if slot8 ~= -1 then
		gohelper.setActive(gohelper.findChild(slot1[slot8].go, "txt_desc/image_line"), false)
	end

	if slot3 then
		slot3._scrollbuff.verticalNormalizedPosition = 1

		recthelper.setWidth(slot3._scrollbuff.transform, slot9)
	end
end

function slot0._setPos(slot0, slot1)
	slot0.enemyBuffTipPosY = 80
	slot5 = recthelper.rectToRelativeAnchorPos(slot0.viewParam.iconPos, slot0._gobuffinfocontainer.transform.parent)
	slot6 = recthelper.getWidth(slot0._scrollbuff.transform)
	slot7 = recthelper.getHeight(slot0._scrollbuff.transform)
	slot8 = 0
	slot9 = 0

	if slot1.side == FightEnum.EntitySide.MySide then
		slot8 = slot5.x - slot0.viewParam.offsetX
		slot9 = slot5.y + slot0.viewParam.offsetY
	else
		slot8 = slot5.x + slot3
		slot9 = slot0.enemyBuffTipPosY
	end

	slot10 = UnityEngine.Screen.width * 0.5
	slot11 = 10
	slot12 = {
		min = -slot10 + slot6 + slot11,
		max = slot10 - slot6 - slot11
	}

	recthelper.setAnchor(slot0._gobuffinfocontainer.transform, GameUtil.clamp(slot8, slot12.min, slot12.max), slot9)
end

function slot0.onInitView(slot0)
	slot0._gobuffinfocontainer = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff")
	slot0._scrollbuff = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	slot0._btnclosebuffinfocontainer = gohelper.findChildButton(slot0.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebuffinfocontainer:AddClickListener(slot0._onCloseBuffInfoContainer, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebuffinfocontainer:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.rectTrScrollBuff = slot0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrBuffContent = gohelper.findChildComponent(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(slot0._gobuffitem, false)

	slot0._buffItemList = {}
end

function slot0._onCloseBuffInfoContainer(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/tips"), true)
	slot0:_updateBuffs(FightDataHelper.entityMgr:getById(slot0.viewParam.entityId or slot0.viewParam))

	if slot0.viewParam.viewname and slot0.viewParam.viewname == "FightView" then
		slot0:_setPos(slot1)
	else
		recthelper.setAnchorX(slot0._gobuffinfocontainer.transform, slot1.side == FightEnum.EntitySide.MySide and 207 or -161)
	end
end

function slot0._updateBuffs(slot0, slot1)
	uv0._updateBuffDesc_overseas(slot1, slot0._buffItemList, slot0._gobuffitem, slot0, slot0.getCommonBuffTipScrollAnchor)
end

slot0.Interval = 10

function slot0.getCommonBuffTipScrollAnchor(slot0, slot1, slot2)
	slot5 = slot0.rectTrScrollBuff
	slot7, slot8 = recthelper.uiPosToScreenPos2(slot5)
	slot9, slot10 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(slot7, slot8, slot1, CameraMgr.instance:getUICamera(), nil, )
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot15 = slot9

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= GameUtil.getViewSize() / 2 + slot9 - recthelper.getWidth(slot5) / 2 - uv0.Interval and slot15 - slot11 - uv0.Interval or slot15 + slot11 + uv0.Interval + slot13, slot10 + math.min(recthelper.getHeight(slot5), recthelper.getHeight(slot0.rectTrBuffContent)) / 2)
end

slot0.filterTypeKey = {
	[2.0] = true
}

function slot0.updateBuffDesc(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightBuffHelper.filterBuffType(tabletool.copy(slot0 and slot0:getBuffList() or {}), uv0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot5)
	table.sort(slot5, function (slot0, slot1)
		if slot0.time ~= slot1.time then
			return slot0.time < slot1.time
		end

		return slot0.id < slot1.id
	end)

	for slot9, slot10 in ipairs(slot1) do
		gohelper.setActive(slot10.go, false)
	end

	slot6 = slot5 and #slot5 or 0
	slot7 = 0

	for slot11 = 1, slot6 do
		if lua_skill_buff.configDict[slot5[slot11].buffId] and slot13.isNoShow == 0 then
			slot14 = lua_skill_bufftype.configDict[slot13.typeId]

			if not slot1[slot7 + 1] then
				slot15 = slot3:getUserDataTb_()
				slot15.go = gohelper.cloneInPlace(slot2, "buff" .. slot7)
				slot15.getAnchorFunc = slot4
				slot15.viewClass = slot3

				table.insert(slot1, slot15)
			end

			slot16 = slot15.go

			gohelper.setActive(slot16, true)
			uv0.showBuffTime(gohelper.findChildText(slot16, "title/txt_time"), slot12, slot13, slot0)

			slot18 = gohelper.findChildText(slot16, "txt_desc")

			SkillHelper.addHyperLinkClick(slot18, uv0.onClickBuffHyperLink, slot15)

			gohelper.findChildText(slot16, "title/txt_name").text = slot13.name
			slot19 = FightBuffGetDescHelper.getBuffDesc(slot12)

			recthelper.setHeight(slot16.transform, GameUtil.getTextHeightByLine(slot18, slot19, 52.1) + 62)

			slot18.text = slot19

			if gohelper.findChildImage(slot16, "title/simage_icon") then
				UISpriteSetMgr.instance:setBuffSprite(slot21, slot13.iconId)
			end

			slot22 = gohelper.findChild(slot16, "txt_desc/image_line")
			slot23 = gohelper.findChild(slot16, "title/txt_name/go_tag")

			if lua_skill_buff_desc.configDict[slot14.type] then
				gohelper.findChildText(slot16, "title/txt_name/go_tag/bg/txt_tagname").text = slot25.name
			end

			gohelper.setActive(slot23, slot25)
			gohelper.setActive(slot22, slot7 ~= slot6)

			slot3._scrollbuff.verticalNormalizedPosition = 1
		end
	end
end

function slot0.onClickBuffHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(slot1, slot0.getAnchorFunc, slot0.viewClass)
end

function slot0.showBuffTime(slot0, slot1, slot2, slot3)
	if FightBuffHelper.isCountContinueChanelBuff(slot1) then
		slot0.text = string.format(luaLang("enemytip_buff_time"), slot1.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(slot1) then
		slot0.text = string.format(luaLang("buff_tip_duration"), slot1.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(slot1) then
		slot0.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), slot1.duration, FightSkillBuffMgr.instance:getStackedCount(slot1.entityId, slot1))

		return
	end

	slot4 = lua_skill_bufftype.configDict[slot2.typeId]
	slot5, slot6 = FightSkillBuffMgr.instance:buffIsStackerBuff(slot2)

	if slot5 then
		if slot6 == FightEnum.BuffIncludeTypes.Stacked12 then
			slot0.text = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(slot3.id, slot1)) .. " " .. string.format(luaLang("enemytip_buff_time"), slot1.duration)
		else
			slot0.text = slot7
		end
	elseif slot1.duration == 0 then
		if slot1.count == 0 then
			slot0.text = luaLang("forever")
		else
			slot7 = slot1.count
			slot8 = "enemytip_buff_count"

			if string.split(slot4 and slot4.includeTypes or "", "#")[1] == "11" then
				slot8 = "enemytip_buff_stacked_count"
				slot7 = slot1.layer
			end

			slot0.text = string.format(luaLang(slot8), slot7)
		end
	elseif slot1.count == 0 then
		slot0.text = string.format(luaLang("enemytip_buff_time"), slot1.duration)
	else
		slot7 = slot1.count
		slot8 = "round_or_times"

		if string.split(slot4 and slot4.includeTypes or "", "#")[1] == "11" then
			slot8 = "round_or_stacked_count"
			slot7 = slot1.layer
		end

		slot0.text = GameUtil.getSubPlaceholderLuaLang(luaLang(slot8), {
			slot1.duration,
			slot7
		})
	end
end

return slot0
