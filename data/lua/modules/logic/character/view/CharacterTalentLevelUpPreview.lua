module("modules.logic.character.view.CharacterTalentLevelUpPreview", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpPreview", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_up")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_up/Viewport/#go_Content")
	arg_1_0._gocapacity = gohelper.findChild(arg_1_0.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0.onOpen, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onRefreshViewParam(arg_7_0, arg_7_1)
	arg_7_0.hero_mo_data = arg_7_1
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.hero_mo_data = arg_8_0.viewParam
	arg_8_0._scrollup.verticalNormalizedPosition = 1

	arg_8_0:_bootLogic(arg_8_0.hero_mo_data.talent + 1, arg_8_0.hero_mo_data.talent)
end

function var_0_0._bootLogic(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.target_lv = arg_9_1
	arg_9_0.old_level = arg_9_2

	local var_9_0 = HeroResonanceConfig.instance:getTalentConfig(arg_9_0.hero_mo_data.heroId, arg_9_2) or {}
	local var_9_1 = HeroResonanceConfig.instance:getTalentConfig(arg_9_0.hero_mo_data.heroId, arg_9_1)

	arg_9_0.old_model_config = HeroResonanceConfig.instance:getTalentModelConfig(arg_9_0.hero_mo_data.heroId, arg_9_2) or {}
	arg_9_0.target_model_config = HeroResonanceConfig.instance:getTalentModelConfig(arg_9_0.hero_mo_data.heroId, arg_9_1)

	gohelper.setActive(arg_9_0._goContent, arg_9_0.target_model_config ~= nil)

	if not arg_9_0.target_model_config then
		return
	end

	local var_9_2 = {}

	if arg_9_0.target_model_config.allShape ~= arg_9_0.old_model_config.allShape then
		table.insert(var_9_2, {
			up_type = CharacterTalentLevelUpResultView.DebrisType.Chess,
			value = arg_9_0.target_model_config.allShape
		})
	end

	if var_9_1.exclusive ~= var_9_0.exclusive then
		local var_9_3 = {}
		local var_9_4 = {}
		local var_9_5 = {}
		local var_9_6 = string.splitToNumber(var_9_0.exclusive, "#") or {}
		local var_9_7 = string.splitToNumber(var_9_1.exclusive, "#") or {}

		for iter_9_0, iter_9_1 in ipairs(var_9_7) do
			if iter_9_1 ~= var_9_6[iter_9_0] then
				var_9_3[iter_9_0] = iter_9_1 - (var_9_6[iter_9_0] or 0)
			end

			var_9_4[iter_9_0] = iter_9_1
			var_9_5[iter_9_0] = var_9_6[iter_9_0]
		end

		if not string.nilorempty(var_9_1.exclusive) then
			table.insert(var_9_2, {
				cube_id = var_9_7[1],
				up_type = CharacterTalentLevelUpResultView.DebrisType.Exclusive,
				new_debris = #var_9_6 == 0,
				value = var_9_3,
				target_value_tab = var_9_4,
				old_value_tab = var_9_5
			})
		end
	end

	for iter_9_2 = 10, 20 do
		local var_9_8 = "type" .. iter_9_2
		local var_9_9 = arg_9_0.old_model_config[var_9_8]
		local var_9_10 = arg_9_0.target_model_config[var_9_8]

		if var_9_9 ~= var_9_10 and not string.nilorempty(var_9_10) then
			local var_9_11 = {}
			local var_9_12 = {}
			local var_9_13 = {}
			local var_9_14 = string.splitToNumber(var_9_9, "#") or {}
			local var_9_15 = string.splitToNumber(var_9_10, "#") or {}

			for iter_9_3, iter_9_4 in ipairs(var_9_15) do
				if iter_9_4 ~= var_9_14[iter_9_3] then
					var_9_11[iter_9_3] = iter_9_4 - (var_9_14[iter_9_3] or 0)
				end

				var_9_12[iter_9_3] = iter_9_4
				var_9_13[iter_9_3] = var_9_14[iter_9_3]
			end

			local var_9_16

			if var_9_11[1] then
				if var_9_11[2] then
					var_9_16 = CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel
				else
					var_9_16 = CharacterTalentLevelUpResultView.DebrisType.DebrisCount
				end
			elseif var_9_11[2] then
				var_9_16 = CharacterTalentLevelUpResultView.DebrisType.DebrisLevel
			end

			table.insert(var_9_2, {
				cube_id = iter_9_2,
				up_type = var_9_16,
				new_debris = #var_9_14 == 0,
				value = var_9_11,
				target_value_tab = var_9_12,
				old_value_tab = var_9_13
			})
		end
	end

	arg_9_0.obj_list = arg_9_0:getUserDataTb_()

	gohelper.CreateObjList(arg_9_0, arg_9_0._onItemShow, var_9_2, arg_9_0._goContent, arg_9_0._gocapacity)
end

function var_0_0._onItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1.name = arg_10_2.cube_id or "shape"

	local var_10_0 = arg_10_1.transform
	local var_10_1 = var_10_0:Find("cellicon/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	local var_10_2 = var_10_0:Find("cellicon/cell_bg"):GetComponent(gohelper.Type_Image)
	local var_10_3 = var_10_0:Find("info/go_capacityTip").gameObject
	local var_10_4 = var_10_0:Find("info/go_numTip").gameObject
	local var_10_5 = var_10_0:Find("info/attr").gameObject
	local var_10_6 = var_10_0:Find("info/go_level").gameObject
	local var_10_7 = var_10_0:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh)
	local var_10_8 = var_10_0:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(var_10_3, arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess)
	gohelper.setActive(var_10_4, arg_10_2.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess and (arg_10_2.new_debris or arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount))
	gohelper.setActive(var_10_5, arg_10_2.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess)

	if arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive then
		gohelper.setActive(var_10_6, true)

		var_10_7.text = "Lv." .. arg_10_2.target_value_tab[2]
		var_10_8.text = "+" .. arg_10_2.value[2]
	elseif arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel then
		gohelper.setActive(var_10_6, true)

		var_10_7.text = "Lv." .. arg_10_2.target_value_tab[2]
		var_10_8.text = "+" .. arg_10_2.value[2]
	elseif arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(var_10_6, true)

		var_10_7.text = "Lv." .. arg_10_2.target_value_tab[2]
		var_10_8.text = "+" .. arg_10_2.value[2]
	else
		gohelper.setActive(var_10_6, false)
	end

	if arg_10_2.new_debris then
		var_10_8.text = ""
	end

	if arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(var_10_1, "icon_danao01", true)

		var_10_2.enabled = false
		var_10_3.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		var_10_3.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(arg_10_0.old_model_config.allShape, ",", luaLang("multiple"))
		var_10_3.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(arg_10_2.value, ",", luaLang("multiple"))

		local var_10_9 = {}
		local var_10_10 = HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(arg_10_0.hero_mo_data.heroId)
		local var_10_11 = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(arg_10_0.hero_mo_data.heroId, arg_10_0.target_lv)

		for iter_10_0 = 1, var_10_10 do
			var_10_9[iter_10_0] = {}
			var_10_9[iter_10_0].cur_level = var_10_11
		end
	else
		local var_10_12 = HeroConfig.instance:getTalentCubeAttrConfig(arg_10_2.cube_id, arg_10_2.target_value_tab[2])

		if not var_10_12 then
			logError(arg_10_2.cube_id, arg_10_2.target_value_tab[2])
		end

		local var_10_13 = {}

		for iter_10_1 = 1, HeroConfig.instance:getTalentCubeMaxLevel(arg_10_2.cube_id) do
			var_10_13[iter_10_1] = {}
			var_10_13[iter_10_1].cur_level = var_10_12.level
		end

		if arg_10_2.new_debris then
			var_10_4.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = "<color=#975129>" .. luaLang("talent_new_debris") .. "</color>"
			var_10_4.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = ""
			var_10_4.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = ""
		elseif arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount or arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
			var_10_4.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			var_10_4.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = arg_10_2.target_value_tab[1]
			var_10_4.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. arg_10_2.value[1]
		end

		local var_10_14 = {}

		arg_10_0.hero_mo_data:getTalentStyleCubeAttr(arg_10_2.cube_id, var_10_14, nil, nil, arg_10_2.target_value_tab[2])

		local var_10_15 = {}

		if (arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive or arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel or arg_10_2.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel) and arg_10_2.old_value_tab[2] then
			arg_10_0.hero_mo_data:getTalentStyleCubeAttr(arg_10_2.cube_id, var_10_15, nil, nil, arg_10_2.old_value_tab[2] or 0)
		end

		local var_10_16 = {}
		local var_10_17 = HeroConfig.instance:getTalentCubeAttrConfig(arg_10_2.cube_id, arg_10_2.old_value_tab[2]) or var_10_12

		for iter_10_2, iter_10_3 in pairs(var_10_14) do
			local var_10_18 = 0

			if var_10_15[iter_10_2] then
				var_10_18 = iter_10_3 - var_10_15[iter_10_2]
			end

			table.insert(var_10_16, {
				key = iter_10_2,
				value = iter_10_3,
				add_value = var_10_18,
				is_special = var_10_12.calculateType == 1,
				config = var_10_12,
				old_attr_config = var_10_17
			})
		end

		table.sort(var_10_16, function(arg_11_0, arg_11_1)
			return HeroConfig.instance:getIDByAttrType(arg_11_0.key) < HeroConfig.instance:getIDByAttrType(arg_11_1.key)
		end)
		gohelper.CreateObjList(arg_10_0, arg_10_0._onShowSingleCubeAttr, var_10_16, var_10_5, var_10_5.transform:Find("go_attrItem").gameObject)

		var_10_2.enabled = true

		local var_10_19 = HeroResonanceConfig.instance:getCubeConfig(arg_10_2.cube_id).icon

		UISpriteSetMgr.instance:setCharacterTalentSprite(var_10_1, "glow_" .. var_10_19, true)

		local var_10_20 = string.split(var_10_19, "_")

		UISpriteSetMgr.instance:setCharacterTalentSprite(var_10_2, "gz_" .. var_10_20[#var_10_20], true)
	end

	table.insert(arg_10_0.obj_list, var_10_0)
end

function var_0_0._onDebrisStarItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1.transform

	gohelper.setActive(var_12_0:Find("lighticon").gameObject, arg_12_3 <= arg_12_2.cur_level)
end

function var_0_0._onShowSingleCubeAttr(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.transform
	local var_13_1 = var_13_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_13_2 = var_13_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_13_3 = var_13_0:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local var_13_4 = var_13_0:Find("addvalue"):GetComponent(gohelper.Type_TextMesh)
	local var_13_5 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_13_2.key))

	var_13_2.text = var_13_5.name

	UISpriteSetMgr.instance:setCommonSprite(var_13_1, "icon_att_" .. var_13_5.id)

	local var_13_6 = arg_13_2.add_value

	if var_13_5.type ~= 1 then
		arg_13_2.value = arg_13_2.value / 10 .. "%"
		arg_13_2.add_value = arg_13_2.add_value / 10 .. "%"
	elseif not arg_13_2.is_special then
		arg_13_2.value = arg_13_2.config[arg_13_2.key] / 10 .. "%"
		arg_13_2.add_value = (arg_13_2.config[arg_13_2.key] - arg_13_2.old_attr_config[arg_13_2.key]) / 10 .. "%"
	else
		arg_13_2.value = math.floor(arg_13_2.value)
		arg_13_2.add_value = math.floor(arg_13_2.add_value)
	end

	var_13_3.text = arg_13_2.value
	var_13_4.text = var_13_6 == 0 and "" or "+" .. arg_13_2.add_value
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

function var_0_0.definePrefabUrl(arg_16_0)
	arg_16_0:setPrefabUrl("ui/viewres/character/charactertalentup/charactertalentleveluppreview.prefab")
end

return var_0_0
