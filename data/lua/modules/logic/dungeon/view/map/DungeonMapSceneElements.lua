module("modules.logic.dungeon.view.map.DungeonMapSceneElements", package.seeall)

slot0 = class("DungeonMapSceneElements", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._elementList = slot0:getUserDataTb_()
	slot0._arrowList = slot0:getUserDataTb_()

	slot0:_initClick()
end

function slot0._initClick(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)

	slot0._click:AddClickDownListener(slot0._clickDownHandler, slot0)
	slot0._click:AddClickUpListener(slot0._clickUp, slot0)
end

function slot0.setElementDown(slot0, slot1)
	if not gohelper.isNil(slot0._mapScene._uiGo) then
		return
	end

	slot0._elementMouseDown = slot1
end

function slot0._clickDownHandler(slot0)
	slot0._clickDown = true
end

function slot0._clickUp(slot0)
	slot1 = slot0._elementMouseDown
	slot0._elementMouseDown = nil

	if slot0._clickDown and slot1 and slot1:isValid() then
		slot1:onClick()
	end
end

function slot0._setClickDown(slot0)
	slot0._clickDown = false
end

function slot0._updateElementArrow(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot0:_updateArrow(slot5)
	end
end

function slot0._updateArrow(slot0, slot1)
	if not slot1:showArrow() then
		return
	end

	slot4 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(slot1._transform.position)
	slot6 = slot4.y
	slot7 = slot4.x >= 0 and slot5 <= 1 and slot6 >= 0 and slot6 <= 1

	if not slot0._arrowList[slot1:getElementId()] then
		return
	end

	gohelper.setActive(slot8.go, not slot7)

	if slot7 then
		return
	end

	recthelper.setAnchor(slot8.go.transform, recthelper.getWidth(slot0._goarrow.transform) * (math.max(0.02, math.min(slot5, 0.98)) - 0.5), recthelper.getHeight(slot0._goarrow.transform) * (math.max(0.035, math.min(slot6, 0.965)) - 0.5))

	slot13 = slot8.initRotation

	if slot5 >= 0 and slot5 <= 1 then
		if slot6 < 0 then
			transformhelper.setLocalRotation(slot8.rotationTrans, slot13[1], slot13[2], 180)

			return
		elseif slot6 > 1 then
			transformhelper.setLocalRotation(slot8.rotationTrans, slot13[1], slot13[2], 0)

			return
		end
	end

	if slot6 >= 0 and slot6 <= 1 then
		if slot5 < 0 then
			transformhelper.setLocalRotation(slot8.rotationTrans, slot13[1], slot13[2], 270)

			return
		elseif slot5 > 1 then
			transformhelper.setLocalRotation(slot8.rotationTrans, slot13[1], slot13[2], 90)

			return
		end
	end

	transformhelper.setLocalRotation(slot8.rotationTrans, slot13[1], slot13[2], 90 - Mathf.Atan2(slot6, slot5) * Mathf.Rad2Deg)
end

function slot0._changeMap(slot0)
	slot0:_stopShowSequence()
end

function slot0._loadSceneFinish(slot0, slot1)
	slot0._mapCfg = slot1[1]
	slot0._sceneGo = slot1[2]
	slot0._mapScene = slot1[3]
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)
end

function slot0._disposeScene(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:onDestroy()
	end

	slot0._elementList = slot0:getUserDataTb_()
	slot0._elementRoot = nil

	slot0:_stopShowSequence()
end

function slot0.onDisposeOldMap(slot0, slot1)
	if slot0.viewName == slot1 then
		slot0:_disposeOldMap()
	end
end

function slot0._disposeOldMap(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:onDestroy()
	end

	slot0._elementList = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(slot0._arrowList) do
		slot5.arrowClick:RemoveClickListener()
		gohelper.destroy(slot5.go)
	end

	slot0._arrowList = slot0:getUserDataTb_()

	slot0:_stopShowSequence()
end

function slot0._initElements(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	slot0:_checkSkipShowElementAnim()
	slot0:_showElements(slot0._mapCfg.id)

	slot0._skipShowElementAnim = false
end

function slot0._checkSkipShowElementAnim(slot0)
	slot0._skipShowElementAnim = GuideModel.instance:isDoingClickGuide() or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowElementAnim)
end

function slot0._showElements(slot0, slot1)
	if gohelper.isNil(slot0._sceneGo) or slot0._lockShowElementAnim then
		return
	end

	slot3 = DungeonMapModel.instance:getNewElements()
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0:_getElements(slot1)) do
		if slot10.showCamera == 1 and not slot0._skipShowElementAnim and (slot3 and tabletool.indexOf(slot3, slot10.id) or slot0._forceShowElementAnim) then
			table.insert(slot4, slot10.id)
		else
			table.insert(slot5, slot10)
		end
	end

	slot0:_showElementAnim(slot4, slot5)
	DungeonMapModel.instance:clearNewElements()
end

function slot0._getElements(slot0, slot1)
	return DungeonMapModel.instance:getElements(slot1)
end

function slot0._showElement(slot0, slot1, slot2)
	if gohelper.isNil(slot0._sceneGo) or slot0._lockShowElementAnim then
		return
	end

	slot4 = DungeonMapModel.instance:getNewElements()
	slot6 = 0

	for slot10, slot11 in ipairs(slot0:_getElements(slot1)) do
		if slot11.showCamera == 1 and not slot0._skipShowElementAnim and slot2 == slot11.id then
			break
		end
	end

	if #{
		slot11.id
	} > 0 then
		slot0:_showElementAnim(slot5, {})
		DungeonMapModel.instance:clearNewElements()
	end
end

function slot0._addElement(slot0, slot1)
	if slot0._elementList[slot1.id] then
		return
	end

	slot2 = UnityEngine.GameObject.New(tostring(slot1.id))

	gohelper.addChild(slot0._elementRoot, slot2)

	slot3 = MonoHelper.addLuaComOnceToGo(slot2, DungeonMapElement, {
		slot1,
		slot0._mapScene,
		slot0
	})
	slot0._elementList[slot1.id] = slot3

	if slot3:showArrow() then
		slot5 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[5], slot0._goarrow)
		slot6 = gohelper.findChild(slot5, "mesh")
		slot7, slot8, slot9 = transformhelper.getLocalRotation(slot6.transform)
		slot10 = gohelper.getClick(gohelper.findChild(slot5, "click"))

		slot10:AddClickListener(slot0._arrowClick, slot0, slot1.id)

		slot0._arrowList[slot1.id] = {
			go = slot5,
			rotationTrans = slot6.transform,
			initRotation = {
				slot7,
				slot8,
				slot9
			},
			arrowClick = slot10
		}

		slot0:_updateArrow(slot3)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, slot1.id)
end

function slot0._arrowClick(slot0, slot1)
	slot0._elementMouseDown = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	slot0:_focusElementById(slot1)
end

function slot0._removeElement(slot0, slot1)
	if slot0._elementList[slot1] then
		slot2:setFinish()
	end

	slot0._elementList[slot1] = nil

	if slot0._arrowList[slot1] then
		slot3.arrowClick:RemoveClickListener()

		slot0._arrowList[slot1] = nil

		gohelper.destroy(slot3.go)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementRemove, slot1)
end

function slot0.getElementComp(slot0, slot1)
	return slot0._elementList[slot1]
end

function slot0.onOpen(slot0)
	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0._onGamepadKeyDown, slot0)
	end

	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnNormalDungeonInitElements, slot0._initElements, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0._disposeScene, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0._loadSceneFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, slot0._updateElementArrow, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnSetClickDown, slot0._setClickDown, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0._beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnim, slot0._guideShowElementAnim, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideStopShowElementAnim, slot0._guideStopShowElementAnim, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideStartShowElementAnim, slot0._guideStartShowElementAnim, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowSingleElementAnim, slot0._guideShowSingleElementAnim, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnClickElement, slot0.clickElement, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, slot0._checkActElement, slot0)
end

function slot0._onGamepadKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot2 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

		for slot8 = 0, UnityEngine.Physics2D.RaycastAll(slot2.origin, slot2.direction).Length - 1 do
			if MonoHelper.getLuaComFromGo(slot3[slot8].transform.parent.gameObject, DungeonMapElement) == nil then
				slot10 = MonoHelper.getLuaComFromGo(slot9.transform.parent.gameObject, DungeonMapFinishElement)
			end

			if slot10 then
				slot10:onDown()

				return
			end
		end
	end
end

function slot0.clickElement(slot0, slot1)
	if slot0:_isShowElementAnim() then
		return
	end

	if not slot0._elementList[tonumber(slot1)] then
		return
	end

	slot3 = slot2._config

	slot0:_focusElementById(slot3.id)

	if slot3.type == DungeonEnum.ElementType.UnlockEpisode then
		for slot8, slot9 in ipairs(string.splitToNumber(slot3.param, "#")) do
			if DungeonMapModel.instance:getElementById(slot9) then
				return
			end
		end

		DungeonRpc.instance:sendMapElementRequest(slot3.id)
	elseif slot3.type == DungeonEnum.ElementType.UnLockExplore then
		if not GuideModel.instance:getById(14500) then
			logError("密室解锁指引没有接取！！")
		end

		if slot4 and slot4.isFinish or not slot4 and GuideController.instance:isForbidGuides() then
			DungeonRpc.instance:sendMapElementRequest(slot3.id)

			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnClickExploreElement)
	elseif slot3.type == DungeonEnum.ElementType.ToughBattle then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		ToughBattleModel.instance:setIsJumpActElement(false)

		if (tonumber(slot3.param) or 0) == 0 then
			if ToughBattleModel.instance:isStoryFinish() then
				DungeonRpc.instance:sendMapElementRequest(slot3.id, nil, function (slot0, slot1, slot2)
					if slot1 ~= 0 then
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
			Activity158Rpc.instance:sendGet158InfosRequest(slot4, slot0.onRecvToughInfo, slot0)
		end

		return
	elseif slot3.type == DungeonEnum.ElementType.HeroInvitation then
		StoryController.instance:playStory(tonumber(slot3.param), nil, function ()
			DungeonRpc.instance:sendMapElementRequest(uv0.id)
		end)
	elseif slot3.type == DungeonEnum.ElementType.Investigate then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		DungeonRpc.instance:sendMapElementRequest(slot3.id)
	elseif slot3.type == DungeonEnum.ElementType.FairyLand then
		FairyLandController.instance:openFairyLandView()
	else
		slot0._mapScene:getInteractiveItem():_OnClickElement(slot2)
	end
end

function slot0.onRecvToughInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
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

function slot0._checkActElement(slot0)
	if not slot0._mapCfg or ToughBattleEnum.MapId_7_30 ~= slot0._mapCfg.id then
		return
	end

	if ToughBattleModel.instance:getActIsOnline() then
		if not slot0._elementList[ToughBattleEnum.ActElementId] then
			slot0:_addElementById(ToughBattleEnum.ActElementId)
		end
	elseif slot0._elementList[ToughBattleEnum.ActElementId] then
		slot0:_removeElement(ToughBattleEnum.ActElementId)
	end
end

function slot0._setEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._goarrow, slot1)
end

function slot0._onFinishGuide(slot0, slot1)
	if slot0._lockShowElementAnim and slot1 == 129 then
		slot0._lockShowElementAnim = nil

		GuideModel.instance:clearFlagByGuideId(slot1)
		slot0:_initElements()
	end
end

function slot0._beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0._endShowRewardView(slot0)
	slot0._showRewardView = false

	if slot0._needRemoveElementId then
		TaskDispatcher.runDelay(slot0._removeElementAfterShowReward, slot0, DungeonEnum.RefreshTimeAfterShowReward)
		TaskDispatcher.runDelay(slot0._showNewElements, slot0, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		return
	end

	slot0:_showNewElements()
end

function slot0._removeElementAfterShowReward(slot0)
	slot0._needRemoveElementId = nil

	slot0:_removeElement(slot0._needRemoveElementId)
end

function slot0._guideStartShowElementAnim(slot0)
	slot0._lockShowElementAnim = false
	slot0._forceShowElementAnim = true

	slot0:_showElements(slot0._mapCfg.id)

	slot0._forceShowElementAnim = false
end

function slot0._guideShowSingleElementAnim(slot0, slot1)
	slot2 = tonumber(slot1)
	slot0._lockShowElementAnim = false
	slot0._forceShowElementAnim = true

	slot0:_showElement(slot0._mapCfg.id, slot2)

	slot0._forceShowElementAnim = false
	slot0._forceShowElementId = slot2
end

function slot0._guideShowElementAnim(slot0)
	slot0._lockShowElementAnim = true
end

function slot0._guideStopShowElementAnim(slot0)
	if not slot0:_isShowElementAnim() then
		return
	end

	slot0:_stopShowSequence()
	slot0:_initElements()
end

function slot0._OnClickGuidepost(slot0)
	if not slot0._guidepostGo then
		return
	end

	slot1, slot2 = transformhelper.getLocalPos(slot0._guidepostGo.transform)

	slot0:setScenePosSafety(Vector3(slot0._mapMaxX - slot1 + slot0._viewWidth / 2, slot0._mapMinY - slot2 - slot0._viewHeight / 2 + 2, 0), true)
end

function slot0._showNewElements(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	if DungeonMapModel.instance:getNewElements() then
		slot0:_showElements(slot0._mapCfg.id)
	end
end

function slot0._focusElementById(slot0, slot1)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, slot1)
end

function slot0._addElementById(slot0, slot1)
	slot0:_addElement(lua_chapter_map_element.configDict[slot1])
end

function slot0._doAddElement(slot0)
	slot1 = slot0[1]
	slot2 = slot0[2]

	slot1:_addElementById(slot2)

	if not slot1._elementList[lua_chapter_map_element.configDict[slot2].id] then
		return
	end

	slot4:setWenHaoAnim("wenhao_a_001_camerin")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function slot0._doFocusElement(slot0)
	slot1 = slot0[1]
	slot1._tweenTime = 1

	slot1:_focusElementById(slot0[2])

	slot1._tweenTime = nil
end

function slot0._addAnimElementDone(slot0)
	slot1 = slot0[1]

	for slot6, slot7 in ipairs(slot0[2]) do
		slot1:_addElement(slot7)
	end

	slot1:_onAddAnimElementDone()
end

function slot0._onAddAnimElementDone(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:_onAddAnimDone()
	end
end

function slot0._doSetInitPos(slot0)
	slot1 = slot0[1]

	DungeonController.instance:dispatchEvent(DungeonEvent.GuideShowElementAnimFinish)
end

function slot0._stopShowSequence(slot0)
	if slot0._showSequence then
		slot0._showSequence:unregisterDoneListener(slot0._stopShowSequence, slot0)
		slot0._showSequence:destroy()

		slot0._showSequence = nil

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
			UIBlockMgr.instance:endBlock("DungeonMapSceneElements UseBlock")
		end
	end
end

function slot0._showElementAnim(slot0, slot1, slot2)
	if not slot1 or #slot1 <= 0 then
		uv0._addAnimElementDone({
			slot0,
			slot2
		})

		return
	end

	slot0:_stopShowSequence()

	slot0._showSequence = FlowSequence.New()
	slot6 = 0.8

	slot0._showSequence:addWork(TimerWork.New(slot6))
	table.sort(slot1)

	for slot6, slot7 in ipairs(slot1) do
		slot0._showSequence:addWork(FunctionWork.New(uv0._doFocusElement, {
			slot0,
			slot7
		}))
		slot0._showSequence:addWork(TimerWork.New(1.2))
		slot0._showSequence:addWork(FunctionWork.New(uv0._doAddElement, {
			slot0,
			slot7
		}))
		slot0._showSequence:addWork(TimerWork.New(1))
	end

	slot0._showSequence:addWork(TimerWork.New(0.5))
	slot0._showSequence:addWork(FunctionWork.New(uv0._addAnimElementDone, {
		slot0,
		slot2
	}))
	slot0._showSequence:addWork(FunctionWork.New(uv0._doSetInitPos, {
		slot0
	}))
	slot0._showSequence:registerDoneListener(slot0._stopShowSequence, slot0)
	slot0._showSequence:start()

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapSceneElements UseBlock")
	end
end

function slot0._isShowElementAnim(slot0)
	return slot0._showSequence and slot0._showSequence.status == WorkStatus.Running
end

function slot0._OnRemoveElement(slot0, slot1)
	if not slot0._showRewardView then
		slot0:_removeElement(slot1)
		slot0:_showNewElements()
	else
		slot0._needRemoveElementId = slot1
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_disposeOldMap()
	slot0._click:RemoveClickDownListener()
	slot0._click:RemoveClickUpListener()
	DungeonMapModel.instance:clearNewElements()
	TaskDispatcher.cancelTask(slot0._removeElementAfterShowReward, slot0)
	TaskDispatcher.cancelTask(slot0._showNewElements, slot0)
end

return slot0
