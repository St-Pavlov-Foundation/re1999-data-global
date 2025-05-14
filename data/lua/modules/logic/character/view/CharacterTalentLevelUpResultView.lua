module("modules.logic.character.view.CharacterTalentLevelUpResultView", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclickmask = gohelper.findChild(arg_1_0.viewGO, "clickmask")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._scrollup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_up")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_up/Viewport/#go_Content")
	arg_1_0._gocapacity = gohelper.findChild(arg_1_0.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")
	arg_1_0._txtleveluptip = gohelper.findChildText(arg_1_0.viewGO, "leveluptip/tip")
	arg_1_0._txtlevelup = gohelper.findChildText(arg_1_0.viewGO, "leveluptip/tip/#txt_levelup")
	arg_1_0._goeasoning = gohelper.findChild(arg_1_0.viewGO, "esonan/#go_easoning")
	arg_1_0._goesonan = gohelper.findChild(arg_1_0.viewGO, "esonan/#go_esonan")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(arg_2_0._goclickmask), arg_2_0._closeSelf, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_success)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._closeSelf(arg_6_0)
	if ServerTime.now() - arg_6_0.open_time < 2 then
		return
	end

	arg_6_0:closeThis()
end

var_0_0.DebrisType = {
	Chess = 0,
	UnlockStyle = 5,
	Exclusive = 1,
	DebrisLevel = 3,
	DebrisCount = 2,
	DebrisCountAndLevel = 4
}

function var_0_0.onOpen(arg_7_0)
	arg_7_0.open_time = ServerTime.now()
	arg_7_0.hero_id = arg_7_0.viewParam
	arg_7_0.hero_mo_data = HeroModel.instance:getByHeroId(arg_7_0.hero_id)
	arg_7_0._mainCubeId = arg_7_0.hero_mo_data.talentCubeInfos.own_main_cube_id

	arg_7_0:_bootLogic(arg_7_0.hero_mo_data.talent, arg_7_0.hero_mo_data.talent - 1)
	TaskDispatcher.runDelay(arg_7_0._playScrollTween, arg_7_0, 1.2)
	TaskDispatcher.runDelay(arg_7_0._playAttrAni, arg_7_0, 1.2)

	arg_7_0._txtleveluptip.text = luaLang("talent_charactertalentlevelupresult_tip" .. CharacterEnum.TalentTxtByHeroType[arg_7_0.hero_mo_data.config.heroType])

	gohelper.setActive(arg_7_0._goeasoning, arg_7_0.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(arg_7_0._goesonan, arg_7_0.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
end

function var_0_0._bootLogic(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.target_lv = arg_8_1
	arg_8_0.old_level = arg_8_2

	local var_8_0 = HeroResonanceConfig.instance:getTalentConfig(arg_8_0.hero_mo_data.heroId, arg_8_2) or {}
	local var_8_1 = HeroResonanceConfig.instance:getTalentConfig(arg_8_0.hero_mo_data.heroId, arg_8_1)

	arg_8_0.old_model_config = HeroResonanceConfig.instance:getTalentModelConfig(arg_8_0.hero_mo_data.heroId, arg_8_2) or {}
	arg_8_0.target_model_config = HeroResonanceConfig.instance:getTalentModelConfig(arg_8_0.hero_mo_data.heroId, arg_8_1)

	gohelper.setActive(arg_8_0._goContent, arg_8_0.target_model_config ~= nil)

	if not arg_8_0.target_model_config then
		return
	end

	local var_8_2 = {}

	if TalentStyleModel.instance:getLevelUnlockStyle(arg_8_0._mainCubeId, arg_8_1) then
		table.insert(var_8_2, {
			up_type = var_0_0.DebrisType.UnlockStyle
		})
	end

	if arg_8_0.target_model_config.allShape ~= arg_8_0.old_model_config.allShape then
		table.insert(var_8_2, {
			up_type = var_0_0.DebrisType.Chess,
			value = arg_8_0.target_model_config.allShape
		})
	end

	if var_8_1.exclusive ~= var_8_0.exclusive then
		local var_8_3 = {}
		local var_8_4 = {}
		local var_8_5 = {}
		local var_8_6 = string.splitToNumber(var_8_0.exclusive, "#") or {}
		local var_8_7 = string.splitToNumber(var_8_1.exclusive, "#") or {}

		for iter_8_0, iter_8_1 in ipairs(var_8_7) do
			if iter_8_1 ~= var_8_6[iter_8_0] then
				var_8_3[iter_8_0] = iter_8_1 - (var_8_6[iter_8_0] or 0)
			end

			var_8_4[iter_8_0] = iter_8_1
			var_8_5[iter_8_0] = var_8_6[iter_8_0]
		end

		if not string.nilorempty(var_8_1.exclusive) then
			table.insert(var_8_2, {
				cube_id = var_8_7[1],
				up_type = var_0_0.DebrisType.Exclusive,
				new_debris = #var_8_6 == 0,
				value = var_8_3,
				target_value_tab = var_8_4,
				old_value_tab = var_8_5
			})
		end
	end

	for iter_8_2 = 10, 20 do
		local var_8_8 = "type" .. iter_8_2
		local var_8_9 = arg_8_0.old_model_config[var_8_8]
		local var_8_10 = arg_8_0.target_model_config[var_8_8]

		if var_8_9 ~= var_8_10 and not string.nilorempty(var_8_10) then
			local var_8_11 = {}
			local var_8_12 = {}
			local var_8_13 = {}
			local var_8_14 = string.splitToNumber(var_8_9, "#") or {}
			local var_8_15 = string.splitToNumber(var_8_10, "#") or {}

			for iter_8_3, iter_8_4 in ipairs(var_8_15) do
				if iter_8_4 ~= var_8_14[iter_8_3] then
					var_8_11[iter_8_3] = iter_8_4 - (var_8_14[iter_8_3] or 0)
				end

				var_8_12[iter_8_3] = iter_8_4
				var_8_13[iter_8_3] = var_8_14[iter_8_3]
			end

			local var_8_16

			if var_8_11[1] then
				if var_8_11[2] then
					var_8_16 = var_0_0.DebrisType.DebrisCountAndLevel
				else
					var_8_16 = var_0_0.DebrisType.DebrisCount
				end
			elseif var_8_11[2] then
				var_8_16 = var_0_0.DebrisType.DebrisLevel
			end

			table.insert(var_8_2, {
				cube_id = iter_8_2,
				up_type = var_8_16,
				new_debris = #var_8_14 == 0,
				value = var_8_11,
				target_value_tab = var_8_12,
				old_value_tab = var_8_13
			})
		end
	end

	arg_8_0.obj_list = arg_8_0:getUserDataTb_()
	arg_8_0._attr_ani_tab = arg_8_0:getUserDataTb_()
	arg_8_0._burst_effect_attr_tab = arg_8_0:getUserDataTb_()

	gohelper.CreateObjList(arg_8_0, arg_8_0._onItemShow, var_8_2, arg_8_0._goContent, arg_8_0._gocapacity)

	arg_8_0._txtlevelup.text = string.format("Lv.<size=80>%s", arg_8_0.target_lv)
end

function var_0_0._playScrollTween(arg_9_0)
	arg_9_0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
	arg_9_0.parallel_sequence = arg_9_0.parallel_sequence or FlowParallel.New()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.obj_list) do
		local var_9_0 = recthelper.getAnchorY(iter_9_1)

		recthelper.setAnchorY(iter_9_1, var_9_0 - 200)

		local var_9_1 = FlowSequence.New()

		var_9_1:addWork(WorkWaitSeconds.New(0.03 * (iter_9_0 - 1)))

		local var_9_2 = FlowParallel.New()

		var_9_2:addWork(TweenWork.New({
			type = "DOAnchorPosY",
			t = 0.33,
			tr = iter_9_1,
			to = var_9_0,
			ease = EaseType.OutQuart
		}))
		var_9_2:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.6,
			go = iter_9_1.gameObject
		}))
		var_9_1:addWork(var_9_2)

		if iter_9_0 == #arg_9_0.obj_list then
			var_9_1:addWork(FunctionWork.New(function()
				arg_9_0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
			end))
		end

		arg_9_0.parallel_sequence:addWork(var_9_1)
	end

	arg_9_0.parallel_sequence:start({})
end

function var_0_0._playAttrAni(arg_11_0)
	arg_11_0._parallel_attr_sequence = arg_11_0._parallel_attr_sequence or FlowParallel.New()

	for iter_11_0 = 1, #arg_11_0._attr_ani_tab do
		local var_11_0 = FlowParallel.New()

		for iter_11_1, iter_11_2 in ipairs(arg_11_0._attr_ani_tab[iter_11_0]) do
			local var_11_1 = FlowSequence.New()

			var_11_1:addWork(WorkWaitSeconds.New(0.06 * (iter_11_1 - 1)))

			local var_11_2 = FlowParallel.New()

			var_11_2:addWork(FunctionWork.New(function()
				gohelper.findChildComponent(iter_11_2, "", gohelper.Type_CanvasGroup).alpha = 1
				gohelper.findChildComponent(iter_11_2, "", typeof(UnityEngine.Animator)).enabled = true

				gohelper.setActive(gohelper.findChild(iter_11_2, "#new"), arg_11_0._burst_effect_attr_tab[iter_11_0][iter_11_1])
			end))
			var_11_1:addWork(var_11_2)
			var_11_0:addWork(var_11_1)
		end

		arg_11_0._parallel_attr_sequence:addWork(var_11_0)
	end

	arg_11_0._parallel_attr_sequence:start({})
end

local var_0_1 = {
	var_0_0.DebrisType.Chess,
	var_0_0.DebrisType.UnlockStyle
}

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._attr_ani_tab[arg_13_3] = arg_13_0:getUserDataTb_()
	arg_13_0._burst_effect_attr_tab[arg_13_3] = arg_13_0:getUserDataTb_()
	arg_13_1.name = arg_13_2.cube_id or "shape"

	local var_13_0 = arg_13_1.transform
	local var_13_1 = var_13_0:Find("cell/cell_bg/click").gameObject
	local var_13_2 = var_13_0:Find("cell/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	local var_13_3 = var_13_0:Find("cell/cell_bg"):GetComponent(gohelper.Type_Image)
	local var_13_4 = var_13_0:Find("info/go_style").gameObject
	local var_13_5 = var_13_0:Find("info/go_style/txt_unlocked"):GetComponent(gohelper.Type_TextMesh)
	local var_13_6 = var_13_0:Find("info/go_capacityTip").gameObject
	local var_13_7 = var_13_0:Find("info/go_numTip").gameObject
	local var_13_8 = var_13_0:Find("cell/go_new").gameObject
	local var_13_9 = var_13_0:Find("info/attr").gameObject
	local var_13_10 = var_13_0:Find("info/go_level").gameObject
	local var_13_11 = var_13_0:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh)
	local var_13_12 = var_13_0:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh)
	local var_13_13 = not LuaUtil.tableContains(var_0_1, arg_13_2.up_type)

	gohelper.setActive(var_13_6, arg_13_2.up_type == var_0_0.DebrisType.Chess)
	gohelper.setActive(var_13_7, var_13_13 and arg_13_2.up_type == var_0_0.DebrisType.DebrisCount)
	gohelper.setActive(var_13_8, var_13_13 and arg_13_2.new_debris)
	gohelper.setActive(var_13_9, var_13_13)
	gohelper.setActive(var_13_4, arg_13_2.up_type == var_0_0.DebrisType.UnlockStyle)

	local var_13_14 = luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[arg_13_0.hero_mo_data.config.heroType])

	var_13_5.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", var_13_14)

	if arg_13_2.up_type == var_0_0.DebrisType.Exclusive then
		gohelper.setActive(var_13_10, true)

		var_13_11.text = "Lv." .. arg_13_2.target_value_tab[2]
		var_13_12.text = "+" .. arg_13_2.value[2]
	elseif arg_13_2.up_type == var_0_0.DebrisType.DebrisLevel then
		gohelper.setActive(var_13_10, true)

		var_13_11.text = "Lv." .. arg_13_2.target_value_tab[2]
		var_13_12.text = "+" .. arg_13_2.value[2]
	elseif arg_13_2.up_type == var_0_0.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(var_13_10, true)

		var_13_11.text = "Lv." .. arg_13_2.target_value_tab[2]
		var_13_12.text = "+" .. arg_13_2.value[2]
	else
		gohelper.setActive(var_13_10, false)
	end

	if arg_13_2.new_debris then
		var_13_12.text = ""
	end

	if var_13_10.activeInHierarchy then
		table.insert(arg_13_0._attr_ani_tab[arg_13_3], var_13_10)
		table.insert(arg_13_0._burst_effect_attr_tab[arg_13_3], false)
	end

	if var_13_6.activeInHierarchy then
		table.insert(arg_13_0._attr_ani_tab[arg_13_3], var_13_6)
		table.insert(arg_13_0._burst_effect_attr_tab[arg_13_3], false)
	end

	if var_13_7.activeInHierarchy then
		table.insert(arg_13_0._attr_ani_tab[arg_13_3], var_13_7)
		table.insert(arg_13_0._burst_effect_attr_tab[arg_13_3], false)
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._attr_ani_tab[arg_13_3]) do
		gohelper.findChildComponent(iter_13_1, "", typeof(UnityEngine.Animator)).enabled = false
		gohelper.findChildComponent(iter_13_1, "", gohelper.Type_CanvasGroup).alpha = 0
	end

	if arg_13_2.up_type == var_0_0.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(var_13_2, "icon_danao", true)

		var_13_3.enabled = false
		var_13_6.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		var_13_6.transform:Find("name/value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(arg_13_0.old_model_config.allShape, ",", luaLang("multiple"))
		var_13_6.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(arg_13_2.value, ",", luaLang("multiple"))

		local var_13_15 = {}
		local var_13_16 = HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(arg_13_0.hero_mo_data.heroId)
		local var_13_17 = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(arg_13_0.hero_mo_data.heroId, arg_13_0.target_lv)

		for iter_13_2 = 1, var_13_16 do
			var_13_15[iter_13_2] = {}
			var_13_15[iter_13_2].cur_level = var_13_17
		end
	elseif arg_13_2.up_type == var_0_0.DebrisType.UnlockStyle then
		-- block empty
	else
		local var_13_18 = HeroConfig.instance:getTalentCubeAttrConfig(arg_13_2.cube_id, arg_13_2.target_value_tab[2])

		if not var_13_18 then
			logError(arg_13_2.cube_id, arg_13_2.target_value_tab[2])
		end

		local var_13_19 = {}

		for iter_13_3 = 1, HeroConfig.instance:getTalentCubeMaxLevel(arg_13_2.cube_id) do
			var_13_19[iter_13_3] = {}
			var_13_19[iter_13_3].cur_level = var_13_18.level
		end

		if arg_13_2.up_type == var_0_0.DebrisType.DebrisCount or arg_13_2.up_type == var_0_0.DebrisType.DebrisCountAndLevel then
			var_13_7.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			var_13_7.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = arg_13_2.target_value_tab[1]
			var_13_7.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. arg_13_2.value[1]
		end

		local var_13_20 = {}

		arg_13_0.hero_mo_data:getTalentStyleCubeAttr(arg_13_2.cube_id, var_13_20, nil, nil, arg_13_2.target_value_tab[2])

		local var_13_21 = {}

		if (arg_13_2.up_type == var_0_0.DebrisType.Exclusive or arg_13_2.up_type == var_0_0.DebrisType.DebrisCountAndLevel or arg_13_2.up_type == var_0_0.DebrisType.DebrisLevel) and arg_13_2.old_value_tab[2] then
			arg_13_0.hero_mo_data:getTalentStyleCubeAttr(arg_13_2.cube_id, var_13_21, nil, nil, arg_13_2.old_value_tab[2] or 0)
		end

		local var_13_22 = {}
		local var_13_23 = HeroConfig.instance:getTalentCubeAttrConfig(arg_13_2.cube_id, arg_13_2.old_value_tab[2]) or var_13_18

		for iter_13_4, iter_13_5 in pairs(var_13_20) do
			local var_13_24 = 0
			local var_13_25 = false

			if var_13_21[iter_13_4] then
				var_13_24 = iter_13_5 - var_13_21[iter_13_4]
			else
				var_13_25 = true
			end

			table.insert(var_13_22, {
				is_new_attr = var_13_25,
				debris_index = arg_13_3,
				key = iter_13_4,
				value = iter_13_5,
				add_value = var_13_24,
				is_special = var_13_18.calculateType == 1,
				config = var_13_18,
				old_attr_config = var_13_23
			})
		end

		table.sort(var_13_22, function(arg_14_0, arg_14_1)
			return HeroConfig.instance:getIDByAttrType(arg_14_0.key) < HeroConfig.instance:getIDByAttrType(arg_14_1.key)
		end)
		gohelper.CreateObjList(arg_13_0, arg_13_0._onShowSingleCubeAttr, var_13_22, var_13_9, var_13_9.transform:Find("go_attrItem").gameObject)

		local var_13_26 = HeroResonanceConfig.instance:getCubeConfig(arg_13_2.cube_id).icon
		local var_13_27 = string.split(var_13_26, "_")
		local var_13_28 = "gz_" .. var_13_27[#var_13_27]

		if arg_13_0._mainCubeId == arg_13_2.cube_id then
			local var_13_29 = arg_13_0.hero_mo_data:getHeroUseStyleCubeId()

			if var_13_29 ~= arg_13_0._mainCubeId then
				local var_13_30 = HeroResonanceConfig.instance:getCubeConfig(var_13_29)

				if var_13_30 then
					local var_13_31 = var_13_30.icon

					if not string.nilorempty(var_13_31) then
						var_13_26 = "mk_" .. var_13_31
						var_13_28 = var_13_28 .. "_2"
					end
				end
			end
		end

		var_13_3.enabled = true

		UISpriteSetMgr.instance:setCharacterTalentSprite(var_13_2, var_13_26, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(var_13_3, var_13_28, true)
	end

	table.insert(arg_13_0.obj_list, var_13_0)

	if arg_13_2.up_type ~= var_0_0.DebrisType.Chess and arg_13_2.new_debris then
		arg_13_0:_setNewTipPos(var_13_8, arg_13_2.cube_id)
	end
end

function var_0_0._setNewTipPos(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = HeroResonanceConfig.instance:getCubeConfig(arg_15_2).shape

	if var_15_0 == nil then
		return
	end

	local var_15_1 = string.split(var_15_0, "#")[1]
	local var_15_2 = string.splitToNumber(var_15_1, ",")
	local var_15_3 = var_15_2[#var_15_2] == 0

	recthelper.setAnchorY(arg_15_1.transform, var_15_3 and 1.4 or 13.3)
end

function var_0_0._onDebrisStarItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1.transform

	gohelper.setActive(var_16_0:Find("lighticon").gameObject, arg_16_3 <= arg_16_2.cur_level)
end

function var_0_0._onShowSingleCubeAttr(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.transform
	local var_17_1 = var_17_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_17_2 = var_17_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_17_3 = var_17_0:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local var_17_4 = var_17_0:Find("addvalue"):GetComponent(gohelper.Type_TextMesh)
	local var_17_5 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_17_2.key))

	var_17_2.text = var_17_5.name

	UISpriteSetMgr.instance:setCommonSprite(var_17_1, "icon_att_" .. var_17_5.id)

	local var_17_6 = arg_17_2.add_value

	if var_17_5.type ~= 1 then
		arg_17_2.value = arg_17_2.value / 10 .. "%"
		arg_17_2.add_value = arg_17_2.add_value / 10 .. "%"
	elseif not arg_17_2.is_special then
		arg_17_2.value = arg_17_2.config[arg_17_2.key] / 10 .. "%"
		arg_17_2.add_value = (arg_17_2.config[arg_17_2.key] - arg_17_2.old_attr_config[arg_17_2.key]) / 10 .. "%"
	else
		arg_17_2.value = math.floor(arg_17_2.value)
		arg_17_2.add_value = math.floor(arg_17_2.add_value)
	end

	var_17_3.text = arg_17_2.value
	var_17_4.text = var_17_6 == 0 and "" or "+" .. arg_17_2.add_value
	gohelper.findChildComponent(arg_17_1, "", typeof(UnityEngine.Animator)).enabled = false
	gohelper.findChildComponent(arg_17_1, "", gohelper.Type_CanvasGroup).alpha = 0

	table.insert(arg_17_0._attr_ani_tab[arg_17_2.debris_index], arg_17_1)
	table.insert(arg_17_0._burst_effect_attr_tab[arg_17_2.debris_index], arg_17_2.is_new_attr)
end

function var_0_0._onCubeClick(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.name

	if var_18_0 ~= "shape" then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)

		local var_18_1 = tonumber(var_18_0)

		CharacterController.instance:openCharacterTalentTipView({
			open_type = 1,
			hero_id = arg_18_0.hero_id,
			cube_id = var_18_1
		})
	end
end

function var_0_0.onClose(arg_19_0)
	if arg_19_0.parallel_sequence then
		arg_19_0.parallel_sequence:destroy()
	end

	if arg_19_0._parallel_attr_sequence then
		arg_19_0._parallel_attr_sequence:destroy()
	end

	TaskDispatcher.cancelTask(arg_19_0._playScrollTween, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._playAttrAni, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
