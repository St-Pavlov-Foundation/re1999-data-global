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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnHide:RemoveClickListener()
end

function var_0_0._btnHideOnClick(arg_4_0)
	if arg_4_0._hideTime and Time.time - arg_4_0._hideTime < 0.2 then
		return
	end

	arg_4_0._hideTime = Time.time
	arg_4_0._showUI = not arg_4_0._showUI

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, arg_4_0._showUI)
end

function var_0_0._btntimerankOnClick(arg_5_0)
	return
end

function var_0_0._btnrarerankOnClick(arg_6_0)
	return
end

function var_0_0._showSceneStatus(arg_7_0)
	local var_7_0 = MainSceneSwitchModel.getSceneStatus(arg_7_0._selectSceneSkinId)

	gohelper.setActive(arg_7_0._goLocked, var_7_0 ~= MainSceneSwitchEnum.SceneStutas.Unlock)
	arg_7_0:_updateSceneInfo()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._showUI = true
	arg_8_0._goright = gohelper.findChild(arg_8_0.viewGO, "right")
	arg_8_0._goLeft = gohelper.findChild(arg_8_0.viewGO, "left")
	arg_8_0._rootAnimator = arg_8_0.viewGO:GetComponent("Animator")

	gohelper.setActive(arg_8_0._btnchange, false)
	gohelper.setActive(arg_8_0._btnget, false)
	gohelper.setActive(arg_8_0._goshowing, false)
	gohelper.setActive(arg_8_0._goLocked, false)
	gohelper.setActive(arg_8_0._goSceneLogo, true)
	arg_8_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, arg_8_0._onSceneSwitchUIVisible, arg_8_0)
	arg_8_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_8_0._onTouchScreen, arg_8_0)
end

function var_0_0._onTouchScreen(arg_9_0)
	if not arg_9_0._showUI then
		arg_9_0:_btnHideOnClick()
	end
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._selectSceneSkinId = arg_10_0.viewParam.sceneSkinId

	arg_10_0:_showSceneStatus()

	if not arg_10_0.viewParam.noInfoEffect then
		arg_10_0._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end
end

function var_0_0._onSceneSwitchUIVisible(arg_11_0, arg_11_1)
	arg_11_0._rootAnimator:Play(arg_11_1 and "open" or "close", 0, 0)
end

function var_0_0._updateSceneInfo(arg_12_0)
	local var_12_0 = lua_scene_switch.configDict[arg_12_0._selectSceneSkinId]

	if not var_12_0 then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, arg_12_0._selectSceneSkinId)

	local var_12_1 = var_12_0.itemId
	local var_12_2 = lua_item.configDict[var_12_1]

	if not var_12_2 then
		return
	end

	arg_12_0._txtSceneName.text = var_12_2.name
	arg_12_0._txtSceneDescr.text = var_12_2.desc

	gohelper.setActive(arg_12_0._goTime, true)

	if var_12_0.defaultUnlock == 1 then
		local var_12_3 = PlayerModel.instance:getPlayinfo()
		local var_12_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_12_3.registerTime / 1000))

		arg_12_0._txtTime.text = string.format(luaLang("receive_time"), var_12_4)
	else
		local var_12_5 = ItemModel.instance:getById(var_12_1)

		if var_12_5 and var_12_5.quantity > 0 and var_12_5.lastUpdateTime then
			local var_12_6 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_12_5.lastUpdateTime / 1000))

			arg_12_0._txtTime.text = string.format(luaLang("receive_time"), var_12_6)
		else
			arg_12_0._txtTime.text = ""

			gohelper.setActive(arg_12_0._goTime, false)
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
