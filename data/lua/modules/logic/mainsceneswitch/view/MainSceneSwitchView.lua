module("modules.logic.mainsceneswitch.view.MainSceneSwitchView", package.seeall)

slot0 = class("MainSceneSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/start/#btn_change")
	slot0._btnget = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/start/#btn_get")
	slot0._goshowing = gohelper.findChild(slot0.viewGO, "right/start/#go_showing")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "right/start/#go_Locked")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "right/mask/#scroll_card")
	slot0._btntimerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_timerank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_rarerank")
	slot0._goSceneLogo = gohelper.findChild(slot0.viewGO, "right/#go_SceneLogo")
	slot0._goHideBtn = gohelper.findChild(slot0.viewGO, "left/LayoutGroup/#go_HideBtn")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_show")
	slot0._goSceneName = gohelper.findChild(slot0.viewGO, "left/LayoutGroup/#go_SceneName")
	slot0._txtSceneName = gohelper.findChildText(slot0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	slot0._goTime = gohelper.findChild(slot0.viewGO, "left/LayoutGroup/#go_Time")
	slot0._txtTime = gohelper.findChildText(slot0.viewGO, "left/LayoutGroup/#go_Time/#txt_Time")
	slot0._txtSceneDescr = gohelper.findChildText(slot0.viewGO, "left/#txt_SceneDescr")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btnget:AddClickListener(slot0._btngetOnClick, slot0)
	slot0._btntimerank:AddClickListener(slot0._btntimerankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnHide:AddClickListener(slot0._btnHideOnClick, slot0)
	slot0._btnShow:AddClickListener(slot0._btnShowOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchange:RemoveClickListener()
	slot0._btnget:RemoveClickListener()
	slot0._btntimerank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnShow:RemoveClickListener()
end

function slot0._btngetOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, lua_scene_switch.configDict[slot0._selectSceneSkinId].itemId)
end

function slot0._btnHideOnClick(slot0)
	if slot0._hideTime and Time.time - slot0._hideTime < 0.2 then
		return
	end

	slot0._hideTime = Time.time
	slot0._showUI = not slot0._showUI

	gohelper.setActive(slot0._btnShow, not slot0._showUI)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SceneSwitchUIVisible, slot0._showUI)
end

function slot0._btnShowOnClick(slot0)
	slot0:_btnHideOnClick()
end

function slot0._btnchangeOnClick(slot0)
	slot2 = lua_scene_switch.configDict[slot0._selectSceneSkinId]

	StatController.instance:track(StatEnum.EventName.ChangeMainInterfaceScene, {
		[StatEnum.EventProperties.BeforeSceneName] = tostring(lua_scene_switch.configDict[slot0._curSceneSkinId].itemId),
		[StatEnum.EventProperties.AfterSceneName] = tostring(slot2.itemId)
	})
	UIBlockMgrExtend.setNeedCircleMv(false)
	PlayerRpc.instance:sendSetMainSceneSkinRequest(slot2.defaultUnlock == 1 and 0 or slot2.itemId, function (slot0, slot1, slot2)
		if slot1 ~= 0 then
			UIBlockMgrExtend.setNeedCircleMv(true)

			return
		end

		if gohelper.isNil(uv0.viewGO) then
			return
		end

		UIBlockMgr.instance:startBlock("switchSceneSkin")

		uv0._waitingSwitchSceneInitFinish = true

		TaskDispatcher.cancelTask(uv0._delaySwitchSceneInitFinish, uv0)
		TaskDispatcher.runDelay(uv0._delaySwitchSceneInitFinish, uv0, 8)

		uv0._curSceneSkinId = uv0._selectSceneSkinId

		MainSceneSwitchModel.instance:setCurSceneId(uv0._selectSceneSkinId)
		MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.BeforeStartSwitchScene)
		TaskDispatcher.runDelay(uv0._delaySwitchScene, uv0, 0.8)
		uv0._rootAnimator:Play("switch", 0, 0)
	end)
end

function slot0._delaySwitchScene(slot0)
	MainSceneSwitchController.instance:switchScene()
end

function slot0._btntimerankOnClick(slot0)
end

function slot0._btnrarerankOnClick(slot0)
end

function slot0._showSceneStatus(slot0)
	slot1 = MainSceneSwitchModel.getSceneStatus(slot0._selectSceneSkinId)
	slot2 = slot0._selectSceneSkinId == slot0._curSceneSkinId
	slot3 = slot1 == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(slot0._btnchange, not slot2 and slot3)
	gohelper.setActive(slot0._btnget, not slot2 and slot1 == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(slot0._goshowing, slot2 and slot3)
	gohelper.setActive(slot0._goLocked, not slot2 and slot1 == MainSceneSwitchEnum.SceneStutas.Lock)
	slot0:_updateSceneInfo()
end

function slot0._editableInitView(slot0)
	slot0._showUI = true
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "left")
	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")

	gohelper.setActive(slot0._btnShow, false)
	gohelper.addUIClickAudio(slot0._btnchange, AudioEnum.MainSceneSkin.play_ui_main_fit_scene)
	gohelper.setActive(slot0._btnchange, false)
	gohelper.setActive(slot0._btnget, false)
	gohelper.setActive(slot0._goshowing, false)
	gohelper.setActive(slot0._goLocked, false)
	gohelper.setActive(slot0._goSceneLogo, false)

	slot0._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()
	slot0._selectSceneSkinId = slot0._curSceneSkinId

	MainSceneSwitchListModel.instance:initList()
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ClickSwitchItem, slot0._onClickSwitchItem, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, slot0._onSceneSwitchUIVisible, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneInitFinish, slot0._onSwitchSceneInitFinish, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.MainSceneSwitchInfoView then
		slot0:_showSceneStatus()
		MainSceneSwitchListModel.instance:onModelUpdate()
	end
end

function slot0._onStartSwitchScene(slot0)
	slot0._startSwitchTime = Time.time
end

function slot0._delaySwitchSceneInitFinish(slot0)
	logError("MainSceneSwitchView _delaySwitchSceneInitFinish timeout!")
	slot0:_onSwitchSceneInitFinish()
end

function slot0._onSwitchSceneInitFinish(slot0)
	if not slot0._waitingSwitchSceneInitFinish then
		return
	end

	TaskDispatcher.cancelTask(slot0._delaySwitchSceneInitFinish, slot0)

	slot4 = math.max(0, 0.9 - (Time.time - slot0._startSwitchTime)) + 0.3

	TaskDispatcher.cancelTask(slot0._delayFinishForPlayLoadingAnim, slot0)
	TaskDispatcher.runDelay(slot0._delayFinishForPlayLoadingAnim, slot0, slot4)
	TaskDispatcher.cancelTask(slot0._playStory, slot0)
	TaskDispatcher.runDelay(slot0._playStory, slot0, slot4 + 0.6)
end

function slot0._delayFinishForPlayLoadingAnim(slot0)
	slot0:_showSceneStatus()
	MainSceneSwitchListModel.instance:refreshScroll()
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.CloseSwitchSceneLoading)
end

function slot0._playStory(slot0)
	slot0._waitingSwitchSceneInitFinish = false

	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if lua_scene_switch.configDict[slot0._selectSceneSkinId].storyId > 0 and not StoryModel.instance:isStoryFinished(slot2) then
		StoryController.instance:playStory(slot2, {
			mark = true
		}, function ()
			uv0:_showTip()
			MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinishStory)
		end)

		return
	end

	slot0:_showTip()
end

function slot0._showTip(slot0)
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	slot0._rootAnimator:Play("open", 0, 0)
end

function slot0.onOpenFinish(slot0)
	slot2 = 1

	slot0:_setSelectedItemMo(MainSceneSwitchListModel.instance:getList()[slot2], slot2)
	MainSceneSwitchController.closeReddot()
end

function slot0._onSceneSwitchUIVisible(slot0, slot1)
	slot0._rootAnimator:Play(slot1 and "open" or "close", 0, 0)
end

function slot0._onClickSwitchItem(slot0, slot1, slot2)
	slot0:_setSelectedItemMo(slot1, slot2)
end

function slot0._setSelectedItemMo(slot0, slot1, slot2)
	MainSceneSwitchListModel.instance:selectCellIndex(slot2)

	slot0._selectSceneSkinId = slot1.id

	slot0:_showSceneStatus()
end

function slot0.onTabSwitchOpen(slot0)
	MainHeroView.resetPostProcessBlur()
	slot0._rootAnimator:Play("open", 0, 0)
end

function slot0._updateSceneInfo(slot0)
	if not lua_scene_switch.configDict[slot0._selectSceneSkinId] then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowSceneInfo, slot0._selectSceneSkinId)

	if not lua_item.configDict[slot1.itemId] then
		return
	end

	slot0._txtSceneName.text = slot3.name
	slot0._txtSceneDescr.text = slot3.desc

	gohelper.setActive(slot0._goTime, true)

	if slot1.defaultUnlock == 1 then
		slot0._txtTime.text = string.format(luaLang("receive_time"), TimeUtil.timestampToString5(ServerTime.timeInLocal(PlayerModel.instance:getPlayinfo().registerTime / 1000)))
	elseif ItemModel.instance:getById(slot2) and slot4.quantity > 0 and slot4.lastUpdateTime then
		slot0._txtTime.text = string.format(luaLang("receive_time"), TimeUtil.timestampToString5(ServerTime.timeInLocal(slot4.lastUpdateTime / 1000)))
	else
		slot0._txtTime.text = ""

		gohelper.setActive(slot0._goTime, false)
	end
end

function slot0.onTabSwitchClose(slot0)
	MainHeroView.setPostProcessBlur()
end

function slot0.onClose(slot0)
	MainSceneSwitchController.closeReddot()
end

function slot0.onDestroyView(slot0)
	MainSceneSwitchListModel.instance:clearList()
	TaskDispatcher.cancelTask(slot0._delaySwitchSceneInitFinish, slot0)
	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0._playStory, slot0)
	TaskDispatcher.cancelTask(slot0._delayFinishForPlayLoadingAnim, slot0)
	TaskDispatcher.cancelTask(slot0._delaySwitchScene, slot0)
end

return slot0
