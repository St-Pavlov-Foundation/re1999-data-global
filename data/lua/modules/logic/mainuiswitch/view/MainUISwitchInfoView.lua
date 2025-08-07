module("modules.logic.mainuiswitch.view.MainUISwitchInfoView", package.seeall)

local var_0_0 = class("MainUISwitchInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "middle")
	arg_1_0._gomainUI = gohelper.findChild(arg_1_0.viewGO, "middle/#go_mainUI")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_equip")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_Locked")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_close")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_card")
	arg_1_0._goSceneName = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName")
	arg_1_0._txtSceneName = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	arg_1_0._btnnamecheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#btn_namecheck")
	arg_1_0._txtSceneDescr = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_SceneDescr")
	arg_1_0._btnshow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_show")
	arg_1_0._goSceneLogo4 = gohelper.findChild(arg_1_0.viewGO, "left/#go_SceneLogo4")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnnamecheck:AddClickListener(arg_2_0._btnHideOnClick, arg_2_0)
	arg_2_0._btnshow:AddClickListener(arg_2_0._btnshowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnamecheck:RemoveClickListener()
	arg_3_0._btnshow:RemoveClickListener()
end

function var_0_0._btnHideOnClick(arg_4_0)
	if arg_4_0._hideTime and Time.time - arg_4_0._hideTime < 0.2 then
		return
	end

	arg_4_0._hideTime = Time.time
	arg_4_0._showUI = not arg_4_0._showUI

	gohelper.setActive(arg_4_0._goleft, arg_4_0._showUI and arg_4_0._isCanShowLeft)
	gohelper.setActive(arg_4_0._goright, arg_4_0._showUI)
	gohelper.setActive(arg_4_0._btnshow.gameObject, not arg_4_0._showUI)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.PreviewSwitchUIVisible, arg_4_0._showUI)
end

function var_0_0._btnshowOnClick(arg_5_0)
	if not arg_5_0._showUI and MainUISwitchController.instance:isClickEagle() then
		MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickEagle)

		return
	end

	arg_5_0:_btnHideOnClick()
end

function var_0_0._btnequipOnClick(arg_6_0)
	MainUISwitchController.instance:setCurMainUIStyle(arg_6_0._selectSkinId, arg_6_0._showSceneStatus, arg_6_0)
end

function var_0_0._showSceneStatus(arg_7_0)
	local var_7_0 = MainUISwitchModel.getUIStatus(arg_7_0._selectSkinId) == MainSceneSwitchEnum.SceneStutas.Unlock
	local var_7_1 = arg_7_0._selectSkinId == MainUISwitchModel.instance:getCurUseUI()

	gohelper.setActive(arg_7_0._btnequip, var_7_0 and not var_7_1)
	gohelper.setActive(arg_7_0._goshowing, var_7_0 and var_7_1)
	gohelper.setActive(arg_7_0._goLocked, not var_7_0)
	arg_7_0:_updateSceneInfo()
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._rootAnimator = arg_9_0.viewGO:GetComponent("Animator")
	arg_9_0._goleft = gohelper.findChild(arg_9_0.viewGO, "left")
	arg_9_0._goright = gohelper.findChild(arg_9_0.viewGO, "right")
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._showUI = true
	arg_10_0._selectSkinId = arg_10_0.viewParam.SkinId
	arg_10_0._isCanShowLeft = true

	if arg_10_0.viewParam and arg_10_0.viewParam.isNotShowLeft == true then
		arg_10_0._isCanShowLeft = false
	end

	arg_10_0:_showSceneStatus()

	if not arg_10_0.viewParam.noInfoEffect then
		arg_10_0._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end

	if not arg_10_0._goblurmask then
		arg_10_0._goblurmask = arg_10_0:getResInst(arg_10_0.viewContainer:getSetting().otherRes[2], arg_10_0._gomiddle)
	end

	if not arg_10_0.viewParam or not arg_10_0.viewParam.sceneId then
		local var_10_0 = MainSceneSwitchModel.instance:getCurSceneId()
	end

	gohelper.setActive(arg_10_0._goleft, arg_10_0._showUI and arg_10_0._isCanShowLeft)
end

function var_0_0._updateSceneInfo(arg_11_0)
	local var_11_0 = lua_scene_ui.configDict[arg_11_0._selectSkinId]

	if not var_11_0 then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, MainSceneSwitchModel.instance:getCurSceneId())

	local var_11_1 = var_11_0.itemId
	local var_11_2 = lua_item.configDict[var_11_1]

	if not var_11_2 then
		return
	end

	arg_11_0._txtSceneName.text = var_11_2.name
	arg_11_0._txtSceneDescr.text = var_11_2.desc

	if var_11_0.defaultUnlock == 1 then
		local var_11_3 = PlayerModel.instance:getPlayinfo()
		local var_11_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_11_3.registerTime / 1000))

		arg_11_0._txtTime.text = string.format(luaLang("receive_time"), var_11_4)
	else
		local var_11_5 = ItemModel.instance:getById(var_11_1)

		if var_11_5 and var_11_5.quantity > 0 and var_11_5.lastUpdateTime then
			local var_11_6 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_11_5.lastUpdateTime / 1000))

			arg_11_0._txtTime.text = string.format(luaLang("receive_time"), var_11_6)
		else
			arg_11_0._txtTime.text = ""
		end
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

return var_0_0
