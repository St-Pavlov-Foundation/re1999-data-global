module("modules.logic.versionactivity1_4.act131.view.Activity131Map", package.seeall)

local var_0_0 = class("Activity131Map", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")

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
	arg_4_0._tempVector = Vector3()
	arg_4_0._sceneIndex = 1
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gofullscreen)

	arg_4_0:_initMap()
	arg_4_0:_addEvents()
end

function var_0_0._initMap(arg_5_0)
	local var_5_0 = CameraMgr.instance:getSceneRoot()

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("Activity131Map")

	local var_5_1 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_2, var_5_3, var_5_4 = transformhelper.getLocalPos(var_5_1)

	transformhelper.setLocalPos(arg_5_0._sceneRoot.transform, 0.5, var_5_3, 0)
	gohelper.addChild(var_5_0, arg_5_0._sceneRoot)

	local var_5_5 = string.split(Activity131Model.instance:getCurMapConfig().scenes, "#")
	local var_5_6 = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_mapinteractiveitem.prefab"

	arg_5_0._mapLoader = MultiAbLoader.New()

	for iter_5_0, iter_5_1 in ipairs(var_5_5) do
		arg_5_0._mapLoader:addPath(iter_5_1 .. ".prefab")
	end

	arg_5_0._mapLoader:addPath(var_5_6)
	arg_5_0._mapLoader:startLoad(function(arg_6_0)
		arg_5_0._mainPrefabs = {}
		arg_5_0._elementRoots = {}

		for iter_6_0, iter_6_1 in ipairs(var_5_5) do
			local var_6_0 = arg_5_0._mapLoader:getAssetItem(iter_6_1 .. ".prefab"):GetResource(iter_6_1 .. ".prefab")
			local var_6_1 = gohelper.clone(var_6_0, arg_5_0._sceneRoot)

			gohelper.setActive(var_6_1, false)
			table.insert(arg_5_0._mainPrefabs, var_6_1)
		end

		local var_6_2 = Activity131Model.instance:getCurEpisodeId()
		local var_6_3 = Activity131Model.instance:getEpisodeCurSceneIndex(var_6_2)

		arg_5_0._sceneGo = arg_5_0._mainPrefabs[var_6_3]

		gohelper.setActive(arg_5_0._sceneGo, true)

		arg_5_0._sceneAnimator = arg_5_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		arg_5_0._sceneAnimator:Play("open", 0, 0)

		arg_5_0._backgroundGo = gohelper.findChild(arg_5_0._sceneGo, "root/BackGround")
		arg_5_0._diffuseGo = gohelper.findChild(arg_5_0._sceneGo, "Obj-Plant/all/diffuse")
		arg_5_0._elementRoots[var_6_3] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(arg_5_0._mainPrefabs[var_6_3], arg_5_0._elementRoots[var_6_3])

		arg_5_0._anim = arg_5_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		local var_6_4 = arg_5_0._mapLoader:getAssetItem(var_5_6)

		arg_5_0._itemPrefab = var_6_4:GetResource(var_5_6)

		arg_5_0:_initElements()

		arg_5_0._sceneLoaded = true

		if arg_5_0._needCheckInit then
			arg_5_0:_checkInitElements()

			arg_5_0._needCheckInit = false
		end
	end)
end

function var_0_0._initElements(arg_7_0)
	arg_7_0:_showElements()
end

function var_0_0._checkInitElements(arg_8_0)
	if not arg_8_0._sceneLoaded then
		arg_8_0._needCheckInit = true

		return
	end

	arg_8_0._needCheckInit = false

	local var_8_0 = Activity131Model.instance:getCurMapInfo()
	local var_8_1 = VersionActivity1_4Enum.ActivityId.Role6
	local var_8_2 = Activity131Model.instance:getCurEpisodeId()

	if var_8_0.progress == Activity131Enum.ProgressType.AfterStory then
		Activity131Controller.instance:dispatchEvent(Activity131Event.ShowFinish)

		return
	end

	local var_8_3 = Activity131Config.instance:getActivity131EpisodeCo(var_8_1, var_8_2)

	if var_8_3.elements ~= "" then
		local var_8_4 = string.splitToNumber(var_8_3.elements, "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_4) do
			for iter_8_2, iter_8_3 in pairs(var_8_0.act131Elements) do
				if iter_8_3.elementId == iter_8_1 and not iter_8_3.isFinish then
					arg_8_0:_clickElement(nil, iter_8_3)

					return
				end
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(var_8_0.act131Elements) do
		if not iter_8_5.isFinish then
			if #iter_8_5.typeList >= iter_8_5.index and iter_8_5.index ~= 0 then
				arg_8_0:_clickElement(nil, iter_8_5)

				return
			elseif iter_8_5.index == 0 and iter_8_5.config.res == "" then
				arg_8_0:_clickElement(nil, iter_8_5)

				return
			end
		end
	end
end

function var_0_0._clickUp(arg_9_0)
	local var_9_0 = arg_9_0._elementMouseDown

	arg_9_0._elementMouseDown = nil

	if var_9_0 and var_9_0:isValid() then
		var_9_0:onClick()
	end
end

function var_0_0._onGamepadKeyDown(arg_10_0, arg_10_1)
	if arg_10_1 == GamepadEnum.KeyCode.A then
		local var_10_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_10_1 = UnityEngine.Physics2D.RaycastAll(var_10_0.origin, var_10_0.direction)
		local var_10_2 = var_10_1.Length - 1

		for iter_10_0 = 0, var_10_2 do
			local var_10_3 = var_10_1[iter_10_0]
			local var_10_4 = MonoHelper.getLuaComFromGo(var_10_3.transform.parent.gameObject, Activity131MapElement)

			if var_10_4 then
				var_10_4:onDown()

				return
			end
		end
	end
end

function var_0_0._onSceneClose(arg_11_0)
	return
end

function var_0_0._initCamera(arg_12_0)
	local var_12_0 = CameraMgr.instance:getMainCamera()

	transformhelper.setLocalRotation(var_12_0.transform, 0, 0, 0)

	local var_12_1 = GameUtil.getAdapterScale(true)

	var_12_0.orthographic = true
	var_12_0.orthographicSize = 7.4 * var_12_1
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:playAmbientAudio()
	MainCameraMgr.instance:addView(ViewName.Activity131GameView, arg_13_0._initCamera, nil, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:_clearElements()
	arg_14_0:_removeEvents()
	arg_14_0:closeAmbientSound()
end

function var_0_0._clearElements(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._elementList) do
		iter_15_1:dispose(true)
	end

	arg_15_0._elementList = arg_15_0:getUserDataTb_()
end

function var_0_0._showElements(arg_16_0)
	local var_16_0 = Activity131Model.instance:getCurEpisodeId()
	local var_16_1 = Activity131Model.instance:getEpisodeElements(var_16_0)
	local var_16_2 = VersionActivity1_4Enum.ActivityId.Role6
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_4 = Activity131Config.instance:getActivity131ElementCo(var_16_2, iter_16_1.elementId).res

		if not string.nilorempty(var_16_4) then
			local var_16_5 = var_16_3[var_16_4] or {}

			if iter_16_1:isAvailable() or arg_16_0._elementList[iter_16_1.elementId] then
				table.insert(var_16_5, iter_16_1)
			end

			var_16_3[var_16_4] = var_16_5
		end
	end

	local var_16_6 = {}

	for iter_16_2 = #var_16_1, 1, -1 do
		local var_16_7 = var_16_1[iter_16_2]
		local var_16_8 = var_16_3[Activity131Config.instance:getActivity131ElementCo(var_16_2, var_16_7.elementId).res]
		local var_16_9 = var_16_8 and #var_16_8 or 0

		if not var_16_7:isAvailable() then
			arg_16_0:_removeElement(var_16_7, var_16_9 <= 1)
		else
			table.insert(var_16_6, var_16_7)
		end
	end

	for iter_16_3 = #var_16_6, 1, -1 do
		local var_16_10 = var_16_6[iter_16_3]
		local var_16_11 = var_16_3[Activity131Config.instance:getActivity131ElementCo(var_16_2, var_16_10.elementId).res]
		local var_16_12 = var_16_11 and #var_16_11 or 0

		arg_16_0:_addElement(var_16_10, var_16_12 <= 1)
	end
end

function var_0_0._addElement(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._elementList[arg_17_1.elementId]

	if var_17_0 then
		var_17_0:updateInfo(arg_17_1)

		return
	end

	local var_17_1 = Activity131Model.instance:getCurEpisodeId()
	local var_17_2 = Activity131Model.instance:getEpisodeCurSceneIndex(var_17_1)
	local var_17_3 = gohelper.findChild(arg_17_0._elementRoots[var_17_2], tostring(arg_17_1.elementId))

	if not var_17_3 then
		var_17_3 = UnityEngine.GameObject.New(tostring(arg_17_1.elementId))

		gohelper.addChild(arg_17_0._elementRoots[var_17_2], var_17_3)
	else
		MonoHelper.removeLuaComFromGo(var_17_3, Activity131MapElement)
		gohelper.destroyAllChildren(var_17_3)
	end

	local var_17_4 = MonoHelper.addLuaComOnceToGo(var_17_3, Activity131MapElement, {
		arg_17_1,
		arg_17_0
	})

	arg_17_0._elementList[arg_17_1.elementId] = var_17_4

	local var_17_5 = var_17_4:getResName()

	if string.nilorempty(var_17_5) then
		return
	end

	local var_17_6 = gohelper.findChild(arg_17_0._diffuseGo, var_17_5)
	local var_17_7

	if not var_17_6 then
		var_17_6 = gohelper.findChild(arg_17_0._backgroundGo, var_17_5)
		var_17_7 = var_17_6
	end

	if not var_17_6 then
		logError(string.format("元件id: %s no resGo:%s", arg_17_1.elementId, var_17_5))

		return
	end

	local var_17_8, var_17_9, var_17_10 = transformhelper.getPos(var_17_6.transform)

	var_17_7 = var_17_7 or gohelper.clone(var_17_6, var_17_3, var_17_5)

	gohelper.setActive(var_17_6, false)
	transformhelper.setPos(var_17_7.transform, var_17_8, var_17_9, var_17_10)
	gohelper.setLayer(var_17_7, UnityLayer.Scene, true)
	var_17_4:setItemGo(var_17_7, arg_17_2)
end

function var_0_0._removeElement(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.elementId
	local var_18_1 = arg_18_0._elementList[var_18_0]

	if not var_18_1 then
		return
	end

	arg_18_0._elementList[var_18_0] = nil

	var_18_1:updateInfo(arg_18_1)
	var_18_1:disappear(arg_18_2)
end

function var_0_0.setElementDown(arg_19_0, arg_19_1)
	if ViewMgr.instance:isOpen(ViewName.Activity131DialogView) then
		return
	end

	arg_19_0._elementMouseDown = arg_19_1
end

function var_0_0.setScenePosSafety(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0._sceneGo then
		return
	end

	if arg_20_1.x < arg_20_0._mapMinX then
		arg_20_1.x = arg_20_0._mapMinX
	elseif arg_20_1.x > arg_20_0._mapMaxX then
		arg_20_1.x = arg_20_0._mapMaxX
	end

	if arg_20_1.y < arg_20_0._mapMinY then
		arg_20_1.y = arg_20_0._mapMinY
	elseif arg_20_1.y > arg_20_0._mapMaxY then
		arg_20_1.y = arg_20_0._mapMaxY
	end

	if arg_20_2 then
		ZProj.TweenHelper.DOLocalMove(arg_20_0._sceneGo.transform, arg_20_1.x, arg_20_1.y, 0, 0.26)
	else
		arg_20_0._sceneGo.transform.localPosition = arg_20_1
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0._playEnterAnim(arg_22_0)
	arg_22_0._isPlayAnim = true

	arg_22_0:_onPlayEnterAnim()
end

function var_0_0._setInitPos(arg_23_0, arg_23_1)
	if not arg_23_0._mapCfg then
		return
	end

	local var_23_0 = arg_23_0._mapCfg.initPos
	local var_23_1 = string.splitToNumber(var_23_0, "#")

	arg_23_0:setScenePosSafety(Vector3(var_23_1[1], var_23_1[2], 0), arg_23_1)
end

function var_0_0._onShowFinishAnimDone(arg_24_0)
	arg_24_0:_showElements()
end

function var_0_0._OnDialogReply(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._elementList[arg_25_1]

	if not var_25_0 then
		return
	end

	arg_25_0:_OnClickElement(var_25_0)
end

function var_0_0._OnGuideClickElement(arg_26_0, arg_26_1)
	local var_26_0 = tonumber(arg_26_1)

	if not var_26_0 then
		return
	end

	local var_26_1 = arg_26_0._elementList[var_26_0]

	if not var_26_1 then
		return
	end

	arg_26_0:_OnClickElement(var_26_1)
end

function var_0_0._OnClickElement(arg_27_0, arg_27_1)
	arg_27_0:_clickElement(arg_27_1)
end

function var_0_0._clickElement(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1 and arg_28_1._info or arg_28_2
	local var_28_1 = var_28_0.elementId
	local var_28_2 = var_28_0:getType()

	if var_28_2 == Activity131Enum.ElementType.Battle then
		Activity131Controller.instance:dispatchEvent(Activity131Event.TriggerBattleElement, var_28_0)
	elseif var_28_2 == Activity131Enum.ElementType.General then
		local var_28_3 = tonumber(var_28_0.config.param)

		AudioMgr.instance:trigger(var_28_3)

		local var_28_4 = VersionActivity1_4Enum.ActivityId.Role6
		local var_28_5 = Activity131Model.instance:getCurEpisodeId()

		Activity131Rpc.instance:sendAct131GeneralRequest(var_28_4, var_28_5, var_28_1)
	elseif var_28_2 == Activity131Enum.ElementType.Respawn then
		-- block empty
	elseif var_28_2 == Activity131Enum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		Activity131Controller.instance:openActivity131DialogView(var_28_0)
	elseif var_28_2 == Activity131Enum.ElementType.TaskTip then
		Activity131Controller.instance:dispatchEvent(Activity131Event.RefreshTaskTip, var_28_0)
	elseif var_28_2 == Activity131Enum.ElementType.SetValue then
		Activity131Controller.instance:dispatchEvent(Activity131Event.UnlockCollect, var_28_0)
	elseif var_28_2 == Activity131Enum.ElementType.ChangeScene then
		local var_28_6 = tonumber(string.split(var_28_0.config.param, "#")[var_28_0.index + 1])

		arg_28_0:_changeScene(var_28_6, var_28_0)
	elseif var_28_2 == Activity131Enum.ElementType.LogStart or var_28_2 == Activity131Enum.ElementType.LogEnd then
		Activity131Controller.instance:dispatchEvent(Activity131Event.TriggerLogElement, var_28_0)
	end
end

function var_0_0._changeScene(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0._mainPrefabs[arg_29_1] then
		logError("配置了一个不存在的场景标记！请检查配置")

		return
	end

	gohelper.setActive(arg_29_0._sceneGo, false)

	arg_29_0._sceneGo = arg_29_0._mainPrefabs[arg_29_1]

	gohelper.setActive(arg_29_0._sceneGo, true)

	arg_29_0._backgroundGo = gohelper.findChild(arg_29_0._sceneGo, "root/BackGround")
	arg_29_0._diffuseGo = gohelper.findChild(arg_29_0._sceneGo, "Obj-Plant/all/diffuse")

	if not arg_29_0._elementRoots[arg_29_1] then
		arg_29_0._elementRoots[arg_29_1] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(arg_29_0._sceneGo, arg_29_0._elementRoots[arg_29_1])
	end

	arg_29_0._anim = arg_29_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if arg_29_2 and arg_29_2.elementId then
		local var_29_0 = VersionActivity1_4Enum.ActivityId.Role6
		local var_29_1 = Activity131Model.instance:getCurEpisodeId()

		Activity131Rpc.instance:sendAct131GeneralRequest(var_29_0, var_29_1, arg_29_2.elementId, arg_29_0._onGeneralSuccess, arg_29_0)
	end
end

function var_0_0._onRestartSet(arg_30_0)
	arg_30_0:_clearElements()
	arg_30_0:_changeScene(1)
	arg_30_0:_showElements()
end

function var_0_0._onGeneralSuccess(arg_31_0)
	arg_31_0:_showElements()
end

function var_0_0._addEvents(arg_32_0)
	arg_32_0._click:AddClickUpListener(arg_32_0._clickUp, arg_32_0)

	if GamepadController.instance:isOpen() then
		arg_32_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_32_0._onGamepadKeyDown, arg_32_0)
	end

	arg_32_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_32_0._onSceneClose, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_32_0._showElements, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, arg_32_0._showElements, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, arg_32_0._onRestartSet, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_32_0._showElements, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnClickElement, arg_32_0._OnClickElement, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.AutoStartElement, arg_32_0._checkInitElements, arg_32_0)
	arg_32_0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_32_0._checkInitElements, arg_32_0)
end

function var_0_0._removeEvents(arg_33_0)
	if arg_33_0._click then
		arg_33_0._click:RemoveClickUpListener()
	end

	if GamepadController.instance:isOpen() then
		arg_33_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_33_0._onGamepadKeyDown, arg_33_0)
	end

	arg_33_0:removeEventCb(MainController.instance, MainEvent.OnSceneClose, arg_33_0._onSceneClose, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_33_0._showElements, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, arg_33_0._showElements, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, arg_33_0._onRestartSet, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_33_0._showElements, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnClickElement, arg_33_0._OnClickElement, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.AutoStartElement, arg_33_0._checkInitElements, arg_33_0)
	arg_33_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_33_0._checkInitElements, arg_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	gohelper.destroy(arg_34_0._sceneRoot)

	if arg_34_0._mapLoader then
		arg_34_0._mapLoader:dispose()

		arg_34_0._mapLoader = nil
	end
end

function var_0_0.playAmbientAudio(arg_35_0)
	arg_35_0:closeAmbientSound()
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_on)

	arg_35_0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.ActivityMapAmbientBgm)
end

function var_0_0.closeAmbientSound(arg_36_0)
	if arg_36_0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(arg_36_0._ambientAudioId)
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_off)

		arg_36_0._ambientAudioId = nil
	end
end

return var_0_0
