module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroRoleItem", package.seeall)

local var_0_0 = class("DiceHeroRoleItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.chapter = arg_1_1.chapter
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._emptyRelicItem = gohelper.findChild(arg_2_1, "root/zaowu/#go_nulllayout/#go_item")
	arg_2_0._relicItem = gohelper.findChild(arg_2_1, "root/zaowu/#go_iconlayout/#simage_iconitem")
	arg_2_0._powerItem = gohelper.findChild(arg_2_1, "root/headbg/energylayout/#go_item")
	arg_2_0._txtname = gohelper.findChildTextMesh(arg_2_1, "root/#txt_name")
	arg_2_0._hpSlider = gohelper.findChildImage(arg_2_1, "root/#simage_hpbg/#simage_hp")
	arg_2_0._shieldSlider = gohelper.findChildImage(arg_2_1, "root/#simage_shieldbg/#simage_shield")
	arg_2_0._hpNum = gohelper.findChildTextMesh(arg_2_1, "root/#simage_hpbg/#txt_hpnum")
	arg_2_0._shieldNum = gohelper.findChildTextMesh(arg_2_1, "root/#simage_shieldbg/#txt_shieldnum")
	arg_2_0._buffConatiner = gohelper.findChild(arg_2_1, "root/#go_statelist")
	arg_2_0._txtdicenum = gohelper.findChildTextMesh(arg_2_1, "root/dice/#txt_num")
	arg_2_0._headicon = gohelper.findChildSingleImage(arg_2_1, "root/headbg/headicon")
	arg_2_0._btnClickHead = gohelper.findChildButtonWithAudio(arg_2_1, "root/#btn_clickhead")
	arg_2_0._btnClickRelic = gohelper.findChildButtonWithAudio(arg_2_1, "root/#btn_clickrelic")
	arg_2_0._goskilltips = gohelper.findChild(arg_2_1, "tips/#go_skilltip")
	arg_2_0._gozaowutip = gohelper.findChild(arg_2_1, "tips/#go_zaowutip")
	arg_2_0._goskillitem = gohelper.findChild(arg_2_1, "tips/#go_skilltip/viewport/content/item")
	arg_2_0._gozaowuitem = gohelper.findChild(arg_2_1, "tips/#go_zaowutip/viewport/content/item")

	gohelper.setActive(arg_2_0._buffConatiner, false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_3_0.onTouchScreen, arg_3_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, arg_3_0.updateInfo, arg_3_0)
	arg_3_0._btnClickHead:AddClickListener(arg_3_0._showSkill, arg_3_0)
	arg_3_0._btnClickRelic:AddClickListener(arg_3_0._showRelic, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClickHead:RemoveClickListener()
	arg_4_0._btnClickRelic:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, arg_4_0.updateInfo, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0:updateInfo()
end

function var_0_0.updateInfo(arg_6_0)
	local var_6_0 = DiceHeroModel.instance:getGameInfo(arg_6_0.chapter)

	if not var_6_0 or var_6_0.heroBaseInfo.id == 0 then
		gohelper.setActive(arg_6_0.go, false)

		return
	end

	gohelper.setActive(arg_6_0.go, true)

	local var_6_1 = var_6_0.heroBaseInfo
	local var_6_2 = {}
	local var_6_3 = {}

	for iter_6_0 = 1, 5 do
		if var_6_1.relicIds[iter_6_0] then
			table.insert(var_6_2, var_6_1.relicIds[iter_6_0])
		else
			table.insert(var_6_3, 1)
		end
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0._createRelicItem, var_6_2, nil, arg_6_0._relicItem)
	gohelper.CreateObjList(nil, nil, var_6_3, nil, arg_6_0._emptyRelicItem)

	local var_6_4 = {}

	for iter_6_1 = 1, var_6_1.maxPower do
		var_6_4[iter_6_1] = iter_6_1 <= var_6_1.power and 1 or 0
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0._createPowerItem, var_6_4, nil, arg_6_0._powerItem)

	local var_6_5 = var_6_1.hp
	local var_6_6 = var_6_1.maxHp
	local var_6_7 = var_6_1.shield
	local var_6_8 = var_6_1.maxShield

	arg_6_0._hpSlider.fillAmount = var_6_6 > 0 and var_6_5 / var_6_6 or 0
	arg_6_0._shieldSlider.fillAmount = var_6_8 > 0 and var_6_7 / var_6_8 or 0
	arg_6_0._hpNum.text = var_6_5
	arg_6_0._shieldNum.text = var_6_7
	arg_6_0._txtname.text = var_6_1.co.name

	local var_6_9 = #string.split(var_6_1.co.dicelist, "#")

	arg_6_0._txtdicenum.text = string.format("×%s", var_6_9)

	arg_6_0._headicon:LoadImage(ResUrl.getHeadIconSmall(var_6_1.co.icon))
end

function var_0_0._createRelicItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildSingleImage(arg_7_1, "")
	local var_7_1 = lua_dice_relic.configDict[arg_7_2]

	if var_7_1 then
		var_7_0:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. var_7_1.icon .. ".png")
	end
end

function var_0_0._createPowerItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChild(arg_8_1, "light")

	gohelper.setActive(var_8_0, arg_8_2 == 1)
end

function var_0_0._showSkill(arg_9_0)
	if arg_9_0._goskilltips.activeSelf then
		gohelper.setActive(arg_9_0._goskilltips, false)

		return
	end

	gohelper.setActive(arg_9_0._gozaowutip, false)

	local var_9_0 = DiceHeroModel.instance:getGameInfo(arg_9_0.chapter)
	local var_9_1 = var_9_0.heroBaseInfo.co.powerSkill
	local var_9_2 = var_9_0.heroBaseInfo.relicIds
	local var_9_3 = lua_dice_card.configDict[var_9_1]
	local var_9_4 = {
		var_9_3
	}

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_5 = lua_dice_relic.configDict[iter_9_1]

		if var_9_5.effect == "skill" then
			local var_9_6 = lua_dice_card.configDict[tonumber(var_9_5.param)]

			if var_9_6 and var_9_6.type == DiceHeroEnum.CardType.Hero then
				table.insert(var_9_4, var_9_6)
			end
		end
	end

	if not var_9_4[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(arg_9_0._goskilltips, true)
	gohelper.CreateObjList(arg_9_0, arg_9_0._createSkillItem, var_9_4, nil, arg_9_0._goskillitem)
end

function var_0_0._createSkillItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildTextMesh(arg_10_1, "#txt_title/#txt_title")
	local var_10_1 = gohelper.findChildTextMesh(arg_10_1, "#txt_desc")

	var_10_0.text = arg_10_2.name
	var_10_1.text = arg_10_2.desc
end

function var_0_0._showRelic(arg_11_0)
	if arg_11_0._gozaowutip.activeSelf then
		gohelper.setActive(arg_11_0._gozaowutip, false)

		return
	end

	gohelper.setActive(arg_11_0._goskilltips, false)

	local var_11_0 = DiceHeroModel.instance:getGameInfo(arg_11_0.chapter).heroBaseInfo.relicIds
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		table.insert(var_11_1, lua_dice_relic.configDict[iter_11_1])
	end

	if #var_11_1 <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(arg_11_0._gozaowutip, true)
	gohelper.CreateObjList(arg_11_0, arg_11_0._createZaowuItem, var_11_1, nil, arg_11_0._gozaowuitem)
end

function var_0_0._createZaowuItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "name/#txt_name")
	local var_12_1 = gohelper.findChildTextMesh(arg_12_1, "#txt_desc")

	gohelper.findChildSingleImage(arg_12_1, "name/#simage_icon"):LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. arg_12_2.icon .. ".png")

	var_12_0.text = arg_12_2.name
	var_12_1.text = arg_12_2.desc
end

function var_0_0.onTouchScreen(arg_13_0)
	if arg_13_0._goskilltips.activeSelf then
		if gohelper.isMouseOverGo(arg_13_0._goskilltips) and gohelper.isMouseOverGo(arg_13_0._goskillitem.transform.parent) or gohelper.isMouseOverGo(arg_13_0._btnClickHead) then
			return
		end

		gohelper.setActive(arg_13_0._goskilltips, false)
	elseif arg_13_0._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(arg_13_0._gozaowutip) and gohelper.isMouseOverGo(arg_13_0._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(arg_13_0._btnClickRelic) then
			return
		end

		gohelper.setActive(arg_13_0._gozaowutip, false)
	end
end

return var_0_0
