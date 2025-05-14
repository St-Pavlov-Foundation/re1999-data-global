module("modules.logic.dungeon.view.map.DungeonMapSceneElements", package.seeall)

local var_0_0 = class("DungeonMapSceneElements", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._elementList = arg_4_0:getUserDataTb_()
	arg_4_0._arrowList = arg_4_0:getUserDataTb_()

	arg_4_0:_initClick()
end

function var_0_0._initClick(arg_5_0)
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0._gofullscreen)

	arg_5_0._click:AddClickDownListener(arg_5_0._clickDownHandler, arg_5_0)
	arg_5_0._click:AddClickUpListener(arg_5_0._clickUp, arg_5_0)
end

function var_0_0.setElementDown(arg_6_0, arg_6_1)
	if not gohelper.isNil(arg_6_0._mapScene._uiGo) then
		return
	end

	arg_6_0._elementMouseDown = arg_6_1
end

function var_0_0._clickDownHandler(arg_7_0)
	arg_7_0._clickDown = true
end

function var_0_0._clickUp(arg_8_0)
	local var_8_0 = arg_8_0._elementMouseDown

	arg_8_0._elementMouseDown = nil

	if arg_8_0._clickDown and var_8_0 and var_8_0:isValid() then
		var_8_0:onClick()
	end
end

function var_0_0._setClickDown(arg_9_0)
	arg_9_0._clickDown = false
end

function var_0_0._updateElementArrow(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._elementList) do
		arg_10_0:_updateArrow(iter_10_1)
	end
end

function var_0_0._updateArrow(arg_11_0, arg_11_1)
	if not arg_11_1:showArrow() then
		return
	end

	local var_11_0 = arg_11_1._transform
	local var_11_1 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(var_11_0.position)
	local var_11_2 = var_11_1.x
	local var_11_3 = var_11_1.y
	local var_11_4 = var_11_2 >= 0 and var_11_2 <= 1 and var_11_3 >= 0 and var_11_3 <= 1
	local var_11_5 = arg_11_0._arrowList[arg_11_1:getElementId()]

	if not var_11_5 then
		return
	end

	gohelper.setActive(var_11_5.go, not var_11_4)

	if var_11_4 then
		return
	end

	local var_11_6 = math.max(0.02, math.min(var_11_2, 0.98))
	local var_11_7 = math.max(0.035, math.min(var_11_3, 0.965))
	local var_11_8 = recthelper.getWidth(arg_11_0._goarrow.transform)
	local var_11_9 = recthelper.getHeight(arg_11_0._goarrow.transform)

	recthelper.setAnchor(var_11_5.go.transform, var_11_8 * (var_11_6 - 0.5), var_11_9 * (var_11_7 - 0.5))

	local var_11_10 = var_11_5.initRotation

	if var_11_2 >= 0 and var_11_2 <= 1 then
		if var_11_3 < 0 then
			transformhelper.setLocalRotation(var_11_5.rotationTrans, var_11_10[1], var_11_10[2], 180)

			return
		elseif var_11_3 > 1 then
			transformhelper.setLocalRotation(var_11_5.rotationTrans, var_11_10[1], var_11_10[2], 0)

			return
		end
	end

	if var_11_3 >= 0 and var_11_3 <= 1 then
		if var_11_2 < 0 then
			transformhelper.setLocalRotation(var_11_5.rotationTrans, var_11_10[1], var_11_10[2], 270)

			return
		elseif var_11_2 > 1 then
			transformhelper.setLocalRotation(var_11_5.rotationTrans, var_11_10[1], var_11_10[2], 90)

			return
		end
	end

	local var_11_11 = 90 - Mathf.Atan2(var_11_3, var_11_2) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(var_11_5.rotationTrans, var_11_10[1], var_11_10[2], var_11_11)
end

function var_0_0._changeMap(arg_12_0)
	arg_12_0:_stopShowSequence()
end

function var_0_0._loadSceneFinish(arg_13_0, arg_13_1)
	arg_13_0._mapCfg = arg_13_1[1]
	arg_13_0._sceneGo = arg_13_1[2]
	arg_13_0._mapScene = arg_13_1[3]
	arg_13_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_13_0._sceneGo, arg_13_0._elementRoot)
end

function var_0_0._disposeScene(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._elementList) do
		iter_14_1:onDestroy()
	end

	arg_14_0._elementList = arg_14_0:getUserDataTb_()
	arg_14_0._elementRoot = nil

	arg_14_0:_stopShowSequence()
end

function var_0_0.onDisposeOldMap(arg_15_0, arg_15_1)
	if arg_15_0.viewName == arg_15_1 then
		arg_15_0:_disposeOldMap()
	end
end

function var_0_0._disposeOldMap(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._elementList) do
		iter_16_1:onDestroy()
	end

	arg_16_0._elementList = arg_16_0:getUserDataTb_()

	for iter_16_2, iter_16_3 in pairs(arg_16_0._arrowList) do
		iter_16_3.arrowClick:RemoveClickListener()
		gohelper.destroy(iter_16_3.go)
	end

	arg_16_0._arrowList = arg_16_0:getUserDataTb_()

	arg_16_0:_stopShowSequence()
end

function var_0_0._initElements(arg_17_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	arg_17_0:_checkSkipShowElementAnim()
	arg_17_0:_showElements(arg_17_0._mapCfg.id)

	arg_17_0._skipShowElementAnim = false
end

function var_0_0._checkSkipShowElementAnim(arg_18_0)
	arg_18_0._skipShowElementAnim = GuideModel.instance:isDoingClickGuide() or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowElementAnim)
end

function var_0_0._showElements(arg_19_0, arg_19_1)
	if gohelper.isNil(arg_19_0._sceneGo) or arg_19_0._lockShowElementAnim then
		return
	end

	local var_19_0 = arg_19_0:_getElements(arg_19_1)
	local var_19_1 = DungeonMapModel.instance:getNewElements()
	local var_19_2 = {}
	local var_19_3 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.showCamera == 1 and not arg_19_0._skipShowElementAnim and (var_19_1 and tabletool.indexOf(var_19_1, iter_19_1.id) or arg_19_0._forceShowElementAnim) then
			table.insert(var_19_2, iter_19_1.id)
		else
			table.insert(var_19_3, iter_19_1)
		end
	end

	arg_19_0:_showElementAnim(var_19_2, var_19_3)
	DungeonMapModel.instance:clearNewElements()
end

function var_0_0._getElements(arg_20_0, arg_20_1)
	return DungeonMapModel.instance:getElements(arg_20_1)
end

function var_0_0._showElement(arg_21_0, arg_21_1, arg_21_2)
	if gohelper.isNil(arg_21_0._sceneGo) or arg_21_0._lockShowElementAnim then
		return
	end

	local var_21_0 = arg_21_0:_getElements(arg_21_1)
	local var_21_1 = DungeonMapModel.instance:getNewElements()
	local var_21_2 = {}
	local var_21_3 = 0

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.showCamera == 1 and not arg_21_0._skipShowElementAnim and arg_21_2 == iter_21_1.id then
			var_21_2[1] = iter_21_1.id

			break
		end
	end

	if #var_21_2 > 0 then
		local var_21_4 = {}

		arg_21_0:_showElementAnim(var_21_2, var_21_4)
		DungeonMapModel.instance:clearNewElements()
	end
end

function var_0_0._addElement(arg_22_0, arg_22_1)
	if arg_22_0._elementList[arg_22_1.id] then
		return
	end

	local var_22_0 = UnityEngine.GameObject.New(tostring(arg_22_1.id))

	gohelper.addChild(arg_22_0._elementRoot, var_22_0)

	local var_22_1 = MonoHelper.addLuaComOnceToGo(var_22_0, DungeonMapElement, {
		arg_22_1,
		arg_22_0._mapScene,
		arg_22_0
	})

	arg_22_0._elementList[arg_22_1.id] = var_22_1

	if var_22_1:showArrow() then
		local var_22_2 = arg_22_0.viewContainer:getSetting().otherRes[5]
		local var_22_3 = arg_22_0:getResInst(var_22_2, arg_22_0._goarrow)
		local var_22_4 = gohelper.findChild(var_22_3, "mesh")
		local var_22_5, var_22_6, var_22_7 = transformhelper.getLocalRotation(var_22_4.transform)
		local var_22_8 = gohelper.getClick(gohelper.findChild(var_22_3, "click"))

		var_22_8:AddClickListener(arg_22_0._arrowClick, arg_22_0, arg_22_1.id)

		arg_22_0._arrowList[arg_22_1.id] = {
			go = var_22_3,
			rotationTrans = var_22_4.transform,
			initRotation = {
				var_22_5,
				var_22_6,
				var_22_7
			},
			arrowClick = var_22_8
		}

		arg_22_0:_updateArrow(var_22_1)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, arg_22_1.id)
end

function var_0_0._arrowClick(arg_23_0, arg_23_1)
	arg_23_0._elementMouseDown = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	arg_23_0:_focusElementById(arg_23_1)
end

function var_0_0._removeElement(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._elementList[arg_24_1]

	if var_24_0 then
		var_24_0:setFinish()
	end

	arg_24_0._elementList[arg_24_1] = nil

	local var_24_1 = arg_24_0._arrowList[arg_24_1]

	if var_24_1 then
		var_24_1.arrowClick:RemoveClickListener()

		arg_24_0._arrowList[arg_24_1] = nil

		gohelper.destroy(var_24_1.go)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementRemove, arg_24_1)
end

function var_0_0.getElementComp(arg_25_0, arg_25_1)
	return arg_25_0._elementList[arg_25_1]
end

function var_0_0.onOpen(arg_26_0)
	if GamepadController.instance:isOpen() then
		arg_26_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_26_0._onGamepadKeyDown, arg_26_0)
	end

	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_26_0.onDisposeOldMap, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnNormalDungeonInitElements, arg_26_0._initElements, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_26_0._disposeScene, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_26_0._loadSceneFinish, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, arg_26_0._updateElementArrow, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnSetClickDown, arg_26_0._setClickDown, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_26_0._OnRemoveElement, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_26_0._beginShowRewardView, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_26_0._endShowRewardView, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnim, arg_26_0._guideShowElementAnim, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.GuideStopShowElementAnim, arg_26_0._guideStopShowElementAnim, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.GuideStartShowElementAnim, arg_26_0._guideStartShowElementAnim, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowSingleElementAnim, arg_26_0._guideShowSingleElementAnim, arg_26_0)
	arg_26_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_26_0._onFinishGuide, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_26_0._setEpisodeListVisible, arg_26_0)
	arg_26_0:addEventCb(DungeonController.instance, DungeonEvent.OnClickElement, arg_26_0.clickElement, arg_26_0)
	arg_26_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, arg_26_0._checkActElement, arg_26_0)
end

function var_0_0._onGamepadKeyDown(arg_27_0, arg_27_1)
	if arg_27_1 == GamepadEnum.KeyCode.A then
		local var_27_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_27_1 = UnityEngine.Physics2D.RaycastAll(var_27_0.origin, var_27_0.direction)
		local var_27_2 = var_27_1.Length - 1

		for iter_27_0 = 0, var_27_2 do
			local var_27_3 = var_27_1[iter_27_0]
			local var_27_4 = MonoHelper.getLuaComFromGo(var_27_3.transform.parent.gameObject, DungeonMapElement)

			if var_27_4 == nil then
				var_27_4 = MonoHelper.getLuaComFromGo(var_27_3.transform.parent.gameObject, DungeonMapFinishElement)
			end

			if var_27_4 then
				var_27_4:onDown()

				return
			end
		end
	end
end

function var_0_0.clickElement(arg_28_0, arg_28_1)
	if arg_28_0:_isShowElementAnim() then
		return
	end

	local var_28_0 = arg_28_0._elementList[tonumber(arg_28_1)]

	if not var_28_0 then
		return
	end

	local var_28_1 = var_28_0._config

	arg_28_0:_focusElementById(var_28_1.id)

	if var_28_1.type == DungeonEnum.ElementType.UnlockEpisode then
		local var_28_2 = string.splitToNumber(var_28_1.param, "#")

		for iter_28_0, iter_28_1 in ipairs(var_28_2) do
			if DungeonMapModel.instance:getElementById(iter_28_1) then
				return
			end
		end

		DungeonRpc.instance:sendMapElementRequest(var_28_1.id)
	elseif var_28_1.type == DungeonEnum.ElementType.UnLockExplore then
		local var_28_3 = GuideModel.instance:getById(14500)

		if not var_28_3 then
			logError("密室解锁指引没有接取！！")
		end

		if var_28_3 and var_28_3.isFinish or not var_28_3 and GuideController.instance:isForbidGuides() then
			DungeonRpc.instance:sendMapElementRequest(var_28_1.id)

			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnClickExploreElement)
	elseif var_28_1.type == DungeonEnum.ElementType.ToughBattle then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		ToughBattleModel.instance:setIsJumpActElement(false)

		local var_28_4 = tonumber(var_28_1.param) or 0

		if var_28_4 == 0 then
			if ToughBattleModel.instance:isStoryFinish() then
				DungeonRpc.instance:sendMapElementRequest(var_28_1.id, nil, function(arg_29_0, arg_29_1, arg_29_2)
					if arg_29_1 ~= 0 then
						return
					end

					DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
				end)
			elseif ToughBattleModel.instance:getStoryInfo().openChallenge then
				ViewMgr.instance:openView(ViewName.ToughBattleMapView, {
					mode = ToughBattleEnum.Mode.Story
				})
			else
				ViewMgr.instance:openView(ViewName.ToughBattleEnterView, {
					mode = ToughBattleEnum.Mode.Story
				})
			end
		else
			Activity158Rpc.instance:sendGet158InfosRequest(var_28_4, arg_28_0.onRecvToughInfo, arg_28_0)
		end

		return
	elseif var_28_1.type == DungeonEnum.ElementType.HeroInvitation then
		local var_28_5 = tonumber(var_28_1.param)

		StoryController.instance:playStory(var_28_5, nil, function()
			DungeonRpc.instance:sendMapElementRequest(var_28_1.id)
		end)
	elseif var_28_1.type == DungeonEnum.ElementType.Investigate then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		DungeonRpc.instance:sendMapElementRequest(var_28_1.id)
	elseif var_28_1.type == DungeonEnum.ElementType.FairyLand then
		FairyLandController.instance:openFairyLandView()
	else
		arg_28_0._mapScene:getInteractiveItem():_OnClickElement(var_28_0)
	end
end

function var_0_0.onRecvToughInfo(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 == 0 then
		if ToughBattleModel.instance:getActInfo().openChallenge then
			ViewMgr.instance:openView(ViewName.ToughBattleActMapView, {
				mode = ToughBattleEnum.Mode.Act
			})
		else
			ViewMgr.instance:openView(ViewName.ToughBattleActEnterView, {
				mode = ToughBattleEnum.Mode.Act
			})
		end
	end
end

function var_0_0._checkActElement(arg_32_0)
	if not arg_32_0._mapCfg or ToughBattleEnum.MapId_7_30 ~= arg_32_0._mapCfg.id then
		return
	end

	if ToughBattleModel.instance:getActIsOnline() then
		if not arg_32_0._elementList[ToughBattleEnum.ActElementId] then
			arg_32_0:_addElementById(ToughBattleEnum.ActElementId)
		end
	elseif arg_32_0._elementList[ToughBattleEnum.ActElementId] then
		arg_32_0:_removeElement(ToughBattleEnum.ActElementId)
	end
end

function var_0_0._setEpisodeListVisible(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._goarrow, arg_33_1)
end

function var_0_0._onFinishGuide(arg_34_0, arg_34_1)
	if arg_34_0._lockShowElementAnim and arg_34_1 == 129 then
		arg_34_0._lockShowElementAnim = nil

		GuideModel.instance:clearFlagByGuideId(arg_34_1)
		arg_34_0:_initElements()
	end
end

function var_0_0._beginShowRewardView(arg_35_0)
	arg_35_0._showRewardView = true
end

function var_0_0._endShowRewardView(arg_36_0)
	arg_36_0._showRewardView = false

	if arg_36_0._needRemoveElementId then
		TaskDispatcher.runDelay(arg_36_0._removeElementAfterShowReward, arg_36_0, DungeonEnum.RefreshTimeAfterShowReward)
		TaskDispatcher.runDelay(arg_36_0._showNewElements, arg_36_0, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		return
	end

	arg_36_0:_showNewElements()
end

function var_0_0._removeElementAfterShowReward(arg_37_0)
	local var_37_0 = arg_37_0._needRemoveElementId

	arg_37_0._needRemoveElementId = nil

	arg_37_0:_removeElement(var_37_0)
end

function var_0_0._guideStartShowElementAnim(arg_38_0)
	arg_38_0._lockShowElementAnim = false
	arg_38_0._forceShowElementAnim = true

	arg_38_0:_showElements(arg_38_0._mapCfg.id)

	arg_38_0._forceShowElementAnim = false
end

function var_0_0._guideShowSingleElementAnim(arg_39_0, arg_39_1)
	local var_39_0 = tonumber(arg_39_1)

	arg_39_0._lockShowElementAnim = false
	arg_39_0._forceShowElementAnim = true

	arg_39_0:_showElement(arg_39_0._mapCfg.id, var_39_0)

	arg_39_0._forceShowElementAnim = false
	arg_39_0._forceShowElementId = var_39_0
end

function var_0_0._guideShowElementAnim(arg_40_0)
	arg_40_0._lockShowElementAnim = true
end

function var_0_0._guideStopShowElementAnim(arg_41_0)
	if not arg_41_0:_isShowElementAnim() then
		return
	end

	arg_41_0:_stopShowSequence()
	arg_41_0:_initElements()
end

function var_0_0._OnClickGuidepost(arg_42_0)
	if not arg_42_0._guidepostGo then
		return
	end

	local var_42_0, var_42_1 = transformhelper.getLocalPos(arg_42_0._guidepostGo.transform)
	local var_42_2 = arg_42_0._mapMaxX - var_42_0 + arg_42_0._viewWidth / 2
	local var_42_3 = arg_42_0._mapMinY - var_42_1 - arg_42_0._viewHeight / 2 + 2

	arg_42_0:setScenePosSafety(Vector3(var_42_2, var_42_3, 0), true)
end

function var_0_0._showNewElements(arg_43_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	if DungeonMapModel.instance:getNewElements() then
		arg_43_0:_showElements(arg_43_0._mapCfg.id)
	end
end

function var_0_0._focusElementById(arg_44_0, arg_44_1)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, arg_44_1)
end

function var_0_0._addElementById(arg_45_0, arg_45_1)
	local var_45_0 = lua_chapter_map_element.configDict[arg_45_1]

	arg_45_0:_addElement(var_45_0)
end

function var_0_0._doAddElement(arg_46_0)
	local var_46_0 = arg_46_0[1]
	local var_46_1 = arg_46_0[2]

	var_46_0:_addElementById(var_46_1)

	local var_46_2 = lua_chapter_map_element.configDict[var_46_1]
	local var_46_3 = var_46_0._elementList[var_46_2.id]

	if not var_46_3 then
		return
	end

	var_46_3:setWenHaoAnim("wenhao_a_001_camerin")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function var_0_0._doFocusElement(arg_47_0)
	local var_47_0 = arg_47_0[1]
	local var_47_1 = arg_47_0[2]

	var_47_0._tweenTime = 1

	var_47_0:_focusElementById(var_47_1)

	var_47_0._tweenTime = nil
end

function var_0_0._addAnimElementDone(arg_48_0)
	local var_48_0 = arg_48_0[1]
	local var_48_1 = arg_48_0[2]

	for iter_48_0, iter_48_1 in ipairs(var_48_1) do
		var_48_0:_addElement(iter_48_1)
	end

	var_48_0:_onAddAnimElementDone()
end

function var_0_0._onAddAnimElementDone(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0._elementList) do
		iter_49_1:_onAddAnimDone()
	end
end

function var_0_0._doSetInitPos(arg_50_0)
	local var_50_0 = arg_50_0[1]

	DungeonController.instance:dispatchEvent(DungeonEvent.GuideShowElementAnimFinish)
end

function var_0_0._stopShowSequence(arg_51_0)
	if arg_51_0._showSequence then
		arg_51_0._showSequence:unregisterDoneListener(arg_51_0._stopShowSequence, arg_51_0)
		arg_51_0._showSequence:destroy()

		arg_51_0._showSequence = nil

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
			UIBlockMgr.instance:endBlock("DungeonMapSceneElements UseBlock")
		end
	end
end

function var_0_0._showElementAnim(arg_52_0, arg_52_1, arg_52_2)
	if not arg_52_1 or #arg_52_1 <= 0 then
		var_0_0._addAnimElementDone({
			arg_52_0,
			arg_52_2
		})

		return
	end

	arg_52_0:_stopShowSequence()

	arg_52_0._showSequence = FlowSequence.New()

	arg_52_0._showSequence:addWork(TimerWork.New(0.8))
	table.sort(arg_52_1)

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		arg_52_0._showSequence:addWork(FunctionWork.New(var_0_0._doFocusElement, {
			arg_52_0,
			iter_52_1
		}))
		arg_52_0._showSequence:addWork(TimerWork.New(1.2))
		arg_52_0._showSequence:addWork(FunctionWork.New(var_0_0._doAddElement, {
			arg_52_0,
			iter_52_1
		}))
		arg_52_0._showSequence:addWork(TimerWork.New(1))
	end

	arg_52_0._showSequence:addWork(TimerWork.New(0.5))
	arg_52_0._showSequence:addWork(FunctionWork.New(var_0_0._addAnimElementDone, {
		arg_52_0,
		arg_52_2
	}))
	arg_52_0._showSequence:addWork(FunctionWork.New(var_0_0._doSetInitPos, {
		arg_52_0
	}))
	arg_52_0._showSequence:registerDoneListener(arg_52_0._stopShowSequence, arg_52_0)
	arg_52_0._showSequence:start()

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapSceneElements UseBlock")
	end
end

function var_0_0._isShowElementAnim(arg_53_0)
	return arg_53_0._showSequence and arg_53_0._showSequence.status == WorkStatus.Running
end

function var_0_0._OnRemoveElement(arg_54_0, arg_54_1)
	if not arg_54_0._showRewardView then
		arg_54_0:_removeElement(arg_54_1)
		arg_54_0:_showNewElements()
	else
		arg_54_0._needRemoveElementId = arg_54_1
	end
end

function var_0_0.onClose(arg_55_0)
	return
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0:_disposeOldMap()
	arg_56_0._click:RemoveClickDownListener()
	arg_56_0._click:RemoveClickUpListener()
	DungeonMapModel.instance:clearNewElements()
	TaskDispatcher.cancelTask(arg_56_0._removeElementAfterShowReward, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._showNewElements, arg_56_0)
end

return var_0_0
