module("modules.logic.fight.entity.comp.FightNameUI", package.seeall)

local var_0_0 = class("FightNameUI", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._entity = arg_1_1
	arg_1_0._nameUIActive = true
	arg_1_0._nameUIVisible = true
	arg_1_0._expointCtrl = FightNameUIExPointMgr.New(arg_1_0)
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
	arg_20_0._exPointGO = gohelper.findChild(arg_20_0._uiGO, "expointContainer")

	arg_20_0._expointCtrl:initMgr(arg_20_0._exPointGO, arg_20_0.entity)
end

function var_0_0.initStressMgr(arg_21_0)
	if not arg_21_0.entity:getMO():hasStress() then
		return
	end

	arg_21_0.stressMgr = FightNameUIStressMgr.New(arg_21_0)
	arg_21_0.stressGo = gohelper.findChild(arg_21_0._uiGO, "#go_fightstressitem")

	arg_21_0.stressMgr:initMgr(arg_21_0.stressGo, arg_21_0.entity)
end

function var_0_0.beforeDestroy(arg_22_0)
	arg_22_0._power:releaseSelf()

	if arg_22_0._seasonGuard then
		arg_22_0._seasonGuard:releaseSelf()
	end

	arg_22_0._expointCtrl:beforeDestroy()

	if arg_22_0.stressMgr then
		arg_22_0.stressMgr:beforeDestroy()
	end

	if arg_22_0._enemyOperation then
		arg_22_0._enemyOperation:disposeSelf()
	end

	arg_22_0._opCtrl:beforeDestroy()
	arg_22_0.buffMgr:beforeDestroy()
	CameraMgr.instance:getCameraTrace():RemoveChangeActor(arg_22_0._uiFollower)
	FightFloatMgr.instance:nameUIBeforeDestroy(arg_22_0._floatContainerGO)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_22_0._updateFollow, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_22_0._beforePlaySkill, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_22_0._onMySideRoundEnd, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_22_0._updateUIPos, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_22_0._onStartSequenceFinish, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_22_0.updateUI, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_22_0._onRoundSequenceFinish, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_22_0.updateActive, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.SetIsShowFloat, arg_22_0._setIsShowFloat, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.SetIsShowNameUI, arg_22_0._setIsShowNameUI, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnFloatEquipEffect, arg_22_0._onFloatEquipEffect, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnCameraFovChange, arg_22_0._updateUIPos, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnMaxHpChange, arg_22_0._onMaxHpChange, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.OnCurrentHpChange, arg_22_0._onCurrentHpChange, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.MultiHpChange, arg_22_0._onMultiHpChange, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.ChangeWaveEnd, arg_22_0._onChangeWaveEnd, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.ChangeCareer, arg_22_0._onChangeCareer, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.UpdateUIFollower, arg_22_0._onUpdateUIFollower, arg_22_0)
	arg_22_0:removeEventCb(FightController.instance, FightEvent.ChangeShield, arg_22_0._onChangeShield, arg_22_0)
	arg_22_0:_killHpTween()
	TaskDispatcher.cancelTask(arg_22_0._onDelAniOver, arg_22_0)
	FightNameMgr.instance:unregister(arg_22_0)
	gohelper.destroy(arg_22_0._containerGO)
	arg_22_0._uiLoader:dispose()

	arg_22_0._uiLoader = nil
	arg_22_0._containerGO = nil
end

function var_0_0.updateUI(arg_23_0)
	local var_23_0 = arg_23_0.entity:getMO()

	arg_23_0._txtName.text = var_23_0:getEntityName()

	arg_23_0:_refreshCareer()
	arg_23_0:_updateFollow()
	arg_23_0:updateActive()
end

function var_0_0._refreshCareer(arg_24_0)
	local var_24_0 = arg_24_0.entity:getMO()
	local var_24_1 = FightModel.instance:getVersion()

	if SkillEditorMgr.instance.inEditMode then
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._imgCareerIcon, "sx_icon_" .. tostring(var_24_0:getCO().career), true)
	elseif var_24_1 >= 2 and var_24_0.career ~= 0 then
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._imgCareerIcon, "sx_icon_" .. tostring(var_24_0.career), true)
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._imgCareerIcon, "sx_icon_" .. tostring(var_24_0:getCO().career), true)
	end
end

function var_0_0._onChangeCareer(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.entity.id then
		arg_25_0:_refreshCareer()
	end
end

function var_0_0._beforePlaySkill(arg_26_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		return
	end

	arg_26_0._opCtrl:hideOpContainer()
end

function var_0_0._onMySideRoundEnd(arg_27_0)
	arg_27_0._opCtrl:showOpContainer()
end

function var_0_0._onStartSequenceFinish(arg_28_0)
	arg_28_0:updateUI()
	arg_28_0._opCtrl:showOpContainer()
end

function var_0_0._onRoundSequenceFinish(arg_29_0)
	arg_29_0:updateUI()
	arg_29_0._opCtrl:showOpContainer()
end

function var_0_0._updateFollow(arg_30_0, arg_30_1)
	if arg_30_1 and arg_30_1.unitSpawn ~= arg_30_0.entity then
		return
	end

	local var_30_0 = arg_30_0.entity.spine and arg_30_0.entity.spine:getSpineGO()

	if not var_30_0 then
		recthelper.setAnchorX(arg_30_0._containerGO.transform, 20000)

		return
	end

	local var_30_1 = CameraMgr.instance:getUnitCamera()
	local var_30_2 = CameraMgr.instance:getUICamera()
	local var_30_3 = arg_30_0.entity.go.transform
	local var_30_4 = ViewMgr.instance:getUIRoot().transform
	local var_30_5 = FightConfig.instance:getSkinCO(arg_30_0.entity:getMO().skin)
	local var_30_6 = var_30_5 and var_30_5.topuiOffset or {
		0,
		0,
		0,
		0
	}
	local var_30_7 = var_30_6 and var_30_6[1] or 0
	local var_30_8 = var_30_6 and var_30_6[2] or 0
	local var_30_9 = var_30_6 and var_30_6[3] or 0
	local var_30_10 = var_30_6 and var_30_6[4] or 0
	local var_30_11 = arg_30_0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle, true)
	local var_30_12, var_30_13 = FightHelper.getEntityBoxSizeOffsetV2(arg_30_0.entity)
	local var_30_14 = var_30_12.y
	local var_30_15, var_30_16, var_30_17 = transformhelper.getPos(var_30_11.transform)
	local var_30_18, var_30_19, var_30_20 = transformhelper.getPos(arg_30_0.entity.go.transform)

	arg_30_0._uiFollower = gohelper.onceAddComponent(arg_30_0._containerGO, typeof(ZProj.UIFollower))

	arg_30_0._uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())

	local var_30_21 = gohelper.findChild(var_30_0, ModuleEnum.SpineHangPointRoot)
	local var_30_22 = var_30_21 and gohelper.findChild(var_30_21, ModuleEnum.SpineHangPoint.mounthproot)

	if var_30_22 then
		local var_30_23, var_30_24 = transformhelper.getLocalScale(arg_30_0.entity.go.transform)
		local var_30_25 = 0.5

		arg_30_0._uiFollower:Set(var_30_1, var_30_2, var_30_4, var_30_22.transform, var_30_9, (var_30_10 + var_30_25) * var_30_24, 0, var_30_7, var_30_8)
	elseif isTypeOf(arg_30_0.entity, FightEntityAssembledMonsterMain) or isTypeOf(arg_30_0.entity, FightEntityAssembledMonsterSub) then
		local var_30_26 = arg_30_0.entity:getMO()
		local var_30_27 = lua_fight_assembled_monster.configDict[var_30_26.skin]

		arg_30_0._uiFollower:Set(var_30_1, var_30_2, var_30_4, var_30_11.transform, var_30_27.hpPos[1] or 0, var_30_27.hpPos[2] or 0, 0, 0, 0)
	else
		local var_30_28, var_30_29 = transformhelper.getLocalScale(arg_30_0.entity.go.transform)

		arg_30_0._uiFollower:Set(var_30_1, var_30_2, var_30_4, var_30_11.transform, 0 + var_30_9, var_30_14 + var_30_19 - var_30_16 + var_30_10 * var_30_29, 0, var_30_7, var_30_8 + 15)
	end

	arg_30_0._uiFollower:SetEnable(true)
	CameraMgr.instance:getCameraTrace():AddChangeActor(arg_30_0._uiFollower)
end

function var_0_0._updateUIPos(arg_31_0)
	if arg_31_0._uiFollower then
		arg_31_0._uiFollower:ForceUpdate()
	end
end

function var_0_0.changeHpWithChoushiBuff(arg_32_0, arg_32_1)
	if not arg_32_0.entity:isMySide() then
		gohelper.setActive(arg_32_0._gohpbg, not arg_32_1)
		gohelper.setActive(arg_32_0._gohpbg, arg_32_1)

		if arg_32_1 then
			UISpriteSetMgr.instance:setFightSprite(arg_32_0._imgHp, "bg_xt_choushi")
		else
			UISpriteSetMgr.instance:setFightSprite(arg_32_0._imgHp, "bg_xt2")
		end
	end
end

function var_0_0.getFollower(arg_33_0)
	return arg_33_0._uiFollower
end

function var_0_0.updateActive(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if arg_34_1 and arg_34_1 ~= arg_34_0.entity.id then
		return
	end

	if arg_34_3 then
		local var_34_0 = lua_skill_buff.configDict[arg_34_3]

		if var_34_0 and var_34_0.typeId == 3120005 then
			arg_34_0:_insteadSpecialHp(arg_34_2)
		end

		if FightConfig.instance:hasBuffFeature(arg_34_3, FightEnum.BuffType_HideLife) then
			arg_34_0:_doSetActive()
		end
	else
		arg_34_0:_doSetActive()
	end
end

function var_0_0._insteadSpecialHp(arg_35_0, arg_35_1)
	if arg_35_1 then
		if arg_35_1 == FightEnum.EffectType.BUFFADD then
			arg_35_0:changeHpWithChoushiBuff(true)
		elseif arg_35_1 == FightEnum.EffectType.BUFFDEL or arg_35_1 == FightEnum.EffectType.BUFFDELNOEFFECT then
			arg_35_0:changeHpWithChoushiBuff(false)
		end
	else
		local var_35_0 = arg_35_0.entity:getMO():getBuffDic()

		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			local var_35_1 = lua_skill_buff.configDict[iter_35_1.buffId]

			if var_35_1 and var_35_1.typeId == 3120005 then
				arg_35_0:changeHpWithChoushiBuff(true)

				return
			end
		end
	end
end

function var_0_0.getFloatItemStartY(arg_36_0)
	return (arg_36_0.buffMgr:getBuffLineCount() or 0) * 34.5 + (#arg_36_0._opCtrl:getOpItemList() > 0 and 42 or 0)
end

function var_0_0.showPoisoningEffect(arg_37_0, arg_37_1)
	arg_37_0.buffMgr:showPoisoningEffect(arg_37_1)
end

function var_0_0._setIsShowFloat(arg_38_0, arg_38_1)
	if not arg_38_0._canvasGroup then
		arg_38_0._canvasGroup = gohelper.onceAddComponent(arg_38_0._floatContainerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_38_0._canvasGroup, arg_38_1)
end

function var_0_0.addHp(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.entity:getMO().attrMO.hp

	arg_39_0._curHp = arg_39_0._curHp + arg_39_1
	arg_39_0._curHp = arg_39_0._curHp >= 0 and arg_39_0._curHp or 0
	arg_39_0._curHp = var_39_0 >= arg_39_0._curHp and arg_39_0._curHp or var_39_0
	arg_39_0._txtHp.text = arg_39_0._curHp

	arg_39_0:_tweenFillAmount()
end

function var_0_0.getHp(arg_40_0)
	return arg_40_0._curHp
end

function var_0_0.setShield(arg_41_0, arg_41_1)
	arg_41_0._curShield = arg_41_1 > 0 and arg_41_1 or 0

	arg_41_0:_tweenFillAmount()
end

function var_0_0._tweenFillAmount(arg_42_0)
	local var_42_0, var_42_1 = arg_42_0:_getFillAmount()

	arg_42_0._imgHp.fillAmount = var_42_0

	ZProj.TweenHelper.KillByObj(arg_42_0._imgHpMinus)
	ZProj.TweenHelper.DOFillAmount(arg_42_0._imgHpMinus, var_42_0, 0.5)
	ZProj.TweenHelper.KillByObj(arg_42_0._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(arg_42_0._imgHpShield, var_42_1, 0.5)
	gohelper.setActive(arg_42_0._imgHpMinus.gameObject, arg_42_0._curShield <= 0)
end

function var_0_0.resetHp(arg_43_0)
	ZProj.TweenHelper.KillByObj(arg_43_0._imgHpMinus)
	ZProj.TweenHelper.KillByObj(arg_43_0._imgHpShield)

	arg_43_0._curHp = arg_43_0.entity:getMO().currentHp
	arg_43_0._curHp = arg_43_0._curHp > 0 and arg_43_0._curHp or 0
	arg_43_0._curShield = arg_43_0.entity:getMO().shieldValue

	local var_43_0, var_43_1 = arg_43_0:_getFillAmount()

	arg_43_0._imgHpMinus.fillAmount = var_43_0
	arg_43_0._imgHp.fillAmount = var_43_0
	arg_43_0._imgHpShield.fillAmount = var_43_1
	arg_43_0._txtHp.text = arg_43_0._curHp

	gohelper.setActive(arg_43_0._imgHpMinus.gameObject, arg_43_0._curShield <= 0)
end

function var_0_0._getFillAmount(arg_44_0)
	local var_44_0 = arg_44_0.entity:getMO()
	local var_44_1 = var_44_0.attrMO and var_44_0.attrMO.hp > 0 and var_44_0.attrMO.hp or 1
	local var_44_2 = var_44_1 > 0 and arg_44_0._curHp / var_44_1 or 0
	local var_44_3 = 0

	if var_44_1 >= arg_44_0._curShield + arg_44_0._curHp then
		var_44_2 = arg_44_0._curHp / var_44_1
		var_44_3 = (arg_44_0._curShield + arg_44_0._curHp) / var_44_1
	else
		var_44_2 = arg_44_0._curHp / (arg_44_0._curHp + arg_44_0._curShield)
		var_44_3 = 1
	end

	local var_44_4 = var_44_0.attrMO and var_44_0.attrMO.original_max_hp or 1

	if var_44_1 < var_44_4 then
		local var_44_5 = var_44_4 - var_44_1

		var_44_2 = var_44_2 * var_44_1 / var_44_4 + var_44_5 / var_44_4
		var_44_3 = var_44_3 * var_44_1 / var_44_4 + var_44_5 / var_44_4
	end

	return var_44_2, var_44_3
end

function var_0_0._onFloatEquipEffect(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 ~= arg_45_0.entity.id then
		return
	end

	if not arg_45_0._float_equip_time then
		arg_45_0._float_equip_time = Time.time
	elseif Time.time - arg_45_0._float_equip_time < 1 then
		return
	end

	arg_45_0._float_equip_time = Time.time

	FightFloatMgr.instance:float(arg_45_1, FightEnum.FloatType.equipeffect, "", arg_45_2)
end

function var_0_0.setFloatRootVisble(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._floatContainerGO, arg_46_1)
end

function var_0_0._onMaxHpChange(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if arg_47_1 ~= arg_47_0.entity.id then
		return
	end

	arg_47_0:_killHpTween()

	if not arg_47_0._hp_tweens then
		arg_47_0._hp_tweens = {}
	end

	if arg_47_2 < arg_47_3 then
		arg_47_0._hp_ani:Play("up", 0, 0)

		local var_47_0 = ZProj.TweenHelper.DOAnchorPosX(arg_47_0._hp_container_tran, 0, 0.3, arg_47_0._hpTweenDone, arg_47_0)

		table.insert(arg_47_0._hp_tweens, var_47_0)
	else
		local var_47_1 = arg_47_0.entity:getMO()

		if (var_47_1.attrMO and var_47_1.attrMO.hp > 0 and var_47_1.attrMO.hp or 1) < (var_47_1.attrMO and var_47_1.attrMO.original_max_hp or 1) then
			arg_47_0._hp_ani:Play("down", 0, 0)
			arg_47_0:resetHp()
		end
	end
end

function var_0_0._hpTweenDone(arg_48_0)
	arg_48_0:resetHp()
end

function var_0_0._killHpTween(arg_49_0)
	if arg_49_0._hp_tweens then
		for iter_49_0, iter_49_1 in ipairs(arg_49_0._hp_tweens) do
			ZProj.TweenHelper.KillById(iter_49_1)
		end

		arg_49_0._hp_tweens = {}
	end
end

function var_0_0._onChangeShield(arg_50_0, arg_50_1)
	if arg_50_1 ~= arg_50_0.entity.id then
		return
	end

	arg_50_0._curShield = FightDataHelper.entityMgr:getById(arg_50_1).shieldValue

	arg_50_0:_tweenFillAmount()
end

function var_0_0._onCurrentHpChange(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_1 ~= arg_51_0.entity.id then
		return
	end

	arg_51_0:resetHp()
end

function var_0_0._onMultiHpChange(arg_52_0, arg_52_1)
	arg_52_0:_onCurrentHpChange(arg_52_1)
end

function var_0_0._onChangeWaveEnd(arg_53_0)
	arg_53_0:_setPosOffset()
end

function var_0_0.onCoverPerformanceEntityData(arg_54_0, arg_54_1)
	if arg_54_1 ~= arg_54_0.entity.id then
		return
	end

	local var_54_0 = FightDataHelper.entityMgr:getById(arg_54_1)

	arg_54_0:setShield(var_54_0.shieldValue)
	arg_54_0:resetHp()
	arg_54_0.buffMgr:refreshBuffList()
	arg_54_0._power:_refreshUI()
	arg_54_0._expointCtrl:updateSelfExPoint()
end

function var_0_0._setPosOffset(arg_55_0)
	if arg_55_0.entity:getSide() == FightEnum.EntitySide.MySide then
		local var_55_0 = FightEnum.MySideDefaultStanceId
		local var_55_1 = arg_55_0.entity:getMO()
		local var_55_2 = FightModel.instance:getFightParam()
		local var_55_3 = var_55_2 and var_55_2.battleId
		local var_55_4 = var_55_3 and lua_battle.configDict[var_55_3]

		if var_55_4 and not string.nilorempty(var_55_4.myStance) then
			var_55_0 = tonumber(var_55_4.myStance)

			if not var_55_0 then
				local var_55_5 = string.splitToNumber(var_55_4.myStance, "#")

				if #var_55_5 > 0 then
					local var_55_6 = FightModel.instance:getCurWaveId() or 1

					var_55_0 = var_55_5[var_55_6 <= #var_55_5 and var_55_6 or #var_55_5]
				end
			end
		end

		local var_55_7 = lua_stance_hp_offset.configDict[var_55_0]

		if var_55_7 then
			local var_55_8 = var_55_7["offsetPos" .. var_55_1.position]

			if var_55_8 and #var_55_8 > 0 then
				recthelper.setAnchor(arg_55_0._floatContainerGO.transform, var_55_8[1], var_55_8[2])
				recthelper.setAnchor(arg_55_0._uiGO.transform, var_55_8[1], var_55_8[2])

				arg_55_0._originPosOffsetX = var_55_8[1]
				arg_55_0._originPosOffsetY = var_55_8[2]
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

function var_0_0.updateInnerLayout(arg_56_0)
	local var_56_0 = arg_56_0._power:_getPowerData()
	local var_56_1 = not arg_56_0._expointCtrl:checkNeedShieldExPoint()
	local var_56_2

	if var_56_0 and var_56_1 then
		var_56_2 = var_0_1.ExPoint_Power
	elseif var_56_0 then
		var_56_2 = var_0_1.NoExPoint_Power
	elseif var_56_1 then
		var_56_2 = var_0_1.ExPoint_NoPower
	else
		var_56_2 = var_0_1.NoExPoint_NoPower
	end

	local var_56_3 = var_0_2[var_56_2]
	local var_56_4 = arg_56_0._imgCareerIcon:GetComponent(gohelper.Type_RectTransform)
	local var_56_5 = gohelper.findChildComponent(arg_56_0._uiGO, "layout", gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_56_4, var_56_3.imageCareer)
	recthelper.setAnchorY(var_56_5, var_56_3.layout)
end

function var_0_0._onUpdateUIFollower(arg_57_0, arg_57_1)
	if arg_57_0._entity and arg_57_1 == arg_57_0._entity.id then
		arg_57_0:_updateFollow()
	end
end

function var_0_0.onDestroy(arg_58_0)
	return
end

return var_0_0
