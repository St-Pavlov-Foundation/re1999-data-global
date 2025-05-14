module("modules.logic.seasonver.act166.view.talent.Season166TalentSelectView", package.seeall)

local var_0_0 = class("Season166TalentSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_titleen")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_title")
	arg_1_0._txtbasicSkill = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_basicSkill")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, arg_2_0.OnSetTalentSkill, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = {
	Lock = 4,
	Full = 2,
	Select = 3,
	Normal = 1
}

function var_0_0._editableInitView(arg_4_0)
	SkillHelper.addHyperLinkClick(arg_4_0._txtbasicSkill, arg_4_0.clcikHyperLink, arg_4_0)

	arg_4_0.unlockStateTab = arg_4_0:getUserDataTb_()
	arg_4_0.localUnlockStateTab = arg_4_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_5_0)
	if arg_5_0.viewParam and arg_5_0.viewParam.talentId then
		arg_5_0.actId = Season166Model.instance:getCurSeasonId()
		arg_5_0.talentId = arg_5_0.viewParam.talentId
		arg_5_0.talentConfig = lua_activity166_talent.configDict[arg_5_0.actId][arg_5_0.talentId]
		arg_5_0._txttitle.text = arg_5_0.talentConfig.name
		arg_5_0._txttitleen.text = arg_5_0.talentConfig.nameEn

		local var_5_0 = string.splitToNumber(arg_5_0.talentConfig.baseSkillIds, "#")
		local var_5_1 = lua_skill_effect.configDict[var_5_0[1]]
		local var_5_2 = FightConfig.instance:getSkillEffectDesc("", var_5_1)

		arg_5_0._txtbasicSkill.text = SkillHelper.buildDesc(var_5_2)
		arg_5_0.styleCfgDic = lua_activity166_talent_style.configDict[arg_5_0.talentId]
		arg_5_0.talentInfo = Season166Model.instance:getTalentInfo(arg_5_0.actId, arg_5_0.talentId)
		arg_5_0.baseConfig = Season166Config.instance:getBaseSpotByTalentId(arg_5_0.actId, arg_5_0.talentId)

		arg_5_0:refreshTalentParam(arg_5_0.talentInfo)
		arg_5_0:_initSkillItem()
		arg_5_0:_initLeftArea()
		arg_5_0:_initMiddleArea()
		arg_5_0:playUnlockEffect()
	else
		logError("please open view with talentId")
	end
end

function var_0_0.onClose(arg_6_0)
	arg_6_0:saveUnlockState()
end

function var_0_0.refreshTalentParam(arg_7_0, arg_7_1)
	arg_7_0.talentLvl = arg_7_1.level
	arg_7_0.maxSlot = arg_7_1.config.slot
end

function var_0_0._initLeftArea(arg_8_0)
	arg_8_0.selectSkillList = {}

	for iter_8_0 = 1, 3 do
		local var_8_0 = arg_8_0:getUserDataTb_()

		var_8_0.go = gohelper.findChild(arg_8_0.viewGO, "root/left/basicSkill/" .. iter_8_0)
		var_8_0.goUnequip = gohelper.findChild(var_8_0.go, "unequip")
		var_8_0.goWhiteBg = gohelper.findChild(var_8_0.go, "unequip/bg2")
		var_8_0.goEquiped = gohelper.findChild(var_8_0.go, "equiped")
		var_8_0.animEquip = var_8_0.goEquiped:GetComponent(gohelper.Type_Animation)
		var_8_0.txtDesc = gohelper.findChildText(var_8_0.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(var_8_0.txtDesc, arg_8_0.clcikHyperLink, arg_8_0)

		local var_8_1 = gohelper.findChildImage(var_8_0.go, "equiped/txt_desc/slot")

		UISpriteSetMgr.instance:setSeason166Sprite(var_8_1, "season166_talentree_pointl" .. tostring(arg_8_0.talentConfig.sortIndex))

		local var_8_2 = gohelper.findChild(var_8_0.go, "equiped/txt_desc/slot/" .. arg_8_0.talentConfig.sortIndex)

		gohelper.setActive(var_8_2, true)

		var_8_0.goLock = gohelper.findChild(var_8_0.go, "locked")

		local var_8_3 = gohelper.findChildText(var_8_0.go, "locked/txt_desc")
		local var_8_4 = arg_8_0.styleCfgDic[iter_8_0].needStar

		var_8_3.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), var_8_4, arg_8_0.baseConfig.name)
		var_8_0.anim = var_8_0.go:GetComponent(gohelper.Type_Animator)
		arg_8_0.selectSkillList[iter_8_0] = var_8_0
	end

	arg_8_0:_refreshSelectSkill()
end

function var_0_0._initMiddleArea(arg_9_0)
	local var_9_0 = arg_9_0.talentConfig.sortIndex
	local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "root/middle/talent" .. var_9_0)

	arg_9_0.equipSlotList = arg_9_0:getUserDataTb_()
	arg_9_0.equipSlotLightList = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, 3 do
		local var_9_2 = "equipslot/" .. iter_9_0

		arg_9_0.equipSlotList[iter_9_0] = gohelper.findChild(var_9_1, var_9_2)

		gohelper.setActive(arg_9_0.equipSlotList[iter_9_0], iter_9_0 <= arg_9_0.maxSlot)

		local var_9_3 = "equipslot/" .. iter_9_0 .. "/light"

		arg_9_0.equipSlotLightList[iter_9_0] = gohelper.findChild(var_9_1, var_9_3)
	end

	gohelper.setActive(var_9_1, true)
	arg_9_0:_refreshMiddlSlot()
end

function var_0_0._initSkillItem(arg_10_0)
	arg_10_0.skillUnlockLvlDic = {}
	arg_10_0.skillIds = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.styleCfgDic) do
		local var_10_0 = string.splitToNumber(iter_10_1.skillId, "#")

		tabletool.addValues(arg_10_0.skillIds, var_10_0)

		arg_10_0.skillUnlockLvlDic[iter_10_1.level] = var_10_0
	end

	arg_10_0.skillItemDic = {}

	for iter_10_2 = 1, 6 do
		local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "root/right/#scroll_skill/Viewport/Content/skillItem" .. iter_10_2)
		local var_10_2 = arg_10_0.skillIds[iter_10_2]

		if var_10_2 then
			local var_10_3 = arg_10_0:getUserDataTb_()

			var_10_3.effctConfig = lua_skill_effect.configDict[var_10_2]
			var_10_3.canvasGroup = gohelper.findChild(var_10_1, "content"):GetComponent(gohelper.Type_CanvasGroup)
			var_10_3.goslot = gohelper.findChild(var_10_1, "content/slot/go_slotLight")
			var_10_3.txtdesc = gohelper.findChildText(var_10_1, "content/txt_desc")
			var_10_3.txtdesc.text = FightConfig.instance:getSkillEffectDesc("", var_10_3.effctConfig)

			local var_10_4 = gohelper.findChildImage(var_10_1, "content/slot/go_slotLight")

			UISpriteSetMgr.instance:setSeason166Sprite(var_10_4, "season166_talentree_pointl" .. tostring(arg_10_0.talentConfig.sortIndex))

			var_10_3.select = gohelper.findChild(var_10_1, "select")
			var_10_3.normal = gohelper.findChild(var_10_1, "normal")
			var_10_3.full = gohelper.findChild(var_10_1, "full")
			var_10_3.lock = gohelper.findChild(var_10_1, "lock")

			local var_10_5 = gohelper.findChildText(var_10_1, "lock/txt_locktips")
			local var_10_6 = arg_10_0:getSkillUnlockLvl(var_10_2)
			local var_10_7 = arg_10_0.styleCfgDic[var_10_6].needStar

			var_10_5.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), var_10_7, arg_10_0.baseConfig.name)
			var_10_3.anim = var_10_1:GetComponent(gohelper.Type_Animator)

			local var_10_8 = gohelper.findChildButtonWithAudio(var_10_1, "click")

			arg_10_0:addClickCb(var_10_8, arg_10_0._clickItem, arg_10_0, var_10_2)

			arg_10_0.skillItemDic[var_10_2] = var_10_3
		else
			gohelper.setActive(var_10_1, false)
		end
	end

	arg_10_0:_refreshSkillItemStatus()
end

function var_0_0._refreshSelectSkill(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.talentInfo.skillIds
	local var_11_1 = #var_11_0 + 1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.selectSkillList) do
		if iter_11_0 == var_11_1 and var_11_1 <= arg_11_0.maxSlot then
			gohelper.setActive(iter_11_1.goWhiteBg, true)
		else
			gohelper.setActive(iter_11_1.goWhiteBg, false)
		end

		if iter_11_0 > arg_11_0.maxSlot then
			gohelper.setActive(iter_11_1.goUnequip, false)
			gohelper.setActive(iter_11_1.goEquiped, false)
			gohelper.setActive(iter_11_1.goLock, true)
		elseif iter_11_0 > #var_11_0 then
			gohelper.setActive(iter_11_1.goUnequip, true)
			gohelper.setActive(iter_11_1.goEquiped, false)
			gohelper.setActive(iter_11_1.goLock, false)
		else
			local var_11_2 = lua_skill_effect.configDict[var_11_0[iter_11_0]]
			local var_11_3 = FightConfig.instance:getSkillEffectDesc("", var_11_2)

			iter_11_1.txtDesc.text = SkillHelper.buildDesc(var_11_3)

			gohelper.setActive(iter_11_1.goUnequip, false)
			gohelper.setActive(iter_11_1.goEquiped, true)
			gohelper.setActive(iter_11_1.goLock, false)

			if arg_11_1 and iter_11_0 == #var_11_0 then
				iter_11_1.animEquip:Play("equiped_open")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_light)
			end
		end
	end
end

function var_0_0._refreshMiddlSlot(arg_12_0)
	local var_12_0 = #arg_12_0.talentInfo.skillIds

	for iter_12_0 = 1, arg_12_0.maxSlot do
		gohelper.setActive(arg_12_0.equipSlotLightList[iter_12_0], iter_12_0 <= var_12_0)
	end
end

function var_0_0._refreshSkillItemStatus(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.skillItemDic) do
		local var_13_0 = arg_13_0:getSkillUnlockLvl(iter_13_0)
		local var_13_1 = arg_13_0:InferSkillStatus(iter_13_0, var_13_0)
		local var_13_2 = arg_13_0.styleCfgDic[var_13_0]

		if var_13_1 == var_0_1.Full or var_13_1 == var_0_1.Lock then
			iter_13_1.canvasGroup.alpha = 0.5
		else
			iter_13_1.canvasGroup.alpha = 1
		end

		gohelper.setActive(iter_13_1.select, var_13_1 == var_0_1.Select)
		gohelper.setActive(iter_13_1.goslot, var_13_1 == var_0_1.Select)
		gohelper.setActive(iter_13_1.normal, var_13_1 == var_0_1.Normal)
		gohelper.setActive(iter_13_1.full, var_13_1 == var_0_1.Full)
		gohelper.setActive(iter_13_1.lock, var_13_1 == var_0_1.Lock)

		local var_13_3 = var_13_1 ~= var_0_1.Lock and var_13_2.needStar > 0

		arg_13_0.unlockStateTab[iter_13_0] = var_13_3 and Season166Enum.UnlockState or Season166Enum.LockState
		iter_13_1.isUnlock = var_13_3
	end
end

function var_0_0._clickItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getSkillUnlockLvl(arg_14_1)
	local var_14_1 = arg_14_0:InferSkillStatus(arg_14_1, var_14_0)

	if var_14_1 == var_0_1.Normal then
		local var_14_2 = tabletool.copy(arg_14_0.talentInfo.skillIds)

		var_14_2[#var_14_2 + 1] = arg_14_1

		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(arg_14_0.actId, arg_14_0.talentId, var_14_2)
	elseif var_14_1 == var_0_1.Select then
		local var_14_3 = tabletool.copy(arg_14_0.talentInfo.skillIds)

		tabletool.removeValue(var_14_3, arg_14_1)
		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(arg_14_0.actId, arg_14_0.talentId, var_14_3)
	end
end

function var_0_0.OnSetTalentSkill(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.talentId == arg_15_1 then
		arg_15_0:_refreshSkillItemStatus()
		arg_15_0:_refreshSelectSkill(arg_15_2)
		arg_15_0:_refreshMiddlSlot()
		arg_15_0:saveUnlockState()
	end
end

function var_0_0.InferSkillStatus(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 > arg_16_0.talentLvl then
		return var_0_1.Lock
	end

	if tabletool.indexOf(arg_16_0.talentInfo.skillIds, arg_16_1) then
		return var_0_1.Select
	end

	if #arg_16_0.talentInfo.skillIds >= arg_16_0.maxSlot then
		return var_0_1.Full
	end

	return var_0_1.Normal
end

function var_0_0.getSkillUnlockLvl(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.skillUnlockLvlDic) do
		if tabletool.indexOf(iter_17_1, arg_17_1) then
			return iter_17_0
		end
	end

	return 0
end

function var_0_0.playUnlockEffect(arg_18_0)
	local var_18_0 = Season166Controller.instance:getPlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. arg_18_0.talentId, 0)
	local var_18_1 = arg_18_0.talentInfo.level

	if var_18_0 < var_18_1 then
		for iter_18_0 = 1, var_18_1 do
			local var_18_2 = arg_18_0.selectSkillList[iter_18_0]

			if iter_18_0 == var_18_1 then
				var_18_2.anim:Play("unlock")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
			end

			for iter_18_1 = 1, 2 do
				local var_18_3 = arg_18_0.skillIds[(iter_18_0 - 1) * 2 + iter_18_1]
				local var_18_4 = arg_18_0.skillItemDic[var_18_3]

				if iter_18_0 == var_18_1 then
					var_18_4.anim:Play("unlock")
				end
			end
		end

		Season166Controller.instance:savePlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. arg_18_0.talentId, var_18_1)
	end
end

function var_0_0.isTalentSelect(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.talentInfo.skillIds

	return tabletool.indexOf(var_19_0, arg_19_1)
end

function var_0_0.saveUnlockState(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = Season166Model.instance:getTalentLocalSaveKey(arg_20_0.talentId)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.unlockStateTab) do
		local var_20_2 = string.format("%s|%s", iter_20_0, iter_20_1)

		table.insert(var_20_0, var_20_2)
	end

	local var_20_3 = cjson.encode(var_20_0)

	Season166Controller.instance:savePlayerPrefs(var_20_1, var_20_3)
end

function var_0_0.clcikHyperLink(arg_21_0, arg_21_1, arg_21_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_21_1, Vector2(-305, 30))
end

return var_0_0
