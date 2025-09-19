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
	arg_1_0._txtTotalScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Assess/image_NumBG/#txt_Num")
	arg_1_0._imageScore = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Assess/image_NumBG/#txt_Num/image_AssessIon")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Frequency/image_NumBG/#txt_Num")
	arg_1_0._txtFrequencyName = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Frequency/txt_Frequency")
	arg_1_0._btnSwitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_switch")
	arg_1_0._txtSwitch = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#btn_switch/txt_switch")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnSwitch:AddClickListener(arg_2_0.changeSwitch, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
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

	local var_4_5 = 0
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._equipBox.slots) do
		if not iter_4_1.item:isEmpty() then
			table.insert(var_4_6, iter_4_1.item)

			var_4_5 = var_4_5 + iter_4_1:getScore()
		end
	end

	arg_4_0._totalScore = var_4_5
	arg_4_0._equips = var_4_6

	arg_4_0:_refreshView()
	gohelper.setActive(arg_4_0._goEmpty, #var_4_6 == 0)
	gohelper.setActive(arg_4_0._btnSwitch, #var_4_6 ~= 0)
end

function var_0_0._refreshView(arg_5_0)
	local var_5_0

	if arg_5_0._equipFoundCo then
		local var_5_1 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.WorldLevel)
		local var_5_2 = lua_survival_equip_score.configDict[var_5_1][2].level
		local var_5_3 = 1

		if not string.nilorempty(var_5_2) then
			for iter_5_0, iter_5_1 in ipairs(string.splitToNumber(var_5_2, "#")) do
				if iter_5_1 <= arg_5_0._totalScore then
					var_5_3 = iter_5_0 + 1
				end
			end
		end

		UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._imageScore, "survivalequip_scoreicon_" .. var_5_3)

		arg_5_0._txtTotalScore.text = string.format("<color=%s>%s</color>", var_0_1[var_5_3] or var_0_1[1], arg_5_0._totalScore)

		UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._imageFrequency, arg_5_0._equipFoundCo.value)

		arg_5_0._txtFrequency.text = arg_5_0._equipBox.values[arg_5_0._equipFoundCo.value] or 0

		local var_5_4 = lua_survival_attr.configDict[arg_5_0._equipFoundCo.value]

		arg_5_0._txtFrequencyName.text = var_5_4 and var_5_4.name or ""

		arg_5_0._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(arg_5_0._equipFoundCo.icon))

		local var_5_5 = {}
		local var_5_6 = arg_5_0._equipFoundCo.desc

		if SurvivalModel.instance._isUseSimpleDesc == 1 then
			var_5_6 = arg_5_0._equipFoundCo.desc1
		end

		if not string.nilorempty(var_5_6) then
			local var_5_7 = {}
			local var_5_8 = {}

			for iter_5_2, iter_5_3 in ipairs(string.split(var_5_6, "|")) do
				local var_5_9, var_5_10 = SurvivalDescExpressionHelper.instance:parstDesc(iter_5_3, arg_5_0._equipBox.values)

				if var_5_10 then
					table.insert(var_5_7, {
						var_5_9,
						var_5_10
					})
				else
					table.insert(var_5_8, {
						var_5_9,
						var_5_10
					})
				end
			end

			tabletool.addValues(var_5_5, var_5_7)
			tabletool.addValues(var_5_5, var_5_8)
		end

		gohelper.CreateObjList(arg_5_0, arg_5_0._createDescItem, var_5_5, nil, arg_5_0._godesc)

		var_5_0 = gohelper.findChild(arg_5_0._goScroll, "viewport/Content/#go_Item")
	else
		var_5_0 = gohelper.findChild(arg_5_0._goScrollBig, "viewport/Content/#go_Item")
	end

	gohelper.CreateObjList(arg_5_0, arg_5_0._createEquipItem, arg_5_0._equips, nil, var_5_0)

	arg_5_0._txtSwitch.text = SurvivalModel.instance._isUseSimpleDesc == 1 and luaLang("survival_equipoverview_simple") or luaLang("survival_equipoverview_exdesc")
end

function var_0_0.changeSwitch(arg_6_0)
	SurvivalModel.instance:changeDescSimple()
end

function var_0_0._createDescItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildTextMesh(arg_7_1, "")
	local var_7_1 = gohelper.findChildImage(arg_7_1, "image_Point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0.gameObject, SurvivalSkillDescComp):updateInfo(var_7_0, arg_7_2[1], 3028)
	ZProj.UGUIHelper.SetColorAlpha(var_7_0, arg_7_2[2] and 1 or 0.5)

	if arg_7_2[2] then
		var_7_1.color = GameUtil.parseColor("#000000")
	else
		var_7_1.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0._createEquipItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildTextMesh(arg_8_1, "#txt_Descr")
	local var_8_1 = gohelper.findChildTextMesh(arg_8_1, "#txt_Descr/#txt_Name")
	local var_8_2 = gohelper.findChildTextMesh(arg_8_1, "#txt_Descr/Assess/image_NumBG/#txt_Num")
	local var_8_3 = gohelper.findChild(arg_8_1, "#txt_Descr/#go_Item")
	local var_8_4 = gohelper.findChildImage(arg_8_1, "#txt_Descr/Assess/image_NumBG/image_FrequencyIcon")
	local var_8_5 = gohelper.findChildTextMesh(arg_8_1, "#txt_Descr/Assess/image_NumBG/#txt_FrequencyNum")
	local var_8_6 = arg_8_2:getEquipEffectDesc()
	local var_8_7 = ""

	for iter_8_0, iter_8_1 in ipairs(var_8_6) do
		if not string.nilorempty(var_8_7) then
			var_8_7 = var_8_7 .. "\n"
		end

		if iter_8_1[2] then
			var_8_7 = var_8_7 .. iter_8_1[1]
		else
			var_8_7 = var_8_7 .. "<color=#22222280>" .. iter_8_1[1] .. "</color>"
		end
	end

	MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0.gameObject, SurvivalSkillDescComp):updateInfo(var_8_0, var_8_7, 3028)

	var_8_1.text = arg_8_2.co.name
	var_8_2.text = arg_8_2.equipCo.score + arg_8_2.exScore

	local var_8_8 = gohelper.clone(arg_8_0._item, var_8_3)

	gohelper.setActive(var_8_8, true)

	local var_8_9 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_8, SurvivalBagItem)

	var_8_9:updateMo(arg_8_2)
	var_8_9:setClickCallback(arg_8_0._onClickItem, arg_8_0)

	if var_8_4 then
		local var_8_10 = lua_survival_equip_found.configDict[arg_8_0._equipBox.maxTagId]

		if var_8_10 then
			UISpriteSetMgr.instance:setSurvivalSprite(var_8_4, var_8_10.value)

			var_8_5.text = arg_8_2.equipValues[var_8_10.value] or 0
		end
	end
end

function var_0_0._onClickItem(arg_9_0, arg_9_1)
	arg_9_0._infoPanel:updateMo(arg_9_1._mo)
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

return var_0_0
