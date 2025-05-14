module("modules.logic.mainsceneswitch.view.MainSceneSwitchView", package.seeall)

local var_0_0 = class("MainSceneSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_change")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_get")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_Locked")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_card")
	arg_1_0._btntimerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_timerank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_rarerank")
	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "right/#go_SceneLogo")
	arg_1_0._goHideBtn = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_HideBtn")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_show")
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
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	arg_2_0._btntimerank:AddClickListener(arg_2_0._btntimerankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._btnHideOnClick, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._btnShowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	arg_3_0._btntimerank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
end

function var_0_0._btngetOnClick(arg_4_0)
	local var_4_0 = lua_scene_switch.configDict[arg_4_0._selectSceneSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, var_4_0.itemId)
end

function var_0_0._btnHideOnClick(arg_5_0)
	if arg_5_0._hideTime and Time.time - arg_5_0._hideTime < 0.2 then
		return
	end

	arg_5_0._hideTime = Time.time
	arg_5_0._showUI = not arg_5_0._showUI

	gohelper.setActive(arg_5_0._btnShow, not arg_5_0._showUI)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SceneSwitchUIVisible, arg_5_0._showUI)
end

function var_0_0._btnShowOnClick(arg_6_0)
	arg_6_0:_btnHideOnClick()
end

function var_0_0._btnchangeOnClick(arg_7_0)
	local var_7_0 = lua_scene_switch.configDict[arg_7_0._curSceneSkinId]
	local var_7_1 = lua_scene_switch.configDict[arg_7_0._selectSceneSkinId]

	StatController.instance:track(StatEnum.EventName.ChangeMainInterfaceScene, {
		[StatEnum.EventProperties.BeforeSceneName] = tostring(var_7_0.itemId),
		[StatEnum.EventProperties.AfterSceneName] = tostring(var_7_1.itemId)
	})

	local var_7_2 = var_7_1.defaultUnlock == 1 and 0 or var_7_1.itemId

	UIBlockMgrExtend.setNeedCircleMv(false)
	PlayerRpc.instance:sendSetMainSceneSkinRequest(var_7_2, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_1 ~= 0 then
			UIBlockMgrExtend.setNeedCircleMv(true)

			return
		end

		if gohelper.isNil(arg_7_0.viewGO) then
			return
		end

		UIBlockMgr.instance:startBlock("switchSceneSkin")

		arg_7_0._waitingSwitchSceneInitFinish = true

		TaskDispatcher.cancelTask(arg_7_0._delaySwitchSceneInitFinish, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._delaySwitchSceneInitFinish, arg_7_0, 8)

		arg_7_0._curSceneSkinId = arg_7_0._selectSceneSkinId

		MainSceneSwitchModel.instance:setCurSceneId(arg_7_0._selectSceneSkinId)
		MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.BeforeStartSwitchScene)
		TaskDispatcher.runDelay(arg_7_0._delaySwitchScene, arg_7_0, 0.8)
		arg_7_0._rootAnimator:Play("switch", 0, 0)
	end)
end

function var_0_0._delaySwitchScene(arg_9_0)
	MainSceneSwitchController.instance:switchScene()
end

function var_0_0._btntimerankOnClick(arg_10_0)
	return
end

function var_0_0._btnrarerankOnClick(arg_11_0)
	return
end

function var_0_0._showSceneStatus(arg_12_0)
	local var_12_0 = MainSceneSwitchModel.getSceneStatus(arg_12_0._selectSceneSkinId)
	local var_12_1 = arg_12_0._selectSceneSkinId == arg_12_0._curSceneSkinId
	local var_12_2 = var_12_0 == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(arg_12_0._btnchange, not var_12_1 and var_12_2)
	gohelper.setActive(arg_12_0._btnget, not var_12_1 and var_12_0 == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(arg_12_0._goshowing, var_12_1 and var_12_2)
	gohelper.setActive(arg_12_0._goLocked, not var_12_1 and var_12_0 == MainSceneSwitchEnum.SceneStutas.Lock)
	arg_12_0:_updateSceneInfo()
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._showUI = true
	arg_13_0._goright = gohelper.findChild(arg_13_0.viewGO, "right")
	arg_13_0._goLeft = gohelper.findChild(arg_13_0.viewGO, "left")
	arg_13_0._rootAnimator = arg_13_0.viewGO:GetComponent("Animator")

	gohelper.setActive(arg_13_0._btnShow, false)
	gohelper.addUIClickAudio(arg_13_0._btnchange, AudioEnum.MainSceneSkin.play_ui_main_fit_scene)
	gohelper.setActive(arg_13_0._btnchange, false)
	gohelper.setActive(arg_13_0._btnget, false)
	gohelper.setActive(arg_13_0._goshowing, false)
	gohelper.setActive(arg_13_0._goLocked, false)
	gohelper.setActive(arg_13_0._goSceneLogo, false)

	arg_13_0._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()
	arg_13_0._selectSceneSkinId = arg_13_0._curSceneSkinId

	MainSceneSwitchListModel.instance:initList()
	arg_13_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ClickSwitchItem, arg_13_0._onClickSwitchItem, arg_13_0)
	arg_13_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, arg_13_0._onSceneSwitchUIVisible, arg_13_0)
	arg_13_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneInitFinish, arg_13_0._onSwitchSceneInitFinish, arg_13_0)
	arg_13_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_13_0._onStartSwitchScene, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)
end

function var_0_0._onCloseView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.MainSceneSwitchInfoView then
		arg_14_0:_showSceneStatus()
		MainSceneSwitchListModel.instance:onModelUpdate()
	end
end

function var_0_0._onStartSwitchScene(arg_15_0)
	arg_15_0._startSwitchTime = Time.time
end

function var_0_0._delaySwitchSceneInitFinish(arg_16_0)
	logError("MainSceneSwitchView _delaySwitchSceneInitFinish timeout!")
	arg_16_0:_onSwitchSceneInitFinish()
end

function var_0_0._onSwitchSceneInitFinish(arg_17_0)
	if not arg_17_0._waitingSwitchSceneInitFinish then
		return
	end

	TaskDispatcher.cancelTask(arg_17_0._delaySwitchSceneInitFinish, arg_17_0)

	local var_17_0 = 0.6
	local var_17_1 = 0.9 - (Time.time - arg_17_0._startSwitchTime)
	local var_17_2 = math.max(0, var_17_1) + 0.3

	TaskDispatcher.cancelTask(arg_17_0._delayFinishForPlayLoadingAnim, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._delayFinishForPlayLoadingAnim, arg_17_0, var_17_2)
	TaskDispatcher.cancelTask(arg_17_0._playStory, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._playStory, arg_17_0, var_17_2 + var_17_0)
end

function var_0_0._delayFinishForPlayLoadingAnim(arg_18_0)
	arg_18_0:_showSceneStatus()
	MainSceneSwitchListModel.instance:refreshScroll()
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.CloseSwitchSceneLoading)
end

function var_0_0._playStory(arg_19_0)
	arg_19_0._waitingSwitchSceneInitFinish = false

	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)

	local var_19_0 = lua_scene_switch.configDict[arg_19_0._selectSceneSkinId].storyId

	if var_19_0 > 0 and not StoryModel.instance:isStoryFinished(var_19_0) then
		local var_19_1 = {}

		var_19_1.mark = true

		StoryController.instance:playStory(var_19_0, var_19_1, function()
			arg_19_0:_showTip()
			MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinishStory)
		end)

		return
	end

	arg_19_0:_showTip()
end

function var_0_0._showTip(arg_21_0)
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	arg_21_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0.onOpenFinish(arg_22_0)
	local var_22_0 = MainSceneSwitchListModel.instance:getList()
	local var_22_1 = 1

	arg_22_0:_setSelectedItemMo(var_22_0[var_22_1], var_22_1)
	MainSceneSwitchController.closeReddot()
end

function var_0_0._onSceneSwitchUIVisible(arg_23_0, arg_23_1)
	arg_23_0._rootAnimator:Play(arg_23_1 and "open" or "close", 0, 0)
end

function var_0_0._onClickSwitchItem(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:_setSelectedItemMo(arg_24_1, arg_24_2)
end

function var_0_0._setSelectedItemMo(arg_25_0, arg_25_1, arg_25_2)
	MainSceneSwitchListModel.instance:selectCellIndex(arg_25_2)

	arg_25_0._selectSceneSkinId = arg_25_1.id

	arg_25_0:_showSceneStatus()
end

function var_0_0.onTabSwitchOpen(arg_26_0)
	MainHeroView.resetPostProcessBlur()
	arg_26_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0._updateSceneInfo(arg_27_0)
	local var_27_0 = lua_scene_switch.configDict[arg_27_0._selectSceneSkinId]

	if not var_27_0 then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowSceneInfo, arg_27_0._selectSceneSkinId)

	local var_27_1 = var_27_0.itemId
	local var_27_2 = lua_item.configDict[var_27_1]

	if not var_27_2 then
		return
	end

	arg_27_0._txtSceneName.text = var_27_2.name
	arg_27_0._txtSceneDescr.text = var_27_2.desc

	gohelper.setActive(arg_27_0._goTime, true)

	if var_27_0.defaultUnlock == 1 then
		local var_27_3 = PlayerModel.instance:getPlayinfo()
		local var_27_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_27_3.registerTime / 1000))

		arg_27_0._txtTime.text = string.format(luaLang("receive_time"), var_27_4)
	else
		local var_27_5 = ItemModel.instance:getById(var_27_1)

		if var_27_5 and var_27_5.quantity > 0 and var_27_5.lastUpdateTime then
			local var_27_6 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_27_5.lastUpdateTime / 1000))

			arg_27_0._txtTime.text = string.format(luaLang("receive_time"), var_27_6)
		else
			arg_27_0._txtTime.text = ""

			gohelper.setActive(arg_27_0._goTime, false)
		end
	end
end

function var_0_0.onTabSwitchClose(arg_28_0)
	MainHeroView.setPostProcessBlur()
end

function var_0_0.onClose(arg_29_0)
	MainSceneSwitchController.closeReddot()
end

function var_0_0.onDestroyView(arg_30_0)
	MainSceneSwitchListModel.instance:clearList()
	TaskDispatcher.cancelTask(arg_30_0._delaySwitchSceneInitFinish, arg_30_0)
	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_30_0._playStory, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._delayFinishForPlayLoadingAnim, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._delaySwitchScene, arg_30_0)
end

return var_0_0
