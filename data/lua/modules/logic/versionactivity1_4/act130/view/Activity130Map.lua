module("modules.logic.versionactivity1_4.act130.view.Activity130Map", package.seeall)

local var_0_0 = class("Activity130Map", BaseView)

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

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("Activity130Map")

	local var_5_1 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_2, var_5_3, var_5_4 = transformhelper.getLocalPos(var_5_1)

	transformhelper.setLocalPos(arg_5_0._sceneRoot.transform, 0.5, var_5_3, 0)
	gohelper.addChild(var_5_0, arg_5_0._sceneRoot)

	local var_5_5 = string.split(Activity130Model.instance:getCurMapConfig().scenes, "#")
	local var_5_6 = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_mapinteractiveitem.prefab"

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

		local var_6_2 = Activity130Model.instance:getCurEpisodeId()
		local var_6_3 = Activity130Model.instance:getEpisodeCurSceneIndex(var_6_2)

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

	local var_8_0 = Activity130Model.instance:getCurMapInfo()
	local var_8_1 = VersionActivity1_4Enum.ActivityId.Role37
	local var_8_2 = Activity130Model.instance:getCurEpisodeId()

	if var_8_0.progress == Activity130Enum.ProgressType.AfterStory then
		local var_8_3 = Activity130Config.instance:getActivity130EpisodeCo(var_8_1, var_8_2)

		if var_8_3.afterStoryId > 0 and not StoryModel.instance:isStoryFinished(var_8_3.afterStoryId) then
			StoryController.instance:playStory(var_8_3.afterStoryId, nil, arg_8_0._onStoryFinished, arg_8_0)
		else
			arg_8_0:_onStoryFinished()
		end

		return
	end

	local var_8_4 = Activity130Config.instance:getActivity130EpisodeCo(var_8_1, var_8_2)

	if var_8_4.elements ~= "" then
		local var_8_5 = string.splitToNumber(var_8_4.elements, "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_5) do
			for iter_8_2, iter_8_3 in pairs(var_8_0.act130Elements) do
				if iter_8_3.elementId == iter_8_1 and not iter_8_3.isFinish then
					arg_8_0:_clickElement(nil, iter_8_3)

					return
				end
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(var_8_0.act130Elements) do
		if not iter_8_5.isFinish then
			if iter_8_5:getType() == Activity130Enum.ElementType.CheckDecrypt then
				Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, iter_8_5)

				return
			elseif #iter_8_5.typeList >= iter_8_5.index and iter_8_5.index ~= 0 then
				arg_8_0:_clickElement(nil, iter_8_5)

				return
			elseif iter_8_5.index == 0 and iter_8_5.config.res == "" then
				arg_8_0:_clickElement(nil, iter_8_5)

				return
			end
		end
	end
end

function var_0_0._onStoryFinished(arg_9_0)
	local var_9_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_9_1 = Activity130Model.instance:getCurEpisodeId()

	if Activity130Config.instance:getActivity130EpisodeCo(var_9_0, var_9_1).afterStoryId > 0 then
		Activity130Rpc.instance:sendAct130StoryRequest(var_9_0, var_9_1)
	end

	if var_9_1 == Activity130Model.instance:getMaxUnlockEpisode() then
		arg_9_0:_backToLevelView()
	end
end

function var_0_0._clickUp(arg_10_0)
	local var_10_0 = arg_10_0._elementMouseDown

	arg_10_0._elementMouseDown = nil

	if var_10_0 and var_10_0:isValid() then
		var_10_0:onClick()
	end
end

function var_0_0._onGamepadKeyDown(arg_11_0, arg_11_1)
	if arg_11_1 == GamepadEnum.KeyCode.A then
		local var_11_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_11_1 = UnityEngine.Physics2D.RaycastAll(var_11_0.origin, var_11_0.direction)
		local var_11_2 = var_11_1.Length - 1

		for iter_11_0 = 0, var_11_2 do
			local var_11_3 = var_11_1[iter_11_0]
			local var_11_4 = MonoHelper.getLuaComFromGo(var_11_3.transform.parent.gameObject, Activity130MapElement)

			if var_11_4 then
				var_11_4:onDown()

				return
			end
		end
	end
end

function var_0_0._onSceneClose(arg_12_0)
	return
end

function var_0_0._initCamera(arg_13_0)
	local var_13_0 = CameraMgr.instance:getMainCamera()

	transformhelper.setLocalRotation(var_13_0.transform, 0, 0, 0)

	local var_13_1 = GameUtil.getAdapterScale(true)

	var_13_0.orthographic = true
	var_13_0.orthographicSize = 7.4 * var_13_1
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:playAmbientAudio()
	MainCameraMgr.instance:addView(ViewName.Activity130GameView, arg_14_0._initCamera, nil, arg_14_0)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:_clearElements()
	arg_15_0:_removeEvents()
	arg_15_0:closeAmbientSound()
end

function var_0_0._clearElements(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._elementList) do
		iter_16_1:dispose()
	end

	arg_16_0._elementList = arg_16_0:getUserDataTb_()
end

function var_0_0._showElements(arg_17_0)
	local var_17_0 = Activity130Model.instance:getCurEpisodeId()
	local var_17_1 = Activity130Model.instance:getEpisodeElements(var_17_0)
	local var_17_2 = VersionActivity1_4Enum.ActivityId.Role37
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_4 = Activity130Config.instance:getActivity130ElementCo(var_17_2, iter_17_1.elementId).res

		if not string.nilorempty(var_17_4) then
			local var_17_5 = var_17_3[var_17_4] or {}

			if iter_17_1:isAvailable() or arg_17_0._elementList[iter_17_1.elementId] then
				table.insert(var_17_5, iter_17_1)
			end

			var_17_3[var_17_4] = var_17_5
		end
	end

	local var_17_6 = {}

	for iter_17_2 = #var_17_1, 1, -1 do
		local var_17_7 = var_17_1[iter_17_2]
		local var_17_8 = var_17_3[Activity130Config.instance:getActivity130ElementCo(var_17_2, var_17_7.elementId).res]
		local var_17_9 = var_17_8 and #var_17_8 or 0

		if not var_17_7:isAvailable() then
			arg_17_0:_removeElement(var_17_7, var_17_9 <= 1)
		else
			table.insert(var_17_6, var_17_7)
		end
	end

	for iter_17_3 = #var_17_6, 1, -1 do
		local var_17_10 = var_17_6[iter_17_3]
		local var_17_11 = var_17_3[Activity130Config.instance:getActivity130ElementCo(var_17_2, var_17_10.elementId).res]
		local var_17_12 = var_17_11 and #var_17_11 or 0

		arg_17_0:_addElement(var_17_10, var_17_12 <= 1)
	end
end

function var_0_0._addElement(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._elementList[arg_18_1.elementId]

	if var_18_0 then
		var_18_0:updateInfo(arg_18_1)

		return
	end

	local var_18_1 = Activity130Model.instance:getCurEpisodeId()
	local var_18_2 = Activity130Model.instance:getEpisodeCurSceneIndex(var_18_1)
	local var_18_3 = gohelper.findChild(arg_18_0._elementRoots[var_18_2], tostring(arg_18_1.elementId))

	if not var_18_3 then
		var_18_3 = UnityEngine.GameObject.New(tostring(arg_18_1.elementId))

		gohelper.addChild(arg_18_0._elementRoots[var_18_2], var_18_3)
	else
		MonoHelper.removeLuaComFromGo(var_18_3, Activity130MapElement)
		gohelper.destroyAllChildren(var_18_3)
	end

	local var_18_4 = MonoHelper.addLuaComOnceToGo(var_18_3, Activity130MapElement, {
		arg_18_1,
		arg_18_0
	})

	arg_18_0._elementList[arg_18_1.elementId] = var_18_4

	local var_18_5 = var_18_4:getResName()

	if string.nilorempty(var_18_5) then
		return
	end

	local var_18_6 = gohelper.findChild(arg_18_0._diffuseGo, var_18_5)
	local var_18_7

	if not var_18_6 then
		var_18_6 = gohelper.findChild(arg_18_0._backgroundGo, var_18_5)
		var_18_7 = var_18_6
	end

	if not var_18_6 then
		logError(string.format("元件id: %s no resGo:%s", arg_18_1.elementId, var_18_5))

		return
	end

	local var_18_8, var_18_9, var_18_10 = transformhelper.getPos(var_18_6.transform)

	var_18_7 = var_18_7 or gohelper.clone(var_18_6, var_18_3, var_18_5)

	gohelper.setActive(var_18_6, false)
	transformhelper.setPos(var_18_7.transform, var_18_8, var_18_9, var_18_10)
	gohelper.setLayer(var_18_7, UnityLayer.Scene, true)
	var_18_4:setItemGo(var_18_7, arg_18_2)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnAddElement, arg_18_1.elementId)
end

function var_0_0._removeElement(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.elementId
	local var_19_1 = arg_19_0._elementList[var_19_0]

	if not var_19_1 then
		return
	end

	arg_19_0._elementList[var_19_0] = nil

	var_19_1:updateInfo(arg_19_1)
	var_19_1:disappear(arg_19_2)
end

function var_0_0.setElementDown(arg_20_0, arg_20_1)
	if ViewMgr.instance:isOpen(ViewName.Activity130DialogView) then
		return
	end

	arg_20_0._elementMouseDown = arg_20_1
end

function var_0_0.setScenePosSafety(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0._sceneGo then
		return
	end

	if arg_21_1.x < arg_21_0._mapMinX then
		arg_21_1.x = arg_21_0._mapMinX
	elseif arg_21_1.x > arg_21_0._mapMaxX then
		arg_21_1.x = arg_21_0._mapMaxX
	end

	if arg_21_1.y < arg_21_0._mapMinY then
		arg_21_1.y = arg_21_0._mapMinY
	elseif arg_21_1.y > arg_21_0._mapMaxY then
		arg_21_1.y = arg_21_0._mapMaxY
	end

	if arg_21_2 then
		ZProj.TweenHelper.DOLocalMove(arg_21_0._sceneGo.transform, arg_21_1.x, arg_21_1.y, 0, 0.26)
	else
		arg_21_0._sceneGo.transform.localPosition = arg_21_1
	end
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0._playEnterAnim(arg_23_0)
	arg_23_0._isPlayAnim = true

	arg_23_0:_onPlayEnterAnim()
end

function var_0_0._setInitPos(arg_24_0, arg_24_1)
	if not arg_24_0._mapCfg then
		return
	end

	local var_24_0 = arg_24_0._mapCfg.initPos
	local var_24_1 = string.splitToNumber(var_24_0, "#")

	arg_24_0:setScenePosSafety(Vector3(var_24_1[1], var_24_1[2], 0), arg_24_1)
end

function var_0_0._onShowFinishAnimDone(arg_25_0)
	arg_25_0:_showElements()
end

function var_0_0._OnDialogReply(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._elementList[arg_26_1]

	if not var_26_0 then
		return
	end

	arg_26_0:_OnClickElement(var_26_0)
end

function var_0_0._OnGuideClickElement(arg_27_0, arg_27_1)
	local var_27_0 = tonumber(arg_27_1)

	if not var_27_0 then
		return
	end

	local var_27_1 = arg_27_0._elementList[var_27_0]

	if not var_27_1 then
		return
	end

	arg_27_0:_OnClickElement(var_27_1)
end

function var_0_0._OnClickElement(arg_28_0, arg_28_1)
	arg_28_0:_clickElement(arg_28_1)
end

function var_0_0._backToLevelView(arg_29_0)
	arg_29_0:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function var_0_0._clickElement(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 and arg_30_1._info or arg_30_2
	local var_30_1 = var_30_0.elementId
	local var_30_2 = var_30_0:getType()

	if var_30_2 == Activity130Enum.ElementType.Battle then
		-- block empty
	elseif var_30_2 == Activity130Enum.ElementType.General then
		local var_30_3 = tonumber(var_30_0.config.param)

		AudioMgr.instance:trigger(var_30_3)

		local var_30_4 = VersionActivity1_4Enum.ActivityId.Role37
		local var_30_5 = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130GeneralRequest(var_30_4, var_30_5, var_30_1)
	elseif var_30_2 == Activity130Enum.ElementType.Respawn then
		-- block empty
	elseif var_30_2 == Activity130Enum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)

		local var_30_6 = {
			elementInfo = var_30_0
		}

		var_30_6.isClient = false

		Activity130Controller.instance:openActivity130DialogView(var_30_6)
	elseif var_30_2 == Activity130Enum.ElementType.TaskTip then
		Activity130Controller.instance:dispatchEvent(Activity130Event.RefreshTaskTip, var_30_0)
	elseif var_30_2 == Activity130Enum.ElementType.SetValue then
		Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockCollect, var_30_0)
	elseif var_30_2 == Activity130Enum.ElementType.UnlockDecrypt then
		Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockDecrypt, var_30_0)
	elseif var_30_2 == Activity130Enum.ElementType.CheckDecrypt then
		Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, var_30_0)
	elseif var_30_2 == Activity130Enum.ElementType.ChangeScene then
		local var_30_7 = tonumber(string.split(var_30_0.config.param, "#")[var_30_0.index + 1])

		arg_30_0:_changeScene(var_30_7, var_30_0)
	end
end

function var_0_0._changeScene(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._mainPrefabs[arg_31_1] then
		logError("配置了一个不存在的场景标记！请检查配置")

		return
	end

	gohelper.setActive(arg_31_0._sceneGo, false)

	arg_31_0._sceneGo = arg_31_0._mainPrefabs[arg_31_1]

	gohelper.setActive(arg_31_0._sceneGo, true)

	arg_31_0._backgroundGo = gohelper.findChild(arg_31_0._sceneGo, "root/BackGround")
	arg_31_0._diffuseGo = gohelper.findChild(arg_31_0._sceneGo, "Obj-Plant/all/diffuse")

	if not arg_31_0._elementRoots[arg_31_1] then
		arg_31_0._elementRoots[arg_31_1] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(arg_31_0._sceneGo, arg_31_0._elementRoots[arg_31_1])
	end

	arg_31_0._anim = arg_31_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if arg_31_2 and arg_31_2.elementId then
		local var_31_0 = VersionActivity1_4Enum.ActivityId.Role37
		local var_31_1 = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130GeneralRequest(var_31_0, var_31_1, arg_31_2.elementId, arg_31_0._onGeneralSuccess, arg_31_0)
	end
end

function var_0_0._onRestartSet(arg_32_0)
	arg_32_0:_clearElements()
	arg_32_0:_changeScene(1)
	arg_32_0:_showElements()
end

function var_0_0._onGeneralSuccess(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 ~= 0 then
		return
	end

	arg_33_0:_showElements()
end

function var_0_0._addEvents(arg_34_0)
	arg_34_0._click:AddClickUpListener(arg_34_0._clickUp, arg_34_0)

	if GamepadController.instance:isOpen() then
		arg_34_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_34_0._onGamepadKeyDown, arg_34_0)
	end

	arg_34_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_34_0._onSceneClose, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, arg_34_0._showElements, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, arg_34_0._showElements, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, arg_34_0._onRestartSet, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_34_0._showElements, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnClickElement, arg_34_0._OnClickElement, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.AutoStartElement, arg_34_0._checkInitElements, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_34_0._checkInitElements, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, arg_34_0._backToLevelView, arg_34_0)
	arg_34_0:addEventCb(Activity130Controller.instance, Activity130Event.GuideClickElement, arg_34_0._OnGuideClickElement, arg_34_0)
end

function var_0_0._removeEvents(arg_35_0)
	if arg_35_0._click then
		arg_35_0._click:RemoveClickUpListener()
	end

	if GamepadController.instance:isOpen() then
		arg_35_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_35_0._onGamepadKeyDown, arg_35_0)
	end

	arg_35_0:removeEventCb(MainController.instance, MainEvent.OnSceneClose, arg_35_0._onSceneClose, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, arg_35_0._showElements, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, arg_35_0._showElements, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, arg_35_0._onRestartSet, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_35_0._showElements, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnClickElement, arg_35_0._OnClickElement, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.AutoStartElement, arg_35_0._checkInitElements, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_35_0._checkInitElements, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, arg_35_0._backToLevelView, arg_35_0)
	arg_35_0:removeEventCb(Activity130Controller.instance, Activity130Event.GuideClickElement, arg_35_0._OnGuideClickElement, arg_35_0)
end

function var_0_0.onDestroyView(arg_36_0)
	gohelper.destroy(arg_36_0._sceneRoot)

	if arg_36_0._mapLoader then
		arg_36_0._mapLoader:dispose()
	end
end

function var_0_0.playAmbientAudio(arg_37_0)
	arg_37_0:closeAmbientSound()
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_on)

	arg_37_0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.ActivityMapAmbientBgm)
end

function var_0_0.closeAmbientSound(arg_38_0)
	if arg_38_0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(arg_38_0._ambientAudioId)
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_off)

		arg_38_0._ambientAudioId = nil
	end
end

return var_0_0
