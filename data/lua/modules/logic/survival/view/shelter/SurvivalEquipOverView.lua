module("modules.logic.survival.view.shelter.SurvivalEquipOverView", package.seeall)

local var_0_0 = class("SurvivalEquipOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")
	arg_1_0._goLeft = gohelper.findChild(arg_1_0.viewGO, "Panel/Left")
	arg_1_0._imageSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/image_Icon")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "Panel/go_empty")
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_List")
	arg_1_0._goScrollBig = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_ListBig")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_Descr/viewport/Content/#txt_Descr")
	arg_1_0._txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/#txt_Name")
	arg_1_0._txtTotalScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Assess/image_NumBG/#txt_Num")
	arg_1_0._imageScore = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Assess/image_NumBG/#txt_Num/image_AssessIon")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Frequency/item1/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Frequency/item1/#txt_Num")
	arg_1_0._goitemFrequency = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Frequency/item2")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/Frequency/#btn_click")
	arg_1_0._btnSwitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_switch")
	arg_1_0._txtSwitch = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#btn_switch/txt_switch")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClickFrequency, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnSwitch:AddClickListener(arg_2_0.changeSwitch, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnSwitch:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_3_0._refreshView, arg_3_0)
end

local var_0_1 = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = gohelper.create2d(arg_4_0.viewGO, "#go_info")
	local var_4_2 = arg_4_0:getResInst(var_4_0, var_4_1)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setCloseShow(true)
	arg_4_0._infoPanel:setShowBtns(false)
	arg_4_0._infoPanel:updateMo()

	local var_4_3 = arg_4_0.viewContainer._viewSetting.otherRes.itemRes

	arg_4_0._item = arg_4_0:getResInst(var_4_3, arg_4_0.viewGO)

	gohelper.setActive(arg_4_0._item, false)

	arg_4_0._equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	local var_4_4 = lua_survival_equip_found.configDict[arg_4_0._equipBox.maxTagId]

	gohelper.setActive(arg_4_0._goLeft, var_4_4)
	gohelper.setActive(arg_4_0._goScroll, var_4_4)
	gohelper.setActive(arg_4_0._goScrollBig, not var_4_4)

	arg_4_0._equipFoundCo = var_4_4

	if var_4_4 then
		arg_4_0._txtName.text = var_4_4.name
	end

	local var_4_5 = {}
	local var_4_6 = true

	for iter_4_0, iter_4_1 in pairs(arg_4_0._equipBox.jewelrySlots) do
		if not iter_4_1.item:isEmpty() then
			table.insert(var_4_5, {
				type = 1,
				item = iter_4_1.item,
				isFirst = var_4_6
			})

			var_4_6 = false
		end
	end

	local var_4_7 = true

	for iter_4_2, iter_4_3 in pairs(arg_4_0._equipBox.slots) do
		if not iter_4_3.item:isEmpty() then
			table.insert(var_4_5, {
				type = 2,
				item = iter_4_3.item,
				isFirst = var_4_7
			})

			var_4_7 = false
		end
	end

	arg_4_0._totalScore = arg_4_0._equipBox:getAllScore()
	arg_4_0._equips = var_4_5

	arg_4_0:_refreshFrequency()
	arg_4_0:_refreshScore()
	arg_4_0:_refreshView()
	gohelper.setActive(arg_4_0._goEmpty, #var_4_5 == 0)
	gohelper.setActive(arg_4_0._btnSwitch, #var_4_5 ~= 0)
end

local var_0_2 = {
	[1001] = true,
	[1002] = true,
	[1004] = true
}

function var_0_0._refreshFrequency(arg_5_0)
	if not arg_5_0._equipFoundCo then
		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._imageFrequency, arg_5_0._equipFoundCo.value)

	arg_5_0._txtFrequency.text = arg_5_0._equipBox.values[arg_5_0._equipFoundCo.value] or 0

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._equipBox.values) do
		if iter_5_0 ~= arg_5_0._equipFoundCo.value and iter_5_1 > 0 and var_0_2[iter_5_0] then
			table.insert(var_5_0, {
				key = iter_5_0,
				value = iter_5_1
			})
		end
	end

	gohelper.CreateObjList(arg_5_0, arg_5_0._createFrequencyItem, var_5_0, nil, arg_5_0._goitemFrequency, nil, nil, nil, 3)
end

function var_0_0._onClickFrequency(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._equipBox.values) do
		if iter_6_1 > 0 and var_0_2[iter_6_0] then
			local var_6_1 = lua_survival_attr.configDict[iter_6_0]

			if var_6_1 then
				table.insert(var_6_0, {
					title = var_6_1.name,
					desc = SkillHelper.buildDesc(var_6_1.desc, nil, "#5283ca")
				})
			end
		end
	end

	ViewMgr.instance:openView(ViewName.SurvivalCommonTipsView, {
		list = var_6_0,
		pivot = Vector2(1, 1)
	})
end

function var_0_0._createFrequencyItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildImage(arg_7_1, "image_FrequencyIcon")
	local var_7_1 = gohelper.findChildTextMesh(arg_7_1, "#txt_Num")

	UISpriteSetMgr.instance:setSurvivalSprite(var_7_0, arg_7_2.key)

	var_7_1.text = arg_7_2.value
end

function var_0_0._refreshScore(arg_8_0)
	local var_8_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.WorldLevel)
	local var_8_1 = lua_survival_equip_score.configDict[var_8_0][2].level
	local var_8_2 = 1

	if not string.nilorempty(var_8_1) then
		for iter_8_0, iter_8_1 in ipairs(string.splitToNumber(var_8_1, "#")) do
			if iter_8_1 <= arg_8_0._totalScore then
				var_8_2 = iter_8_0 + 1
			end
		end
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_8_0._imageScore, "survivalequip_scoreicon_" .. var_8_2)

	arg_8_0._txtTotalScore.text = string.format("<color=%s>%s</color>", var_0_1[var_8_2] or var_0_1[1], arg_8_0._totalScore)
end

function var_0_0._refreshView(arg_9_0)
	local var_9_0

	if arg_9_0._equipFoundCo then
		arg_9_0._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(arg_9_0._equipFoundCo.icon))

		local var_9_1 = {}
		local var_9_2 = arg_9_0._equipFoundCo.desc

		if SurvivalModel.instance._isUseSimpleDesc == 1 then
			var_9_2 = arg_9_0._equipFoundCo.desc1
		end

		if not string.nilorempty(var_9_2) then
			local var_9_3 = {}
			local var_9_4 = {}

			for iter_9_0, iter_9_1 in ipairs(string.split(var_9_2, "|")) do
				local var_9_5, var_9_6 = SurvivalDescExpressionHelper.instance:parstDesc(iter_9_1, arg_9_0._equipBox.values)

				if var_9_6 then
					table.insert(var_9_3, {
						var_9_5,
						var_9_6
					})
				else
					table.insert(var_9_4, {
						var_9_5,
						var_9_6
					})
				end
			end

			tabletool.addValues(var_9_1, var_9_3)
			tabletool.addValues(var_9_1, var_9_4)
		end

		gohelper.CreateObjList(arg_9_0, arg_9_0._createDescItem, var_9_1, nil, arg_9_0._godesc)

		var_9_0 = gohelper.findChild(arg_9_0._goScroll, "viewport/Content/#go_Item")
	else
		var_9_0 = gohelper.findChild(arg_9_0._goScrollBig, "viewport/Content/#go_Item")
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._createEquipItem, arg_9_0._equips, nil, var_9_0)

	arg_9_0._txtSwitch.text = SurvivalModel.instance._isUseSimpleDesc == 1 and luaLang("survival_equipoverview_simple") or luaLang("survival_equipoverview_exdesc")
end

function var_0_0.changeSwitch(arg_10_0)
	SurvivalModel.instance:changeDescSimple()
end

function var_0_0._createDescItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildTextMesh(arg_11_1, "")
	local var_11_1 = gohelper.findChildImage(arg_11_1, "image_Point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.gameObject, SurvivalSkillDescComp):updateInfo(var_11_0, arg_11_2[1], 3028)
	ZProj.UGUIHelper.SetColorAlpha(var_11_0, arg_11_2[2] and 1 or 0.5)

	if arg_11_2[2] then
		var_11_1.color = GameUtil.parseColor("#000000")
	else
		var_11_1.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0._createEquipItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "#txt_Descr")
	local var_12_1 = gohelper.findChildTextMesh(arg_12_1, "#txt_Descr/#txt_Name")
	local var_12_2 = gohelper.findChildTextMesh(arg_12_1, "#txt_Descr/Assess/image_NumBG/#txt_Num")
	local var_12_3 = gohelper.findChild(arg_12_1, "#txt_Descr/#go_Item")
	local var_12_4 = gohelper.findChildImage(arg_12_1, "#txt_Descr/Assess/image_NumBG/image_FrequencyIcon")
	local var_12_5 = gohelper.findChildTextMesh(arg_12_1, "#txt_Descr/Assess/image_NumBG/#txt_FrequencyNum")
	local var_12_6 = gohelper.findChild(arg_12_1, "#txt_Descr/Assess/image_NumBG/image_Line")
	local var_12_7 = gohelper.findChild(arg_12_1, "#go_SmallTitle")
	local var_12_8 = gohelper.findChild(arg_12_1, "#go_SmallTitle/#go_Type1")
	local var_12_9 = gohelper.findChild(arg_12_1, "#go_SmallTitle/#go_Type2")

	gohelper.setActive(var_12_7, arg_12_2.isFirst)
	gohelper.setActive(var_12_8, arg_12_2.type == 1)
	gohelper.setActive(var_12_9, arg_12_2.type == 2)

	local var_12_10 = arg_12_0._equipFoundCo and arg_12_2.type == 2

	gohelper.setActive(var_12_4, var_12_10)
	gohelper.setActive(var_12_5, var_12_10)
	gohelper.setActive(var_12_6, var_12_10)

	local var_12_11 = arg_12_2.item:getEquipEffectDesc()
	local var_12_12 = ""

	for iter_12_0, iter_12_1 in ipairs(var_12_11) do
		if not string.nilorempty(var_12_12) then
			var_12_12 = var_12_12 .. "\n"
		end

		if iter_12_1[2] then
			var_12_12 = var_12_12 .. iter_12_1[1]
		else
			var_12_12 = var_12_12 .. "<color=#22222280>" .. iter_12_1[1] .. "</color>"
		end
	end

	MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0.gameObject, SurvivalSkillDescComp):updateInfo(var_12_0, var_12_12, 3028)

	var_12_1.text = arg_12_2.item.co.name
	var_12_2.text = arg_12_2.item.equipCo.score + arg_12_2.item.exScore

	local var_12_13 = gohelper.clone(arg_12_0._item, var_12_3)

	gohelper.setActive(var_12_13, true)

	local var_12_14 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_13, SurvivalBagItem)

	var_12_14:updateMo(arg_12_2.item)
	var_12_14:setClickCallback(arg_12_0._onClickItem, arg_12_0)

	if var_12_10 then
		local var_12_15 = lua_survival_equip_found.configDict[arg_12_0._equipBox.maxTagId]

		if var_12_15 then
			UISpriteSetMgr.instance:setSurvivalSprite(var_12_4, var_12_15.value)

			var_12_5.text = arg_12_2.item.equipValues[var_12_15.value] or 0
		end
	end
end

function var_0_0._onClickItem(arg_13_0, arg_13_1)
	arg_13_0._infoPanel:updateMo(arg_13_1._mo)
end

function var_0_0.onClickModalMask(arg_14_0)
	arg_14_0:closeThis()
end

return var_0_0
