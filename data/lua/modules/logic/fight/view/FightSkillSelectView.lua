module("modules.logic.fight.view.FightSkillSelectView", package.seeall)

local var_0_0 = class("FightSkillSelectView", BaseView)
local var_0_1 = SLFramework.UGUI.UIRightClickListener

function var_0_0._onRightClick(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_onClickDown(arg_1_1, arg_1_2)

	if arg_1_0._curClickEntityId then
		arg_1_0:_onLongPress(arg_1_1)
	end
end

local var_0_2 = SLFramework.UGUI.UILongPressListener

function var_0_0.onInitView(arg_2_0)
	arg_2_0._clickBlock = gohelper.findChildClick(arg_2_0.viewGO, "clickBlock")
	arg_2_0._clickBlockTransform = arg_2_0._clickBlock:GetComponent(gohelper.Type_RectTransform)
	arg_2_0._longPress = var_0_2.Get(arg_2_0._clickBlock.gameObject)
	arg_2_0._guideClickObj = gohelper.findChild(arg_2_0.viewGO, "guideClick")

	gohelper.setActive(arg_2_0._guideClickObj, false)

	arg_2_0._guideClickObj.name = "guideClick"
	arg_2_0._guideClickList = {}
	arg_2_0._containerGO = arg_2_0.viewGO
	arg_2_0._containerTr = arg_2_0._containerGO.transform
	arg_2_0._imgSelectGO = gohelper.findChild(arg_2_0.viewGO, "imgSkillSelect")
	arg_2_0._imgSelectTr = arg_2_0._imgSelectGO.transform
	arg_2_0._imgSelectAnimator = arg_2_0._containerGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_2_0._containerGO, false)

	arg_2_0.showUI = true
	arg_2_0.entityVisible = true

	arg_2_0:_setSelectGOActive(false)

	arg_2_0.started = nil

	arg_2_0._clickBlock:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0._clickBlock:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	arg_2_0._clickBlock:AddClickUpListener(arg_2_0._onClickUp, arg_2_0)
	arg_2_0._longPress:AddLongPressListener(arg_2_0._onLongPress, arg_2_0)

	arg_2_0._pressTab = {
		0.5,
		99999
	}

	arg_2_0._longPress:SetLongPressTime(arg_2_0._pressTab)

	arg_2_0._rightClick = var_0_1.Get(arg_2_0._clickBlock.gameObject)

	arg_2_0._rightClick:AddClickListener(arg_2_0._onRightClick, arg_2_0)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_3_0.onCameraFocusChanged, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, arg_3_0.onEnemyActionStatusChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundSequenceFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_3_0._removeAllEvent, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_3_0._setIsShowUI, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_3_0._onRestartStage, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, arg_3_0._onSkillTimeLineDone, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, arg_3_0._setEntityVisibleByTimeline, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBeginWave, arg_3_0._onBeginWave, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.EntityDeadFinish, arg_3_0.onEntityDeadFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ExitStage, arg_3_0.onExitStage, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GuideCreateClickBySkinId, arg_3_0._onGuideCreateClickBySkinId, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GuideReleaseClickBySkilId, arg_3_0._onGuideReleaseClickBySkilId, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_3_0.onChangeEntity, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._rightClick:RemoveClickListener()
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_4_0._onStartSequenceFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_4_0.onCameraFocusChanged, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, arg_4_0.onEnemyActionStatusChange, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0._onRoundSequenceFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.StartReplay, arg_4_0._removeAllEvent, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_4_0._setIsShowUI, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_4_0._onRestartStage, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, arg_4_0._onSkillTimeLineDone, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, arg_4_0._setEntityVisibleByTimeline, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, arg_4_0._onBeginWave, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.EntityDeadFinish, arg_4_0.onEntityDeadFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.ExitStage, arg_4_0.onExitStage, arg_4_0)
	arg_4_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, arg_4_0.OnKeySelect, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_4_0.onChangeEntity, arg_4_0)
	arg_4_0._clickBlock:RemoveClickListener()
	arg_4_0._clickBlock:RemoveClickDownListener()
	arg_4_0._clickBlock:RemoveClickUpListener()
	arg_4_0._longPress:RemoveLongPressListener()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._guideClickList) do
		iter_4_1.rightClick:RemoveClickListener()

		local var_4_0 = iter_4_1.click

		var_4_0:RemoveClickListener()
		var_4_0:RemoveClickDownListener()
		var_4_0:RemoveClickUpListener()
		iter_4_1.longPress:RemoveLongPressListener()
	end
end

function var_0_0._onRoundSequenceFinish(arg_5_0)
	arg_5_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
end

function var_0_0.onChangeEntity(arg_6_0, arg_6_1)
	if not FightHelper.getEntity(FightCardModel.instance.curSelectEntityId) then
		arg_6_0:_resetDefaultFocus()
		FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	end
end

function var_0_0._updateGuideClick(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._guideClickList) do
		local var_7_0 = iter_7_1.entity
		local var_7_1 = var_7_0:getMO()
		local var_7_2, var_7_3, var_7_4, var_7_5 = FightHelper.calcRect(var_7_0, arg_7_0._clickBlockTransform)
		local var_7_6
		local var_7_7
		local var_7_8 = var_7_0:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

		if var_7_8 then
			local var_7_9, var_7_10, var_7_11 = transformhelper.getPos(var_7_8.transform)

			var_7_6, var_7_7 = recthelper.worldPosToAnchorPosXYZ(var_7_9, var_7_10, var_7_11, arg_7_0._containerTr)
		else
			var_7_6 = (var_7_2 + var_7_4) / 2
			var_7_7 = (var_7_3 + var_7_5) / 2
		end

		recthelper.setAnchor(iter_7_1.transform, var_7_6, var_7_7)

		local var_7_12 = math.abs(var_7_2 - var_7_4)
		local var_7_13 = math.abs(var_7_3 - var_7_5)
		local var_7_14 = lua_monster_skin.configDict[var_7_1.skin]
		local var_7_15 = var_7_14 and var_7_14.clickBoxUnlimit == 1
		local var_7_16 = var_7_15 and 800 or 200
		local var_7_17 = var_7_15 and 800 or 500
		local var_7_18 = Mathf.Clamp(var_7_12, 150, var_7_16)
		local var_7_19 = Mathf.Clamp(var_7_13, 150, var_7_17)

		recthelper.setSize(iter_7_1.transform, var_7_18, var_7_19)
	end
end

function var_0_0._onGuideCreateClickBySkinId(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = tonumber(arg_8_1)
	arg_8_2 = tonumber(arg_8_2)

	local var_8_0 = FightHelper.getAllEntitys()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = iter_8_1:getMO()

		if arg_8_0:_checkEntityGuideClick(var_8_1, arg_8_1, arg_8_2) then
			FightModel.instance:setClickEnemyState(true)

			arg_8_0._curClickEntityId = iter_8_1.id

			local var_8_2 = arg_8_0:getUserDataTb_()

			var_8_2.entity = iter_8_1

			local var_8_3 = gohelper.cloneInPlace(arg_8_0._guideClickObj, "guideClick" .. arg_8_1)

			gohelper.setActive(var_8_3, true)

			var_8_2.obj = var_8_3
			var_8_2.transform = var_8_3.transform

			local var_8_4 = gohelper.getClick(var_8_3)

			var_8_4:AddClickListener(arg_8_0._onClick, arg_8_0)
			var_8_4:AddClickDownListener(arg_8_0._onClickDown, arg_8_0)
			var_8_4:AddClickUpListener(arg_8_0._onClickUp, arg_8_0)

			var_8_2.click = var_8_4

			local var_8_5 = var_0_2.Get(var_8_3)

			var_8_5:AddLongPressListener(arg_8_0._onLongPress, arg_8_0)
			var_8_5:SetLongPressTime(arg_8_0._pressTab)

			var_8_2.longPress = var_8_5

			local var_8_6 = var_0_1.Get(var_8_3)

			var_8_6:AddClickListener(arg_8_0._onRightClick, arg_8_0)

			var_8_2.rightClick = var_8_6

			table.insert(arg_8_0._guideClickList, var_8_2)
			TaskDispatcher.runRepeat(arg_8_0._updateGuideClick, arg_8_0, 0.01)

			break
		end
	end
end

function var_0_0._checkEntityGuideClick(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 then
		return false
	end

	if arg_9_1.skin ~= tonumber(arg_9_2) then
		return false
	end

	if arg_9_3 and tonumber(arg_9_3) ~= arg_9_1.position then
		return false
	end

	return true
end

function var_0_0._onGuideReleaseClickBySkilId(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = #arg_10_0._guideClickList, 1, -1 do
		local var_10_0 = arg_10_0._guideClickList[iter_10_0].entity:getMO()

		if arg_10_0:_checkEntityGuideClick(var_10_0, arg_10_1, arg_10_2) then
			local var_10_1 = table.remove(arg_10_0._guideClickList, iter_10_0)

			var_10_1.rightClick:RemoveClickListener()

			local var_10_2 = var_10_1.click

			var_10_2:RemoveClickListener()
			var_10_2:RemoveClickDownListener()
			var_10_2:RemoveClickUpListener()
			var_10_1.longPress:RemoveLongPressListener()
			gohelper.destroy(var_10_1.obj)
		end
	end

	if #arg_10_0._guideClickList == 0 then
		TaskDispatcher.cancelTask(arg_10_0._updateGuideClick, arg_10_0)
		FightModel.instance:setClickEnemyState(false)

		arg_10_0._curClickEntityId = nil
	end
end

function var_0_0._onClick(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1 or arg_11_0._curClickEntityId

	if not var_11_0 then
		return
	end

	local var_11_1 = FightHelper.getEntity(var_11_0)

	if not var_11_1 then
		return
	end

	if not var_11_1:isEnemySide() then
		return
	end

	local var_11_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightFocus)
	local var_11_3 = GuideModel.instance:isGuideFinish(GuideController.FirstGuideId)

	if not var_11_2 and not var_11_3 then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	local var_11_4 = FightDataHelper.stageMgr:getCurOperateState()

	if var_11_4 == FightStageMgr.OperateStateType.Discard or var_11_4 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightModel.instance:isAuto() then
		if var_11_0 == FightCardModel.instance.curSelectEntityId then
			FightCardModel.instance:setCurSelectEntityId(0)
		else
			arg_11_0:_playSelectAnim()
			FightCardModel.instance:setCurSelectEntityId(var_11_0)
		end
	else
		if var_11_0 ~= FightCardModel.instance.curSelectEntityId then
			arg_11_0:_playSelectAnim()
		end

		FightCardModel.instance:setCurSelectEntityId(var_11_0)
	end

	arg_11_0:_updateSelectUI()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, var_11_0)
end

function var_0_0._onClickDown(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._curClickEntityId = nil

	local var_12_0 = FightHelper.getAllEntitys()

	for iter_12_0 = #var_12_0, 1, -1 do
		if not arg_12_0:checkCanSelect(var_12_0[iter_12_0].id) then
			table.remove(var_12_0, iter_12_0)
		end
	end

	local var_12_1 = FightHelper.getClickEntity(var_12_0, arg_12_0._clickBlockTransform, arg_12_2)

	if var_12_1 then
		FightModel.instance:setClickEnemyState(true)

		arg_12_0._curClickEntityId = var_12_1
	end
end

function var_0_0.checkCanSelect(arg_13_0, arg_13_1)
	if FightDataHelper.entityMgr:isSub(arg_13_1) then
		return false
	end

	local var_13_0 = FightDataHelper.entityMgr:getById(arg_13_1)

	if not var_13_0 then
		return false
	end

	if var_13_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_13_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	if var_13_0:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return false
	end

	return true
end

function var_0_0._onClickUp(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._curClickEntityId then
		FightModel.instance:setClickEnemyState(false)
	end
end

function var_0_0._onLongPress(arg_15_0, arg_15_1)
	if not arg_15_0._curClickEntityId then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	local var_15_0 = FightDataHelper.stageMgr:getCurOperateState()

	if var_15_0 == FightStageMgr.OperateStateType.Discard or var_15_0 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightModel.instance:isAuto() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	local var_15_1 = FightHelper.getEntity(arg_15_0._curClickEntityId)

	if not var_15_1 then
		return
	end

	if FightDataHelper.entityMgr:isSub(var_15_1.id) then
		return
	end

	arg_15_0.currentFocusEntityMO = FightDataHelper.entityMgr:getById(arg_15_0._curClickEntityId)

	if not arg_15_0.currentFocusEntityMO then
		return
	end

	arg_15_0.viewContainer:openFightFocusView(arg_15_0.currentFocusEntityMO.id)
end

function var_0_0.onExitStage(arg_16_0, arg_16_1)
	local var_16_0 = FightDataHelper.stageMgr:getCurStage()

	if FightDataHelper.stageMgr:inReplay() then
		logError("reply stage ?")

		return
	end

	if var_16_0 == FightStageMgr.StageType.Normal then
		arg_16_0:clearAllFlag()
		arg_16_0:_updatePos()
	end
end

function var_0_0.onEntityDeadFinish(arg_17_0)
	arg_17_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	arg_17_0:_updatePos()
end

function var_0_0.onEnemyActionStatusChange(arg_18_0, arg_18_1)
	arg_18_0.showEnemyActioning = FightEnum.EnemyActionStatus.Select == arg_18_1

	arg_18_0:_setSelectGOActive(true)
end

function var_0_0.onUpdateParam(arg_19_0)
	gohelper.setAsFirstSibling(arg_19_0.viewGO)
end

function var_0_0.onOpen(arg_20_0)
	gohelper.setAsFirstSibling(arg_20_0.viewGO)

	if FightReplayModel.instance:isReplay() then
		arg_20_0:_removeAllEvent()
	end
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._updateGuideClick, arg_21_0)
	FightCardModel.instance:setCurSelectEntityId(0)
	TaskDispatcher.cancelTask(arg_21_0._delayStartSequenceFinish, arg_21_0)
	arg_21_0:removeLateUpdate()
end

function var_0_0._onBeginWave(arg_22_0)
	arg_22_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
end

function var_0_0._setEntityVisibleByTimeline(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1.id ~= FightCardModel.instance.curSelectEntityId then
		return
	end

	arg_23_0.entityVisible = arg_23_3

	arg_23_0:_setSelectGOActive(true)
end

function var_0_0._onSkillPlayStart(arg_24_0, arg_24_1)
	if FightCardModel.instance.curSelectEntityId ~= arg_24_1.id then
		return
	end

	arg_24_0.playingCurSelectEntityTimeline = true

	arg_24_0:_setSelectGOActive(false)
end

function var_0_0._onSkillTimeLineDone(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1 and arg_25_1.fromId

	if FightCardModel.instance.curSelectEntityId ~= var_25_0 then
		return
	end

	arg_25_0.playingCurSelectEntityTimeline = false

	arg_25_0:_setSelectGOActive(true)
end

function var_0_0._setIsShowUI(arg_26_0, arg_26_1)
	arg_26_0.showUI = arg_26_1

	if not arg_26_0._canvasGroup then
		arg_26_0._canvasGroup = gohelper.onceAddComponent(arg_26_0._containerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_26_0._canvasGroup, arg_26_1)
end

function var_0_0._removeAllEvent(arg_27_0)
	arg_27_0:removeEvents()
	arg_27_0:removeLateUpdate()
end

function var_0_0.onCameraFocusChanged(arg_28_0, arg_28_1)
	if arg_28_1 then
		arg_28_0._on_camera_focus = true

		arg_28_0:_setSelectGOActive(false)
	else
		arg_28_0._on_camera_focus = false

		arg_28_0:_setSelectGOActive(true)
	end
end

function var_0_0.clearAllFlag(arg_29_0)
	arg_29_0._on_camera_focus = nil
	arg_29_0.playingCurSelectEntityTimeline = nil
	arg_29_0.entityVisible = true
	arg_29_0.showEnemyActioning = nil
end

function var_0_0._setSelectGOActive(arg_30_0, arg_30_1)
	if not arg_30_1 then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if arg_30_0.showEnemyActioning then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if arg_30_0._on_camera_focus then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if arg_30_0.playingCurSelectEntityTimeline then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if not arg_30_0.entityVisible then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	if not GMFightShowState.monsterSelect then
		gohelper.setActive(arg_30_0._imgSelectGO, false)

		return
	end

	gohelper.setActive(arg_30_0._imgSelectGO, true)
end

function var_0_0._resetSelect(arg_31_0)
	arg_31_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	arg_31_0:_updateSelectUI()
end

function var_0_0._onStartSequenceFinish(arg_32_0)
	FightCardModel.instance:setCurSelectEntityId(0)
	TaskDispatcher.runDelay(arg_32_0._delayStartSequenceFinish, arg_32_0, 0.01)
end

function var_0_0._delayStartSequenceFinish(arg_33_0)
	arg_33_0.started = true

	arg_33_0:clearAllFlag()
	gohelper.setActive(arg_33_0._containerGO, true)
	arg_33_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	arg_33_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, arg_33_0.OnKeySelect, arg_33_0)
	arg_33_0:initUpdateBeat()
end

function var_0_0.OnKeySelect(arg_34_0, arg_34_1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	local var_34_0 = FightCardModel.instance:getSelectEnemyPosLOrR(arg_34_1)

	if var_34_0 ~= nil then
		arg_34_0:_onClick(var_34_0)
	end
end

function var_0_0.initUpdateBeat(arg_35_0)
	if arg_35_0.lateUpdateHandle or not arg_35_0.showUI or arg_35_0.playingCurSelectEntityTimeline then
		return
	end

	arg_35_0.lateUpdateHandle = LateUpdateBeat:CreateListener(arg_35_0._onFrameLateUpdate, arg_35_0)

	LateUpdateBeat:AddListener(arg_35_0.lateUpdateHandle)
end

function var_0_0._onFrameLateUpdate(arg_36_0)
	if arg_36_0._on_camera_focus then
		return
	end

	arg_36_0:_updatePos()
end

function var_0_0.removeLateUpdate(arg_37_0)
	if arg_37_0.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(arg_37_0.lateUpdateHandle)

		arg_37_0.lateUpdateHandle = nil
	end
end

function var_0_0._playSelectAnim(arg_38_0)
	if arg_38_0._imgSelectAnimator then
		arg_38_0._imgSelectAnimator:Play("fightview_skillselect", 0, 0)
	else
		logError("无法播放目标锁定动画，Animator不存在")
	end
end

function var_0_0._onRestartStage(arg_39_0)
	gohelper.setActive(arg_39_0._containerGO, false)
	arg_39_0:removeLateUpdate()

	arg_39_0.started = nil
end

function var_0_0._updatePos(arg_40_0)
	arg_40_0:_updateSelectUI()
end

function var_0_0._resetDefaultFocus(arg_41_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAutoFocus) then
		FightCardModel.instance:resetCurSelectEntityIdDefault()
	end
end

function var_0_0._updateSelectUI(arg_42_0)
	local var_42_0 = FightHelper.getEntity(FightCardModel.instance.curSelectEntityId)

	arg_42_0:_setSelectGOActive(var_42_0 ~= nil)

	if var_42_0 then
		local var_42_1, var_42_2 = arg_42_0:_getEntityMiddlePos(var_42_0)

		recthelper.setAnchor(arg_42_0._imgSelectTr, var_42_1, var_42_2)
	end
end

function var_0_0._getEntityMiddlePos(arg_43_0, arg_43_1)
	if FightHelper.isAssembledMonster(arg_43_1) then
		local var_43_0 = arg_43_1:getMO()
		local var_43_1 = lua_fight_assembled_monster.configDict[var_43_0.skin]
		local var_43_2, var_43_3, var_43_4 = transformhelper.getPos(arg_43_1.go.transform)
		local var_43_5, var_43_6 = recthelper.worldPosToAnchorPosXYZ(var_43_2 + var_43_1.selectPos[1], var_43_3 + var_43_1.selectPos[2], var_43_4, arg_43_0._containerTr)

		return var_43_5, var_43_6
	end

	local var_43_7 = arg_43_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

	if var_43_7 and var_43_7.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local var_43_8, var_43_9, var_43_10 = transformhelper.getPos(var_43_7.transform)
		local var_43_11, var_43_12 = recthelper.worldPosToAnchorPosXYZ(var_43_8, var_43_9, var_43_10, arg_43_0._containerTr)

		return var_43_11, var_43_12
	else
		local var_43_13, var_43_14, var_43_15, var_43_16 = FightHelper.calcRect(arg_43_1, arg_43_0._clickBlockTransform)

		return (var_43_13 + var_43_15) / 2, (var_43_14 + var_43_16) / 2
	end
end

function var_0_0.getCurrentFocusEntityId(arg_44_0)
	return arg_44_0.currentFocusEntityMO.id
end

function var_0_0.onDestroyView(arg_45_0)
	return
end

return var_0_0
