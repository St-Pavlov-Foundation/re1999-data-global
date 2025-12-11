module("modules.logic.fight.view.FightViewBossHp", package.seeall)

local var_0_0 = class("FightViewBossHp", FightBaseView)

var_0_0.VariantIdToMaterialPath = {
	"ui/materials/dynamic/ui_headicon_stylization_1.mat",
	"ui/materials/dynamic/ui_headicon_stylization_2.mat",
	"ui/materials/dynamic/ui_headicon_stylization_3.mat",
	"ui/materials/dynamic/ui_headicon_stylization_4.mat"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._bossHpGO = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp")
	arg_1_0._imgbossHpbg = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp")
	arg_1_0._hp_container_tran = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container").transform
	arg_1_0._aniBossHp = arg_1_0._bossHpGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imgHp = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgHp")
	arg_1_0._reduceHp = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/reducehp")
	arg_1_0._reduceHpImage = arg_1_0._reduceHp:GetComponent(gohelper.Type_Image)
	arg_1_0._gochoushi = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/choushi")
	arg_1_0._goHpShield = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgProtect")

	gohelper.setActive(arg_1_0._goHpShield, true)

	arg_1_0._imgHpShield = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_idle/imgProtect")
	arg_1_0._trsShieldPosUI = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_posui").transform
	arg_1_0._rectMaskHpShield = arg_1_0._goHpShield:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._aniHpShield = arg_1_0._goHpShield:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgHp/txtHp")
	arg_1_0._goHpEffect = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/#hpeffect")
	arg_1_0._aniHpEffect = arg_1_0._goHpEffect:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imgHead = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/headbg/imgHead")
	arg_1_0._imgHeadIcon = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/headbg/imgHead")
	arg_1_0._imgCareer = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/headbg/imgCareer")
	arg_1_0._passiveSkillPrefab = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/passiveSkills/item")
	arg_1_0._btnpassiveSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Alpha/bossHp/passiveSkills/btn_passiveclick")
	arg_1_0._exPointPrefab = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/exPoint/item")
	arg_1_0._imgSignHpContainer = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	arg_1_0._imgSignHpItem = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")

	gohelper.setActive(arg_1_0._passiveSkillPrefab, false)
	gohelper.setActive(arg_1_0._exPointPrefab, false)

	arg_1_0._specialSkillGOs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveSkillImgs = arg_1_0:getUserDataTb_()
	arg_1_0._exPointFullList = arg_1_0:getUserDataTb_()
	arg_1_0.bossSkillInfos = {}
	arg_1_0._multiHpRoot = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/image_HPBG")
	arg_1_0._multiHpItemContent = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/image_HPBG/grid")
	arg_1_0._multiHpItem = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/image_HPBG/grid/image_HpItem")
	arg_1_0._bossActionRoot = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/actionbar")
	arg_1_0._bossEnergyRoot = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/#go_assisthpbar")
	arg_1_0.killLineComp = FightBossHpKillLineComp.New(FightHpKillLineComp.KillLineType.BossHp)

	arg_1_0.killLineComp:init(arg_1_0._imgHp.gameObject)
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._btnpassiveSkill:AddClickListener(arg_2_0._onClickPassiveSkill, arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.RespBeginRound, arg_2_0._checkBossAndUpdate)
	arg_2_0:com_registFightEvent(FightEvent.OnChangeEntity, arg_2_0._checkBossAndUpdate)
	arg_2_0:com_registFightEvent(FightEvent.OnEntityDead, arg_2_0._onEntityDead)
	arg_2_0:com_registFightEvent(FightEvent.OnBeginWave, arg_2_0._onBeginWave)
	arg_2_0:com_registFightEvent(FightEvent.UpdateExPoint, arg_2_0._updateExPoint)
	arg_2_0:com_registFightEvent(FightEvent.OnHpChange, arg_2_0._onHpChange)
	arg_2_0:com_registFightEvent(FightEvent.OnShieldChange, arg_2_0._onShieldChange)
	arg_2_0:com_registFightEvent(FightEvent.OnMonsterChange, arg_2_0._onMonsterChange)
	arg_2_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStage)
	arg_2_0:com_registFightEvent(FightEvent.GMHideFightView, arg_2_0._checkBossAndUpdate)
	arg_2_0:com_registFightEvent(FightEvent.OnMaxHpChange, arg_2_0._onMaxHpChange)
	arg_2_0:com_registFightEvent(FightEvent.OnCurrentHpChange, arg_2_0._onCurrentHpChange)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate)
	arg_2_0:com_registFightEvent(FightEvent.MultiHpChange, arg_2_0._onMultiHpChange)
	arg_2_0:com_registFightEvent(FightEvent.BeforeDeadEffect, arg_2_0._onBeforeDeadEffect)
	arg_2_0:com_registFightEvent(FightEvent.PushTeamInfo, arg_2_0._onMonsterChange)
	arg_2_0:com_registFightEvent(FightEvent.OnSummon, arg_2_0._checkBossAndUpdate)
	arg_2_0:com_registFightEvent(FightEvent.CoverPerformanceEntityData, arg_2_0.onCoverPerformanceEntityData)
	arg_2_0:com_registFightEvent(FightEvent.ChangeCareer, arg_2_0._onChangeCareer)
	arg_2_0:com_registFightEvent(FightEvent.ChangeShield, arg_2_0._onChangeShield)
	arg_2_0:com_registFightEvent(FightEvent.SetFakeNuoDiKaDamageShield, arg_2_0.onSetFakeNuoDiKaDamageShield)
	arg_2_0:com_registFightEvent(FightEvent.AiJiAoFakeDecreaseHp, arg_2_0.onAiJiAoFakeDecreaseHp)
	arg_2_0:com_registFightEvent(FightEvent.OnFightReconnectLastWork, arg_2_0.onFightReconnectLastWork)
	arg_2_0:com_registFightEvent(FightEvent.MultiHpTypeChange, arg_2_0._detectBossMultiHp)

	arg_2_0.sheildWidth = recthelper.getWidth(arg_2_0._goHpShield.transform)

	arg_2_0:_checkBossAndUpdate()

	if BossRushController.instance:isInBossRushFight(true) or FightDataHelper.fieldMgr:isShelter() then
		arg_2_0:com_openSubView(FightViewBossHpBossRushAction, "ui/viewres/fight/fightviewbosshpbossrushaction.prefab", arg_2_0._bossActionRoot)
	end
end

function var_0_0.onClose(arg_3_0)
	arg_3_0._btnpassiveSkill:RemoveClickListener()

	if arg_3_0.killLineComp then
		arg_3_0.killLineComp:destroy()

		arg_3_0.killLineComp = nil
	end
end

function var_0_0._onBeginWave(arg_4_0)
	arg_4_0._bossHasDead = nil

	arg_4_0:_checkBossAndUpdate()
end

function var_0_0._onEntityDead(arg_5_0, arg_5_1)
	if arg_5_0._bossEntityMO and arg_5_0._bossEntityMO.id == arg_5_1 then
		arg_5_0._boss_hp_sign = nil
		arg_5_0._bossHasDead = true

		arg_5_0:_checkBossAndUpdate()
	end
end

function var_0_0._onBeforeDeadEffect(arg_6_0, arg_6_1)
	if arg_6_0._bossEntityMO and arg_6_0._bossEntityMO.id == arg_6_1 then
		arg_6_0:_detectBossMultiHp()
	end
end

function var_0_0._checkBossAndUpdate(arg_7_0)
	if arg_7_0._bossHasDead then
		gohelper.setActive(arg_7_0._bossHpGO, false)

		arg_7_0._aniHpEffect.enabled = false
		arg_7_0._bossEntityMO = nil

		arg_7_0.killLineComp:refreshByEntityMo()

		return
	end

	if arg_7_0._bossEntityMO and not FightDataHelper.entityMgr:getById(arg_7_0._bossEntityMO.id) then
		arg_7_0._bossEntityMO = nil
	end

	if not arg_7_0._bossEntityMO then
		arg_7_0._bossEntityMO = arg_7_0:_getBossEntityMO()
	end

	arg_7_0.killLineComp:refreshByEntityMo(arg_7_0._bossEntityMO)

	if not arg_7_0._bossEntityMO or not GMFightShowState.bossHp then
		arg_7_0._aniHpEffect.enabled = false
	end

	gohelper.setActive(arg_7_0._bossHpGO, arg_7_0._bossEntityMO and GMFightShowState.bossHp)

	if arg_7_0._bossEntityMO then
		arg_7_0:_refreshBossHpUI()
	end

	if arg_7_0._bossEntityMO and arg_7_0._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy) then
		if not arg_7_0._bossEnergyView then
			arg_7_0._bossEnergyView = arg_7_0:com_openSubView(FightViewBossEnergy, "ui/viewres/fight/assisthpbar.prefab", arg_7_0._bossEnergyRoot, arg_7_0._bossEntityMO)
		end

		gohelper.setActive(arg_7_0._bossEnergyRoot, true)
	else
		gohelper.setActive(arg_7_0._bossEnergyRoot, false)
	end
end

function var_0_0._refreshBossHpUI(arg_8_0)
	arg_8_0._boss_hp_sign = nil

	arg_8_0:_insteadSpecialHp()
	arg_8_0:_updateUI()
	arg_8_0:_updatePassiveSkill()
	arg_8_0:_updateExPoint()
end

function var_0_0._onRestartStage(arg_9_0)
	gohelper.setActive(arg_9_0._bossHpGO, false)

	arg_9_0._bossEntityMO = nil
end

function var_0_0._onMonsterChange(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._bossEntityMO = nil

	arg_10_0:_checkBossAndUpdate()
end

function var_0_0._getBossEntityMO(arg_11_0)
	local var_11_0 = arg_11_0:_getBossId()

	if var_11_0 then
		local var_11_1 = FightDataHelper.entityMgr:getEnemyNormalList()

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			if FightHelper.isBossId(var_11_0, iter_11_1.modelId) then
				return iter_11_1
			end
		end

		local var_11_2 = arg_11_0:_getChangeBossId(var_11_0)

		if var_11_2 then
			for iter_11_2, iter_11_3 in ipairs(var_11_1) do
				if var_11_2 == iter_11_3.modelId then
					return iter_11_3
				end
			end
		end
	end
end

function var_0_0._onBuffUpdate(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if not arg_12_0._bossEntityMO then
		return
	end

	if arg_12_0._bossEntityMO.id ~= arg_12_1 then
		return
	end

	if arg_12_3 then
		local var_12_0 = lua_skill_buff.configDict[arg_12_3]

		if var_12_0 and var_12_0.typeId == 3120005 then
			arg_12_0:_insteadSpecialHp(arg_12_2)
		end
	end
end

function var_0_0._insteadSpecialHp(arg_13_0, arg_13_1)
	if arg_13_1 then
		if arg_13_1 == FightEnum.EffectType.BUFFADD then
			arg_13_0:changeBossHpWithChouShiBuff(true)
		elseif arg_13_1 == FightEnum.EffectType.BUFFDEL or arg_13_1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			arg_13_0:changeBossHpWithChouShiBuff(false)
		end
	elseif arg_13_0._bossEntityMO then
		local var_13_0 = arg_13_0._bossEntityMO:getBuffDic()

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			local var_13_1 = lua_skill_buff.configDict[iter_13_1.buffId]

			if var_13_1 and var_13_1.typeId == 3120005 then
				arg_13_0:changeBossHpWithChouShiBuff(true)

				return
			end
		end
	end
end

function var_0_0.changeBossHpWithChouShiBuff(arg_14_0, arg_14_1)
	if arg_14_1 then
		UISpriteSetMgr.instance:setFightSprite(arg_14_0._imgbossHpbg, "bg_xuetiaobossdi2")
		UISpriteSetMgr.instance:setFightSprite(arg_14_0._imgHp, "bg_xuetiaoboss_choushi")
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._imgHp, "#FFFFFF")
	else
		UISpriteSetMgr.instance:setFightSprite(arg_14_0._imgbossHpbg, "bg_xtiaodi")
		UISpriteSetMgr.instance:setFightSprite(arg_14_0._imgHp, "bosshp")
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._imgHp, "#873816")
	end

	gohelper.setActive(arg_14_0._gochoushi, arg_14_1)
end

function var_0_0._getBossId(arg_15_0)
	local var_15_0 = FightModel.instance:getCurMonsterGroupId()
	local var_15_1 = var_15_0 and lua_monster_group.configDict[var_15_0]

	return var_15_1 and not string.nilorempty(var_15_1.bossId) and var_15_1.bossId or nil
end

function var_0_0._getChangeBossId(arg_16_0, arg_16_1)
	local var_16_0 = string.splitToNumber(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = lua_monster.configDict[iter_16_1]

		if not var_16_1 then
			logError("怪物表找不到id:" .. iter_16_1)
		end

		local var_16_2 = FightHelper._buildMonsterSkills(var_16_1)

		for iter_16_2, iter_16_3 in ipairs(var_16_2) do
			local var_16_3 = lua_skill.configDict[iter_16_3]

			if not var_16_3 then
				logError("技能表找不到id: " .. iter_16_3)
			end

			for iter_16_4 = 1, FightEnum.MaxBehavior do
				local var_16_4 = var_16_3["behavior" .. iter_16_4]
				local var_16_5 = string.splitToNumber(var_16_4, "#")
				local var_16_6 = var_16_5[1]
				local var_16_7 = var_16_6 and lua_skill_behavior.configDict[var_16_6]

				if var_16_7 and var_16_7.type == "MonsterChange" then
					return var_16_5[2]
				end
			end
		end
	end
end

function var_0_0._updateUI(arg_17_0)
	if not arg_17_0._bossEntityMO then
		return
	end

	local var_17_0 = lua_monster.configDict[arg_17_0._bossEntityMO.modelId]
	local var_17_1 = FightConfig.instance:getSkinCO(var_17_0.skinId)
	local var_17_2 = arg_17_0._bossEntityMO.attrMO.hp
	local var_17_3 = arg_17_0._bossEntityMO.currentHp

	arg_17_0._curHp = var_17_3
	arg_17_0._curShield = arg_17_0._bossEntityMO.shieldValue
	var_17_3 = var_17_3 > 0 and var_17_3 or 0

	arg_17_0:_tweenFillAmount()

	arg_17_0._txtHp.text = string.format("%d/%d", var_17_3, var_17_2)

	if not string.nilorempty(var_17_1.headIcon) then
		gohelper.getSingleImage(arg_17_0._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_17_1.headIcon))

		if var_17_0.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(var_17_0.heartVariantId), arg_17_0._imgHeadIcon)
		end
	else
		gohelper.setActive(arg_17_0._imgHead.gameObject, false)
	end

	arg_17_0:_refreshCareer()
	arg_17_0:_detectBossHpSign()
	arg_17_0:_detectBossMultiHp()
end

function var_0_0._refreshCareer(arg_18_0)
	if FightModel.instance:getVersion() >= 2 then
		UISpriteSetMgr.instance:setCommonSprite(arg_18_0._imgCareer, "sx_icon_" .. tostring(arg_18_0._bossEntityMO.career))
	else
		local var_18_0 = lua_monster.configDict[arg_18_0._bossEntityMO.modelId]

		UISpriteSetMgr.instance:setCommonSprite(arg_18_0._imgCareer, "sx_icon_" .. tostring(var_18_0.career))
	end
end

function var_0_0._onChangeCareer(arg_19_0, arg_19_1)
	if arg_19_0._bossEntityMO and arg_19_1 == arg_19_0._bossEntityMO.id then
		arg_19_0:_refreshCareer()
	end
end

function var_0_0._onHpChange(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 ~= 0 and arg_20_0._bossEntityMO and arg_20_1.id == arg_20_0._bossEntityMO.id then
		if arg_20_2 < 0 then
			gohelper.setActive(arg_20_0._goHpEffect, true)

			arg_20_0._aniHpEffect.enabled = true
			arg_20_0._aniHpEffect.speed = 1

			arg_20_0._aniHpEffect:Play("hpeffect", 0, 0)
			arg_20_0._aniHpEffect:Update(0)
		end

		local var_20_0 = arg_20_0._bossEntityMO.attrMO.hp

		arg_20_0._curHp = arg_20_0._curHp + arg_20_2
		arg_20_0._curHp = arg_20_0._curHp > 0 and arg_20_0._curHp or 0
		arg_20_0._curHp = var_20_0 >= arg_20_0._curHp and arg_20_0._curHp or var_20_0
		arg_20_0._txtHp.text = arg_20_0._curHp

		arg_20_0:_tweenFillAmount()
	end

	if arg_20_0.aiJiAoFakeHpBgImg then
		arg_20_0.aiJiAoFakeHpBgImg.fillAmount = 0
	end
end

function var_0_0._playHpEffectAni(arg_21_0)
	return
end

function var_0_0._detectBossHpSign(arg_22_0)
	local var_22_0 = arg_22_0._bossEntityMO:getCO()

	if not string.nilorempty(var_22_0.hpSign) and not arg_22_0._boss_hp_sign then
		arg_22_0._boss_hp_sign = string.splitToNumber(var_22_0.hpSign, "#")
	end

	gohelper.setActive(arg_22_0._imgSignHpContainer, arg_22_0._boss_hp_sign)

	if arg_22_0._boss_hp_sign then
		gohelper.CreateObjList(arg_22_0, arg_22_0._bossHpSignShow, arg_22_0._boss_hp_sign, arg_22_0._imgSignHpContainer, arg_22_0._imgSignHpItem)
	end
end

function var_0_0._bossHpSignShow(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	recthelper.setAnchorX(arg_23_1.transform, arg_23_2 / 1000 * recthelper.getWidth(arg_23_1.transform.parent.parent))
end

function var_0_0._onMultiHpChange(arg_24_0, arg_24_1)
	if arg_24_0._bossEntityMO and arg_24_1 == arg_24_0._bossEntityMO.id then
		local var_24_0, var_24_1 = arg_24_0:_getFillAmount()

		arg_24_0._bossEntityMO = nil

		arg_24_0:_checkBossAndUpdate()

		local var_24_2 = arg_24_0._curHp
		local var_24_3 = arg_24_0._curShield

		if arg_24_0._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_24_0._bossEntityMO.id] then
			local var_24_4, var_24_5 = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(arg_24_0._bossEntityMO.id, var_24_2, var_24_3)

			var_24_0, var_24_1 = arg_24_0:_getFillAmount(var_24_4, var_24_5)
			var_24_0 = Mathf.Clamp(var_24_0, 0.01, 1)
			var_24_1 = Mathf.Clamp(var_24_1, 0.01, 1)
		end

		arg_24_0._imgHp.fillAmount = var_24_0
		arg_24_0._imgHpShield.fillAmount = var_24_1

		arg_24_0:_tweenFillAmount(0.8)
		arg_24_0:refreshReduceHP()
	end
end

function var_0_0._detectBossMultiHp(arg_25_0)
	local var_25_0 = arg_25_0._bossEntityMO.attrMO.multiHpNum
	local var_25_1 = arg_25_0._bossEntityMO.attrMO:getCurMultiHpIndex()

	if not arg_25_0._hpMultiAni or var_25_1 == 0 then
		arg_25_0._hpMultiAni = {}
	end

	gohelper.setActive(arg_25_0._multiHpRoot, var_25_0 > 1)

	if var_25_0 > 1 then
		arg_25_0:com_createObjList(arg_25_0._onMultiHpItemShow, var_25_0, arg_25_0._multiHpItemContent, arg_25_0._multiHpItem)
	end
end

local var_0_1 = "idle"
local var_0_2 = "close"

function var_0_0._onMultiHpItemShow(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0._bossEntityMO.attrMO.multiHpNum
	local var_26_1 = arg_26_0._bossEntityMO.attrMO:getCurMultiHpIndex()
	local var_26_2 = gohelper.findChild(arg_26_1, "hp")
	local var_26_3 = gohelper.onceAddComponent(arg_26_1, typeof(UnityEngine.Animator))
	local var_26_4 = arg_26_3 <= var_26_0 - var_26_1

	if not arg_26_0._hpMultiAni[arg_26_3] then
		gohelper.setActive(var_26_2, var_26_4)

		arg_26_0._hpMultiAni[arg_26_3] = var_26_4 and var_0_1 or var_0_2
	else
		local var_26_5 = var_26_4 and var_0_1 or var_0_2

		if arg_26_0._hpMultiAni[arg_26_3] ~= var_26_5 then
			arg_26_0._hpMultiAni[arg_26_3] = var_26_5

			var_26_3:Play(arg_26_0._hpMultiAni[arg_26_3])
		end
	end
end

function var_0_0._onShieldChange(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._bossEntityMO and arg_27_1.id == arg_27_0._bossEntityMO.id then
		arg_27_0._curShield = arg_27_2 ~= 0 and arg_27_0._curShield + arg_27_2 or arg_27_0._bossEntityMO.shieldValue

		local var_27_0 = arg_27_0._curHp
		local var_27_1 = arg_27_0._curShield
		local var_27_2, var_27_3 = arg_27_0:_getFillAmount()

		if arg_27_0._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_27_0._bossEntityMO.id] then
			local var_27_4

			var_27_4, var_27_1 = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(arg_27_0._bossEntityMO.id, var_27_0, var_27_1)

			local var_27_5

			var_27_2, var_27_5 = arg_27_0:_getFillAmount(var_27_4, var_27_1)
			var_27_2 = Mathf.Clamp(var_27_2, 0.01, 1)

			local var_27_6 = Mathf.Clamp(var_27_5, 0.01, 1)
		end

		arg_27_0:_changeShieldPos(var_27_2)

		if var_27_1 <= 0 then
			if arg_27_0:_checkShieldBreakAnim() then
				return
			end

			arg_27_0._imgHp.fillAmount = var_27_2

			arg_27_0._aniHpShield:Play(UIAnimationName.Open)
			arg_27_0._aniBossHp:Play("shake", 0, 0)
		else
			arg_27_0._aniHpShield:Play(UIAnimationName.Idle)
		end

		arg_27_0:_tweenFillAmount()
		arg_27_0:refreshReduceHP()
	end
end

function var_0_0._checkShieldBreakAnim(arg_28_0)
	if arg_28_0._aniHpShield:GetCurrentAnimatorStateInfo(0).normalizedTime <= 1 then
		return true
	end

	return false
end

function var_0_0._tweenFillAmount(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_1 = arg_29_1 or 0.5
	arg_29_2 = arg_29_2 or arg_29_0._curHp
	arg_29_3 = arg_29_3 or arg_29_0._curShield

	local var_29_0, var_29_1 = arg_29_0:_getFillAmount(arg_29_2, arg_29_3)
	local var_29_2 = var_29_0

	if arg_29_0._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_29_0._bossEntityMO.id] then
		arg_29_2, arg_29_3 = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(arg_29_0._bossEntityMO.id, arg_29_2, arg_29_3)
		var_29_0, var_29_1 = arg_29_0:_getFillAmount(arg_29_2, arg_29_3)
		var_29_0 = Mathf.Clamp(var_29_0, 0.01, 1)
		var_29_1 = Mathf.Clamp(var_29_1, 0.01, 1)
	end

	arg_29_0:_changeShieldPos(var_29_0)
	ZProj.TweenHelper.KillByObj(arg_29_0._imgHp)
	ZProj.TweenHelper.KillByObj(arg_29_0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(arg_29_0._imgHp, var_29_0, arg_29_1 / FightModel.instance:getUISpeed())
	ZProj.TweenHelper.DOFillAmount(arg_29_0._imgHpShield, var_29_1, arg_29_1 / FightModel.instance:getUISpeed())
	arg_29_0:setAiJiAoFakeHp(var_29_2)
	arg_29_0:refreshReduceHP()
end

function var_0_0.refreshReduceHP(arg_30_0)
	local var_30_0 = arg_30_0._bossEntityMO

	if not var_30_0 then
		gohelper.setActive(arg_30_0._reduceHp, false)

		return
	end

	local var_30_1 = var_30_0 and var_30_0:getLockMaxHpRate() or 1
	local var_30_2 = var_30_1 < 1

	gohelper.setActive(arg_30_0._reduceHp, var_30_2)

	if var_30_2 then
		arg_30_0._reduceHpImage.fillAmount = Mathf.Clamp01(1 - var_30_1)
	end
end

function var_0_0._changeShieldPos(arg_31_0, arg_31_1)
	if arg_31_0:_checkShieldBreakAnim() then
		return
	end

	recthelper.setAnchorX(arg_31_0._trsShieldPosUI, arg_31_1 * arg_31_0.sheildWidth)
end

function var_0_0._getFillAmount(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0._bossEntityMO then
		return 0, 0
	end

	arg_32_1 = arg_32_1 or arg_32_0._curHp
	arg_32_2 = arg_32_2 or arg_32_0._curShield

	local var_32_0 = arg_32_0._bossEntityMO
	local var_32_1, var_32_2 = var_32_0:getHpAndShieldFillAmount(arg_32_1, arg_32_2)

	if not var_32_0.attrMO or not (var_32_0.attrMO.hp > 0) or not var_32_0.attrMO.hp then
		local var_32_3 = 1
	end

	return var_32_1, var_32_2
end

function var_0_0._updatePassiveSkill(arg_33_0)
	if not arg_33_0._bossEntityMO then
		return
	end

	local var_33_0 = lua_monster.configDict[arg_33_0._bossEntityMO.modelId]
	local var_33_1 = FightConfig.instance:getPassiveSkillsAfterUIFilter(var_33_0.id)
	local var_33_2 = FightConfig.instance:_filterSpeicalSkillIds(var_33_1, true)

	arg_33_0.bossSkillInfos = {}

	for iter_33_0 = 1, #var_33_2 do
		local var_33_3 = var_33_2[iter_33_0]
		local var_33_4 = lua_skill_specialbuff.configDict[var_33_3]

		if var_33_4 then
			local var_33_5 = arg_33_0._specialSkillGOs[iter_33_0]

			if not var_33_5 then
				var_33_5 = arg_33_0:getUserDataTb_()
				var_33_5.go = gohelper.cloneInPlace(arg_33_0._passiveSkillPrefab, "item" .. iter_33_0)
				var_33_5._gotag = gohelper.findChild(var_33_5.go, "tag")
				var_33_5._txttag = gohelper.findChildText(var_33_5.go, "tag/#txt_tag")

				table.insert(arg_33_0._specialSkillGOs, var_33_5)

				local var_33_6 = gohelper.findChildImage(var_33_5.go, "icon")

				table.insert(arg_33_0._passiveSkillImgs, var_33_6)
			end

			if not string.nilorempty(var_33_4.lv) then
				gohelper.setActive(var_33_5._gotag, true)

				var_33_5._txttag.text = var_33_4.lv
			else
				gohelper.setActive(var_33_5._gotag, false)
			end

			if var_33_4.icon == 0 then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_33_4.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_33_0._passiveSkillImgs[iter_33_0], var_33_4.icon)
			gohelper.setActive(var_33_5.go, true)
			table.insert(arg_33_0.bossSkillInfos, {
				skillId = var_33_3,
				icon = var_33_4.icon
			})
		end
	end

	gohelper.setAsLastSibling(arg_33_0._btnpassiveSkill.gameObject)

	for iter_33_1 = #var_33_2 + 1, #arg_33_0._specialSkillGOs do
		gohelper.setActive(arg_33_0._specialSkillGOs[iter_33_1].go, false)
	end
end

function var_0_0._onClickPassiveSkill(arg_34_0)
	if not FightModel.instance:isStartFinish() then
		return
	end

	if not arg_34_0.bossSkillInfos then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnPassiveSkillClick, arg_34_0.bossSkillInfos, arg_34_0._btnpassiveSkill.transform, -509.5, -29, arg_34_0._bossEntityMO.id)
end

function var_0_0._updateExPoint(arg_35_0)
	if not arg_35_0._bossEntityMO then
		return
	end

	local var_35_0 = arg_35_0._bossEntityMO.exPoint
	local var_35_1 = arg_35_0._bossEntityMO:getMaxExPoint()

	for iter_35_0 = 1, var_35_1 do
		if not arg_35_0._exPointFullList[iter_35_0] then
			local var_35_2 = gohelper.cloneInPlace(arg_35_0._exPointPrefab, arg_35_0._exPointPrefab.name .. iter_35_0)

			table.insert(arg_35_0._exPointFullList, gohelper.findChild(var_35_2, "full"))
			gohelper.setActive(var_35_2, true)
		end

		gohelper.setActive(arg_35_0._exPointFullList[iter_35_0], iter_35_0 <= var_35_0)
	end

	for iter_35_1 = var_35_1 + 1, #arg_35_0._exPointFullList do
		gohelper.setActive(arg_35_0._exPointFullList[iter_35_1], false)
	end
end

function var_0_0._onMaxHpChange(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_0._bossEntityMO and arg_36_0._bossEntityMO.id == arg_36_1 then
		arg_36_0:_updateUI()
	end
end

function var_0_0._onCurrentHpChange(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_0._bossEntityMO and arg_37_0._bossEntityMO.id == arg_37_1 then
		arg_37_0:_updateUI()
	end
end

function var_0_0._onChangeShield(arg_38_0, arg_38_1)
	if arg_38_0._bossEntityMO and arg_38_0._bossEntityMO.id == arg_38_1 then
		arg_38_0:_updateUI()
	end
end

function var_0_0.onSetFakeNuoDiKaDamageShield(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0._bossEntityMO and arg_39_0._bossEntityMO.id == arg_39_1 then
		arg_39_0._curShield = arg_39_2 > 0 and arg_39_2 or 0

		arg_39_0:_tweenFillAmount()
	end
end

function var_0_0.onCoverPerformanceEntityData(arg_40_0, arg_40_1)
	if not arg_40_0._bossEntityMO or arg_40_1 ~= arg_40_0._bossEntityMO.id then
		return
	end

	arg_40_0._curHp = arg_40_0._bossEntityMO.currentHp
	arg_40_0._curShield = arg_40_0._bossEntityMO.shieldValue

	arg_40_0:_tweenFillAmount()
end

function var_0_0.onAiJiAoFakeDecreaseHp(arg_41_0, arg_41_1)
	if arg_41_0._bossEntityMO and arg_41_1 == arg_41_0._bossEntityMO.id and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_41_1] then
		arg_41_0:_tweenFillAmount()
	end
end

function var_0_0.setAiJiAoFakeHp(arg_42_0, arg_42_1)
	if not arg_42_0.aiJiAoFakeHpBgImg then
		local var_42_0 = arg_42_0._imgHp.gameObject

		arg_42_0.aiJiAoFakeHpBgImg = gohelper.onceAddComponent(gohelper.cloneInPlace(var_42_0, "aiJiAoFakeHpBgImg"), gohelper.Type_Image)

		gohelper.setAsLastSibling(var_42_0)

		local var_42_1 = arg_42_0.aiJiAoFakeHpBgImg.transform
		local var_42_2 = var_42_1.childCount

		for iter_42_0 = 1, var_42_2 do
			local var_42_3 = var_42_1:GetChild(iter_42_0 - 1)

			gohelper.setActive(var_42_3.gameObject, false)
		end

		SLFramework.UGUI.GuiHelper.SetColor(arg_42_0.aiJiAoFakeHpBgImg, "#E1C590")
	end

	if arg_42_0._bossEntityMO and not FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_42_0._bossEntityMO.id] then
		arg_42_1 = 0
	end

	arg_42_0.aiJiAoFakeHpBgImg.fillAmount = arg_42_1
end

function var_0_0.checkAiJiAoFakeDecreaseHp(arg_43_0)
	if arg_43_0._bossEntityMO then
		arg_43_0:onAiJiAoFakeDecreaseHp(arg_43_0._bossEntityMO.id)
	end
end

function var_0_0.onFightReconnectLastWork(arg_44_0)
	arg_44_0:checkAiJiAoFakeDecreaseHp()
end

return var_0_0
