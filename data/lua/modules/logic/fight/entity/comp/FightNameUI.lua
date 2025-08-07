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
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	if arg_3_1 and arg_3_0._curHp and arg_3_0._curHp <= 0 then
		return
	end

	arg_3_0._nameUIActive = arg_3_1

	arg_3_0:_doSetActive()
end

function var_0_0.playDeadEffect(arg_4_0)
	arg_4_0:_playAni("die")
end

function var_0_0.playOpenEffect(arg_5_0)
	arg_5_0:_playAni(UIAnimationName.Open)
end

function var_0_0.playCloseEffect(arg_6_0)
	arg_6_0:_playAni("close")
end

function var_0_0._playAni(arg_7_0, arg_7_1)
	if arg_7_0._ani then
		arg_7_0._ani:Play(arg_7_1, 0, 0)

		local var_7_0 = FightModel.instance:getSpeed()

		arg_7_0._ani.speed = var_7_0
	end
end

function var_0_0._setIsShowNameUI(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = false

	if not arg_8_2 then
		var_8_0 = true
	else
		for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
			if iter_8_1.id == arg_8_0.entity.id then
				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		arg_8_0._nameUIVisible = arg_8_1

		arg_8_0:_doSetActive()
	end
end

function var_0_0._doSetActive(arg_9_0)
	local var_9_0 = arg_9_0:getUIGO()

	if gohelper.isNil(var_9_0) then
		return
	end

	local var_9_1 = arg_9_0._nameUIActive and arg_9_0._nameUIVisible

	if arg_9_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_HideLife) then
		var_9_1 = false
	end

	if FightDataHelper.tempMgr.hideNameUIByTimeline then
		var_9_1 = false
	end

	if not gohelper.isNil(arg_9_0._uiCanvasGroup) then
		if var_9_1 then
			recthelper.setAnchor(arg_9_0:getUIGO().transform, arg_9_0._originPosOffsetX or 0, arg_9_0._originPosOffsetY or 0)
		else
			recthelper.setAnchor(arg_9_0:getUIGO().transform, 20000, 20000)
		end
	end

	if var_9_1 and arg_9_0._uiFollower then
		arg_9_0._uiFollower:ForceUpdate()
	end
end

function var_0_0.getAnchorXY(arg_10_0)
	if arg_10_0._uiTransform then
		local var_10_0, var_10_1 = recthelper.getAnchor(arg_10_0._uiTransform, 0, 0)

		return recthelper.getAnchor(arg_10_0._uiTransform, 0, 0)
	end

	return 0, 0
end

function var_0_0.getFloatContainerGO(arg_11_0)
	return arg_11_0._floatContainerGO
end

function var_0_0.getGO(arg_12_0)
	return arg_12_0._containerGO
end

function var_0_0.getUIGO(arg_13_0)
	return arg_13_0._uiGO
end

function var_0_0.getOpCtrl(arg_14_0)
	return arg_14_0._opCtrl
end

function var_0_0._onLoaded(arg_15_0)
	gohelper.setAsLastSibling(arg_15_0._floatContainerGO)

	arg_15_0._uiGO = arg_15_0._uiLoader:getInstGO()
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

	arg_15_0._hp_ani = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp"):GetComponent(typeof(UnityEngine.Animator))
	arg_15_0._hp_container_tran = gohelper.findChild(arg_15_0._uiGO, "layout/top/hp/container").transform
	arg_15_0._imgHp = var_15_0 and var_15_1 or var_15_2
	arg_15_0._imgHpShield = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/hp/container/shield")
	arg_15_0._txtHp = gohelper.findChildText(arg_15_0._uiGO, "layout/top/hp/Text")

	arg_15_0:resetHp()

	arg_15_0._imgCareerIcon = gohelper.findChildImage(arg_15_0._uiGO, "layout/top/imgCareerIcon")
	arg_15_0.careerTopRectTr = gohelper.findChildComponent(arg_15_0._uiGO, "layout/top/imgCareerIcon/careertoppos", gohelper.Type_RectTransform)

	arg_15_0:initExPointMgr()
	arg_15_0:initStressMgr()
	arg_15_0:initPowerMgr()

	arg_15_0._opContainerGO = gohelper.findChild(arg_15_0._uiGO, "layout/top/op")
	arg_15_0._opContainerCanvasGroup = gohelper.onceAddComponent(arg_15_0._opContainerGO, typeof(UnityEngine.CanvasGroup))
	arg_15_0._opContainerTr = arg_15_0._opContainerGO.transform
	arg_15_0._opItemGO = gohelper.findChild(arg_15_0._uiGO, "layout/top/op/item")

	arg_15_0._opCtrl:init(arg_15_0.entity, arg_15_0._opContainerGO, arg_15_0._opItemGO)

	if arg_15_0._enemyOperation then
		arg_15_0._enemyOperation:init(arg_15_0.entity, arg_15_0._opContainerGO, arg_15_0._opItemGO)
	end

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
	arg_15_0:addEventCb(FightController.instance, FightEvent.AiJiAoFakeDecreaseHp, arg_15_0.onAiJiAoFakeDecreaseHp, arg_15_0)
	arg_15_0._power:onOpen()
	arg_15_0:_setPosOffset()
	arg_15_0:updateInnerLayout()
end

function var_0_0._onStageChange(arg_16_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal then
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

	arg_23_0._opCtrl:beforeDestroy()
	arg_23_0.buffMgr:beforeDestroy()
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
	if FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		return
	end

	arg_27_0._opCtrl:hideOpContainer()
end

function var_0_0._onMySideRoundEnd(arg_28_0)
	arg_28_0._opCtrl:showOpContainer()
end

function var_0_0._onStartSequenceFinish(arg_29_0)
	arg_29_0:updateUI()
	arg_29_0._opCtrl:showOpContainer()
end

function var_0_0._onRoundSequenceFinish(arg_30_0)
	arg_30_0:updateUI()
	arg_30_0._opCtrl:showOpContainer()
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
	return (arg_37_0.buffMgr:getBuffLineCount() or 0) * 34.5 + (#arg_37_0._opCtrl:getOpItemList() > 0 and 42 or 0)
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
end

function var_0_0.resetHp(arg_44_0)
	arg_44_0._curHp = arg_44_0.entity:getMO().currentHp
	arg_44_0._curHp = arg_44_0._curHp > 0 and arg_44_0._curHp or 0
	arg_44_0._curShield = arg_44_0.entity:getMO().shieldValue

	arg_44_0:_tweenFillAmount()
end

function var_0_0._getFillAmount(arg_45_0, arg_45_1, arg_45_2)
	arg_45_1 = arg_45_1 or arg_45_0._curHp
	arg_45_2 = arg_45_2 or arg_45_0._curShield

	return var_0_0.getHpFillAmount(arg_45_1, arg_45_2, arg_45_0.entity.id)
end

function var_0_0.getHpFillAmount(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = FightDataHelper.entityMgr:getById(arg_46_2)

	if not var_46_0 then
		return 0, 0
	end

	local var_46_1 = var_46_0.attrMO and var_46_0.attrMO.hp > 0 and var_46_0.attrMO.hp or 1
	local var_46_2 = var_46_1 > 0 and arg_46_0 / var_46_1 or 0
	local var_46_3 = 0

	if var_46_1 >= arg_46_1 + arg_46_0 then
		var_46_2 = arg_46_0 / var_46_1
		var_46_3 = (arg_46_1 + arg_46_0) / var_46_1
	else
		var_46_2 = arg_46_0 / (arg_46_0 + arg_46_1)
		var_46_3 = 1
	end

	local var_46_4 = var_46_0.attrMO and var_46_0.attrMO.original_max_hp or 1

	if var_46_1 < var_46_4 then
		local var_46_5 = var_46_4 - var_46_1

		var_46_2 = var_46_2 * var_46_1 / var_46_4 + var_46_5 / var_46_4
		var_46_3 = var_46_3 * var_46_1 / var_46_4 + var_46_5 / var_46_4
	end

	return var_46_2, var_46_3
end

function var_0_0._onFloatEquipEffect(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 ~= arg_47_0.entity.id then
		return
	end

	if not arg_47_0._float_equip_time then
		arg_47_0._float_equip_time = Time.time
	elseif Time.time - arg_47_0._float_equip_time < 1 then
		return
	end

	arg_47_0._float_equip_time = Time.time

	FightFloatMgr.instance:float(arg_47_1, FightEnum.FloatType.equipeffect, "", arg_47_2, false)
end

function var_0_0.setFloatRootVisble(arg_48_0, arg_48_1)
	gohelper.setActive(arg_48_0._floatContainerGO, arg_48_1)
end

function var_0_0._onMaxHpChange(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if arg_49_1 ~= arg_49_0.entity.id then
		return
	end

	arg_49_0:_killHpTween()

	if not arg_49_0._hp_tweens then
		arg_49_0._hp_tweens = {}
	end

	if arg_49_2 < arg_49_3 then
		arg_49_0._hp_ani:Play("up", 0, 0)

		local var_49_0 = ZProj.TweenHelper.DOAnchorPosX(arg_49_0._hp_container_tran, 0, 0.3, arg_49_0._hpTweenDone, arg_49_0)

		table.insert(arg_49_0._hp_tweens, var_49_0)
	else
		local var_49_1 = arg_49_0.entity:getMO()

		if (var_49_1.attrMO and var_49_1.attrMO.hp > 0 and var_49_1.attrMO.hp or 1) < (var_49_1.attrMO and var_49_1.attrMO.original_max_hp or 1) then
			arg_49_0._hp_ani:Play("down", 0, 0)
			arg_49_0:resetHp()
		end
	end
end

function var_0_0._hpTweenDone(arg_50_0)
	arg_50_0:resetHp()
end

function var_0_0._killHpTween(arg_51_0)
	if arg_51_0._hp_tweens then
		for iter_51_0, iter_51_1 in ipairs(arg_51_0._hp_tweens) do
			ZProj.TweenHelper.KillById(iter_51_1)
		end

		arg_51_0._hp_tweens = {}
	end
end

function var_0_0._onChangeShield(arg_52_0, arg_52_1)
	if arg_52_1 ~= arg_52_0.entity.id then
		return
	end

	arg_52_0._curShield = FightDataHelper.entityMgr:getById(arg_52_1).shieldValue

	arg_52_0:_tweenFillAmount()
end

function var_0_0._onCurrentHpChange(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	if arg_53_1 ~= arg_53_0.entity.id then
		return
	end

	arg_53_0:resetHp()
end

function var_0_0._onMultiHpChange(arg_54_0, arg_54_1)
	arg_54_0:_onCurrentHpChange(arg_54_1)
end

function var_0_0._onChangeWaveEnd(arg_55_0)
	arg_55_0:_setPosOffset()
end

function var_0_0.onCoverPerformanceEntityData(arg_56_0, arg_56_1)
	if arg_56_1 ~= arg_56_0.entity.id then
		return
	end

	local var_56_0 = FightDataHelper.entityMgr:getById(arg_56_1)

	arg_56_0:setShield(var_56_0.shieldValue)
	arg_56_0:resetHp()
	arg_56_0.buffMgr:refreshBuffList()
	arg_56_0._power:_refreshUI()
end

function var_0_0._setPosOffset(arg_57_0)
	if arg_57_0.entity:getSide() == FightEnum.EntitySide.MySide then
		local var_57_0 = FightEnum.MySideDefaultStanceId
		local var_57_1 = arg_57_0.entity:getMO()
		local var_57_2 = FightModel.instance:getFightParam()
		local var_57_3 = var_57_2 and var_57_2.battleId
		local var_57_4 = var_57_3 and lua_battle.configDict[var_57_3]

		if var_57_4 and not string.nilorempty(var_57_4.myStance) then
			var_57_0 = tonumber(var_57_4.myStance)

			if not var_57_0 then
				local var_57_5 = string.splitToNumber(var_57_4.myStance, "#")

				if #var_57_5 > 0 then
					local var_57_6 = FightModel.instance:getCurWaveId() or 1

					var_57_0 = var_57_5[var_57_6 <= #var_57_5 and var_57_6 or #var_57_5]
				end
			end
		end

		local var_57_7 = lua_stance_hp_offset.configDict[var_57_0]

		if var_57_7 then
			local var_57_8 = var_57_7["offsetPos" .. var_57_1.position]

			if var_57_8 and #var_57_8 > 0 then
				recthelper.setAnchor(arg_57_0._floatContainerGO.transform, var_57_8[1], var_57_8[2])
				recthelper.setAnchor(arg_57_0._uiGO.transform, var_57_8[1], var_57_8[2])

				arg_57_0._originPosOffsetX = var_57_8[1]
				arg_57_0._originPosOffsetY = var_57_8[2]
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

function var_0_0.updateInnerLayout(arg_58_0)
	local var_58_0 = arg_58_0._power:_getPowerData()
	local var_58_1 = FightMsgMgr.sendMsg(FightMsgId.GetExPointView, arg_58_0.entity.id)
	local var_58_2

	if var_58_0 and var_58_1 then
		var_58_2 = var_0_1.ExPoint_Power
	elseif var_58_0 then
		var_58_2 = var_0_1.NoExPoint_Power
	elseif var_58_1 then
		var_58_2 = var_0_1.ExPoint_NoPower
	else
		var_58_2 = var_0_1.NoExPoint_NoPower
	end

	local var_58_3 = var_0_2[var_58_2]
	local var_58_4 = arg_58_0._imgCareerIcon:GetComponent(gohelper.Type_RectTransform)
	local var_58_5 = gohelper.findChildComponent(arg_58_0._uiGO, "layout", gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_58_4, var_58_3.imageCareer)
	recthelper.setAnchorY(var_58_5, var_58_3.layout)
end

function var_0_0._onUpdateUIFollower(arg_59_0, arg_59_1)
	if arg_59_0._entity and arg_59_1 == arg_59_0._entity.id then
		arg_59_0:_updateFollow()
	end
end

function var_0_0.onAiJiAoFakeDecreaseHp(arg_60_0, arg_60_1)
	if arg_60_1 ~= arg_60_0.entity.id then
		return
	end

	arg_60_0:_tweenFillAmount()
end

function var_0_0.onDestroy(arg_61_0)
	return
end

return var_0_0
