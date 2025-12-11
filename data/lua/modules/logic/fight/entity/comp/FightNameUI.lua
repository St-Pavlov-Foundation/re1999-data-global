module("modules.logic.fight.entity.comp.FightNameUI", package.seeall)

local var_0_0 = class("FightNameUI", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._entity = arg_1_1
	arg_1_0._nameUIActive = true
	arg_1_0._nameUIVisible = true
	arg_1_0.buffMgr = FightNameUIBuffMgr.New()
	arg_1_0._power = FightNameUIPower.New(arg_1_0, 1)
	arg_1_0._hpKillLineComp = FightHpKillLineComp.New(FightHpKillLineComp.KillLineType.NameUiHp)
end

function var_0_0.load(arg_2_0, arg_2_1)
	if arg_2_0._uiLoader then
		arg_2_0._uiLoader:dispose()
	end

	arg_2_0._containerGO = gohelper.create2d(FightNameMgr.instance:getNameParent(), arg_2_0.entity:getMO():getIdName())
	arg_2_0._floatContainerGO = gohelper.create2d(arg_2_0._containerGO, "float")

	FightNameMgr.instance:register(arg_2_0)

	arg_2_0._uiLoader = PrefabInstantiate.Create(arg_2_0._containerGO)

	arg_2_0._uiLoader:startLoad(arg_2_1, arg_2_0._onLoaded, arg_2_0)
	arg_2_0:checkLoadHealth()
end

function var_0_0.checkLoadHealth(arg_3_0)
	if not FightHelper.getSurvivalEntityHealth(arg_3_0.entity.id) then
		return
	end

	arg_3_0.healthComp = FightNameUIHealthComp.Create(arg_3_0.entity, arg_3_0._containerGO)
end

function var_0_0.setActive(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_0._curHp and arg_4_0._curHp <= 0 then
		return
	end

	arg_4_0._nameUIActive = arg_4_1

	arg_4_0:_doSetActive()
end

function var_0_0.playDeadEffect(arg_5_0)
	arg_5_0:_playAni("die")
end

function var_0_0.playOpenEffect(arg_6_0)
	arg_6_0:_playAni(UIAnimationName.Open)
end

function var_0_0.playCloseEffect(arg_7_0)
	arg_7_0:_playAni("close")
end

function var_0_0._playAni(arg_8_0, arg_8_1)
	if arg_8_0._ani then
		arg_8_0._ani:Play(arg_8_1, 0, 0)

		local var_8_0 = FightModel.instance:getSpeed()

		arg_8_0._ani.speed = var_8_0
	end
end

function var_0_0._setIsShowNameUI(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = false

	if not arg_9_2 then
		var_9_0 = true
	else
		for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
			if iter_9_1.id == arg_9_0.entity.id then
				var_9_0 = true

				break
			end
		end
	end

	if var_9_0 then
		arg_9_0._nameUIVisible = arg_9_1

		arg_9_0:_doSetActive()
	end
end

function var_0_0._doSetActive(arg_10_0)
	local var_10_0 = arg_10_0:getUIGO()

	if gohelper.isNil(var_10_0) then
		return
	end

	local var_10_1 = arg_10_0._nameUIActive and arg_10_0._nameUIVisible

	if arg_10_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_HideLife) then
		var_10_1 = false
	end

	if FightDataHelper.tempMgr.hideNameUIByTimeline then
		var_10_1 = false
	end

	if not gohelper.isNil(arg_10_0._uiCanvasGroup) then
		if var_10_1 then
			recthelper.setAnchor(arg_10_0:getUIGO().transform, arg_10_0._originPosOffsetX or 0, arg_10_0._originPosOffsetY or 0)
		else
			recthelper.setAnchor(arg_10_0:getUIGO().transform, 20000, 20000)
		end
	end

	if var_10_1 and arg_10_0._uiFollower then
		arg_10_0._uiFollower:ForceUpdate()
	end
end

function var_0_0.getAnchorXY(arg_11_0)
	if arg_11_0._uiTransform then
		local var_11_0, var_11_1 = recthelper.getAnchor(arg_11_0._uiTransform, 0, 0)

		return recthelper.getAnchor(arg_11_0._uiTransform, 0, 0)
	end

	return 0, 0
end

function var_0_0.getFloatContainerGO(arg_12_0)
	return arg_12_0._floatContainerGO
end

function var_0_0.getGO(arg_13_0)
	return arg_13_0._containerGO
end

function var_0_0.getUIGO(arg_14_0)
	return arg_14_0._uiGO
end

function var_0_0._onLoaded(arg_15_0)
	gohelper.setAsLastSibling(arg_15_0._floatContainerGO)

	arg_15_0._uiGO = arg_15_0._uiLoader:getInstGO()
	arg_15_0.entityView = FightEntityView.New(arg_15_0.entity.id, arg_15_0._uiGO)
	arg_15_0._uiTransform = arg_15_0._uiGO.transform
	arg_15_0._uiCanvasGroup = gohelper.onceAddComponent(arg_15_0._uiGO, typeof(UnityEngine.CanvasGroup))
	arg_15_0._txtName = gohelper.findChildText(arg_15_0._uiGO, "layout/top/Text")

	arg_15_0:_doSetActive()

	arg_15_0._gohpbg = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp/container/bg")
	arg_15_0._gochoushibg = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp/container/choushibg")
	arg_15_0._imgHpMinus = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/hp/container/minus")

	local var_15_0 = arg_15_0.entity:isMySide()
	local var_15_1 = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/hp/container/my")
	local var_15_2 = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/hp/container/enemy")

	gohelper.setActive(var_15_1.gameObject, var_15_0)
	gohelper.setActive(var_15_2.gameObject, not var_15_0)

	arg_15_0._hpGo = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp")
	arg_15_0._hp_ani = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp"):GetComponent(typeof(UnityEngine.Animator))
	arg_15_0._hp_container_tran = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp/container").transform
	arg_15_0._imgHp = var_15_0 and var_15_1 or var_15_2
	arg_15_0._imgHpShield = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/hp/container/shield")
	arg_15_0._txtHp = gohelper.findChildText(arg_15_0._uiGO, "layout/top/hp/Text")
	arg_15_0._reduceHp = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp/container/reduce")
	arg_15_0._reduceHpImage = arg_15_0._reduceHp:GetComponent(gohelper.Type_Image)

	arg_15_0:resetHp()

	arg_15_0._imgCareerIcon = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/imgCareerIcon")
	arg_15_0.careerTopRectTr = gohelper.findChildComponent(arg_15_0._uiGO, "layout/top/imgCareerIcon/careertoppos", gohelper.Type_RectTransform)

	arg_15_0:initExPointMgr()
	arg_15_0:initStressMgr()
	arg_15_0._hpKillLineComp:init(arg_15_0.entity.id, arg_15_0._hpGo)
	arg_15_0:initPowerMgr()

	arg_15_0._opContainerGO = gohelper.findChild(arg_15_0._uiGO, "layout/top/op")
	arg_15_0._opContainerTr = arg_15_0._opContainerGO.transform
	arg_15_0._buffContainerGO = gohelper.findChild(arg_15_0._uiGO, "layout/top/buffContainer")
	arg_15_0._buffGO = gohelper.findChild(arg_15_0._uiGO, "layout/top/buffContainer/buff")

	arg_15_0.buffMgr:init(arg_15_0.entity, arg_15_0._buffGO, arg_15_0._opContainerTr)
	gohelper.setActive(gohelper.findChild(arg_15_0._uiGO, "#go_Shield"), false)

	if FightModel.instance:isSeason2() and arg_15_0.entity:getMO().guard ~= -1 then
		arg_15_0._seasonGuard = FightNameUISeasonGuard.New(arg_15_0)

		arg_15_0._seasonGuard:init(gohelper.findChild(arg_15_0._uiGO, "#go_Shield"))
	end

	arg_15_0._ani = arg_15_0._uiGO:GetComponent(typeof(UnityEngine.Animator))
	arg_15_0._goBossFocusIcon = gohelper.findChild(arg_15_0._uiGO, "go_bossfocusicon")

	gohelper.setActive(arg_15_0._goBossFocusIcon, false)
	arg_15_0:updateUI()
	arg_15_0:_insteadSpecialHp()
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_15_0._updateFollow, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_15_0._beforePlaySkill, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_15_0._onMySideRoundEnd, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_15_0._updateUIPos, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_15_0._onStartSequenceFinish, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_15_0.updateUI, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_15_0._onRoundSequenceFinish, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_15_0.updateActive, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.SetIsShowFloat, arg_15_0._setIsShowFloat, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.SetIsShowNameUI, arg_15_0._setIsShowNameUI, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, arg_15_0._onFloatEquipEffect, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnCameraFovChange, arg_15_0._updateUIPos, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnMaxHpChange, arg_15_0._onMaxHpChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnCurrentHpChange, arg_15_0._onCurrentHpChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.MultiHpChange, arg_15_0._onMultiHpChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.ChangeWaveEnd, arg_15_0._onChangeWaveEnd, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.CoverPerformanceEntityData, arg_15_0.onCoverPerformanceEntityData, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.ChangeCareer, arg_15_0._onChangeCareer, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.UpdateUIFollower, arg_15_0._onUpdateUIFollower, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.ChangeShield, arg_15_0._onChangeShield, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_15_0._onStageChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_15_0._onSkillPlayFinish, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnLockHpChange, arg_15_0._onLockHpChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.AiJiAoFakeDecreaseHp, arg_15_0.onAiJiAoFakeDecreaseHp, arg_15_0)
	arg_15_0._power:onOpen()
	arg_15_0:_setPosOffset()
	arg_15_0:updateInnerLayout()
end

function var_0_0._onStageChange(arg_16_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local var_16_0 = FightDataHelper.roundMgr:getRoundData()
		local var_16_1 = var_16_0 and var_16_0:getAIUseCardMOList()

		arg_16_0:refreshBossFocusIcon(var_16_1)
	end
end

function var_0_0.refreshBossFocusIcon(arg_17_0, arg_17_1)
	if not arg_17_1 then
		gohelper.setActive(arg_17_0._goBossFocusIcon, false)

		return
	end

	local var_17_0 = arg_17_0.entity and arg_17_0.entity:getMO()
	local var_17_1 = false

	if var_17_0 and var_17_0.side == FightEnum.EntitySide.MySide then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			if arg_17_0:_checkCanMark(iter_17_1) then
				var_17_1 = true

				break
			end
		end
	end

	gohelper.setActive(arg_17_0._goBossFocusIcon, var_17_1)
end

function var_0_0._onSkillPlayFinish(arg_18_0)
	local var_18_0 = FightDataHelper.roundMgr:getPreRoundData()
	local var_18_1 = var_18_0 and var_18_0:getAIUseCardMOList()

	arg_18_0:refreshBossFocusIcon(var_18_1)
end

function var_0_0._checkCanMark(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return false
	end

	if arg_19_1.targetUid ~= arg_19_0.entity.id then
		return false
	end

	local var_19_0 = FightDataHelper.entityMgr:getById(arg_19_1.uid)

	if not var_19_0 or var_19_0:isStatusDead() then
		return false
	end

	if not lua_ai_mark_skill.configDict[arg_19_1.skillId] then
		return false
	end

	return true
end

function var_0_0.initExPointMgr(arg_20_0)
	arg_20_0._expointCtrl = FightExPointView.New(arg_20_0.entity.id, arg_20_0._uiGO)
end

function var_0_0.initPowerMgr(arg_21_0)
	arg_21_0.powerView = FightNamePowerInfoView.New(arg_21_0.entity.id, arg_21_0._uiGO)
end

function var_0_0.initStressMgr(arg_22_0)
	if not arg_22_0.entity:getMO():hasStress() then
		return
	end

	arg_22_0.stressMgr = FightNameUIStressMgr.New(arg_22_0)
	arg_22_0.stressGo = gohelper.findChild(arg_22_0._uiGO, "#go_fightstressitem")

	arg_22_0.stressMgr:initMgr(arg_22_0.stressGo, arg_22_0.entity)
end

function var_0_0.beforeDestroy(arg_23_0)
	arg_23_0._power:releaseSelf()

	if arg_23_0._seasonGuard then
		arg_23_0._seasonGuard:releaseSelf()
	end

	if arg_23_0.entityView then
		arg_23_0.entityView:disposeSelf()
	end

	if arg_23_0._expointCtrl then
		arg_23_0._expointCtrl:disposeSelf()
	end

	if arg_23_0.powerView then
		arg_23_0.powerView:disposeSelf()
	end

	if arg_23_0.stressMgr then
		arg_23_0.stressMgr:beforeDestroy()
	end

	if arg_23_0._enemyOperation then
		arg_23_0._enemyOperation:disposeSelf()
	end

	if arg_23_0.healthComp then
		arg_23_0.healthComp:beforeDestroy()

		arg_23_0.healthComp = nil
	end

	arg_23_0.buffMgr:beforeDestroy()
	arg_23_0._hpKillLineComp:beforeDestroy()
	CameraMgr.instance:getCameraTrace():RemoveChangeActor(arg_23_0._uiFollower)
	FightFloatMgr.instance:nameUIBeforeDestroy(arg_23_0._floatContainerGO)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_23_0._updateFollow, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_23_0._beforePlaySkill, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_23_0._onMySideRoundEnd, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_23_0._updateUIPos, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_23_0._onStartSequenceFinish, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_23_0.updateUI, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_23_0._onRoundSequenceFinish, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_23_0.updateActive, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.SetIsShowFloat, arg_23_0._setIsShowFloat, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.SetIsShowNameUI, arg_23_0._setIsShowNameUI, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, arg_23_0._onFloatEquipEffect, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnCameraFovChange, arg_23_0._updateUIPos, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnMaxHpChange, arg_23_0._onMaxHpChange, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnCurrentHpChange, arg_23_0._onCurrentHpChange, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.MultiHpChange, arg_23_0._onMultiHpChange, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.ChangeWaveEnd, arg_23_0._onChangeWaveEnd, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.ChangeCareer, arg_23_0._onChangeCareer, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.UpdateUIFollower, arg_23_0._onUpdateUIFollower, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.ChangeShield, arg_23_0._onChangeShield, arg_23_0)
	arg_23_0:removeEventCb(FightController.instance, FightEvent.OnLockHpChange, arg_23_0._onLockHpChange, arg_23_0)
	arg_23_0:_killHpTween()
	TaskDispatcher.cancelTask(arg_23_0._onDelAniOver, arg_23_0)
	FightNameMgr.instance:unregister(arg_23_0)
	gohelper.destroy(arg_23_0._containerGO)
	arg_23_0._uiLoader:dispose()

	arg_23_0._uiLoader = nil
	arg_23_0._containerGO = nil
end

function var_0_0.updateUI(arg_24_0)
	local var_24_0 = arg_24_0.entity:getMO()

	arg_24_0._txtName.text = var_24_0:getEntityName()

	arg_24_0:_refreshCareer()
	arg_24_0:_updateFollow()
	arg_24_0:updateActive()
end

function var_0_0._refreshCareer(arg_25_0)
	local var_25_0 = arg_25_0.entity:getMO()
	local var_25_1 = FightModel.instance:getVersion()

	if SkillEditorMgr.instance.inEditMode then
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imgCareerIcon, "sx_icon_" .. tostring(var_25_0:getCO().career), true)
	elseif var_25_1 >= 2 and var_25_0.career ~= 0 then
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imgCareerIcon, "sx_icon_" .. tostring(var_25_0.career), true)
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imgCareerIcon, "sx_icon_" .. tostring(var_25_0:getCO().career), true)
	end
end

function var_0_0._onChangeCareer(arg_26_0, arg_26_1)
	if arg_26_1 == arg_26_0.entity.id then
		arg_26_0:_refreshCareer()
	end
end

function var_0_0._beforePlaySkill(arg_27_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.ClothSkill) then
		return
	end
end

function var_0_0._onMySideRoundEnd(arg_28_0)
	return
end

function var_0_0._onStartSequenceFinish(arg_29_0)
	arg_29_0:updateUI()
end

function var_0_0._onRoundSequenceFinish(arg_30_0)
	arg_30_0:updateUI()
end

function var_0_0._updateFollow(arg_31_0, arg_31_1)
	if arg_31_1 and arg_31_1.unitSpawn ~= arg_31_0.entity then
		return
	end

	local var_31_0 = arg_31_0.entity.spine and arg_31_0.entity.spine:getSpineGO()

	if not var_31_0 then
		recthelper.setAnchorX(arg_31_0._containerGO.transform, 20000)

		return
	end

	local var_31_1 = CameraMgr.instance:getUnitCamera()
	local var_31_2 = CameraMgr.instance:getUICamera()
	local var_31_3 = arg_31_0.entity.go.transform
	local var_31_4 = ViewMgr.instance:getUIRoot().transform
	local var_31_5 = FightConfig.instance:getSkinCO(arg_31_0.entity:getMO().skin)
	local var_31_6 = var_31_5 and var_31_5.topuiOffset or {
		0,
		0,
		0,
		0
	}
	local var_31_7 = var_31_6 and var_31_6[1] or 0
	local var_31_8 = var_31_6 and var_31_6[2] or 0
	local var_31_9 = var_31_6 and var_31_6[3] or 0
	local var_31_10 = var_31_6 and var_31_6[4] or 0
	local var_31_11 = arg_31_0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle, true)
	local var_31_12, var_31_13 = FightHelper.getEntityBoxSizeOffsetV2(arg_31_0.entity)
	local var_31_14 = var_31_12.y
	local var_31_15, var_31_16, var_31_17 = transformhelper.getPos(var_31_11.transform)
	local var_31_18, var_31_19, var_31_20 = transformhelper.getPos(arg_31_0.entity.go.transform)

	arg_31_0._uiFollower = gohelper.onceAddComponent(arg_31_0._containerGO, typeof(ZProj.UIFollower))

	arg_31_0._uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())

	local var_31_21 = gohelper.findChild(var_31_0, ModuleEnum.SpineHangPointRoot)
	local var_31_22 = var_31_21 and gohelper.findChild(var_31_21, ModuleEnum.SpineHangPoint.mounthproot)

	if var_31_22 then
		local var_31_23, var_31_24 = transformhelper.getLocalScale(arg_31_0.entity.go.transform)
		local var_31_25 = 0.5

		arg_31_0._uiFollower:Set(var_31_1, var_31_2, var_31_4, var_31_22.transform, var_31_9, (var_31_10 + var_31_25) * var_31_24, 0, var_31_7, var_31_8)
	elseif isTypeOf(arg_31_0.entity, FightEntityAssembledMonsterMain) or isTypeOf(arg_31_0.entity, FightEntityAssembledMonsterSub) then
		local var_31_26 = arg_31_0.entity:getMO()
		local var_31_27 = lua_fight_assembled_monster.configDict[var_31_26.skin]

		arg_31_0._uiFollower:Set(var_31_1, var_31_2, var_31_4, var_31_11.transform, var_31_27.hpPos[1] or 0, var_31_27.hpPos[2] or 0, 0, 0, 0)
	else
		local var_31_28, var_31_29 = transformhelper.getLocalScale(arg_31_0.entity.go.transform)

		arg_31_0._uiFollower:Set(var_31_1, var_31_2, var_31_4, var_31_11.transform, 0 + var_31_9, var_31_14 + var_31_19 - var_31_16 + var_31_10 * var_31_29, 0, var_31_7, var_31_8 + 15)
	end

	arg_31_0._uiFollower:SetEnable(true)
	CameraMgr.instance:getCameraTrace():AddChangeActor(arg_31_0._uiFollower)
end

function var_0_0._updateUIPos(arg_32_0)
	if arg_32_0._uiFollower then
		arg_32_0._uiFollower:ForceUpdate()
	end
end

function var_0_0.changeHpWithChoushiBuff(arg_33_0, arg_33_1)
	if not arg_33_0.entity:isMySide() then
		gohelper.setActive(arg_33_0._gohpbg, not arg_33_1)
		gohelper.setActive(arg_33_0._gohpbg, arg_33_1)

		if arg_33_1 then
			UISpriteSetMgr.instance:setFightSprite(arg_33_0._imgHp, "bg_xt_choushi")
		else
			UISpriteSetMgr.instance:setFightSprite(arg_33_0._imgHp, "bg_xt2")
		end
	end
end

function var_0_0.getFollower(arg_34_0)
	return arg_34_0._uiFollower
end

function var_0_0.updateActive(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	if arg_35_1 and arg_35_1 ~= arg_35_0.entity.id then
		return
	end

	if arg_35_3 then
		local var_35_0 = lua_skill_buff.configDict[arg_35_3]

		if var_35_0 and var_35_0.typeId == 3120005 then
			arg_35_0:_insteadSpecialHp(arg_35_2)
		end

		if FightConfig.instance:hasBuffFeature(arg_35_3, FightEnum.BuffType_HideLife) then
			arg_35_0:_doSetActive()
		end
	else
		arg_35_0:_doSetActive()
	end
end

function var_0_0._insteadSpecialHp(arg_36_0, arg_36_1)
	if arg_36_1 then
		if arg_36_1 == FightEnum.EffectType.BUFFADD then
			arg_36_0:changeHpWithChoushiBuff(true)
		elseif arg_36_1 == FightEnum.EffectType.BUFFDEL or arg_36_1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			arg_36_0:changeHpWithChoushiBuff(false)
		end
	else
		local var_36_0 = arg_36_0.entity:getMO():getBuffDic()

		for iter_36_0, iter_36_1 in pairs(var_36_0) do
			local var_36_1 = lua_skill_buff.configDict[iter_36_1.buffId]

			if var_36_1 and var_36_1.typeId == 3120005 then
				arg_36_0:changeHpWithChoushiBuff(true)

				return
			end
		end
	end
end

function var_0_0.getFloatItemStartY(arg_37_0)
	local var_37_0 = FightMsgMgr.sendMsg(FightMsgId.GetEnemyAiUseCardItemList, arg_37_0.entity.id)
	local var_37_1 = var_37_0 and #var_37_0 or 0

	return (arg_37_0.buffMgr:getBuffLineCount() or 0) * 34.5 + (var_37_1 > 0 and 42 or 0)
end

function var_0_0.showPoisoningEffect(arg_38_0, arg_38_1)
	arg_38_0.buffMgr:showPoisoningEffect(arg_38_1)
end

function var_0_0._setIsShowFloat(arg_39_0, arg_39_1)
	if not arg_39_0._canvasGroup then
		arg_39_0._canvasGroup = gohelper.onceAddComponent(arg_39_0._floatContainerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_39_0._canvasGroup, arg_39_1)
end

function var_0_0.addHp(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0.entity:getMO().attrMO.hp

	arg_40_0._curHp = arg_40_0._curHp + arg_40_1
	arg_40_0._curHp = arg_40_0._curHp >= 0 and arg_40_0._curHp or 0
	arg_40_0._curHp = var_40_0 >= arg_40_0._curHp and arg_40_0._curHp or var_40_0
	arg_40_0._txtHp.text = arg_40_0._curHp

	arg_40_0:_tweenFillAmount()
end

function var_0_0.getHp(arg_41_0)
	return arg_41_0._curHp
end

function var_0_0.setShield(arg_42_0, arg_42_1)
	arg_42_0._curShield = arg_42_1 > 0 and arg_42_1 or 0

	arg_42_0:_tweenFillAmount()
end

function var_0_0._tweenFillAmount(arg_43_0, arg_43_1, arg_43_2)
	arg_43_1 = arg_43_1 or arg_43_0._curHp
	arg_43_2 = arg_43_2 or arg_43_0._curShield

	local var_43_0, var_43_1 = arg_43_0:_getFillAmount(arg_43_1, arg_43_2)
	local var_43_2 = var_43_0

	if FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_43_0.entity.id] then
		arg_43_1, arg_43_2 = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(arg_43_0.entity.id, arg_43_1, arg_43_2)
		var_43_0, var_43_1 = arg_43_0:_getFillAmount(arg_43_1, arg_43_2)
	end

	arg_43_0._imgHp.fillAmount = var_43_0

	ZProj.TweenHelper.KillByObj(arg_43_0._imgHpMinus)
	ZProj.TweenHelper.DOFillAmount(arg_43_0._imgHpMinus, var_43_2, 0.5)
	ZProj.TweenHelper.KillByObj(arg_43_0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(arg_43_0._imgHpShield, var_43_1, 0.5)
	gohelper.setActive(arg_43_0._imgHpMinus.gameObject, arg_43_2 <= 0)
	arg_43_0:refreshReduceHp()
end

function var_0_0.resetHp(arg_44_0)
	arg_44_0._curHp = arg_44_0.entity:getMO().currentHp
	arg_44_0._curHp = arg_44_0._curHp > 0 and arg_44_0._curHp or 0
	arg_44_0._curShield = arg_44_0.entity:getMO().shieldValue

	arg_44_0:_tweenFillAmount()
end

function var_0_0.refreshReduceHp(arg_45_0)
	local var_45_0 = arg_45_0.entity:getMO()
	local var_45_1 = var_45_0 and var_45_0:getLockMaxHpRate() or 1
	local var_45_2 = var_45_1 < 1

	gohelper.setActive(arg_45_0._reduceHp, var_45_2)

	if var_45_2 then
		arg_45_0._reduceHpImage.fillAmount = Mathf.Clamp01(1 - var_45_1)
	end
end

function var_0_0._getFillAmount(arg_46_0, arg_46_1, arg_46_2)
	arg_46_1 = arg_46_1 or arg_46_0._curHp
	arg_46_2 = arg_46_2 or arg_46_0._curShield

	return var_0_0.getHpFillAmount(arg_46_1, arg_46_2, arg_46_0.entity.id)
end

function var_0_0.getHpFillAmount(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = FightDataHelper.entityMgr:getById(arg_47_2)

	if not var_47_0 then
		return 0, 0
	end

	local var_47_1, var_47_2 = var_47_0:getHpAndShieldFillAmount(arg_47_0, arg_47_1)

	return var_47_1, var_47_2
end

function var_0_0._onFloatEquipEffect(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_1 ~= arg_48_0.entity.id then
		return
	end

	if not arg_48_0._float_equip_time then
		arg_48_0._float_equip_time = Time.time
	elseif Time.time - arg_48_0._float_equip_time < 1 then
		return
	end

	arg_48_0._float_equip_time = Time.time

	FightFloatMgr.instance:float(arg_48_1, FightEnum.FloatType.equipeffect, "", arg_48_2, false)
end

function var_0_0.setFloatRootVisble(arg_49_0, arg_49_1)
	gohelper.setActive(arg_49_0._floatContainerGO, arg_49_1)
end

function var_0_0._onMaxHpChange(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if arg_50_1 ~= arg_50_0.entity.id then
		return
	end

	arg_50_0:_killHpTween()

	if not arg_50_0._hp_tweens then
		arg_50_0._hp_tweens = {}
	end

	if arg_50_2 < arg_50_3 then
		arg_50_0._hp_ani:Play("up", 0, 0)

		local var_50_0 = ZProj.TweenHelper.DOAnchorPosX(arg_50_0._hp_container_tran, 0, 0.3, arg_50_0._hpTweenDone, arg_50_0)

		table.insert(arg_50_0._hp_tweens, var_50_0)
	else
		local var_50_1 = arg_50_0.entity:getMO()

		if (var_50_1.attrMO and var_50_1.attrMO.hp > 0 and var_50_1.attrMO.hp or 1) < (var_50_1.attrMO and var_50_1.attrMO.original_max_hp or 1) then
			arg_50_0._hp_ani:Play("down", 0, 0)
			arg_50_0:resetHp()
		end
	end
end

function var_0_0._hpTweenDone(arg_51_0)
	arg_51_0:resetHp()
end

function var_0_0._killHpTween(arg_52_0)
	if arg_52_0._hp_tweens then
		for iter_52_0, iter_52_1 in ipairs(arg_52_0._hp_tweens) do
			ZProj.TweenHelper.KillById(iter_52_1)
		end

		arg_52_0._hp_tweens = {}
	end
end

function var_0_0._onChangeShield(arg_53_0, arg_53_1)
	if arg_53_1 ~= arg_53_0.entity.id then
		return
	end

	arg_53_0._curShield = FightDataHelper.entityMgr:getById(arg_53_1).shieldValue

	arg_53_0:_tweenFillAmount()
end

function var_0_0._onCurrentHpChange(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_1 ~= arg_54_0.entity.id then
		return
	end

	arg_54_0:resetHp()
end

function var_0_0._onMultiHpChange(arg_55_0, arg_55_1)
	arg_55_0:_onCurrentHpChange(arg_55_1)
end

function var_0_0._onChangeWaveEnd(arg_56_0)
	arg_56_0:_setPosOffset()
end

function var_0_0.onCoverPerformanceEntityData(arg_57_0, arg_57_1)
	if arg_57_1 ~= arg_57_0.entity.id then
		return
	end

	local var_57_0 = FightDataHelper.entityMgr:getById(arg_57_1)

	arg_57_0:setShield(var_57_0.shieldValue)
	arg_57_0:resetHp()
	arg_57_0.buffMgr:refreshBuffList()
	arg_57_0._power:_refreshUI()
end

function var_0_0._setPosOffset(arg_58_0)
	if arg_58_0.entity:getSide() == FightEnum.EntitySide.MySide then
		local var_58_0 = FightEnum.MySideDefaultStanceId
		local var_58_1 = arg_58_0.entity:getMO()
		local var_58_2 = FightModel.instance:getFightParam()
		local var_58_3 = var_58_2 and var_58_2.battleId
		local var_58_4 = var_58_3 and lua_battle.configDict[var_58_3]

		if var_58_4 and not string.nilorempty(var_58_4.myStance) then
			var_58_0 = tonumber(var_58_4.myStance)

			if not var_58_0 then
				local var_58_5 = string.splitToNumber(var_58_4.myStance, "#")

				if #var_58_5 > 0 then
					local var_58_6 = FightModel.instance:getCurWaveId() or 1

					var_58_0 = var_58_5[var_58_6 <= #var_58_5 and var_58_6 or #var_58_5]
				end
			end
		end

		local var_58_7 = lua_stance_hp_offset.configDict[var_58_0]

		if var_58_7 then
			local var_58_8 = var_58_7["offsetPos" .. var_58_1.position]

			if var_58_8 and #var_58_8 > 0 then
				recthelper.setAnchor(arg_58_0._floatContainerGO.transform, var_58_8[1], var_58_8[2])
				recthelper.setAnchor(arg_58_0._uiGO.transform, var_58_8[1], var_58_8[2])

				arg_58_0._originPosOffsetX = var_58_8[1]
				arg_58_0._originPosOffsetY = var_58_8[2]
			end
		end
	end
end

local var_0_1 = {
	NoExPoint_NoPower = 1,
	ExPoint_NoPower = 2,
	NoExPoint_Power = 3,
	ExPoint_Power = 4
}
local var_0_2 = {
	[var_0_1.NoExPoint_NoPower] = {
		imageCareer = 5,
		layout = 36
	},
	[var_0_1.ExPoint_NoPower] = {
		imageCareer = -5,
		layout = 52
	},
	[var_0_1.NoExPoint_Power] = {
		imageCareer = -5,
		layout = 40
	},
	[var_0_1.ExPoint_Power] = {
		imageCareer = -12,
		layout = 52
	}
}

function var_0_0.updateInnerLayout(arg_59_0)
	local var_59_0 = arg_59_0._power:_getPowerData()
	local var_59_1 = FightMsgMgr.sendMsg(FightMsgId.GetExPointView, arg_59_0.entity.id)
	local var_59_2

	if var_59_0 and var_59_1 then
		var_59_2 = var_0_1.ExPoint_Power
	elseif var_59_0 then
		var_59_2 = var_0_1.NoExPoint_Power
	elseif var_59_1 then
		var_59_2 = var_0_1.ExPoint_NoPower
	else
		var_59_2 = var_0_1.NoExPoint_NoPower
	end

	local var_59_3 = var_0_2[var_59_2]
	local var_59_4 = arg_59_0._imgCareerIcon:GetComponent(gohelper.Type_RectTransform)
	local var_59_5 = gohelper.findChildComponent(arg_59_0._uiGO, "layout", gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_59_4, var_59_3.imageCareer)
	recthelper.setAnchorY(var_59_5, var_59_3.layout)
end

function var_0_0._onUpdateUIFollower(arg_60_0, arg_60_1)
	if arg_60_0._entity and arg_60_1 == arg_60_0._entity.id then
		arg_60_0:_updateFollow()
	end
end

function var_0_0._onLockHpChange(arg_61_0)
	arg_61_0:resetHp()
end

function var_0_0.onAiJiAoFakeDecreaseHp(arg_62_0, arg_62_1)
	if arg_62_1 ~= arg_62_0.entity.id then
		return
	end

	arg_62_0:_tweenFillAmount()
end

function var_0_0.onDestroy(arg_63_0)
	return
end

return var_0_0
