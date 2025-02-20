module("modules.logic.fight.view.FightViewBossHp", package.seeall)

slot0 = class("FightViewBossHp", BaseViewExtended)
slot0.VariantIdToMaterialPath = {
	"ui/materials/dynamic/ui_headicon_stylization_1.mat",
	"ui/materials/dynamic/ui_headicon_stylization_2.mat",
	"ui/materials/dynamic/ui_headicon_stylization_3.mat",
	"ui/materials/dynamic/ui_headicon_stylization_4.mat"
}

function slot0.onInitView(slot0)
	slot0._bossHpGO = gohelper.findChild(slot0.viewGO, "Alpha/bossHp")
	slot0._imgbossHpbg = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp")
	slot0._hp_container_tran = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container").transform
	slot0._aniBossHp = slot0._bossHpGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgHp = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/mask/container/imgHp")
	slot0._gochoushi = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/choushi")
	slot0._goHpShield = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container/imgProtect")

	gohelper.setActive(slot0._goHpShield, true)

	slot0._imgHpShield = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_idle/imgProtect")
	slot0._trsShieldPosUI = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_posui").transform
	slot0._rectMaskHpShield = slot0._goHpShield:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._aniHpShield = slot0._goHpShield:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtHp = gohelper.findChildText(slot0.viewGO, "Alpha/bossHp/mask/container/imgHp/txtHp")
	slot0._goHpEffect = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/#hpeffect")
	slot0._aniHpEffect = slot0._goHpEffect:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgHead = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/headbg/imgHead")
	slot0._imgHeadIcon = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/headbg/imgHead")
	slot0._imgCareer = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/headbg/imgCareer")
	slot0._passiveSkillPrefab = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/passiveSkills/item")
	slot0._btnpassiveSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "Alpha/bossHp/passiveSkills/btn_passiveclick")
	slot0._exPointPrefab = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/exPoint/item")
	slot0._imgSignHpContainer = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	slot0._imgSignHpItem = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")

	gohelper.setActive(slot0._passiveSkillPrefab, false)
	gohelper.setActive(slot0._exPointPrefab, false)

	slot0._specialSkillGOs = slot0:getUserDataTb_()
	slot0._passiveSkillImgs = slot0:getUserDataTb_()
	slot0._exPointFullList = slot0:getUserDataTb_()
	slot0.bossSkillInfos = {}
	slot0._multiHpRoot = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/image_HPBG")
	slot0._multiHpItemContent = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/image_HPBG/grid")
	slot0._multiHpItem = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/image_HPBG/grid/image_HpItem")
	slot0._bossActionRoot = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/actionbar")
	slot0._bossEnergyRoot = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/#go_assisthpbar")
end

function slot0.onOpen(slot0)
	slot0._btnpassiveSkill:AddClickListener(slot0._onClickPassiveSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._checkBossAndUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0._checkBossAndUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEntityDead, slot0._onEntityDead, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateExPoint, slot0._updateExPoint, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnHpChange, slot0._onHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnShieldChange, slot0._onShieldChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMonsterChange, slot0._onMonsterChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkBossAndUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMaxHpChange, slot0._onMaxHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCurrentHpChange, slot0._onCurrentHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushTeamInfo, slot0._onMonsterChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSummon, slot0._checkBossAndUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeCareer, slot0._onChangeCareer, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeShield, slot0._onChangeShield, slot0)

	slot0.sheildWidth = recthelper.getWidth(slot0._goHpShield.transform)

	slot0:_checkBossAndUpdate()

	if BossRushController.instance:isInBossRushFight(true) then
		slot0:openSubView(FightViewBossHpBossRushAction, "ui/viewres/fight/fightviewbosshpbossrushaction.prefab", slot0._bossActionRoot)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._checkBossAndUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0._checkBossAndUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnEntityDead, slot0._onEntityDead, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.UpdateExPoint, slot0._updateExPoint, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnHpChange, slot0._onHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnShieldChange, slot0._onShieldChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMonsterChange, slot0._onMonsterChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._checkBossAndUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMaxHpChange, slot0._onMaxHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCurrentHpChange, slot0._onCurrentHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PushTeamInfo, slot0._onMonsterChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSummon, slot0._checkBossAndUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeCareer, slot0._onChangeCareer, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeShield, slot0._onChangeShield, slot0)
	slot0._btnpassiveSkill:RemoveClickListener()
end

function slot0._onBeginWave(slot0)
	slot0._bossHasDead = nil

	slot0:_checkBossAndUpdate()
end

function slot0._onEntityDead(slot0, slot1)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0._boss_hp_sign = nil
		slot0._bossHasDead = true

		slot0:_checkBossAndUpdate()
	end
end

function slot0._onBeforeDeadEffect(slot0, slot1)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0:_detectBossMultiHp()
	end
end

function slot0._checkBossAndUpdate(slot0)
	if slot0._bossHasDead then
		gohelper.setActive(slot0._bossHpGO, false)

		slot0._aniHpEffect.enabled = false
		slot0._bossEntityMO = nil

		return
	end

	if slot0._bossEntityMO and not FightDataHelper.entityMgr:getById(slot0._bossEntityMO.id) then
		slot0._bossEntityMO = nil
	end

	if not slot0._bossEntityMO then
		slot0._bossEntityMO = slot0:_getBossEntityMO()
	end

	if not slot0._bossEntityMO or not GMFightShowState.bossHp then
		slot0._aniHpEffect.enabled = false
	end

	gohelper.setActive(slot0._bossHpGO, slot0._bossEntityMO and GMFightShowState.bossHp)

	if slot0._bossEntityMO then
		slot0:_refreshBossHpUI()
	end

	if slot0._bossEntityMO and slot0._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy) then
		if not slot0._bossEnergyView then
			slot0._bossEnergyView = slot0:openSubView(FightViewBossEnergy, "ui/viewres/fight/assisthpbar.prefab", slot0._bossEnergyRoot, slot0._bossEntityMO)
		end

		gohelper.setActive(slot0._bossEnergyRoot, true)
	else
		gohelper.setActive(slot0._bossEnergyRoot, false)
	end
end

function slot0._refreshBossHpUI(slot0)
	slot0._boss_hp_sign = nil

	slot0:_insteadSpecialHp()
	slot0:_updateUI()
	slot0:_updatePassiveSkill()
	slot0:_updateExPoint()
end

function slot0._onRestartStage(slot0)
	gohelper.setActive(slot0._bossHpGO, false)

	slot0._bossEntityMO = nil
end

function slot0._onMonsterChange(slot0, slot1, slot2)
	slot0._bossEntityMO = nil

	slot0:_checkBossAndUpdate()
end

function slot0._getBossEntityMO(slot0)
	if slot0:_getBossId() then
		for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			if FightHelper.isBossId(slot1, slot7.modelId) then
				return slot7
			end
		end

		if slot0:_getChangeBossId(slot1) then
			for slot7, slot8 in ipairs(slot2) do
				if slot3 == slot8.modelId then
					return slot8
				end
			end
		end
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._bossEntityMO then
		return
	end

	if slot0._bossEntityMO.id ~= slot1 then
		return
	end

	if slot3 and lua_skill_buff.configDict[slot3] and slot6.typeId == 3120005 then
		slot0:_insteadSpecialHp(slot2)
	end
end

function slot0._insteadSpecialHp(slot0, slot1)
	if slot1 then
		if slot1 == FightEnum.EffectType.BUFFADD then
			slot0:changeBossHpWithChouShiBuff(true)
		elseif slot1 == FightEnum.EffectType.BUFFDEL or slot1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			slot0:changeBossHpWithChouShiBuff(false)
		end
	elseif slot0._bossEntityMO then
		for slot6, slot7 in pairs(slot0._bossEntityMO:getBuffDic()) do
			if lua_skill_buff.configDict[slot7.buffId] and slot8.typeId == 3120005 then
				slot0:changeBossHpWithChouShiBuff(true)

				return
			end
		end
	end
end

function slot0.changeBossHpWithChouShiBuff(slot0, slot1)
	if slot1 then
		UISpriteSetMgr.instance:setFightSprite(slot0._imgbossHpbg, "bg_xuetiaobossdi2")
		UISpriteSetMgr.instance:setFightSprite(slot0._imgHp, "bg_xuetiaoboss_choushi")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imgHp, "#FFFFFF")
	else
		UISpriteSetMgr.instance:setFightSprite(slot0._imgbossHpbg, "bg_xtiaodi")
		UISpriteSetMgr.instance:setFightSprite(slot0._imgHp, "bosshp")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imgHp, "#873816")
	end

	gohelper.setActive(slot0._gochoushi, slot1)
end

function slot0._getBossId(slot0)
	slot2 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot1]

	return slot2 and not string.nilorempty(slot2.bossId) and slot2.bossId or nil
end

function slot0._getChangeBossId(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot1)) do
		if not lua_monster.configDict[slot7] then
			logError("怪物表找不到id:" .. slot7)
		end

		for slot13, slot14 in ipairs(FightHelper._buildMonsterSkills(slot8)) do
			if not lua_skill.configDict[slot14] then
				logError("技能表找不到id: " .. slot14)
			end

			for slot19 = 1, FightEnum.MaxBehavior do
				if string.splitToNumber(slot15["behavior" .. slot19], "#")[1] and lua_skill_behavior.configDict[slot22] and slot23.type == "MonsterChange" then
					return slot21[2]
				end
			end
		end
	end
end

function slot0._updateUI(slot0)
	if not slot0._bossEntityMO then
		return
	end

	slot4 = slot0._bossEntityMO.currentHp
	slot0._curHp = slot4
	slot0._curShield = slot0._bossEntityMO.shieldValue

	slot0:_tweenFillAmount()

	slot0._txtHp.text = string.format("%d/%d", slot4 > 0 and slot4 or 0, slot0._bossEntityMO.attrMO.hp)

	if not string.nilorempty(FightConfig.instance:getSkinCO(lua_monster.configDict[slot0._bossEntityMO.modelId].skinId).headIcon) then
		gohelper.getSingleImage(slot0._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot2.headIcon))

		if slot1.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(slot1.heartVariantId), slot0._imgHeadIcon)
		end
	else
		gohelper.setActive(slot0._imgHead.gameObject, false)
	end

	slot0:_refreshCareer()
	slot0:_detectBossHpSign()
	slot0:_detectBossMultiHp()
end

function slot0._refreshCareer(slot0)
	if FightModel.instance:getVersion() >= 2 then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imgCareer, "sx_icon_" .. tostring(slot0._bossEntityMO.career))
	else
		UISpriteSetMgr.instance:setCommonSprite(slot0._imgCareer, "sx_icon_" .. tostring(lua_monster.configDict[slot0._bossEntityMO.modelId].career))
	end
end

function slot0._onChangeCareer(slot0, slot1)
	if slot0._bossEntityMO and slot1 == slot0._bossEntityMO.id then
		slot0:_refreshCareer()
	end
end

function slot0._onHpChange(slot0, slot1, slot2)
	if slot2 ~= 0 and slot0._bossEntityMO and slot1.id == slot0._bossEntityMO.id then
		if slot2 < 0 then
			gohelper.setActive(slot0._goHpEffect, true)

			slot0._aniHpEffect.enabled = true
			slot0._aniHpEffect.speed = 1

			slot0._aniHpEffect:Play("hpeffect", 0, 0)
			slot0._aniHpEffect:Update(0)
		end

		slot3 = slot0._bossEntityMO.attrMO.hp
		slot0._curHp = slot0._curHp + slot2
		slot0._curHp = slot0._curHp > 0 and slot0._curHp or 0
		slot0._curHp = slot0._curHp <= slot3 and slot0._curHp or slot3
		slot0._txtHp.text = slot0._curHp

		slot0:_tweenFillAmount()
	end
end

function slot0._playHpEffectAni(slot0)
end

function slot0._detectBossHpSign(slot0)
	if not string.nilorempty(slot0._bossEntityMO:getCO().hpSign) and not slot0._boss_hp_sign then
		slot0._boss_hp_sign = string.splitToNumber(slot1.hpSign, "#")
	end

	gohelper.setActive(slot0._imgSignHpContainer, slot0._boss_hp_sign)

	if slot0._boss_hp_sign then
		gohelper.CreateObjList(slot0, slot0._bossHpSignShow, slot0._boss_hp_sign, slot0._imgSignHpContainer, slot0._imgSignHpItem)
	end
end

function slot0._bossHpSignShow(slot0, slot1, slot2, slot3)
	recthelper.setAnchorX(slot1.transform, slot2 / 1000 * recthelper.getWidth(slot1.transform.parent.parent))
end

function slot0._onMultiHpChange(slot0, slot1)
	if slot0._bossEntityMO and slot1 == slot0._bossEntityMO.id then
		slot0._imgHp.fillAmount, slot0._imgHpShield.fillAmount = slot0:_getFillAmount()
		slot0._bossEntityMO = nil

		slot0:_checkBossAndUpdate()
		slot0:_tweenFillAmount(0.8)
	end
end

function slot0._detectBossMultiHp(slot0)
	slot1 = slot0._bossEntityMO.attrMO.multiHpNum

	if not slot0._hpMultiAni or slot0._bossEntityMO.attrMO:getCurMultiHpIndex() == 0 then
		slot0._hpMultiAni = {}
	end

	gohelper.setActive(slot0._multiHpRoot, slot1 > 1)

	if slot1 > 1 then
		slot0:com_createObjList(slot0._onMultiHpItemShow, slot1, slot0._multiHpItemContent, slot0._multiHpItem)
	end
end

slot1 = "idle"
slot2 = "close"

function slot0._onMultiHpItemShow(slot0, slot1, slot2, slot3)
	slot7 = gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator))
	slot8 = slot3 <= slot0._bossEntityMO.attrMO.multiHpNum - slot0._bossEntityMO.attrMO:getCurMultiHpIndex()

	if not slot0._hpMultiAni[slot3] then
		gohelper.setActive(gohelper.findChild(slot1, "hp"), slot8)

		slot0._hpMultiAni[slot3] = slot8 and uv0 or uv1
	elseif slot0._hpMultiAni[slot3] ~= (slot8 and uv0 or uv1) then
		slot0._hpMultiAni[slot3] = slot9

		slot7:Play(slot0._hpMultiAni[slot3])
	end
end

function slot0._onShieldChange(slot0, slot1, slot2)
	if slot0._bossEntityMO and slot1.id == slot0._bossEntityMO.id then
		slot0._curShield = slot2 ~= 0 and slot0._curShield + slot2 or slot0._bossEntityMO.shieldValue
		slot3, slot4 = slot0:_getFillAmount()

		slot0:_changeShieldPos(slot3)

		if slot0._curShield <= 0 then
			if slot0:_checkShieldBreakAnim() then
				return
			end

			slot0._imgHp.fillAmount = slot3

			slot0._aniHpShield:Play(UIAnimationName.Open)
			slot0._aniBossHp:Play("shake", 0, 0)
		else
			slot0._aniHpShield:Play(UIAnimationName.Idle)
		end

		slot0:_tweenFillAmount()
	end
end

function slot0._checkShieldBreakAnim(slot0)
	if slot0._aniHpShield:GetCurrentAnimatorStateInfo(0).normalizedTime <= 1 then
		return true
	end

	return false
end

function slot0._tweenFillAmount(slot0, slot1)
	slot1 = slot1 or 0.5
	slot2, slot3 = slot0:_getFillAmount()

	slot0:_changeShieldPos(slot2)
	ZProj.TweenHelper.KillByObj(slot0._imgHp)
	ZProj.TweenHelper.KillByObj(slot0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(slot0._imgHp, slot2, slot1 / FightModel.instance:getUISpeed())
	ZProj.TweenHelper.DOFillAmount(slot0._imgHpShield, slot3, slot1 / FightModel.instance:getUISpeed())
end

function slot0._changeShieldPos(slot0, slot1)
	if slot0:_checkShieldBreakAnim() then
		return
	end

	recthelper.setAnchorX(slot0._trsShieldPosUI, slot1 * slot0.sheildWidth)
end

function slot0._getFillAmount(slot0)
	if not slot0._bossEntityMO then
		return 0, 0
	end

	slot2 = slot0._bossEntityMO.attrMO and slot1.attrMO.hp > 0 and slot1.attrMO.hp or 1
	slot3 = slot2 > 0 and slot0._curHp / slot2 or 0
	slot4 = 0

	if slot2 >= slot0._curShield + slot0._curHp then
		slot3 = slot0._curHp / slot2
		slot4 = (slot0._curShield + slot0._curHp) / slot2
	else
		slot3 = slot0._curHp / (slot0._curHp + slot0._curShield)
		slot4 = 1
	end

	if slot2 < (slot1.attrMO and slot1.attrMO.original_max_hp or 1) then
		slot6 = slot5 - slot2
		slot3 = slot3 * slot2 / slot5 + slot6 / slot5
		slot4 = slot4 * slot2 / slot5 + slot6 / slot5
		slot0._hp_width = slot0._hp_width or recthelper.getWidth(slot0._hp_container_tran)

		recthelper.setAnchorX(slot0._hp_container_tran, 0 - slot0._hp_width * slot6 / slot5)
	else
		recthelper.setAnchorX(slot0._hp_container_tran, 0)
	end

	return slot3, slot4
end

function slot0._updatePassiveSkill(slot0)
	if not slot0._bossEntityMO then
		return
	end

	slot6 = FightConfig.instance:getPassiveSkillsAfterUIFilter(lua_monster.configDict[slot0._bossEntityMO.modelId].id)
	slot0.bossSkillInfos = {}

	for slot6 = 1, #FightConfig.instance:_filterSpeicalSkillIds(slot6, true) do
		if lua_skill_specialbuff.configDict[slot2[slot6]] then
			if not slot0._specialSkillGOs[slot6] then
				slot9 = slot0:getUserDataTb_()
				slot9.go = gohelper.cloneInPlace(slot0._passiveSkillPrefab, "item" .. slot6)
				slot9._gotag = gohelper.findChild(slot9.go, "tag")
				slot9._txttag = gohelper.findChildText(slot9.go, "tag/#txt_tag")

				table.insert(slot0._specialSkillGOs, slot9)
				table.insert(slot0._passiveSkillImgs, gohelper.findChildImage(slot9.go, "icon"))
			end

			if not string.nilorempty(slot8.lv) then
				gohelper.setActive(slot9._gotag, true)

				slot9._txttag.text = slot8.lv
			else
				gohelper.setActive(slot9._gotag, false)
			end

			if slot8.icon == 0 then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. slot8.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(slot0._passiveSkillImgs[slot6], slot8.icon)
			gohelper.setActive(slot9.go, true)
			table.insert(slot0.bossSkillInfos, {
				skillId = slot7,
				icon = slot8.icon
			})
		end
	end

	gohelper.setAsLastSibling(slot0._btnpassiveSkill.gameObject)

	for slot6 = #slot2 + 1, #slot0._specialSkillGOs do
		gohelper.setActive(slot0._specialSkillGOs[slot6].go, false)
	end
end

function slot0._onClickPassiveSkill(slot0)
	if not FightModel.instance:isStartFinish() then
		return
	end

	if not slot0.bossSkillInfos then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnPassiveSkillClick, slot0.bossSkillInfos, slot0._btnpassiveSkill.transform, -509.5, -29, slot0._bossEntityMO.id)
end

function slot0._updateExPoint(slot0)
	if not slot0._bossEntityMO then
		return
	end

	slot1 = slot0._bossEntityMO.exPoint

	for slot6 = 1, slot0._bossEntityMO:getMaxExPoint() do
		if not slot0._exPointFullList[slot6] then
			slot8 = gohelper.cloneInPlace(slot0._exPointPrefab, slot0._exPointPrefab.name .. slot6)

			table.insert(slot0._exPointFullList, gohelper.findChild(slot8, "full"))
			gohelper.setActive(slot8, true)
		end

		gohelper.setActive(slot0._exPointFullList[slot6], slot6 <= slot1)
	end

	for slot6 = slot2 + 1, #slot0._exPointFullList do
		gohelper.setActive(slot0._exPointFullList[slot6], false)
	end
end

function slot0._onMaxHpChange(slot0, slot1, slot2, slot3)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0:_updateUI()
	end
end

function slot0._onCurrentHpChange(slot0, slot1, slot2, slot3)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0:_updateUI()
	end
end

function slot0._onChangeShield(slot0, slot1)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0:_updateUI()
	end
end

function slot0._onForceUpdatePerformanceData(slot0, slot1)
	if not slot0._bossEntityMO or slot1 ~= slot0._bossEntityMO.id then
		return
	end

	slot0:_tweenFillAmount()
end

return slot0
