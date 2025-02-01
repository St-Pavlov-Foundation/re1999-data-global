module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

slot0 = class("FightBuffTipsView", BaseView)
slot1 = 635
slot2 = 597
slot3 = 300

function slot0._updateBuffDesc_overseas(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightBuffHelper.filterBuffType(tabletool.copy(slot0.buffModel and slot0.buffModel:getList() or {}), uv0.filterTypeKey)

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
			slot26 = gohelper.findChildImage(slot19, "title/simage_icon")
			slot29 = gohelper.findChildText(gohelper.findChild(slot23, "txt_name/go_tag"), "bg/txt_tagname")

			gohelper.setActive(slot19, true)
			gohelper.setActive(gohelper.findChild(slot19, "txt_desc/image_line"), true)

			slot11[#slot11 + 1] = slot21.transform
			slot11[#slot11 + 1] = slot23.transform
			slot11[#slot11 + 1] = slot19.transform
			slot11[#slot11 + 1] = slot21
			slot11[#slot11 + 1] = slot16
			slot32 = lua_skill_buff_desc.configDict[lua_skill_bufftype.configDict[slot17.typeId].type]
			slot33, slot34 = FightSkillBuffMgr.instance:buffIsStackerBuff(slot17)

			if slot33 then
				if slot34 == FightEnum.BuffIncludeTypes.Stacked12 then
					gohelper.findChildText(slot19, "title/txt_time").text = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(slot0.id, slot17.id)) .. " " .. string.format(luaLang("enemytip_buff_time"), slot16.duration)
				else
					slot20.text = slot35
				end
			elseif FightBuffHelper.isCountContinueChanelBuff(slot16) then
				slot20.text = string.format(luaLang("enemytip_buff_time"), slot16.exInfo)
			elseif slot16.duration == 0 then
				if slot16.count == 0 then
					slot20.text = luaLang("forever")
				else
					slot35 = slot16.count
					slot36 = "enemytip_buff_count"

					if string.split(slot31 and slot31.includeTypes or "", "#")[1] == "11" then
						slot36 = "enemytip_buff_stacked_count"
						slot35 = slot16.layer
					end

					slot20.text = string.format(luaLang(slot36), slot35)
				end
			elseif slot16.count == 0 then
				slot20.text = string.format(luaLang("enemytip_buff_time"), slot16.duration)
			else
				slot35 = slot16.count
				slot36 = "round_or_times"

				if string.split(slot31 and slot31.includeTypes or "", "#")[1] == "11" then
					slot36 = "round_or_stacked_count"
					slot35 = slot16.layer
				end

				slot20.text = GameUtil.getSubPlaceholderLuaLang(luaLang(slot36), {
					slot16.duration,
					slot35
				})
			end

			slot25.text = slot17.name
			slot35 = slot25.preferredWidth

			if slot26 then
				UISpriteSetMgr.instance:setBuffSprite(slot26, slot17.iconId)
			end

			if slot32 then
				slot29.text = slot32.name
				slot35 = slot35 + slot29.preferredWidth
			end

			if uv3 < slot35 then
				slot37 = uv2 + slot35 - uv3
				slot9 = math.max(slot9, slot37)
				slot10 = math.max(slot10, slot37)
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
	slot0:_updateBuffs(FightEntityModel.instance:getById(slot0.viewParam.entityId))

	if slot0.viewParam.viewname and slot0.viewParam.viewname == "FightView" then
		slot0:_setPos(slot1)
	else
		recthelper.setAnchorX(slot0._gobuffinfocontainer.transform, slot1.side == FightEnum.EntitySide.MySide and 207 or -161)
	end
end

function slot0._updateBuffs(slot0, slot1)
	uv0._updateBuffDesc_overseas(slot1, slot0._buffItemList, slot0._gobuffitem, slot0, slot0.getCommonBuffTipScrollAnchor)
end

function slot0.getCommonBuffTipScrollAnchor(slot0, slot1, slot2)
	slot3 = CameraMgr.instance:getUICamera()
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot4, slot5 = recthelper.worldPosToAnchorPos2(slot0.rectTrScrollBuff.position, slot1, slot3, slot3)

	recthelper.setAnchor(slot2, slot4 - recthelper.getWidth(slot0.rectTrScrollBuff) / 2, slot5 + recthelper.getHeight(slot0.rectTrScrollBuff) / 2)
end

slot0.filterTypeKey = {
	[2.0] = true
}

function slot0.updateBuffDesc(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightBuffHelper.filterBuffType(tabletool.copy(slot0 and slot0.buffModel and slot0.buffModel:getList() or {}), uv0.filterTypeKey)

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

			slot18, slot19 = FightSkillBuffMgr.instance:buffIsStackerBuff(slot13)

			if slot18 then
				if slot19 == FightEnum.BuffIncludeTypes.Stacked12 then
					gohelper.findChildText(slot16, "title/txt_time").text = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(slot0.id, slot13.id)) .. " " .. string.format(luaLang("enemytip_buff_time"), slot12.duration)
				else
					slot17.text = slot20
				end
			elseif FightBuffHelper.isCountContinueChanelBuff(slot12) then
				slot17.text = string.format(luaLang("enemytip_buff_time"), slot12.exInfo)
			elseif slot12.duration == 0 then
				if slot12.count == 0 then
					slot17.text = luaLang("forever")
				else
					slot20 = slot12.count
					slot21 = "enemytip_buff_count"

					if string.split(slot14 and slot14.includeTypes or "", "#")[1] == "11" then
						slot21 = "enemytip_buff_stacked_count"
						slot20 = slot12.layer
					end

					slot17.text = string.format(luaLang(slot21), slot20)
				end
			elseif slot12.count == 0 then
				slot17.text = string.format(luaLang("enemytip_buff_time"), slot12.duration)
			else
				slot20 = slot12.count
				slot21 = "round_or_times"

				if string.split(slot14 and slot14.includeTypes or "", "#")[1] == "11" then
					slot21 = "round_or_stacked_count"
					slot20 = slot12.layer
				end

				slot17.text = GameUtil.getSubPlaceholderLuaLang(luaLang(slot21), {
					slot12.duration,
					slot20
				})
			end

			slot20 = gohelper.findChildText(slot16, "txt_desc")

			SkillHelper.addHyperLinkClick(slot20, uv0.onClickBuffHyperLink, slot15)

			gohelper.findChildText(slot16, "title/txt_name").text = slot13.name
			slot21 = FightBuffGetDescHelper.getBuffDesc(slot12)

			recthelper.setHeight(slot16.transform, GameUtil.getTextHeightByLine(slot20, slot21, 52.1) + 62)

			slot20.text = slot21

			if gohelper.findChildImage(slot16, "title/simage_icon") then
				UISpriteSetMgr.instance:setBuffSprite(slot23, slot13.iconId)
			end

			slot24 = gohelper.findChild(slot16, "txt_desc/image_line")
			slot25 = gohelper.findChild(slot16, "title/txt_name/go_tag")

			if lua_skill_buff_desc.configDict[slot14.type] then
				gohelper.findChildText(slot16, "title/txt_name/go_tag/bg/txt_tagname").text = slot27.name
			end

			gohelper.setActive(slot25, slot27)
			gohelper.setActive(slot24, slot7 ~= slot6)

			slot3._scrollbuff.verticalNormalizedPosition = 1
		end
	end
end

function slot0.onClickBuffHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(slot1, slot0.getAnchorFunc, slot0.viewClass)
end

return slot0
