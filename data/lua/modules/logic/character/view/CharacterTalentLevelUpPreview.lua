module("modules.logic.character.view.CharacterTalentLevelUpPreview", package.seeall)

slot0 = class("CharacterTalentLevelUpPreview", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrollup = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_up")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_up/Viewport/#go_Content")
	slot0._gocapacity = gohelper.findChild(slot0.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0.onOpen, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0.hero_mo_data = slot1
end

function slot0.onOpen(slot0)
	slot0.hero_mo_data = slot0.viewParam
	slot0._scrollup.verticalNormalizedPosition = 1

	slot0:_bootLogic(slot0.hero_mo_data.talent + 1, slot0.hero_mo_data.talent)
end

function slot0._bootLogic(slot0, slot1, slot2)
	slot0.target_lv = slot1
	slot0.old_level = slot2
	slot3 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot2) or {}
	slot4 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot1)
	slot0.old_model_config = HeroResonanceConfig.instance:getTalentModelConfig(slot0.hero_mo_data.heroId, slot2) or {}
	slot0.target_model_config = HeroResonanceConfig.instance:getTalentModelConfig(slot0.hero_mo_data.heroId, slot1)

	gohelper.setActive(slot0._goContent, slot0.target_model_config ~= nil)

	if not slot0.target_model_config then
		return
	end

	if slot0.target_model_config.allShape ~= slot0.old_model_config.allShape then
		table.insert({}, {
			up_type = CharacterTalentLevelUpResultView.DebrisType.Chess,
			value = slot0.target_model_config.allShape
		})
	end

	if slot4.exclusive ~= slot3.exclusive then
		slot6 = {
			[slot14] = slot15 - (slot9[slot14] or 0)
		}
		slot7 = {}
		slot8 = {}
		slot9 = string.splitToNumber(slot3.exclusive, "#") or {}

		for slot14, slot15 in ipairs(string.splitToNumber(slot4.exclusive, "#") or {}) do
			if slot15 ~= slot9[slot14] then
				-- Nothing
			end

			slot7[slot14] = slot15
			slot8[slot14] = slot9[slot14]
		end

		if not string.nilorempty(slot4.exclusive) then
			table.insert(slot5, {
				cube_id = slot10[1],
				up_type = CharacterTalentLevelUpResultView.DebrisType.Exclusive,
				new_debris = #slot9 == 0,
				value = slot6,
				target_value_tab = slot7,
				old_value_tab = slot8
			})
		end
	end

	for slot9 = 10, 20 do
		slot10 = "type" .. slot9

		if slot0.old_model_config[slot10] ~= slot0.target_model_config[slot10] and not string.nilorempty(slot12) then
			slot14 = {}
			slot15 = {}
			slot16 = string.splitToNumber(slot11, "#") or {}

			for slot21, slot22 in ipairs(string.splitToNumber(slot12, "#") or {}) do
				if slot22 ~= slot16[slot21] then
					-- Nothing
				end

				slot14[slot21] = slot22
				slot15[slot21] = slot16[slot21]
			end

			slot18 = nil

			if ({
				[slot21] = slot22 - (slot16[slot21] or 0)
			})[1] then
				if slot13[2] then
					slot18 = CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel
				else
					slot18 = CharacterTalentLevelUpResultView.DebrisType.DebrisCount
				end
			elseif slot13[2] then
				slot18 = CharacterTalentLevelUpResultView.DebrisType.DebrisLevel
			end

			table.insert(slot5, {
				cube_id = slot9,
				up_type = slot18,
				new_debris = #slot16 == 0,
				value = slot13,
				target_value_tab = slot14,
				old_value_tab = slot15
			})
		end
	end

	slot0.obj_list = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot5, slot0._goContent, slot0._gocapacity)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1.name = slot2.cube_id or "shape"
	slot4 = slot1.transform
	slot5 = slot4:Find("cellicon/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("cellicon/cell_bg"):GetComponent(gohelper.Type_Image)

	gohelper.setActive(slot4:Find("info/go_capacityTip").gameObject, slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess)
	gohelper.setActive(slot4:Find("info/go_numTip").gameObject, slot2.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess and (slot2.new_debris or slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount))
	gohelper.setActive(slot4:Find("info/attr").gameObject, slot2.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess)

	if slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive then
		gohelper.setActive(slot4:Find("info/go_level").gameObject, true)

		slot4:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh).text = "Lv." .. slot2.target_value_tab[2]
		slot4:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. slot2.value[2]
	elseif slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel then
		gohelper.setActive(slot10, true)

		slot11.text = "Lv." .. slot2.target_value_tab[2]
		slot12.text = "+" .. slot2.value[2]
	elseif slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(slot10, true)

		slot11.text = "Lv." .. slot2.target_value_tab[2]
		slot12.text = "+" .. slot2.value[2]
	else
		gohelper.setActive(slot10, false)
	end

	if slot2.new_debris then
		slot12.text = ""
	end

	if slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot5, "icon_danao01", true)

		slot6.enabled = false
		slot7.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		slot7.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(slot0.old_model_config.allShape, ",", luaLang("multiple"))
		slot7.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(slot2.value, ",", luaLang("multiple"))

		for slot19 = 1, HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(slot0.hero_mo_data.heroId) do
			({
				[slot19] = {}
			})[slot19].cur_level = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(slot0.hero_mo_data.heroId, slot0.target_lv)
		end
	else
		if not HeroConfig.instance:getTalentCubeAttrConfig(slot2.cube_id, slot2.target_value_tab[2]) then
			logError(slot2.cube_id, slot2.target_value_tab[2])
		end

		slot18 = slot2.cube_id

		for slot18 = 1, HeroConfig.instance:getTalentCubeMaxLevel(slot18) do
			({
				[slot18] = {}
			})[slot18].cur_level = slot13.level
		end

		if slot2.new_debris then
			slot8.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = "<color=#975129>" .. luaLang("talent_new_debris") .. "</color>"
			slot8.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = ""
			slot8.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = ""
		elseif slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount or slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
			slot8.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			slot8.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = slot2.target_value_tab[1]
			slot8.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. slot2.value[1]
		end

		slot0.hero_mo_data:getTalentStyleCubeAttr(slot2.cube_id, {}, nil, , slot2.target_value_tab[2])

		if (slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive or slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel or slot2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel) and slot2.old_value_tab[2] then
			slot0.hero_mo_data:getTalentStyleCubeAttr(slot2.cube_id, {}, nil, , slot2.old_value_tab[2] or 0)
		end

		slot17 = {}
		slot18 = HeroConfig.instance:getTalentCubeAttrConfig(slot2.cube_id, slot2.old_value_tab[2]) or slot13

		for slot22, slot23 in pairs(slot15) do
			slot24 = 0

			if slot16[slot22] then
				slot24 = slot23 - slot16[slot22]
			end

			table.insert(slot17, {
				key = slot22,
				value = slot23,
				add_value = slot24,
				is_special = slot13.calculateType == 1,
				config = slot13,
				old_attr_config = slot18
			})
		end

		table.sort(slot17, function (slot0, slot1)
			return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
		end)
		gohelper.CreateObjList(slot0, slot0._onShowSingleCubeAttr, slot17, slot9, slot9.transform:Find("go_attrItem").gameObject)

		slot6.enabled = true
		slot19 = HeroResonanceConfig.instance:getCubeConfig(slot2.cube_id).icon

		UISpriteSetMgr.instance:setCharacterTalentSprite(slot5, "glow_" .. slot19, true)

		slot20 = string.split(slot19, "_")

		UISpriteSetMgr.instance:setCharacterTalentSprite(slot6, "gz_" .. slot20[#slot20], true)
	end

	table.insert(slot0.obj_list, slot4)
end

function slot0._onDebrisStarItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.transform:Find("lighticon").gameObject, slot3 <= slot2.cur_level)
end

function slot0._onShowSingleCubeAttr(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot7 = slot4:Find("value"):GetComponent(gohelper.Type_TextMesh)
	slot8 = slot4:Find("addvalue"):GetComponent(gohelper.Type_TextMesh)
	slot9 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key))
	slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot9.name

	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot9.id)

	slot10 = slot2.add_value

	if slot9.type ~= 1 then
		slot2.value = slot2.value / 10 .. "%"
		slot2.add_value = slot2.add_value / 10 .. "%"
	elseif not slot2.is_special then
		slot2.value = slot2.config[slot2.key] / 10 .. "%"
		slot2.add_value = (slot2.config[slot2.key] - slot2.old_attr_config[slot2.key]) / 10 .. "%"
	else
		slot2.value = math.floor(slot2.value)
		slot2.add_value = math.floor(slot2.add_value)
	end

	slot7.text = slot2.value
	slot8.text = slot10 == 0 and "" or "+" .. slot2.add_value
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.definePrefabUrl(slot0)
	slot0:setPrefabUrl("ui/viewres/character/charactertalentup/charactertalentleveluppreview.prefab")
end

return slot0
