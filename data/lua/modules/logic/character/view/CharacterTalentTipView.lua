module("modules.logic.character.view.CharacterTalentTipView", package.seeall)

local var_0_0 = class("CharacterTalentTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroleAttributeTip = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip")
	arg_1_0._scrollattribute = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_attribute")
	arg_1_0._goattributeContent = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent")
	arg_1_0._goattributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent/#go_attributeItem")
	arg_1_0._scrollreduce = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_reduce")
	arg_1_0._goreducetitle = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#go_reducetitle")
	arg_1_0._godampingContent = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent")
	arg_1_0._goreduceItem = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent/#go_reduceItem")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._scrollattributetip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tip/#scroll_attributetip")
	arg_1_0._gosingleContent = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent")
	arg_1_0._gosingleattributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent/#go_singleattributeItem")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_roleAttributeTip/#go_empty")
	arg_1_0._gotrialAttributeTip = gohelper.findChild(arg_1_0.viewGO, "#go_trialAttributeTip")
	arg_1_0._gotrialattributeContent = gohelper.findChild(arg_1_0.viewGO, "#go_trialAttributeTip/scrollview/viewport/content")
	arg_1_0._gotrialattributeitem = gohelper.findChild(arg_1_0.viewGO, "#go_trialAttributeTip/scrollview/viewport/content/attrnormalitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(arg_2_0.viewGO), arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.hero_id = arg_6_0.viewParam.hero_id
	arg_6_0.open_type = arg_6_0.viewParam.open_type
	arg_6_0.hero_mo_data = arg_6_0.viewParam.hero_mo or HeroModel.instance:getByHeroId(arg_6_0.hero_id)
	arg_6_0._isOwnHero = arg_6_0.viewParam.isOwnHero

	if arg_6_0.viewParam.isTrial then
		gohelper.setActive(arg_6_0._goroleAttributeTip, false)
		gohelper.setActive(arg_6_0._gotip, false)
		gohelper.setActive(arg_6_0._gotrialAttributeTip, true)
	else
		gohelper.setActive(arg_6_0._goroleAttributeTip, arg_6_0.open_type == 0)
		gohelper.setActive(arg_6_0._gotrialAttributeTip, false)
		gohelper.setActive(arg_6_0._gotip, arg_6_0.open_type ~= 0)
	end

	if arg_6_0.open_type == 0 then
		arg_6_0:_showAllattr()
	else
		arg_6_0:_showSingleCubeAttr(arg_6_0.viewParam.cube_id)
	end
end

function var_0_0._showSingleCubeAttr(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_0.hero_mo_data:getTalentStyleCubeAttr(arg_7_1, var_7_0)

	local var_7_1 = {}
	local var_7_2 = arg_7_0.hero_mo_data:getCurTalentLevelConfig(arg_7_1)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, {
			key = iter_7_0,
			value = iter_7_1,
			is_special = var_7_2.calculateType == 1,
			config = var_7_2
		})
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		return HeroConfig.instance:getIDByAttrType(arg_8_0.key) < HeroConfig.instance:getIDByAttrType(arg_8_1.key)
	end)
	table.insert(var_7_1, 1, {})
	table.insert(var_7_1, 1, {})
	gohelper.CreateObjList(arg_7_0, arg_7_0._onShowSingleCubeAttrTips, var_7_1, arg_7_0._gosingleContent, arg_7_0._gosingleattributeItem)
end

function var_0_0._onShowSingleCubeAttrTips(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 ~= 1 and arg_9_3 ~= 2 then
		local var_9_0 = arg_9_1.transform
		local var_9_1 = var_9_0:Find("icon"):GetComponent(gohelper.Type_Image)
		local var_9_2 = var_9_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
		local var_9_3 = var_9_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
		local var_9_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_9_2.key))

		var_9_2.text = var_9_4.name

		UISpriteSetMgr.instance:setCommonSprite(var_9_1, "icon_att_" .. var_9_4.id)

		if var_9_4.type ~= 1 then
			arg_9_2.value = arg_9_2.value / 10 .. "%"
		elseif not arg_9_2.is_special then
			arg_9_2.value = arg_9_2.config[arg_9_2.key] / 10 .. "%"
		else
			arg_9_2.value = math.floor(arg_9_2.value)
		end

		var_9_3.text = arg_9_2.value
	end
end

function var_0_0.isOwnHero(arg_10_0)
	if arg_10_0._isOwnHero ~= nil then
		return arg_10_0._isOwnHero
	end

	return arg_10_0.hero_mo_data and arg_10_0.hero_mo_data:isOwnHero()
end

function var_0_0._showAllattr(arg_11_0)
	local var_11_0 = arg_11_0.hero_mo_data:getTalentGain()
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		table.insert(var_11_1, iter_11_1)
	end

	table.sort(var_11_1, function(arg_12_0, arg_12_1)
		return HeroConfig.instance:getIDByAttrType(arg_12_0.key) < HeroConfig.instance:getIDByAttrType(arg_12_1.key)
	end)

	if not arg_11_0:isOwnHero() then
		gohelper.CreateObjList(arg_11_0, arg_11_0._onItemShow, var_11_1, arg_11_0._gotrialattributeContent, arg_11_0._gotrialattributeitem)

		return
	end

	gohelper.CreateObjList(arg_11_0, arg_11_0._onItemShow, var_11_1, arg_11_0._goattributeContent, arg_11_0._goattributeItem)

	local var_11_2 = arg_11_0.hero_mo_data.talentCubeInfos.data_list
	local var_11_3 = {}

	for iter_11_2, iter_11_3 in ipairs(var_11_2) do
		if not var_11_3[iter_11_3.cubeId] then
			var_11_3[iter_11_3.cubeId] = {}
		end

		table.insert(var_11_3[iter_11_3.cubeId], iter_11_3)
	end

	local var_11_4 = SkillConfig.instance:getTalentDamping()
	local var_11_5 = {}

	for iter_11_4, iter_11_5 in pairs(var_11_3) do
		local var_11_6 = #iter_11_5 >= var_11_4[1][1] and (#iter_11_5 >= var_11_4[2][1] and var_11_4[2][2] or var_11_4[1][2]) or nil

		if var_11_6 then
			table.insert(var_11_5, {
				cube_id = iter_11_4,
				damping = var_11_6
			})
		end
	end

	local var_11_7 = GameUtil.getTabLen(var_11_5)

	gohelper.setActive(arg_11_0._goreducetitle, var_11_7 > 0)
	gohelper.setActive(arg_11_0._scrollreduce.gameObject, var_11_7 > 0)
	gohelper.setActive(arg_11_0._goempty, var_11_7 <= 0 and #var_11_1 <= 0)
	gohelper.setActive(arg_11_0._scrollattribute.gameObject, #var_11_1 > 0)
	gohelper.CreateObjList(arg_11_0, arg_11_0._onDampingItemShow, var_11_5, arg_11_0._godampingContent, arg_11_0._goreduceItem)
end

function var_0_0._onDampingItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1.name = arg_13_2.cube_id

	local var_13_0 = arg_13_1.transform
	local var_13_1 = var_13_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_13_2 = var_13_0:Find("reduceNum"):GetComponent(gohelper.Type_TextMesh)

	UISpriteSetMgr.instance:setCharacterTalentSprite(var_13_1, HeroResonanceConfig.instance:getCubeConfig(arg_13_2.cube_id).icon, true)

	var_13_2.text = arg_13_2.damping / 10 .. "%"

	arg_13_0:addClickCb(gohelper.getClick(var_13_0:Find("clickarea").gameObject), arg_13_0._onDampingClick, arg_13_0, arg_13_1)
end

function var_0_0._onDampingClick(arg_14_0, arg_14_1)
	local var_14_0 = tonumber(arg_14_1.name)

	gohelper.setActive(arg_14_0._gotip, true)
	arg_14_0:_showSingleCubeAttr(var_14_0)
end

function var_0_0._onItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1.transform
	local var_15_1 = var_15_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_15_2 = var_15_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_15_3 = var_15_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_15_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_15_2.key))

	if var_15_4.type ~= 1 then
		arg_15_2.value = tonumber(string.format("%.3f", arg_15_2.value / 10)) .. "%"
	else
		arg_15_2.value = math.floor(arg_15_2.value)
	end

	var_15_3.text = arg_15_2.value
	var_15_2.text = var_15_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_15_1, "icon_att_" .. var_15_4.id, true)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
