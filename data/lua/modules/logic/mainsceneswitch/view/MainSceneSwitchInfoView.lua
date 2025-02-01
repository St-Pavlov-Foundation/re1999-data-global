module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoView", package.seeall)

slot0 = class("MainSceneSwitchInfoView", BaseView)

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
	slot0._btnHide:AddClickListener(slot0._btnHideOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnHide:RemoveClickListener()
end

function slot0._btnHideOnClick(slot0)
	if slot0._hideTime and Time.time - slot0._hideTime < 0.2 then
		return
	end

	slot0._hideTime = Time.time
	slot0._showUI = not slot0._showUI

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, slot0._showUI)
end

function slot0._btntimerankOnClick(slot0)
end

function slot0._btnrarerankOnClick(slot0)
end

function slot0._showSceneStatus(slot0)
	gohelper.setActive(slot0._goLocked, MainSceneSwitchModel.getSceneStatus(slot0._selectSceneSkinId) ~= MainSceneSwitchEnum.SceneStutas.Unlock)
	slot0:_updateSceneInfo()
end

function slot0._editableInitView(slot0)
	slot0._showUI = true
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "left")
	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")

	gohelper.setActive(slot0._btnchange, false)
	gohelper.setActive(slot0._btnget, false)
	gohelper.setActive(slot0._goshowing, false)
	gohelper.setActive(slot0._goLocked, false)
	gohelper.setActive(slot0._goSceneLogo, true)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, slot0._onSceneSwitchUIVisible, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
end

function slot0._onTouchScreen(slot0)
	if not slot0._showUI then
		slot0:_btnHideOnClick()
	end
end

function slot0.onOpen(slot0)
	slot0._selectSceneSkinId = slot0.viewParam.sceneSkinId

	slot0:_showSceneStatus()

	if not slot0.viewParam.noInfoEffect then
		slot0._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end
end

function slot0._onSceneSwitchUIVisible(slot0, slot1)
	slot0._rootAnimator:Play(slot1 and "open" or "close", 0, 0)
end

function slot0._updateSceneInfo(slot0)
	if not lua_scene_switch.configDict[slot0._selectSceneSkinId] then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, slot0._selectSceneSkinId)

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

function slot0.onDestroyView(slot0)
end

return slot0
