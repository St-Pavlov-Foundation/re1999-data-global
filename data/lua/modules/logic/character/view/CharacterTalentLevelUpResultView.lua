module("modules.logic.character.view.CharacterTalentLevelUpResultView", package.seeall)

slot0 = class("CharacterTalentLevelUpResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._goclickmask = gohelper.findChild(slot0.viewGO, "clickmask")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._scrollup = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_up")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_up/Viewport/#go_Content")
	slot0._gocapacity = gohelper.findChild(slot0.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")
	slot0._txtleveluptip = gohelper.findChildText(slot0.viewGO, "leveluptip/tip")
	slot0._txtlevelup = gohelper.findChildText(slot0.viewGO, "leveluptip/tip/#txt_levelup")
	slot0._goeasoning = gohelper.findChild(slot0.viewGO, "esonan/#go_easoning")
	slot0._goesonan = gohelper.findChild(slot0.viewGO, "esonan/#go_esonan")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(gohelper.getClick(slot0._goclickmask), slot0._closeSelf, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_success)
end

function slot0.onUpdateParam(slot0)
end

function slot0._closeSelf(slot0)
	if ServerTime.now() - slot0.open_time < 2 then
		return
	end

	slot0:closeThis()
end

slot0.DebrisType = {
	Chess = 0,
	UnlockStyle = 5,
	Exclusive = 1,
	DebrisLevel = 3,
	DebrisCount = 2,
	DebrisCountAndLevel = 4
}

function slot0.onOpen(slot0)
	slot0.open_time = ServerTime.now()
	slot0.hero_id = slot0.viewParam
	slot0.hero_mo_data = HeroModel.instance:getByHeroId(slot0.hero_id)
	slot0._mainCubeId = slot0.hero_mo_data.talentCubeInfos.own_main_cube_id

	slot0:_bootLogic(slot0.hero_mo_data.talent, slot0.hero_mo_data.talent - 1)
	TaskDispatcher.runDelay(slot0._playScrollTween, slot0, 1.2)
	TaskDispatcher.runDelay(slot0._playAttrAni, slot0, 1.2)

	slot0._txtleveluptip.text = luaLang("talent_charactertalentlevelupresult_tip" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])

	gohelper.setActive(slot0._goeasoning, slot0.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(slot0._goesonan, slot0.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
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

	if TalentStyleModel.instance:getLevelUnlockStyle(slot0._mainCubeId, slot1) then
		table.insert({}, {
			up_type = uv0.DebrisType.UnlockStyle
		})
	end

	if slot0.target_model_config.allShape ~= slot0.old_model_config.allShape then
		table.insert(slot5, {
			up_type = uv0.DebrisType.Chess,
			value = slot0.target_model_config.allShape
		})
	end

	if slot4.exclusive ~= slot3.exclusive then
		slot7 = {
			[slot15] = slot16 - (slot10[slot15] or 0)
		}
		slot8 = {}
		slot9 = {}
		slot10 = string.splitToNumber(slot3.exclusive, "#") or {}

		for slot15, slot16 in ipairs(string.splitToNumber(slot4.exclusive, "#") or {}) do
			if slot16 ~= slot10[slot15] then
				-- Nothing
			end

			slot8[slot15] = slot16
			slot9[slot15] = slot10[slot15]
		end

		if not string.nilorempty(slot4.exclusive) then
			table.insert(slot5, {
				cube_id = slot11[1],
				up_type = uv0.DebrisType.Exclusive,
				new_debris = #slot10 == 0,
				value = slot7,
				target_value_tab = slot8,
				old_value_tab = slot9
			})
		end
	end

	for slot10 = 10, 20 do
		slot11 = "type" .. slot10

		if slot0.old_model_config[slot11] ~= slot0.target_model_config[slot11] and not string.nilorempty(slot13) then
			slot15 = {}
			slot16 = {}
			slot17 = string.splitToNumber(slot12, "#") or {}

			for slot22, slot23 in ipairs(string.splitToNumber(slot13, "#") or {}) do
				if slot23 ~= slot17[slot22] then
					-- Nothing
				end

				slot15[slot22] = slot23
				slot16[slot22] = slot17[slot22]
			end

			slot19 = nil

			if ({
				[slot22] = slot23 - (slot17[slot22] or 0)
			})[1] then
				if slot14[2] then
					slot19 = uv0.DebrisType.DebrisCountAndLevel
				else
					slot19 = uv0.DebrisType.DebrisCount
				end
			elseif slot14[2] then
				slot19 = uv0.DebrisType.DebrisLevel
			end

			table.insert(slot5, {
				cube_id = slot10,
				up_type = slot19,
				new_debris = #slot17 == 0,
				value = slot14,
				target_value_tab = slot15,
				old_value_tab = slot16
			})
		end
	end

	slot0.obj_list = slot0:getUserDataTb_()
	slot0._attr_ani_tab = slot0:getUserDataTb_()
	slot0._burst_effect_attr_tab = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot5, slot0._goContent, slot0._gocapacity)

	slot0._txtlevelup.text = string.format("Lv.<size=80>%s", slot0.target_lv)
end

function slot0._playScrollTween(slot0)
	slot0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
	slot0.parallel_sequence = slot0.parallel_sequence or FlowParallel.New()

	for slot4, slot5 in ipairs(slot0.obj_list) do
		slot6 = recthelper.getAnchorY(slot5)

		recthelper.setAnchorY(slot5, slot6 - 200)

		slot7 = FlowSequence.New()

		slot7:addWork(WorkWaitSeconds.New(0.03 * (slot4 - 1)))

		slot8 = FlowParallel.New()

		slot8:addWork(TweenWork.New({
			type = "DOAnchorPosY",
			t = 0.33,
			tr = slot5,
			to = slot6,
			ease = EaseType.OutQuart
		}))
		slot8:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.6,
			go = slot5.gameObject
		}))
		slot7:addWork(slot8)

		if slot4 == #slot0.obj_list then
			slot7:addWork(FunctionWork.New(function ()
				uv0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
			end))
		end

		slot0.parallel_sequence:addWork(slot7)
	end

	slot0.parallel_sequence:start({})
end

function slot0._playAttrAni(slot0)
	slot0._parallel_attr_sequence = slot0._parallel_attr_sequence or FlowParallel.New()

	for slot4 = 1, #slot0._attr_ani_tab do
		slot5 = FlowParallel.New()

		for slot9, slot10 in ipairs(slot0._attr_ani_tab[slot4]) do
			slot11 = FlowSequence.New()

			slot11:addWork(WorkWaitSeconds.New(0.06 * (slot9 - 1)))

			slot12 = FlowParallel.New()

			slot12:addWork(FunctionWork.New(function ()
				gohelper.findChildComponent(uv0, "", gohelper.Type_CanvasGroup).alpha = 1
				gohelper.findChildComponent(uv0, "", typeof(UnityEngine.Animator)).enabled = true

				gohelper.setActive(gohelper.findChild(uv0, "#new"), uv1._burst_effect_attr_tab[uv2][uv3])
			end))
			slot11:addWork(slot12)
			slot5:addWork(slot11)
		end

		slot0._parallel_attr_sequence:addWork(slot5)
	end

	slot0._parallel_attr_sequence:start({})
end

slot1 = {
	slot0.DebrisType.Chess,
	slot0.DebrisType.UnlockStyle
}

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot0._attr_ani_tab[slot3] = slot0:getUserDataTb_()
	slot0._burst_effect_attr_tab[slot3] = slot0:getUserDataTb_()
	slot1.name = slot2.cube_id or "shape"
	slot4 = slot1.transform
	slot5 = slot4:Find("cell/cell_bg/click").gameObject
	slot6 = slot4:Find("cell/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	slot7 = slot4:Find("cell/cell_bg"):GetComponent(gohelper.Type_Image)
	slot17 = not LuaUtil.tableContains(uv0, slot2.up_type)

	gohelper.setActive(slot4:Find("info/go_capacityTip").gameObject, slot2.up_type == uv1.DebrisType.Chess)
	gohelper.setActive(slot4:Find("info/go_numTip").gameObject, slot17 and slot2.up_type == uv1.DebrisType.DebrisCount)
	gohelper.setActive(slot4:Find("cell/go_new").gameObject, slot17 and slot2.new_debris)
	gohelper.setActive(slot4:Find("info/attr").gameObject, slot17)
	gohelper.setActive(slot4:Find("info/go_style").gameObject, slot2.up_type == uv1.DebrisType.UnlockStyle)

	slot4:Find("info/go_style/txt_unlocked"):GetComponent(gohelper.Type_TextMesh).text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType]))

	if slot2.up_type == uv1.DebrisType.Exclusive then
		gohelper.setActive(slot4:Find("info/go_level").gameObject, true)

		slot4:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh).text = "Lv." .. slot2.target_value_tab[2]
		slot4:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. slot2.value[2]
	elseif slot2.up_type == uv1.DebrisType.DebrisLevel then
		gohelper.setActive(slot14, true)

		slot15.text = "Lv." .. slot2.target_value_tab[2]
		slot16.text = "+" .. slot2.value[2]
	elseif slot2.up_type == uv1.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(slot14, true)

		slot15.text = "Lv." .. slot2.target_value_tab[2]
		slot16.text = "+" .. slot2.value[2]
	else
		gohelper.setActive(slot14, false)
	end

	if slot2.new_debris then
		slot16.text = ""
	end

	if slot14.activeInHierarchy then
		table.insert(slot0._attr_ani_tab[slot3], slot14)
		table.insert(slot0._burst_effect_attr_tab[slot3], false)
	end

	if slot10.activeInHierarchy then
		table.insert(slot0._attr_ani_tab[slot3], slot10)
		table.insert(slot0._burst_effect_attr_tab[slot3], false)
	end

	if slot11.activeInHierarchy then
		table.insert(slot0._attr_ani_tab[slot3], slot11)
		table.insert(slot0._burst_effect_attr_tab[slot3], false)
	end

	for slot23, slot24 in ipairs(slot0._attr_ani_tab[slot3]) do
		gohelper.findChildComponent(slot24, "", typeof(UnityEngine.Animator)).enabled = false
		gohelper.findChildComponent(slot24, "", gohelper.Type_CanvasGroup).alpha = 0
	end

	if slot2.up_type == uv1.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot6, "icon_danao", true)

		slot7.enabled = false
		slot10.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		slot10.transform:Find("name/value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(slot0.old_model_config.allShape, ",", luaLang("multiple"))
		slot10.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(slot2.value, ",", luaLang("multiple"))
		slot26 = slot0.target_lv

		for slot26 = 1, HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(slot0.hero_mo_data.heroId) do
			({
				[slot26] = {}
			})[slot26].cur_level = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(slot0.hero_mo_data.heroId, slot26)
		end
	elseif slot2.up_type ~= uv1.DebrisType.UnlockStyle then
		if not HeroConfig.instance:getTalentCubeAttrConfig(slot2.cube_id, slot2.target_value_tab[2]) then
			logError(slot2.cube_id, slot2.target_value_tab[2])
		end

		slot23 = HeroConfig.instance
		slot25 = slot23

		for slot25 = 1, slot23.getTalentCubeMaxLevel(slot25, slot2.cube_id) do
			({
				[slot25] = {}
			})[slot25].cur_level = slot20.level
		end

		if slot2.up_type == uv1.DebrisType.DebrisCount or slot2.up_type == uv1.DebrisType.DebrisCountAndLevel then
			slot11.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			slot11.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = slot2.target_value_tab[1]
			slot11.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. slot2.value[1]
		end

		slot0.hero_mo_data:getTalentStyleCubeAttr(slot2.cube_id, {}, nil, , slot2.target_value_tab[2])

		if (slot2.up_type == uv1.DebrisType.Exclusive or slot2.up_type == uv1.DebrisType.DebrisCountAndLevel or slot2.up_type == uv1.DebrisType.DebrisLevel) and slot2.old_value_tab[2] then
			slot0.hero_mo_data:getTalentStyleCubeAttr(slot2.cube_id, {}, nil, , slot2.old_value_tab[2] or 0)
		end

		slot24 = {}
		slot25 = HeroConfig.instance:getTalentCubeAttrConfig(slot2.cube_id, slot2.old_value_tab[2]) or slot20

		for slot29, slot30 in pairs(slot22) do
			slot31 = 0
			slot32 = false

			if slot23[slot29] then
				slot31 = slot30 - slot23[slot29]
			else
				slot32 = true
			end

			table.insert(slot24, {
				is_new_attr = slot32,
				debris_index = slot3,
				key = slot29,
				value = slot30,
				add_value = slot31,
				is_special = slot20.calculateType == 1,
				config = slot20,
				old_attr_config = slot25
			})
		end

		table.sort(slot24, function (slot0, slot1)
			return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
		end)
		gohelper.CreateObjList(slot0, slot0._onShowSingleCubeAttr, slot24, slot13, slot13.transform:Find("go_attrItem").gameObject)

		slot27 = string.split(HeroResonanceConfig.instance:getCubeConfig(slot2.cube_id).icon, "_")

		if slot0._mainCubeId == slot2.cube_id and slot0.hero_mo_data:getHeroUseStyleCubeId() ~= slot0._mainCubeId and HeroResonanceConfig.instance:getCubeConfig(slot29) and not string.nilorempty(slot30.icon) then
			slot26 = "mk_" .. slot31
			slot28 = "gz_" .. slot27[#slot27] .. "_2"
		end

		slot7.enabled = true

		UISpriteSetMgr.instance:setCharacterTalentSprite(slot6, slot26, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot7, slot28, true)
	end

	table.insert(slot0.obj_list, slot4)

	if slot2.up_type ~= uv1.DebrisType.Chess and slot2.new_debris then
		slot0:_setNewTipPos(slot12, slot2.cube_id)
	end
end

function slot0._setNewTipPos(slot0, slot1, slot2)
	if HeroResonanceConfig.instance:getCubeConfig(slot2).shape == nil then
		return
	end

	slot5 = string.splitToNumber(string.split(slot3, "#")[1], ",")

	recthelper.setAnchorY(slot1.transform, slot5[#slot5] == 0 and 1.4 or 13.3)
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
	gohelper.findChildComponent(slot1, "", typeof(UnityEngine.Animator)).enabled = false
	gohelper.findChildComponent(slot1, "", gohelper.Type_CanvasGroup).alpha = 0

	table.insert(slot0._attr_ani_tab[slot2.debris_index], slot1)
	table.insert(slot0._burst_effect_attr_tab[slot2.debris_index], slot2.is_new_attr)
end

function slot0._onCubeClick(slot0, slot1)
	if slot1.name ~= "shape" then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
		CharacterController.instance:openCharacterTalentTipView({
			open_type = 1,
			hero_id = slot0.hero_id,
			cube_id = tonumber(slot2)
		})
	end
end

function slot0.onClose(slot0)
	if slot0.parallel_sequence then
		slot0.parallel_sequence:destroy()
	end

	if slot0._parallel_attr_sequence then
		slot0._parallel_attr_sequence:destroy()
	end

	TaskDispatcher.cancelTask(slot0._playScrollTween, slot0)
	TaskDispatcher.cancelTask(slot0._playAttrAni, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
