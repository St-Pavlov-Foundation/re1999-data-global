module("modules.logic.fight.entity.comp.FightNameUI", package.seeall)

slot0 = class("FightNameUI", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._entity = slot1
	slot0._nameUIActive = true
	slot0._nameUIVisible = true
	slot0._expointCtrl = FightNameUIExPointMgr.New(slot0)
	slot0._opCtrl = FightNameUIOp.New(slot0)
	slot0.buffMgr = FightNameUIBuffMgr.New()
	slot0._power = FightNameUIPower.New(slot0, 1)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		slot0._enemyOperation = FightNameUIEnemyOperation.New(slot0)
		slot0._enemyOperation.INVOKED_OPEN_VIEW = true
	end
end

function slot0.load(slot0, slot1)
	if slot0._uiLoader then
		slot0._uiLoader:dispose()
	end

	slot0._containerGO = gohelper.create2d(FightNameMgr.instance:getNameParent(), slot0.entity:getMO():getIdName())
	slot0._floatContainerGO = gohelper.create2d(slot0._containerGO, "float")

	FightNameMgr.instance:register(slot0)

	slot0._uiLoader = PrefabInstantiate.Create(slot0._containerGO)

	slot0._uiLoader:startLoad(slot1, slot0._onLoaded, slot0)
end

function slot0.setActive(slot0, slot1)
	if slot1 and slot0._curHp and slot0._curHp <= 0 then
		return
	end

	slot0._nameUIActive = slot1

	slot0:_doSetActive()
end

function slot0.playDeadEffect(slot0)
	slot0:_playAni("die")
end

function slot0.playOpenEffect(slot0)
	slot0:_playAni(UIAnimationName.Open)
end

function slot0.playCloseEffect(slot0)
	slot0:_playAni("close")
end

function slot0._playAni(slot0, slot1)
	if slot0._ani then
		slot0._ani:Play(slot1, 0, 0)

		slot0._ani.speed = FightModel.instance:getSpeed()
	end
end

function slot0._setIsShowNameUI(slot0, slot1, slot2)
	slot3 = false

	if not slot2 then
		slot3 = true
	else
		for slot7, slot8 in ipairs(slot2) do
			if slot8.id == slot0.entity.id then
				slot3 = true

				break
			end
		end
	end

	if slot3 then
		slot0._nameUIVisible = slot1

		slot0:_doSetActive()
	end
end

function slot0._doSetActive(slot0)
	if gohelper.isNil(slot0:getUIGO()) then
		return
	end

	slot2 = slot0._nameUIActive and slot0._nameUIVisible

	if slot0.entity:getMO():hasBuffFeature(FightEnum.BuffType_HideLife) then
		slot2 = false
	end

	if not gohelper.isNil(slot0._uiCanvasGroup) then
		if slot2 then
			recthelper.setAnchor(slot0:getUIGO().transform, slot0._originPosOffsetX or 0, slot0._originPosOffsetY or 0)
		else
			recthelper.setAnchor(slot0:getUIGO().transform, 20000, 20000)
		end
	end

	if slot2 and slot0._uiFollower then
		slot0._uiFollower:ForceUpdate()
	end
end

function slot0.getAnchorXY(slot0)
	if slot0._uiTransform then
		slot1, slot2 = recthelper.getAnchor(slot0._uiTransform, 0, 0)

		return recthelper.getAnchor(slot0._uiTransform, 0, 0)
	end

	return 0, 0
end

function slot0.getFloatContainerGO(slot0)
	return slot0._floatContainerGO
end

function slot0.getGO(slot0)
	return slot0._containerGO
end

function slot0.getUIGO(slot0)
	return slot0._uiGO
end

function slot0.getOpCtrl(slot0)
	return slot0._opCtrl
end

function slot0._onLoaded(slot0)
	gohelper.setAsLastSibling(slot0._floatContainerGO)

	slot0._uiGO = slot0._uiLoader:getInstGO()
	slot0._uiTransform = slot0._uiGO.transform
	slot0._uiCanvasGroup = gohelper.onceAddComponent(slot0._uiGO, typeof(UnityEngine.CanvasGroup))
	slot0._txtName = gohelper.findChildText(slot0._uiGO, "layout/top/Text")

	slot0:_doSetActive()

	slot0._gohpbg = gohelper.findChild(slot0._uiGO, "layout/top/hp/container/bg")
	slot0._gochoushibg = gohelper.findChild(slot0._uiGO, "layout/top/hp/container/choushibg")
	slot0._imgHpMinus = gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/minus")
	slot1 = slot0.entity:isMySide()

	gohelper.setActive(gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/my").gameObject, slot1)
	gohelper.setActive(gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/enemy").gameObject, not slot1)

	slot0._hp_ani = gohelper.findChild(slot0._uiGO, "layout/top/hp"):GetComponent(typeof(UnityEngine.Animator))
	slot0._hp_container_tran = gohelper.findChild(slot0._uiGO, "layout/top/hp/container").transform
	slot0._imgHp = slot1 and slot2 or slot3
	slot0._imgHpShield = gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/shield")
	slot0._txtHp = gohelper.findChildText(slot0._uiGO, "layout/top/hp/Text")

	slot0:resetHp()

	slot0._imgCareerIcon = gohelper.findChildImage(slot0._uiGO, "layout/top/imgCareerIcon")
	slot0.careerTopRectTr = gohelper.findChildComponent(slot0._uiGO, "layout/top/imgCareerIcon/careertoppos", gohelper.Type_RectTransform)

	slot0:initExPointMgr()
	slot0:initStressMgr()

	slot0._opContainerGO = gohelper.findChild(slot0._uiGO, "layout/top/op")
	slot0._opContainerCanvasGroup = gohelper.onceAddComponent(slot0._opContainerGO, typeof(UnityEngine.CanvasGroup))
	slot0._opContainerTr = slot0._opContainerGO.transform
	slot0._opItemGO = gohelper.findChild(slot0._uiGO, "layout/top/op/item")

	slot0._opCtrl:init(slot0.entity, slot0._opContainerGO, slot0._opItemGO)

	if slot0._enemyOperation then
		slot0._enemyOperation:init(slot0.entity, slot0._opContainerGO, slot0._opItemGO)
	end

	slot0._buffContainerGO = gohelper.findChild(slot0._uiGO, "layout/top/buffContainer")
	slot0._buffGO = gohelper.findChild(slot0._uiGO, "layout/top/buffContainer/buff")

	slot0.buffMgr:init(slot0.entity, slot0._buffGO, slot0._opContainerTr)
	gohelper.setActive(gohelper.findChild(slot0._uiGO, "#go_Shield"), false)

	if FightModel.instance:isSeason2() and slot0.entity:getMO().guard ~= -1 then
		slot0._seasonGuard = FightNameUISeasonGuard.New(slot0)

		slot0._seasonGuard:init(gohelper.findChild(slot0._uiGO, "#go_Shield"))
	end

	slot0._ani = slot0._uiGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goBossFocusIcon = gohelper.findChild(slot0._uiGO, "go_bossfocusicon")

	gohelper.setActive(slot0._goBossFocusIcon, false)
	slot0:updateUI()
	slot0:_insteadSpecialHp()
	slot0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._updateFollow, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, slot0._beforePlaySkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._updateUIPos, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0.updateUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.updateActive, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowFloat, slot0._setIsShowFloat, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowNameUI, slot0._setIsShowNameUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, slot0._onFloatEquipEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFovChange, slot0._updateUIPos, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMaxHpChange, slot0._onMaxHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCurrentHpChange, slot0._onCurrentHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeWaveEnd, slot0._onChangeWaveEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeCareer, slot0._onChangeCareer, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateUIFollower, slot0._onUpdateUIFollower, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeShield, slot0._onChangeShield, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StageChanged, slot0._onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0._power:onOpen()
	slot0:_setPosOffset()
	slot0:updateInnerLayout()
end

function slot0._onStageChange(slot0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal then
		slot0:refreshBossFocusIcon(FightModel.instance:getCurRoundMO() and slot2:getAIUseCardMOList())
	end
end

function slot0.refreshBossFocusIcon(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0._goBossFocusIcon, false)

		return
	end

	slot3 = false

	if slot0.entity and slot0.entity:getMO() and slot2.side == FightEnum.EntitySide.MySide then
		for slot7, slot8 in ipairs(slot1) do
			if slot0:_checkCanMark(slot8) then
				slot3 = true

				break
			end
		end
	end

	gohelper.setActive(slot0._goBossFocusIcon, slot3)
end

function slot0._onSkillPlayFinish(slot0)
	slot0:refreshBossFocusIcon(FightModel.instance:getCurRoundMO() and slot1:getAILastUseCard())
end

function slot0._checkCanMark(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.targetUid ~= slot0.entity.id then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot1.uid) or slot2:isStatusDead() then
		return false
	end

	if not lua_ai_mark_skill.configDict[slot1.skillId] then
		return false
	end

	return true
end

function slot0.initExPointMgr(slot0)
	slot0._exPointGO = gohelper.findChild(slot0._uiGO, "expointContainer")

	slot0._expointCtrl:initMgr(slot0._exPointGO, slot0.entity)
end

function slot0.initStressMgr(slot0)
	if not slot0.entity:getMO():hasStress() then
		return
	end

	slot0.stressMgr = FightNameUIStressMgr.New(slot0)
	slot0.stressGo = gohelper.findChild(slot0._uiGO, "#go_fightstressitem")

	slot0.stressMgr:initMgr(slot0.stressGo, slot0.entity)
end

function slot0.beforeDestroy(slot0)
	slot0._power:releaseSelf()

	if slot0._seasonGuard then
		slot0._seasonGuard:releaseSelf()
	end

	slot0._expointCtrl:beforeDestroy()

	if slot0.stressMgr then
		slot0.stressMgr:beforeDestroy()
	end

	if slot0._enemyOperation then
		slot0._enemyOperation:disposeSelf()
	end

	slot0._opCtrl:beforeDestroy()
	slot0.buffMgr:beforeDestroy()
	CameraMgr.instance:getCameraTrace():RemoveChangeActor(slot0._uiFollower)
	FightFloatMgr.instance:nameUIBeforeDestroy(slot0._floatContainerGO)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._updateFollow, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforePlayTimeline, slot0._beforePlaySkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._updateUIPos, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0.updateUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.updateActive, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowFloat, slot0._setIsShowFloat, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowNameUI, slot0._setIsShowNameUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, slot0._onFloatEquipEffect, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCameraFovChange, slot0._updateUIPos, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMaxHpChange, slot0._onMaxHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCurrentHpChange, slot0._onCurrentHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeWaveEnd, slot0._onChangeWaveEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeCareer, slot0._onChangeCareer, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.UpdateUIFollower, slot0._onUpdateUIFollower, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeShield, slot0._onChangeShield, slot0)
	slot0:_killHpTween()
	TaskDispatcher.cancelTask(slot0._onDelAniOver, slot0)
	FightNameMgr.instance:unregister(slot0)
	gohelper.destroy(slot0._containerGO)
	slot0._uiLoader:dispose()

	slot0._uiLoader = nil
	slot0._containerGO = nil
end

function slot0.updateUI(slot0)
	slot0._txtName.text = slot0.entity:getMO():getEntityName()

	slot0:_refreshCareer()
	slot0:_updateFollow()
	slot0:updateActive()
end

function slot0._refreshCareer(slot0)
	slot2 = FightModel.instance:getVersion()

	if SkillEditorMgr.instance.inEditMode then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imgCareerIcon, "sx_icon_" .. tostring(slot0.entity:getMO():getCO().career), true)
	elseif slot2 >= 2 and slot1.career ~= 0 then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imgCareerIcon, "sx_icon_" .. tostring(slot1.career), true)
	else
		UISpriteSetMgr.instance:setCommonSprite(slot0._imgCareerIcon, "sx_icon_" .. tostring(slot1:getCO().career), true)
	end
end

function slot0._onChangeCareer(slot0, slot1)
	if slot1 == slot0.entity.id then
		slot0:_refreshCareer()
	end
end

function slot0._beforePlaySkill(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		return
	end

	slot0._opCtrl:hideOpContainer()
end

function slot0._onMySideRoundEnd(slot0)
	slot0._opCtrl:showOpContainer()
end

function slot0._onStartSequenceFinish(slot0)
	slot0:updateUI()
	slot0._opCtrl:showOpContainer()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:updateUI()
	slot0._opCtrl:showOpContainer()
end

function slot0._updateFollow(slot0, slot1)
	if slot1 and slot1.unitSpawn ~= slot0.entity then
		return
	end

	if not (slot0.entity.spine and slot0.entity.spine:getSpineGO()) then
		recthelper.setAnchorX(slot0._containerGO.transform, 20000)

		return
	end

	slot5 = slot0.entity.go.transform
	slot8 = FightConfig.instance:getSkinCO(slot0.entity:getMO().skin) and slot7.topuiOffset or {
		0,
		0,
		0,
		0
	}
	slot14, slot15 = FightHelper.getEntityBoxSizeOffsetV2(slot0.entity)
	slot16 = slot14.y
	slot17, slot18, slot19 = transformhelper.getPos(slot0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle, true).transform)
	slot20, slot21, slot22 = transformhelper.getPos(slot0.entity.go.transform)
	slot0._uiFollower = gohelper.onceAddComponent(slot0._containerGO, typeof(ZProj.UIFollower))

	slot0._uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())

	if gohelper.findChild(slot2, ModuleEnum.SpineHangPointRoot) and gohelper.findChild(slot23, ModuleEnum.SpineHangPoint.mounthproot) then
		slot25, slot26 = transformhelper.getLocalScale(slot0.entity.go.transform)

		slot0._uiFollower:Set(CameraMgr.instance:getUnitCamera(), CameraMgr.instance:getUICamera(), ViewMgr.instance:getUIRoot().transform, slot24.transform, slot8 and slot8[3] or 0, ((slot8 and slot8[4] or 0) + 0.5) * slot26, 0, slot8 and slot8[1] or 0, slot8 and slot8[2] or 0)
	elseif isTypeOf(slot0.entity, FightEntityAssembledMonsterMain) or isTypeOf(slot0.entity, FightEntityAssembledMonsterSub) then
		slot0._uiFollower:Set(slot3, slot4, slot6, slot13.transform, lua_fight_assembled_monster.configDict[slot0.entity:getMO().skin].hpPos[1] or 0, slot26.hpPos[2] or 0, 0, 0, 0)
	else
		slot25, slot26 = transformhelper.getLocalScale(slot0.entity.go.transform)

		slot0._uiFollower:Set(slot3, slot4, slot6, slot13.transform, 0 + slot11, slot16 + slot21 - slot18 + slot12 * slot26, 0, slot9, slot10 + 15)
	end

	slot0._uiFollower:SetEnable(true)
	CameraMgr.instance:getCameraTrace():AddChangeActor(slot0._uiFollower)
end

function slot0._updateUIPos(slot0)
	if slot0._uiFollower then
		slot0._uiFollower:ForceUpdate()
	end
end

function slot0.changeHpWithChoushiBuff(slot0, slot1)
	if not slot0.entity:isMySide() then
		gohelper.setActive(slot0._gohpbg, not slot1)
		gohelper.setActive(slot0._gohpbg, slot1)

		if slot1 then
			UISpriteSetMgr.instance:setFightSprite(slot0._imgHp, "bg_xt_choushi")
		else
			UISpriteSetMgr.instance:setFightSprite(slot0._imgHp, "bg_xt2")
		end
	end
end

function slot0.getFollower(slot0)
	return slot0._uiFollower
end

function slot0.updateActive(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 and slot1 ~= slot0.entity.id then
		return
	end

	if slot3 then
		if lua_skill_buff.configDict[slot3] and slot6.typeId == 3120005 then
			slot0:_insteadSpecialHp(slot2)
		end

		if FightConfig.instance:hasBuffFeature(slot3, FightEnum.BuffType_HideLife) then
			slot0:_doSetActive()
		end
	else
		slot0:_doSetActive()
	end
end

function slot0._insteadSpecialHp(slot0, slot1)
	if slot1 then
		if slot1 == FightEnum.EffectType.BUFFADD then
			slot0:changeHpWithChoushiBuff(true)
		elseif slot1 == FightEnum.EffectType.BUFFDEL or slot1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			slot0:changeHpWithChoushiBuff(false)
		end
	else
		for slot6, slot7 in pairs(slot0.entity:getMO():getBuffDic()) do
			if lua_skill_buff.configDict[slot7.buffId] and slot8.typeId == 3120005 then
				slot0:changeHpWithChoushiBuff(true)

				return
			end
		end
	end
end

function slot0.getFloatItemStartY(slot0)
	return (slot0.buffMgr:getBuffLineCount() or 0) * 34.5 + (#slot0._opCtrl:getOpItemList() > 0 and 42 or 0)
end

function slot0.showPoisoningEffect(slot0, slot1)
	slot0.buffMgr:showPoisoningEffect(slot1)
end

function slot0._setIsShowFloat(slot0, slot1)
	if not slot0._canvasGroup then
		slot0._canvasGroup = gohelper.onceAddComponent(slot0._floatContainerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(slot0._canvasGroup, slot1)
end

function slot0.addHp(slot0, slot1)
	slot3 = slot0.entity:getMO().attrMO.hp
	slot0._curHp = slot0._curHp + slot1
	slot0._curHp = slot0._curHp >= 0 and slot0._curHp or 0
	slot0._curHp = slot0._curHp <= slot3 and slot0._curHp or slot3
	slot0._txtHp.text = slot0._curHp

	slot0:_tweenFillAmount()
end

function slot0.getHp(slot0)
	return slot0._curHp
end

function slot0.setShield(slot0, slot1)
	slot0._curShield = slot1 > 0 and slot1 or 0

	slot0:_tweenFillAmount()
end

function slot0._tweenFillAmount(slot0)
	slot1, slot2 = slot0:_getFillAmount()
	slot0._imgHp.fillAmount = slot1

	ZProj.TweenHelper.KillByObj(slot0._imgHpMinus)
	ZProj.TweenHelper.DOFillAmount(slot0._imgHpMinus, slot1, 0.5)
	ZProj.TweenHelper.KillByObj(slot0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(slot0._imgHpShield, slot2, 0.5)
	gohelper.setActive(slot0._imgHpMinus.gameObject, slot0._curShield <= 0)
end

function slot0.resetHp(slot0)
	ZProj.TweenHelper.KillByObj(slot0._imgHpMinus)
	ZProj.TweenHelper.KillByObj(slot0._imgHpShield)

	slot0._curHp = slot0.entity:getMO().currentHp
	slot0._curHp = slot0._curHp > 0 and slot0._curHp or 0
	slot0._curShield = slot0.entity:getMO().shieldValue
	slot1, slot0._imgHpShield.fillAmount = slot0:_getFillAmount()
	slot0._imgHpMinus.fillAmount = slot1
	slot0._imgHp.fillAmount = slot1
	slot0._txtHp.text = slot0._curHp

	gohelper.setActive(slot0._imgHpMinus.gameObject, slot0._curShield <= 0)
end

function slot0._getFillAmount(slot0)
	slot2 = slot0.entity:getMO().attrMO and slot1.attrMO.hp > 0 and slot1.attrMO.hp or 1
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
	end

	return slot3, slot4
end

function slot0._onFloatEquipEffect(slot0, slot1, slot2)
	if slot1 ~= slot0.entity.id then
		return
	end

	if not slot0._float_equip_time then
		slot0._float_equip_time = Time.time
	elseif Time.time - slot0._float_equip_time < 1 then
		return
	end

	slot0._float_equip_time = Time.time

	FightFloatMgr.instance:float(slot1, FightEnum.FloatType.equipeffect, "", slot2)
end

function slot0.setFloatRootVisble(slot0, slot1)
	gohelper.setActive(slot0._floatContainerGO, slot1)
end

function slot0._onMaxHpChange(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entity.id then
		return
	end

	slot0:_killHpTween()

	if not slot0._hp_tweens then
		slot0._hp_tweens = {}
	end

	if slot2 < slot3 then
		slot0._hp_ani:Play("up", 0, 0)
		table.insert(slot0._hp_tweens, ZProj.TweenHelper.DOAnchorPosX(slot0._hp_container_tran, 0, 0.3, slot0._hpTweenDone, slot0))
	elseif (slot0.entity:getMO().attrMO and slot4.attrMO.hp > 0 and slot4.attrMO.hp or 1) < (slot4.attrMO and slot4.attrMO.original_max_hp or 1) then
		slot0._hp_ani:Play("down", 0, 0)
		slot0:resetHp()
	end
end

function slot0._hpTweenDone(slot0)
	slot0:resetHp()
end

function slot0._killHpTween(slot0)
	if slot0._hp_tweens then
		for slot4, slot5 in ipairs(slot0._hp_tweens) do
			ZProj.TweenHelper.KillById(slot5)
		end

		slot0._hp_tweens = {}
	end
end

function slot0._onChangeShield(slot0, slot1)
	if slot1 ~= slot0.entity.id then
		return
	end

	slot0._curShield = FightDataHelper.entityMgr:getById(slot1).shieldValue

	slot0:_tweenFillAmount()
end

function slot0._onCurrentHpChange(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entity.id then
		return
	end

	slot0:resetHp()
end

function slot0._onMultiHpChange(slot0, slot1)
	slot0:_onCurrentHpChange(slot1)
end

function slot0._onChangeWaveEnd(slot0)
	slot0:_setPosOffset()
end

function slot0._onForceUpdatePerformanceData(slot0, slot1)
	if slot1 ~= slot0.entity.id then
		return
	end

	slot0:setShield(FightDataHelper.entityMgr:getById(slot1).shieldValue)
	slot0:resetHp()
	slot0.buffMgr:refreshBuffList()
	slot0._power:_refreshUI()
	slot0._expointCtrl:updateSelfExPoint()
end

function slot0._setPosOffset(slot0)
	if slot0.entity:getSide() == FightEnum.EntitySide.MySide then
		slot2 = FightEnum.MySideDefaultStanceId
		slot3 = slot0.entity:getMO()
		slot5 = FightModel.instance:getFightParam() and slot4.battleId

		if slot5 and lua_battle.configDict[slot5] and not string.nilorempty(slot6.myStance) and not tonumber(slot6.myStance) and #string.splitToNumber(slot6.myStance, "#") > 0 then
			slot8 = FightModel.instance:getCurWaveId() or 1
			slot2 = slot7[slot8 <= #slot7 and slot8 or #slot7]
		end

		if lua_stance_hp_offset.configDict[slot2] and slot7["offsetPos" .. slot3.position] and #slot8 > 0 then
			recthelper.setAnchor(slot0._floatContainerGO.transform, slot8[1], slot8[2])
			recthelper.setAnchor(slot0._uiGO.transform, slot8[1], slot8[2])

			slot0._originPosOffsetX = slot8[1]
			slot0._originPosOffsetY = slot8[2]
		end
	end
end

slot1 = {
	NoExPoint_NoPower = 1,
	ExPoint_NoPower = 2,
	NoExPoint_Power = 3,
	ExPoint_Power = 4
}
slot2 = {
	[slot1.NoExPoint_NoPower] = {
		imageCareer = 5,
		layout = 36
	},
	[slot1.ExPoint_NoPower] = {
		imageCareer = -5,
		layout = 52
	},
	[slot1.NoExPoint_Power] = {
		imageCareer = -5,
		layout = 40
	},
	[slot1.ExPoint_Power] = {
		imageCareer = -12,
		layout = 52
	}
}

function slot0.updateInnerLayout(slot0)
	slot2 = not slot0._expointCtrl:checkNeedShieldExPoint()
	slot3 = nil
	slot4 = uv1[(not slot0._power:_getPowerData() or not slot2 or uv0.ExPoint_Power) and (not slot1 or uv0.NoExPoint_Power) and (not slot2 or uv0.ExPoint_NoPower) and uv0.NoExPoint_NoPower]

	recthelper.setAnchorY(slot0._imgCareerIcon:GetComponent(gohelper.Type_RectTransform), slot4.imageCareer)
	recthelper.setAnchorY(gohelper.findChildComponent(slot0._uiGO, "layout", gohelper.Type_RectTransform), slot4.layout)
end

function slot0._onUpdateUIFollower(slot0, slot1)
	if slot0._entity and slot1 == slot0._entity.id then
		slot0:_updateFollow()
	end
end

function slot0.onDestroy(slot0)
end

return slot0
