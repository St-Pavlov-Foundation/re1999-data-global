module("modules.logic.clickuiswitch.view.ClickUISwitchInfoView", package.seeall)

local var_0_0 = class("ClickUISwitchInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "middle")
	arg_1_0._gorawImage = gohelper.findChild(arg_1_0.viewGO, "RawImage")
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
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_2_0._loadUIPrefabs, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnamecheck:RemoveClickListener()
	arg_3_0._btnshow:RemoveClickListener()
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_3_0._loadUIPrefabs, arg_3_0)
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
	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.PreviewSwitchVisible, arg_4_0._showUI)
end

function var_0_0._btnshowOnClick(arg_5_0)
	arg_5_0:_btnHideOnClick()
end

function var_0_0._btnequipOnClick(arg_6_0)
	ClickUISwitchController.instance:setCurClickUIStyle(arg_6_0._selectSkinId, arg_6_0._showSceneStatus, arg_6_0)
end

function var_0_0._showSceneStatus(arg_7_0)
	local var_7_0 = ClickUISwitchModel.getUIStatus(arg_7_0._selectSkinId) == MainSceneSwitchEnum.SceneStutas.Unlock
	local var_7_1 = arg_7_0._selectSkinId == ClickUISwitchModel.instance:getCurUseUI()

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
	arg_9_0._rawImage = gohelper.onceAddComponent(arg_9_0._gorawImage, gohelper.Type_RawImage)
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

	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.sceneId or MainSceneSwitchModel.instance:getCurSceneId()

	gohelper.setActive(arg_10_0._gorawImage, false)
	arg_10_0:_onShowSceneInfo(var_10_0)
	gohelper.setActive(arg_10_0._goleft, arg_10_0._showUI and arg_10_0._isCanShowLeft)
end

function var_0_0._updateSceneInfo(arg_11_0)
	local var_11_0 = lua_scene_click.configDict[arg_11_0._selectSkinId]

	if not var_11_0 then
		return
	end

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

	arg_11_0:_showClickUI(var_11_0.effect)
end

function var_0_0._showClickUI(arg_12_0, arg_12_1)
	if not arg_12_0._clickUIItems then
		arg_12_0._clickUIItems = {}
	end

	if not arg_12_0._clickUIItems[arg_12_1] then
		local var_12_0 = ClickUISwitchController.instance:getClickUIPrefab(arg_12_1)

		if not var_12_0 then
			return
		end

		local var_12_1 = gohelper.clone(var_12_0, arg_12_0._gomiddle)
		local var_12_2 = var_12_1:GetComponent(typeof(UnityEngine.Animation))
		local var_12_3 = var_12_2.clip.length

		arg_12_0._clickUIItems[arg_12_1] = {
			go = var_12_1,
			ani = var_12_2,
			animTime = var_12_3
		}
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0._clickUIItems) do
		gohelper.setActive(iter_12_1.go, iter_12_0 == arg_12_1)
	end

	arg_12_0._clickUIPrefabName = arg_12_1

	local var_12_4 = arg_12_0._clickUIItems[arg_12_1] and arg_12_0._clickUIItems[arg_12_1].animTime or 0.5

	TaskDispatcher.cancelTask(arg_12_0._runRepeatClickUIAnim, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0._runRepeatClickUIAnim, arg_12_0, var_12_4)
end

function var_0_0._runRepeatClickUIAnim(arg_13_0)
	local var_13_0 = arg_13_0._clickUIItems[arg_13_0._clickUIPrefabName]

	if not var_13_0 then
		return
	end

	var_13_0.ani:Play()
end

function var_0_0._loadUIPrefabs(arg_14_0)
	local var_14_0 = lua_scene_click.configDict[arg_14_0._selectSkinId]

	if var_14_0 then
		arg_14_0:_showClickUI(var_14_0.effect)
	end
end

function var_0_0._onShowSceneInfo(arg_15_0, arg_15_1)
	arg_15_0._sceneId = arg_15_1

	MainSceneSwitchCameraController.instance:showScene(arg_15_1, arg_15_0._showSceneFinished, arg_15_0)
end

function var_0_0._showSceneFinished(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._gorawImage, true)
	var_0_0.adjustRt(arg_16_0._rawImage, arg_16_1)
end

function var_0_0.adjustRt(arg_17_0, arg_17_1)
	arg_17_0.texture = arg_17_1

	arg_17_0:SetNativeSize()

	local var_17_0 = arg_17_1.width
	local var_17_1 = ViewMgr.instance:getUIRoot().transform
	local var_17_2 = recthelper.getWidth(var_17_1) / var_17_0

	transformhelper.setLocalScale(arg_17_0.transform, var_17_2, var_17_2, 1)
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._runRepeatClickUIAnim, arg_18_0)
end

return var_0_0
