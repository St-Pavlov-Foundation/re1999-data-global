module("modules.logic.versionactivity1_4.act130.view.Activity130Map", package.seeall)

slot0 = class("Activity130Map", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")

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
	slot0._tempVector = Vector3()
	slot0._sceneIndex = 1
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)

	slot0:_initMap()
	slot0:_addEvents()
end

function slot0._initMap(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("Activity130Map")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)
	slot11 = 0

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0.5, slot4, slot11)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	slot7 = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_mapinteractiveitem.prefab"
	slot0._mapLoader = MultiAbLoader.New()

	for slot11, slot12 in ipairs(string.split(Activity130Model.instance:getCurMapConfig().scenes, "#")) do
		slot0._mapLoader:addPath(slot12 .. ".prefab")
	end

	slot0._mapLoader:addPath(slot7)
	slot0._mapLoader:startLoad(function (slot0)
		uv0._mainPrefabs = {}
		uv0._elementRoots = {}

		for slot4, slot5 in ipairs(uv1) do
			slot8 = gohelper.clone(uv0._mapLoader:getAssetItem(slot5 .. ".prefab"):GetResource(slot5 .. ".prefab"), uv0._sceneRoot)

			gohelper.setActive(slot8, false)
			table.insert(uv0._mainPrefabs, slot8)
		end

		slot2 = Activity130Model.instance:getEpisodeCurSceneIndex(Activity130Model.instance:getCurEpisodeId())
		uv0._sceneGo = uv0._mainPrefabs[slot2]

		gohelper.setActive(uv0._sceneGo, true)

		uv0._sceneAnimator = uv0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		uv0._sceneAnimator:Play("open", 0, 0)

		uv0._backgroundGo = gohelper.findChild(uv0._sceneGo, "root/BackGround")
		uv0._diffuseGo = gohelper.findChild(uv0._sceneGo, "Obj-Plant/all/diffuse")
		uv0._elementRoots[slot2] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(uv0._mainPrefabs[slot2], uv0._elementRoots[slot2])

		uv0._anim = uv0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
		uv0._itemPrefab = uv0._mapLoader:getAssetItem(uv2):GetResource(uv2)

		uv0:_initElements()

		uv0._sceneLoaded = true

		if uv0._needCheckInit then
			uv0:_checkInitElements()

			uv0._needCheckInit = false
		end
	end)
end

function slot0._initElements(slot0)
	slot0:_showElements()
end

function slot0._checkInitElements(slot0)
	if not slot0._sceneLoaded then
		slot0._needCheckInit = true

		return
	end

	slot0._needCheckInit = false
	slot2 = VersionActivity1_4Enum.ActivityId.Role37
	slot3 = Activity130Model.instance:getCurEpisodeId()

	if Activity130Model.instance:getCurMapInfo().progress == Activity130Enum.ProgressType.AfterStory then
		if Activity130Config.instance:getActivity130EpisodeCo(slot2, slot3).afterStoryId > 0 and not StoryModel.instance:isStoryFinished(slot4.afterStoryId) then
			StoryController.instance:playStory(slot4.afterStoryId, nil, slot0._onStoryFinished, slot0)
		else
			slot0:_onStoryFinished()
		end

		return
	end

	if Activity130Config.instance:getActivity130EpisodeCo(slot2, slot3).elements ~= "" then
		for slot9, slot10 in ipairs(string.splitToNumber(slot4.elements, "#")) do
			for slot14, slot15 in pairs(slot1.act130Elements) do
				if slot15.elementId == slot10 and not slot15.isFinish then
					slot0:_clickElement(nil, slot15)

					return
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot1.act130Elements) do
		if not slot9.isFinish then
			if slot9:getType() == Activity130Enum.ElementType.CheckDecrypt then
				Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, slot9)

				return
			elseif slot9.index <= #slot9.typeList and slot9.index ~= 0 then
				slot0:_clickElement(nil, slot9)

				return
			elseif slot9.index == 0 and slot9.config.res == "" then
				slot0:_clickElement(nil, slot9)

				return
			end
		end
	end
end

function slot0._onStoryFinished(slot0)
	if Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId()).afterStoryId > 0 then
		Activity130Rpc.instance:sendAct130StoryRequest(slot1, slot2)
	end

	if slot2 == Activity130Model.instance:getMaxUnlockEpisode() then
		slot0:_backToLevelView()
	end
end

function slot0._clickUp(slot0)
	slot0._elementMouseDown = nil

	if slot0._elementMouseDown and slot1:isValid() then
		slot1:onClick()
	end
end

function slot0._onGamepadKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot2 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

		for slot8 = 0, UnityEngine.Physics2D.RaycastAll(slot2.origin, slot2.direction).Length - 1 do
			if MonoHelper.getLuaComFromGo(slot3[slot8].transform.parent.gameObject, Activity130MapElement) then
				slot10:onDown()

				return
			end
		end
	end
end

function slot0._onSceneClose(slot0)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()

	transformhelper.setLocalRotation(slot1.transform, 0, 0, 0)

	slot1.orthographic = true
	slot1.orthographicSize = 7.4 * GameUtil.getAdapterScale(true)
end

function slot0.onOpen(slot0)
	slot0:playAmbientAudio()
	MainCameraMgr.instance:addView(ViewName.Activity130GameView, slot0._initCamera, nil, slot0)
end

function slot0.onClose(slot0)
	slot0:_clearElements()
	slot0:_removeEvents()
	slot0:closeAmbientSound()
end

function slot0._clearElements(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:dispose()
	end

	slot0._elementList = slot0:getUserDataTb_()
end

function slot0._showElements(slot0)
	slot4 = {}

	for slot8, slot9 in ipairs(Activity130Model.instance:getEpisodeElements(Activity130Model.instance:getCurEpisodeId())) do
		if not string.nilorempty(Activity130Config.instance:getActivity130ElementCo(VersionActivity1_4Enum.ActivityId.Role37, slot9.elementId).res) then
			slot11 = slot4[slot10] or {}

			if slot9:isAvailable() or slot0._elementList[slot9.elementId] then
				table.insert(slot11, slot9)
			end

			slot4[slot10] = slot11
		end
	end

	slot5 = {}

	for slot9 = #slot2, 1, -1 do
		if not slot10:isAvailable() then
			slot0:_removeElement(slot10, (slot4[Activity130Config.instance:getActivity130ElementCo(slot3, slot2[slot9].elementId).res] and #slot12 or 0) <= 1)
		else
			table.insert(slot5, slot10)
		end
	end

	for slot9 = #slot5, 1, -1 do
		slot0:_addElement(slot10, (slot4[Activity130Config.instance:getActivity130ElementCo(slot3, slot5[slot9].elementId).res] and #slot12 or 0) <= 1)
	end
end

function slot0._addElement(slot0, slot1, slot2)
	if slot0._elementList[slot1.elementId] then
		slot3:updateInfo(slot1)

		return
	end

	if not gohelper.findChild(slot0._elementRoots[Activity130Model.instance:getEpisodeCurSceneIndex(Activity130Model.instance:getCurEpisodeId())], tostring(slot1.elementId)) then
		gohelper.addChild(slot0._elementRoots[slot5], UnityEngine.GameObject.New(tostring(slot1.elementId)))
	else
		MonoHelper.removeLuaComFromGo(slot6, Activity130MapElement)
		gohelper.destroyAllChildren(slot6)
	end

	slot3 = MonoHelper.addLuaComOnceToGo(slot6, Activity130MapElement, {
		slot1,
		slot0
	})
	slot0._elementList[slot1.elementId] = slot3

	if string.nilorempty(slot3:getResName()) then
		return
	end

	slot9 = nil

	if not gohelper.findChild(slot0._diffuseGo, slot7) then
		slot9 = gohelper.findChild(slot0._backgroundGo, slot7)
	end

	if not slot8 then
		logError(string.format("元件id: %s no resGo:%s", slot1.elementId, slot7))

		return
	end

	slot10, slot11, slot12 = transformhelper.getPos(slot8.transform)
	slot9 = slot9 or gohelper.clone(slot8, slot6, slot7)

	gohelper.setActive(slot8, false)
	transformhelper.setPos(slot9.transform, slot10, slot11, slot12)
	gohelper.setLayer(slot9, UnityLayer.Scene, true)
	slot3:setItemGo(slot9, slot2)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnAddElement, slot1.elementId)
end

function slot0._removeElement(slot0, slot1, slot2)
	if not slot0._elementList[slot1.elementId] then
		return
	end

	slot0._elementList[slot3] = nil

	slot4:updateInfo(slot1)
	slot4:disappear(slot2)
end

function slot0.setElementDown(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.Activity130DialogView) then
		return
	end

	slot0._elementMouseDown = slot1
end

function slot0.setScenePosSafety(slot0, slot1, slot2)
	if not slot0._sceneGo then
		return
	end

	if slot1.x < slot0._mapMinX then
		slot1.x = slot0._mapMinX
	elseif slot0._mapMaxX < slot1.x then
		slot1.x = slot0._mapMaxX
	end

	if slot1.y < slot0._mapMinY then
		slot1.y = slot0._mapMinY
	elseif slot0._mapMaxY < slot1.y then
		slot1.y = slot0._mapMaxY
	end

	if slot2 then
		ZProj.TweenHelper.DOLocalMove(slot0._sceneGo.transform, slot1.x, slot1.y, 0, 0.26)
	else
		slot0._sceneGo.transform.localPosition = slot1
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0._playEnterAnim(slot0)
	slot0._isPlayAnim = true

	slot0:_onPlayEnterAnim()
end

function slot0._setInitPos(slot0, slot1)
	if not slot0._mapCfg then
		return
	end

	slot3 = string.splitToNumber(slot0._mapCfg.initPos, "#")

	slot0:setScenePosSafety(Vector3(slot3[1], slot3[2], 0), slot1)
end

function slot0._onShowFinishAnimDone(slot0)
	slot0:_showElements()
end

function slot0._OnDialogReply(slot0, slot1)
	if not slot0._elementList[slot1] then
		return
	end

	slot0:_OnClickElement(slot2)
end

function slot0._OnGuideClickElement(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	if not slot0._elementList[slot2] then
		return
	end

	slot0:_OnClickElement(slot3)
end

function slot0._OnClickElement(slot0, slot1)
	slot0:_clickElement(slot1)
end

function slot0._backToLevelView(slot0)
	slot0:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function slot0._clickElement(slot0, slot1, slot2)
	slot3 = slot1 and slot1._info or slot2
	slot4 = slot3.elementId

	if slot3:getType() == Activity130Enum.ElementType.Battle then
		-- Nothing
	elseif slot5 == Activity130Enum.ElementType.General then
		AudioMgr.instance:trigger(tonumber(slot3.config.param))
		Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot4)
	elseif slot5 == Activity130Enum.ElementType.Respawn then
		-- Nothing
	elseif slot5 == Activity130Enum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		Activity130Controller.instance:openActivity130DialogView({
			elementInfo = slot3,
			isClient = false
		})
	elseif slot5 == Activity130Enum.ElementType.TaskTip then
		Activity130Controller.instance:dispatchEvent(Activity130Event.RefreshTaskTip, slot3)
	elseif slot5 == Activity130Enum.ElementType.SetValue then
		Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockCollect, slot3)
	elseif slot5 == Activity130Enum.ElementType.UnlockDecrypt then
		Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockDecrypt, slot3)
	elseif slot5 == Activity130Enum.ElementType.CheckDecrypt then
		Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, slot3)
	elseif slot5 == Activity130Enum.ElementType.ChangeScene then
		slot0:_changeScene(tonumber(string.split(slot3.config.param, "#")[slot3.index + 1]), slot3)
	end
end

function slot0._changeScene(slot0, slot1, slot2)
	if not slot0._mainPrefabs[slot1] then
		logError("配置了一个不存在的场景标记！请检查配置")

		return
	end

	gohelper.setActive(slot0._sceneGo, false)

	slot0._sceneGo = slot0._mainPrefabs[slot1]

	gohelper.setActive(slot0._sceneGo, true)

	slot0._backgroundGo = gohelper.findChild(slot0._sceneGo, "root/BackGround")
	slot0._diffuseGo = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse")

	if not slot0._elementRoots[slot1] then
		slot0._elementRoots[slot1] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(slot0._sceneGo, slot0._elementRoots[slot1])
	end

	slot0._anim = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if slot2 and slot2.elementId then
		Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot2.elementId, slot0._onGeneralSuccess, slot0)
	end
end

function slot0._onRestartSet(slot0)
	slot0:_clearElements()
	slot0:_changeScene(1)
	slot0:_showElements()
end

function slot0._onGeneralSuccess(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot0:_showElements()
end

function slot0._addEvents(slot0)
	slot0._click:AddClickUpListener(slot0._clickUp, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0._onGamepadKeyDown, slot0)
	end

	slot0:addEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, slot0._showElements, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, slot0._showElements, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._showElements, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnClickElement, slot0._OnClickElement, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.AutoStartElement, slot0._checkInitElements, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._checkInitElements, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, slot0._backToLevelView, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.GuideClickElement, slot0._OnGuideClickElement, slot0)
end

function slot0._removeEvents(slot0)
	if slot0._click then
		slot0._click:RemoveClickUpListener()
	end

	if GamepadController.instance:isOpen() then
		slot0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0._onGamepadKeyDown, slot0)
	end

	slot0:removeEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, slot0._showElements, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, slot0._showElements, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._showElements, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnClickElement, slot0._OnClickElement, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.AutoStartElement, slot0._checkInitElements, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._checkInitElements, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, slot0._backToLevelView, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.GuideClickElement, slot0._OnGuideClickElement, slot0)
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end
end

function slot0.playAmbientAudio(slot0)
	slot0:closeAmbientSound()
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_on)

	slot0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.ActivityMapAmbientBgm)
end

function slot0.closeAmbientSound(slot0)
	if slot0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(slot0._ambientAudioId)
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_off)

		slot0._ambientAudioId = nil
	end
end

return slot0
