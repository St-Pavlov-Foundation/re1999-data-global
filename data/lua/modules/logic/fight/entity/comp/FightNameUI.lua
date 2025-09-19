module("modules.logic.fight.entity.comp.FightNameUI", package.seeall)

local var_0_0 = class("FightNameUI", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._entity = arg_1_1
	arg_1_0._nameUIActive = true
	arg_1_0._nameUIVisible = true
	arg_1_0._opCtrl = FightNameUIOp.New(arg_1_0)
	arg_1_0.buffMgr = FightNameUIBuffMgr.New()
	arg_1_0._power = FightNameUIPower.New(arg_1_0, 1)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		arg_1_0._enemyOperation = FightNameUIEnemyOperation.New(arg_1_0)
		arg_1_0._enemyOperation.INVOKED_OPEN_VIEW = true
	end
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

function var_0_0.getOpCtrl(arg_15_0)
	return arg_15_0._opCtrl
end

function var_0_0._onLoaded(arg_16_0)
	gohelper.setAsLastSibling(arg_16_0._floatContainerGO)

	arg_16_0._uiGO = arg_16_0._uiLoader:getInstGO()
	arg_16_0._uiTransform = arg_16_0._uiGO.transform
	arg_16_0._uiCanvasGroup = gohelper.onceAddComponent(arg_16_0._uiGO, typeof(UnityEngine.CanvasGroup))
	arg_16_0._txtName = gohelper.findChildText(arg_16_0._uiGO, "layout/top/Text")

	arg_16_0:_doSetActive()

	arg_16_0._gohpbg = gohelper.findChild(arg_16_0._uiGO, "layout/top/hp/container/bg")
	arg_16_0._gochoushibg = gohelper.findChild(arg_16_0._uiGO, "layout/top/hp/container/choushibg")
	arg_16_0._imgHpMinus = gohelper.findChildImage(arg_16_0._uiGO, "layout/top/hp/container/minus")

	local var_16_0 = arg_16_0.entity:isMySide()
	local var_16_1 = gohelper.findChildImage(arg_16_0._uiGO, "layout/top/hp/container/my")
	local var_16_2 = gohelper.findChildImage(arg_16_0._uiGO, "layout/top/hp/container/enemy")

	gohelper.setActive(var_16_1.gameObject, var_16_0)
	gohelper.setActive(var_16_2.gameObject, not var_16_0)

	arg_16_0._hp_ani = gohelper.findChild(arg_16_0._uiGO, "layout/top/hp"):GetComponent(typeof(UnityEngine.Animator))
	arg_16_0._hp_container_tran = gohelper.findChild(arg_16_0._uiGO, "layout/top/hp/container").transform
	arg_16_0._imgHp = var_16_0 and var_16_1 or var_16_2
	arg_16_0._imgHpShield = gohelper.findChildImage(arg_16_0._uiGO, "layout/top/hp/container/shield")
	arg_16_0._txtHp = gohelper.findChildText(arg_16_0._uiGO, "layout/top/hp/Text")
	arg_16_0._reduceHp = gohelper.findChild(arg_16_0._uiGO, "layout/top/hp/container/reduce")
	arg_16_0._reduceHpImage = arg_16_0._reduceHp:GetComponent(gohelper.Type_Image)

	arg_16_0:resetHp()

	arg_16_0._imgCareerIcon = gohelper.findChildImage(arg_16_0._uiGO, "layout/top/imgCareerIcon")
	arg_16_0.careerTopRectTr = gohelper.findChildComponent(arg_16_0._uiGO, "layout/top/imgCareerIcon/careertoppos", gohelper.Type_RectTransform)

	arg_16_0:initExPointMgr()
	arg_16_0:initStressMgr()
	arg_16_0:initPowerMgr()

	arg_16_0._opContainerGO = gohelper.findChild(arg_16_0._uiGO, "layout/top/op")
	arg_16_0._opContainerCanvasGroup = gohelper.onceAddComponent(arg_16_0._opContainerGO, typeof(UnityEngine.CanvasGroup))
	arg_16_0._opContainerTr = arg_16_0._opContainerGO.transform
	arg_16_0._opItemGO = gohelper.findChild(arg_16_0._uiGO, "layout/top/op/item")

	arg_16_0._opCtrl:init(arg_16_0.entity, arg_16_0._opContainerGO, arg_16_0._opItemGO)

	if arg_16_0._enemyOperation then
		arg_16_0._enemyOperation:init(arg_16_0.entity, arg_16_0._opContainerGO, arg_16_0._opItemGO)
	end

	arg_16_0._buffContainerGO = gohelper.findChild(arg_16_0._uiGO, "layout/top/buffContainer")
	arg_16_0._buffGO = gohelper.findChild(arg_16_0._uiGO, "layout/top/buffContainer/buff")

	arg_16_0.buffMgr:init(arg_16_0.entity, arg_16_0._buffGO, arg_16_0._opContainerTr)
	gohelper.setActive(gohelper.findChild(arg_16_0._uiGO, "#go_Shield"), false)

	if FightModel.instance:isSeason2() and arg_16_0.entity:getMO().guard ~= -1 then
		arg_16_0._seasonGuard = FightNameUISeasonGuard.New(arg_16_0)

		arg_16_0._seasonGuard:init(gohelper.findChild(arg_16_0._uiGO, "#go_Shield"))
	end

	arg_16_0._ani = arg_16_0._uiGO:GetComponent(typeof(UnityEngine.Animator))
	arg_16_0._goBossFocusIcon = gohelper.findChild(arg_16_0._uiGO, "go_bossfocusicon")

	gohelper.setActive(arg_16_0._goBossFocusIcon, false)
	arg_16_0:updateUI()
	arg_16_0:_insteadSpecialHp()
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_16_0._updateFollow, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_16_0._beforePlaySkill, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_16_0._onMySideRoundEnd, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_16_0._updateUIPos, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_16_0._onStartSequenceFinish, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_16_0.updateUI, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_16_0._onRoundSequenceFinish, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_16_0.updateActive, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.SetIsShowFloat, arg_16_0._setIsShowFloat, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.SetIsShowNameUI, arg_16_0._setIsShowNameUI, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, arg_16_0._onFloatEquipEffect, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnCameraFovChange, arg_16_0._updateUIPos, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnMaxHpChange, arg_16_0._onMaxHpChange, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnCurrentHpChange, arg_16_0._onCurrentHpChange, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.MultiHpChange, arg_16_0._onMultiHpChange, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.ChangeWaveEnd, arg_16_0._onChangeWaveEnd, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.CoverPerformanceEntityData, arg_16_0.onCoverPerformanceEntityData, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.ChangeCareer, arg_16_0._onChangeCareer, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.UpdateUIFollower, arg_16_0._onUpdateUIFollower, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.ChangeShield, arg_16_0._onChangeShield, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_16_0._onStageChange, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_16_0._onSkillPlayFinish, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.OnLockHpChange, arg_16_0._onLockHpChange, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.AiJiAoFakeDecreaseHp, arg_16_0.onAiJiAoFakeDecreaseHp, arg_16_0)
	arg_16_0._power:onOpen()
	arg_16_0:_setPosOffset()
	arg_16_0:updateInnerLayout()
end

function var_0_0._onStageChange(arg_17_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal then
		local var_17_0 = FightDataHelper.roundMgr:getRoundData()
		local var_17_1 = var_17_0 and var_17_0:getAIUseCardMOList()

		arg_17_0:refreshBossFocusIcon(var_17_1)
	end
end

function var_0_0.refreshBossFocusIcon(arg_18_0, arg_18_1)
	if not arg_18_1 then
		gohelper.setActive(arg_18_0._goBossFocusIcon, false)

		return
	end

	local var_18_0 = arg_18_0.entity and arg_18_0.entity:getMO()
	local var_18_1 = false

	if var_18_0 and var_18_0.side == FightEnum.EntitySide.MySide then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			if arg_18_0:_checkCanMark(iter_18_1) then
				var_18_1 = true

				break
			end
		end
	end

	gohelper.setActive(arg_18_0._goBossFocusIcon, var_18_1)
end

function var_0_0._onSkillPlayFinish(arg_19_0)
	local var_19_0 = FightDataHelper.roundMgr:getPreRoundData()
	local var_19_1 = var_19_0 and var_19_0:getAIUseCardMOList()

	arg_19_0:refreshBossFocusIcon(var_19_1)
end

function var_0_0._checkCanMark(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return false
	end

	if arg_20_1.targetUid ~= arg_20_0.entity.id then
		return false
	end

	local var_20_0 = FightDataHelper.entityMgr:getById(arg_20_1.uid)

	if not var_20_0 or var_20_0:isStatusDead() then
		return false
	end

	if not lua_ai_mark_skill.configDict[arg_20_1.skillId] then
		return false
	end

	return true
end

function var_0_0.initExPointMgr(arg_21_0)
	arg_21_0._expointCtrl = FightExPointView.New(arg_21_0.entity.id, arg_21_0._uiGO)
end

function var_0_0.initPowerMgr(arg_22_0)
	arg_22_0.powerView = FightNamePowerInfoView.New(arg_22_0.entity.id, arg_22_0._uiGO)
end

function var_0_0.initStressMgr(arg_23_0)
	if not arg_23_0.entity:getMO():hasStress() then
		return
	end

	arg_23_0.stressMgr = FightNameUIStressMgr.New(arg_23_0)
	arg_23_0.stressGo = gohelper.findChild(arg_23_0._uiGO, "#go_fightstressitem")

	arg_23_0.stressMgr:initMgr(arg_23_0.stressGo, arg_23_0.entity)
end

function var_0_0.beforeDestroy(arg_24_0)
	arg_24_0._power:releaseSelf()

	if arg_24_0._seasonGuard then
		arg_24_0._seasonGuard:releaseSelf()
	end

	if arg_24_0._expointCtrl then
		arg_24_0._expointCtrl:disposeSelf()
	end

	if arg_24_0.powerView then
		arg_24_0.powerView:disposeSelf()
	end

	if arg_24_0.stressMgr then
		arg_24_0.stressMgr:beforeDestroy()
	end

	if arg_24_0._enemyOperation then
		arg_24_0._enemyOperation:disposeSelf()
	end

	if arg_24_0.healthComp then
		arg_24_0.healthComp:beforeDestroy()

		arg_24_0.healthComp = nil
	end

	arg_24_0._opCtrl:beforeDestroy()
	arg_24_0.buffMgr:beforeDestroy()
	CameraMgr.instance:getCameraTrace():RemoveChangeActor(arg_24_0._uiFollower)
	FightFloatMgr.instance:nameUIBeforeDestroy(arg_24_0._floatContainerGO)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_24_0._updateFollow, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_24_0._beforePlaySkill, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_24_0._onMySideRoundEnd, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_24_0._updateUIPos, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_24_0._onStartSequenceFinish, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_24_0.updateUI, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_24_0._onRoundSequenceFinish, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_24_0.updateActive, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.SetIsShowFloat, arg_24_0._setIsShowFloat, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.SetIsShowNameUI, arg_24_0._setIsShowNameUI, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, arg_24_0._onFloatEquipEffect, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnCameraFovChange, arg_24_0._updateUIPos, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnMaxHpChange, arg_24_0._onMaxHpChange, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnCurrentHpChange, arg_24_0._onCurrentHpChange, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.MultiHpChange, arg_24_0._onMultiHpChange, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.ChangeWaveEnd, arg_24_0._onChangeWaveEnd, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.ChangeCareer, arg_24_0._onChangeCareer, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.UpdateUIFollower, arg_24_0._onUpdateUIFollower, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.ChangeShield, arg_24_0._onChangeShield, arg_24_0)
	arg_24_0:removeEventCb(FightController.instance, FightEvent.OnLockHpChange, arg_24_0._onLockHpChange, arg_24_0)
	arg_24_0:_killHpTween()
	TaskDispatcher.cancelTask(arg_24_0._onDelAniOver, arg_24_0)
	FightNameMgr.instance:unregister(arg_24_0)
	gohelper.destroy(arg_24_0._containerGO)
	arg_24_0._uiLoader:dispose()

	arg_24_0._uiLoader = nil
	arg_24_0._containerGO = nil
end

function var_0_0.updateUI(arg_25_0)
	local var_25_0 = arg_25_0.entity:getMO()

	arg_25_0._txtName.text = var_25_0:getEntityName()

	arg_25_0:_refreshCareer()
	arg_25_0:_updateFollow()
	arg_25_0:updateActive()
end

function var_0_0._refreshCareer(arg_26_0)
	local var_26_0 = arg_26_0.entity:getMO()
	local var_26_1 = FightModel.instance:getVersion()

	if SkillEditorMgr.instance.inEditMode then
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imgCareerIcon, "sx_icon_" .. tostring(var_26_0:getCO().career), true)
	elseif var_26_1 >= 2 and var_26_0.career ~= 0 then
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imgCareerIcon, "sx_icon_" .. tostring(var_26_0.career), true)
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imgCareerIcon, "sx_icon_" .. tostring(var_26_0:getCO().career), true)
	end
end

function var_0_0._onChangeCareer(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0.entity.id then
		arg_27_0:_refreshCareer()
	end
end

function var_0_0._beforePlaySkill(arg_28_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		return
	end

	arg_28_0._opCtrl:hideOpContainer()
end

function var_0_0._onMySideRoundEnd(arg_29_0)
	arg_29_0._opCtrl:showOpContainer()
end

function var_0_0._onStartSequenceFinish(arg_30_0)
	arg_30_0:updateUI()
	arg_30_0._opCtrl:showOpContainer()
end

function var_0_0._onRoundSequenceFinish(arg_31_0)
	arg_31_0:updateUI()
	arg_31_0._opCtrl:showOpContainer()
end

function var_0_0._updateFollow(arg_32_0, arg_32_1)
	if arg_32_1 and arg_32_1.unitSpawn ~= arg_32_0.entity then
		return
	end

	local var_32_0 = arg_32_0.entity.spine and arg_32_0.entity.spine:getSpineGO()

	if not var_32_0 then
		recthelper.setAnchorX(arg_32_0._containerGO.transform, 20000)

		return
	end

	local var_32_1 = CameraMgr.instance:getUnitCamera()
	local var_32_2 = CameraMgr.instance:getUICamera()
	local var_32_3 = arg_32_0.entity.go.transform
	local var_32_4 = ViewMgr.instance:getUIRoot().transform
	local var_32_5 = FightConfig.instance:getSkinCO(arg_32_0.entity:getMO().skin)
	local var_32_6 = var_32_5 and var_32_5.topuiOffset or {
		0,
		0,
		0,
		0
	}
	local var_32_7 = var_32_6 and var_32_6[1] or 0
	local var_32_8 = var_32_6 and var_32_6[2] or 0
	local var_32_9 = var_32_6 and var_32_6[3] or 0
	local var_32_10 = var_32_6 and var_32_6[4] or 0
	local var_32_11 = arg_32_0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle, true)
	local var_32_12, var_32_13 = FightHelper.getEntityBoxSizeOffsetV2(arg_32_0.entity)
	local var_32_14 = var_32_12.y
	local var_32_15, var_32_16, var_32_17 = transformhelper.getPos(var_32_11.transform)
	local var_32_18, var_32_19, var_32_20 = transformhelper.getPos(arg_32_0.entity.go.transform)

	arg_32_0._uiFollower = gohelper.onceAddComponent(arg_32_0._containerGO, typeof(ZProj.UIFollower))

	arg_32_0._uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())

	local var_32_21 = gohelper.findChild(var_32_0, ModuleEnum.SpineHangPointRoot)
	local var_32_22 = var_32_21 and gohelper.findChild(var_32_21, ModuleEnum.SpineHangPoint.mounthproot)

	if var_32_22 then
		local var_32_23, var_32_24 = transformhelper.getLocalScale(arg_32_0.entity.go.transform)
		local var_32_25 = 0.5

		arg_32_0._uiFollower:Set(var_32_1, var_32_2, var_32_4, var_32_22.transform, var_32_9, (var_32_10 + var_32_25) * var_32_24, 0, var_32_7, var_32_8)
	elseif isTypeOf(arg_32_0.entity, FightEntityAssembledMonsterMain) or isTypeOf(arg_32_0.entity, FightEntityAssembledMonsterSub) then
		local var_32_26 = arg_32_0.entity:getMO()
		local var_32_27 = lua_fight_assembled_monster.configDict[var_32_26.skin]

		arg_32_0._uiFollower:Set(var_32_1, var_32_2, var_32_4, var_32_11.transform, var_32_27.hpPos[1] or 0, var_32_27.hpPos[2] or 0, 0, 0, 0)
	else
		local var_32_28, var_32_29 = transformhelper.getLocalScale(arg_32_0.entity.go.transform)

		arg_32_0._uiFollower:Set(var_32_1, var_32_2, var_32_4, var_32_11.transform, 0 + var_32_9, var_32_14 + var_32_19 - var_32_16 + var_32_10 * var_32_29, 0, var_32_7, var_32_8 + 15)
	end

	arg_32_0._uiFollower:SetEnable(true)
	CameraMgr.instance:getCameraTrace():AddChangeActor(arg_32_0._uiFollower)
end

function var_0_0._updateUIPos(arg_33_0)
	if arg_33_0._uiFollower then
		arg_33_0._uiFollower:ForceUpdate()
	end
end

function var_0_0.changeHpWithChoushiBuff(arg_34_0, arg_34_1)
	if not arg_34_0.entity:isMySide() then
		gohelper.setActive(arg_34_0._gohpbg, not arg_34_1)
		gohelper.setActive(arg_34_0._gohpbg, arg_34_1)

		if arg_34_1 then
			UISpriteSetMgr.instance:setFightSprite(arg_34_0._imgHp, "bg_xt_choushi")
		else
			UISpriteSetMgr.instance:setFightSprite(arg_34_0._imgHp, "bg_xt2")
		end
	end
end

function var_0_0.getFollower(arg_35_0)
	return arg_35_0._uiFollower
end

function var_0_0.updateActive(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	if arg_36_1 and arg_36_1 ~= arg_36_0.entity.id then
		return
	end

	if arg_36_3 then
		local var_36_0 = lua_skill_buff.configDict[arg_36_3]

		if var_36_0 and var_36_0.typeId == 3120005 then
			arg_36_0:_insteadSpecialHp(arg_36_2)
		end

		if FightConfig.instance:hasBuffFeature(arg_36_3, FightEnum.BuffType_HideLife) then
			arg_36_0:_doSetActive()
		end
	else
		arg_36_0:_doSetActive()
	end
end

function var_0_0._insteadSpecialHp(arg_37_0, arg_37_1)
	if arg_37_1 then
		if arg_37_1 == FightEnum.EffectType.BUFFADD then
			arg_37_0:changeHpWithChoushiBuff(true)
		elseif arg_37_1 == FightEnum.EffectType.BUFFDEL or arg_37_1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			arg_37_0:changeHpWithChoushiBuff(false)
		end
	else
		local var_37_0 = arg_37_0.entity:getMO():getBuffDic()

		for iter_37_0, iter_37_1 in pairs(var_37_0) do
			local var_37_1 = lua_skill_buff.configDict[iter_37_1.buffId]

			if var_37_1 and var_37_1.typeId == 3120005 then
				arg_37_0:changeHpWithChoushiBuff(true)

				return
			end
		end
	end
end

function var_0_0.getFloatItemStartY(arg_38_0)
	return (arg_38_0.buffMgr:getBuffLineCount() or 0) * 34.5 + (#arg_38_0._opCtrl:getOpItemList() > 0 and 42 or 0)
end

function var_0_0.showPoisoningEffect(arg_39_0, arg_39_1)
	arg_39_0.buffMgr:showPoisoningEffect(arg_39_1)
end

function var_0_0._setIsShowFloat(arg_40_0, arg_40_1)
	if not arg_40_0._canvasGroup then
		arg_40_0._canvasGroup = gohelper.onceAddComponent(arg_40_0._floatContainerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_40_0._canvasGroup, arg_40_1)
end

function var_0_0.addHp(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.entity:getMO().attrMO.hp

	arg_41_0._curHp = arg_41_0._curHp + arg_41_1
	arg_41_0._curHp = arg_41_0._curHp >= 0 and arg_41_0._curHp or 0
	arg_41_0._curHp = var_41_0 >= arg_41_0._curHp and arg_41_0._curHp or var_41_0
	arg_41_0._txtHp.text = arg_41_0._curHp

	arg_41_0:_tweenFillAmount()
end

function var_0_0.getHp(arg_42_0)
	return arg_42_0._curHp
end

function var_0_0.setShield(arg_43_0, arg_43_1)
	arg_43_0._curShield = arg_43_1 > 0 and arg_43_1 or 0

	arg_43_0:_tweenFillAmount()
end

function var_0_0._tweenFillAmount(arg_44_0, arg_44_1, arg_44_2)
	arg_44_1 = arg_44_1 or arg_44_0._curHp
	arg_44_2 = arg_44_2 or arg_44_0._curShield

	local var_44_0, var_44_1 = arg_44_0:_getFillAmount(arg_44_1, arg_44_2)
	local var_44_2 = var_44_0

	if FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_44_0.entity.id] then
		arg_44_1, arg_44_2 = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(arg_44_0.entity.id, arg_44_1, arg_44_2)
		var_44_0, var_44_1 = arg_44_0:_getFillAmount(arg_44_1, arg_44_2)
	end

	arg_44_0._imgHp.fillAmount = var_44_0

	ZProj.TweenHelper.KillByObj(arg_44_0._imgHpMinus)
	ZProj.TweenHelper.DOFillAmount(arg_44_0._imgHpMinus, var_44_2, 0.5)
	ZProj.TweenHelper.KillByObj(arg_44_0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(arg_44_0._imgHpShield, var_44_1, 0.5)
	gohelper.setActive(arg_44_0._imgHpMinus.gameObject, arg_44_2 <= 0)
	arg_44_0:refreshReduceHp()
end

function var_0_0.resetHp(arg_45_0)
	arg_45_0._curHp = arg_45_0.entity:getMO().currentHp
	arg_45_0._curHp = arg_45_0._curHp > 0 and arg_45_0._curHp or 0
	arg_45_0._curShield = arg_45_0.entity:getMO().shieldValue

	local var_45_0, var_45_1 = arg_45_0:_getFillAmount()

	arg_45_0._imgHpMinus.fillAmount = var_45_0
	arg_45_0._imgHp.fillAmount = var_45_0
	arg_45_0._imgHpShield.fillAmount = var_45_1
	arg_45_0._txtHp.text = arg_45_0._curHp

	gohelper.setActive(arg_45_0._imgHpMinus.gameObject, arg_45_0._curShield <= 0)
	arg_45_0:refreshReduceHp()
end

function var_0_0.refreshReduceHp(arg_46_0)
	local var_46_0 = arg_46_0.entity:getMO()
	local var_46_1 = var_46_0 and var_46_0:getLockMaxHpRate() or 1
	local var_46_2 = var_46_1 < 1

	gohelper.setActive(arg_46_0._reduceHp, var_46_2)

	if var_46_2 then
		arg_46_0._reduceHpImage.fillAmount = Mathf.Clamp01(1 - var_46_1)
	end
end

function var_0_0._getFillAmount(arg_47_0, arg_47_1, arg_47_2)
	arg_47_1 = arg_47_1 or arg_47_0._curHp
	arg_47_2 = arg_47_2 or arg_47_0._curShield

	return var_0_0.getHpFillAmount(arg_47_1, arg_47_2, arg_47_0.entity.id)
end

function var_0_0.getHpFillAmount(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = FightDataHelper.entityMgr:getById(arg_48_2)

	if not var_48_0 then
		return 0, 0
	end

	local var_48_1, var_48_2 = var_48_0:getHpAndShieldFillAmount(arg_48_0, arg_48_1)
	local var_48_3 = var_48_0.attrMO and var_48_0.attrMO.original_max_hp or 1
	local var_48_4 = var_48_0.attrMO and var_48_0.attrMO.hp > 0 and var_48_0.attrMO.hp or 1

	if var_48_4 < var_48_3 then
		local var_48_5 = var_48_3 - var_48_4

		var_48_1 = var_48_1 * var_48_4 / var_48_3 + var_48_5 / var_48_3
		var_48_2 = var_48_2 * var_48_4 / var_48_3 + var_48_5 / var_48_3
	end

	return var_48_1, var_48_2
end

function var_0_0._onFloatEquipEffect(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 ~= arg_49_0.entity.id then
		return
	end

	if not arg_49_0._float_equip_time then
		arg_49_0._float_equip_time = Time.time
	elseif Time.time - arg_49_0._float_equip_time < 1 then
		return
	end

	arg_49_0._float_equip_time = Time.time

	FightFloatMgr.instance:float(arg_49_1, FightEnum.FloatType.equipeffect, "", arg_49_2, false)
end

function var_0_0.setFloatRootVisble(arg_50_0, arg_50_1)
	gohelper.setActive(arg_50_0._floatContainerGO, arg_50_1)
end

function var_0_0._onMaxHpChange(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_1 ~= arg_51_0.entity.id then
		return
	end

	arg_51_0:_killHpTween()

	if not arg_51_0._hp_tweens then
		arg_51_0._hp_tweens = {}
	end

	if arg_51_2 < arg_51_3 then
		arg_51_0._hp_ani:Play("up", 0, 0)

		local var_51_0 = ZProj.TweenHelper.DOAnchorPosX(arg_51_0._hp_container_tran, 0, 0.3, arg_51_0._hpTweenDone, arg_51_0)

		table.insert(arg_51_0._hp_tweens, var_51_0)
	else
		local var_51_1 = arg_51_0.entity:getMO()

		if (var_51_1.attrMO and var_51_1.attrMO.hp > 0 and var_51_1.attrMO.hp or 1) < (var_51_1.attrMO and var_51_1.attrMO.original_max_hp or 1) then
			arg_51_0._hp_ani:Play("down", 0, 0)
			arg_51_0:resetHp()
		end
	end
end

function var_0_0._hpTweenDone(arg_52_0)
	arg_52_0:resetHp()
end

function var_0_0._killHpTween(arg_53_0)
	if arg_53_0._hp_tweens then
		for iter_53_0, iter_53_1 in ipairs(arg_53_0._hp_tweens) do
			ZProj.TweenHelper.KillById(iter_53_1)
		end

		arg_53_0._hp_tweens = {}
	end
end

function var_0_0._onChangeShield(arg_54_0, arg_54_1)
	if arg_54_1 ~= arg_54_0.entity.id then
		return
	end

	arg_54_0._curShield = FightDataHelper.entityMgr:getById(arg_54_1).shieldValue

	arg_54_0:_tweenFillAmount()
end

function var_0_0._onCurrentHpChange(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if arg_55_1 ~= arg_55_0.entity.id then
		return
	end

	arg_55_0:resetHp()
end

function var_0_0._onMultiHpChange(arg_56_0, arg_56_1)
	arg_56_0:_onCurrentHpChange(arg_56_1)
end

function var_0_0._onChangeWaveEnd(arg_57_0)
	arg_57_0:_setPosOffset()
end

function var_0_0.onCoverPerformanceEntityData(arg_58_0, arg_58_1)
	if arg_58_1 ~= arg_58_0.entity.id then
		return
	end

	local var_58_0 = FightDataHelper.entityMgr:getById(arg_58_1)

	arg_58_0:setShield(var_58_0.shieldValue)
	arg_58_0:resetHp()
	arg_58_0.buffMgr:refreshBuffList()
	arg_58_0._power:_refreshUI()
end

function var_0_0._setPosOffset(arg_59_0)
	if arg_59_0.entity:getSide() == FightEnum.EntitySide.MySide then
		local var_59_0 = FightEnum.MySideDefaultStanceId
		local var_59_1 = arg_59_0.entity:getMO()
		local var_59_2 = FightModel.instance:getFightParam()
		local var_59_3 = var_59_2 and var_59_2.battleId
		local var_59_4 = var_59_3 and lua_battle.configDict[var_59_3]

		if var_59_4 and not string.nilorempty(var_59_4.myStance) then
			var_59_0 = tonumber(var_59_4.myStance)

			if not var_59_0 then
				local var_59_5 = string.splitToNumber(var_59_4.myStance, "#")

				if #var_59_5 > 0 then
					local var_59_6 = FightModel.instance:getCurWaveId() or 1

					var_59_0 = var_59_5[var_59_6 <= #var_59_5 and var_59_6 or #var_59_5]
				end
			end
		end

		local var_59_7 = lua_stance_hp_offset.configDict[var_59_0]

		if var_59_7 then
			local var_59_8 = var_59_7["offsetPos" .. var_59_1.position]

			if var_59_8 and #var_59_8 > 0 then
				recthelper.setAnchor(arg_59_0._floatContainerGO.transform, var_59_8[1], var_59_8[2])
				recthelper.setAnchor(arg_59_0._uiGO.transform, var_59_8[1], var_59_8[2])

				arg_59_0._originPosOffsetX = var_59_8[1]
				arg_59_0._originPosOffsetY = var_59_8[2]
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

function var_0_0.updateInnerLayout(arg_60_0)
	local var_60_0 = arg_60_0._power:_getPowerData()
	local var_60_1 = FightMsgMgr.sendMsg(FightMsgId.GetExPointView, arg_60_0.entity.id)
	local var_60_2

	if var_60_0 and var_60_1 then
		var_60_2 = var_0_1.ExPoint_Power
	elseif var_60_0 then
		var_60_2 = var_0_1.NoExPoint_Power
	elseif var_60_1 then
		var_60_2 = var_0_1.ExPoint_NoPower
	else
		var_60_2 = var_0_1.NoExPoint_NoPower
	end

	local var_60_3 = var_0_2[var_60_2]
	local var_60_4 = arg_60_0._imgCareerIcon:GetComponent(gohelper.Type_RectTransform)
	local var_60_5 = gohelper.findChildComponent(arg_60_0._uiGO, "layout", gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_60_4, var_60_3.imageCareer)
	recthelper.setAnchorY(var_60_5, var_60_3.layout)
end

function var_0_0._onUpdateUIFollower(arg_61_0, arg_61_1)
	if arg_61_0._entity and arg_61_1 == arg_61_0._entity.id then
		arg_61_0:_updateFollow()
	end
end

function var_0_0._onLockHpChange(arg_62_0)
	arg_62_0:resetHp()
end

function var_0_0.onAiJiAoFakeDecreaseHp(arg_63_0, arg_63_1)
	if arg_63_1 ~= arg_63_0.entity.id then
		return
	end

	arg_63_0:_tweenFillAmount()
end

function var_0_0.onDestroy(arg_64_0)
	return
end

return var_0_0
