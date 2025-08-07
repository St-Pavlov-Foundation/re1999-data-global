module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoView", package.seeall)

local var_0_0 = class("MainSceneSwitchInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_change")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_get")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_Locked")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_card")
	arg_1_0._btntimerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_timerank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_rarerank")
	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "right/#go_SceneLogo")
	arg_1_0._goUse = gohelper.findChild(arg_1_0.viewGO, "right/#go_use")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_equip")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_close")
	arg_1_0._goHideBtn = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_HideBtn")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	arg_1_0._goSceneName = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName")
	arg_1_0._txtSceneName = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	arg_1_0._goTime = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_Time")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_Time/#txt_Time")
	arg_1_0._txtSceneDescr = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_SceneDescr")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._btnHideOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnequipOnClick(arg_4_0)
	arg_4_0._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()

	local var_4_0 = lua_scene_switch.configDict[arg_4_0._curSceneSkinId]
	local var_4_1 = lua_scene_switch.configDict[arg_4_0._selectSceneSkinId]

	StatController.instance:track(StatEnum.EventName.ChangeMainInterfaceScene, {
		[StatEnum.EventProperties.BeforeSceneName] = tostring(var_4_0.itemId),
		[StatEnum.EventProperties.AfterSceneName] = tostring(var_4_1.itemId)
	})

	local var_4_2 = var_4_1.defaultUnlock == 1 and 0 or var_4_1.itemId

	UIBlockMgrExtend.setNeedCircleMv(false)
	PlayerRpc.instance:sendSetMainSceneSkinRequest(var_4_2, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_1 ~= 0 then
			UIBlockMgrExtend.setNeedCircleMv(true)

			return
		end

		if gohelper.isNil(arg_4_0.viewGO) then
			return
		end

		UIBlockMgr.instance:startBlock("switchSceneSkin")

		arg_4_0._waitingSwitchSceneInitFinish = true

		TaskDispatcher.cancelTask(arg_4_0._delaySwitchSceneInitFinish, arg_4_0)
		TaskDispatcher.runDelay(arg_4_0._delaySwitchSceneInitFinish, arg_4_0, 8)

		arg_4_0._curSceneSkinId = arg_4_0._selectSceneSkinId

		MainSceneSwitchModel.instance:setCurSceneId(arg_4_0._selectSceneSkinId)
		MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.BeforeStartSwitchScene)
		TaskDispatcher.runDelay(arg_4_0._delaySwitchScene, arg_4_0, 0.8)
		arg_4_0._rootAnimator:Play("switch", 0, 0)
	end)
end

function var_0_0._delaySwitchScene(arg_6_0)
	MainSceneSwitchController.instance:switchScene()
end

function var_0_0._delaySwitchSceneInitFinish(arg_7_0)
	logError("MainSceneSwitchInfoView _delaySwitchSceneInitFinish timeout!")
	arg_7_0:_onSwitchSceneInitFinish()
end

function var_0_0._onSwitchSceneInitFinish(arg_8_0)
	if not arg_8_0._waitingSwitchSceneInitFinish then
		return
	end

	TaskDispatcher.cancelTask(arg_8_0._delaySwitchSceneInitFinish, arg_8_0)

	local var_8_0 = 0.6
	local var_8_1 = 0.9 - (Time.time - arg_8_0._startSwitchTime)
	local var_8_2 = math.max(0, var_8_1) + 0.3

	TaskDispatcher.cancelTask(arg_8_0._delayFinishForPlayLoadingAnim, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._delayFinishForPlayLoadingAnim, arg_8_0, var_8_2)
	TaskDispatcher.cancelTask(arg_8_0._playStory, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._playStory, arg_8_0, var_8_2 + var_8_0)
end

function var_0_0._delayFinishForPlayLoadingAnim(arg_9_0)
	arg_9_0:_showSceneStatus()
	arg_9_0:_updateBtnStatus()
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.CloseSwitchSceneLoading)
end

function var_0_0._playStory(arg_10_0)
	arg_10_0._waitingSwitchSceneInitFinish = false

	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)

	local var_10_0 = lua_scene_switch.configDict[arg_10_0._selectSceneSkinId].storyId

	if var_10_0 > 0 and not StoryModel.instance:isStoryFinished(var_10_0) then
		local var_10_1 = {}

		var_10_1.mark = true

		StoryController.instance:playStory(var_10_0, var_10_1, function()
			arg_10_0:_showTip()
			MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinishStory)
		end)

		return
	end

	arg_10_0:_showTip()
end

function var_0_0._showTip(arg_12_0)
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	arg_12_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0._btncloseOnClick(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0._btnHideOnClick(arg_14_0)
	if arg_14_0._hideTime and Time.time - arg_14_0._hideTime < 0.2 then
		return
	end

	arg_14_0._hideTime = Time.time
	arg_14_0._showUI = not arg_14_0._showUI

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, arg_14_0._showUI)
end

function var_0_0._btntimerankOnClick(arg_15_0)
	return
end

function var_0_0._btnrarerankOnClick(arg_16_0)
	return
end

function var_0_0._showSceneStatus(arg_17_0)
	arg_17_0:_updateSceneInfo()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._goswitchloading = gohelper.findChild(arg_18_0.viewGO, "loadingmainview")
	arg_18_0._switchAniamtor = arg_18_0._goswitchloading:GetComponent("Animator")
	arg_18_0._showUI = true
	arg_18_0._goright = gohelper.findChild(arg_18_0.viewGO, "right")
	arg_18_0._goLeft = gohelper.findChild(arg_18_0.viewGO, "left")
	arg_18_0._rootAnimator = arg_18_0.viewGO:GetComponent("Animator")

	gohelper.setActive(arg_18_0._btnchange, false)
	gohelper.setActive(arg_18_0._btnget, false)
	gohelper.setActive(arg_18_0._goshowing, false)
	gohelper.setActive(arg_18_0._goLocked, false)
	gohelper.setActive(arg_18_0._goSceneLogo, true)
	gohelper.setActive(arg_18_0._goUse, false)
	gohelper.setActive(arg_18_0._btnequip, false)
	arg_18_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, arg_18_0._onSceneSwitchUIVisible, arg_18_0)
	arg_18_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_18_0._onTouchScreen, arg_18_0)
	arg_18_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.BeforeStartSwitchScene, arg_18_0._onStartSwitchScene, arg_18_0)
	arg_18_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.CloseSwitchSceneLoading, arg_18_0._onCloseSwitchSceneLoading, arg_18_0)
	arg_18_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneInitFinish, arg_18_0._onSwitchSceneInitFinish, arg_18_0)
end

function var_0_0._onStartSwitchScene(arg_19_0)
	arg_19_0._startSwitchTime = Time.time

	gohelper.setActive(arg_19_0._goswitchloading, true)
	arg_19_0._switchAniamtor:Play("open", 0, 0)
end

function var_0_0._onCloseSwitchSceneLoading(arg_20_0)
	arg_20_0._switchAniamtor:Play("close", 0, 0)
end

function var_0_0._onTouchScreen(arg_21_0)
	if not arg_21_0._showUI then
		arg_21_0:_btnHideOnClick()
	end
end

function var_0_0._updateBtnStatus(arg_22_0)
	if MainSceneSwitchModel.getSceneStatus(arg_22_0._selectSceneSkinId) ~= MainSceneSwitchEnum.SceneStutas.Unlock then
		return
	end

	local var_22_0 = arg_22_0._selectSceneSkinId == MainSceneSwitchModel.instance:getCurSceneId()

	gohelper.setActive(arg_22_0._btnequip, not var_22_0)
	gohelper.setActive(arg_22_0._goUse, var_22_0)
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0._selectSceneSkinId = arg_23_0.viewParam.sceneSkinId
	arg_23_0._materialDataMOList = arg_23_0.viewParam.materialDataMOList

	arg_23_0:_showSceneStatus()
	arg_23_0:_updateBtnStatus()

	if not arg_23_0.viewParam.noInfoEffect then
		arg_23_0._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end
end

function var_0_0.onClose(arg_24_0)
	if arg_24_0._materialDataMOList and #arg_24_0._materialDataMOList == 1 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_24_0._materialDataMOList)
	end
end

function var_0_0._onSceneSwitchUIVisible(arg_25_0, arg_25_1)
	arg_25_0._rootAnimator:Play(arg_25_1 and "open" or "close", 0, 0)
end

function var_0_0._updateSceneInfo(arg_26_0)
	local var_26_0 = lua_scene_switch.configDict[arg_26_0._selectSceneSkinId]

	if not var_26_0 then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, arg_26_0._selectSceneSkinId)

	local var_26_1 = var_26_0.itemId
	local var_26_2 = lua_item.configDict[var_26_1]

	if not var_26_2 then
		return
	end

	arg_26_0._txtSceneName.text = var_26_2.name
	arg_26_0._txtSceneDescr.text = var_26_2.desc

	gohelper.setActive(arg_26_0._goTime, true)

	if var_26_0.defaultUnlock == 1 then
		local var_26_3 = PlayerModel.instance:getPlayinfo()
		local var_26_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_26_3.registerTime / 1000))

		arg_26_0._txtTime.text = string.format(luaLang("receive_time"), var_26_4)
	else
		local var_26_5 = ItemModel.instance:getById(var_26_1)

		if var_26_5 and var_26_5.quantity > 0 and var_26_5.lastUpdateTime then
			local var_26_6 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_26_5.lastUpdateTime / 1000))

			arg_26_0._txtTime.text = string.format(luaLang("receive_time"), var_26_6)
		else
			arg_26_0._txtTime.text = ""

			gohelper.setActive(arg_26_0._goTime, false)
		end
	end
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
