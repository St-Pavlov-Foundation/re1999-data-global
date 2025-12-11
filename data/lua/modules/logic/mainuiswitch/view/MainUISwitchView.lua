module("modules.logic.mainuiswitch.view.MainUISwitchView", package.seeall)

local var_0_0 = class("MainUISwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "middle")
	arg_1_0._gomainUI = gohelper.findChild(arg_1_0.viewGO, "middle/#go_mainUI")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_change")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_get")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_Locked")
	arg_1_0._goSceneName = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName")
	arg_1_0._txtSceneName = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	arg_1_0._txtSceneDescr = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_SceneDescr")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "left")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/LayoutGroup/#go_SceneName/#btn_namecheck")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_show")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._btnHideOnClick, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._btnshowOnClick, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_2_0._onSwitchMainUI, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_2_0._onUIMainUI, arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_3_0._onSwitchMainUI, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_3_0._onUIMainUI, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0._toSwitchTab(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 1 then
		if arg_4_0.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.UI then
			if arg_4_2 == MainEnum.SwitchType.Scene then
				arg_4_0:onTabSwitchOpen()
			else
				arg_4_0:onTabSwitchClose()
			end
		else
			arg_4_0:onTabSwitchClose()
		end
	end
end

function var_0_0._btnchangeOnClick(arg_5_0)
	MainUISwitchController.instance:setCurMainUIStyle(arg_5_0._selectSkinId, arg_5_0._showBtnStatus, arg_5_0)
	MainUISwitchListModel.instance:refreshScroll()
end

function var_0_0._btngetOnClick(arg_6_0)
	local var_6_0 = lua_scene_ui.configDict[arg_6_0._selectSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, var_6_0.itemId)
end

function var_0_0._onSwitchMainUI(arg_7_0, arg_7_1)
	arg_7_0:_showUIInfo(arg_7_1)
end

function var_0_0._onUIMainUI(arg_8_0, arg_8_1)
	arg_8_0:_showUIInfo(arg_8_0._selectSkinId)
	MainUISwitchListModel.instance:refreshScroll()
end

function var_0_0._btnHideOnClick(arg_9_0)
	if arg_9_0._hideTime and Time.time - arg_9_0._hideTime < 0.2 then
		return
	end

	arg_9_0._hideTime = Time.time
	arg_9_0._showUI = not arg_9_0._showUI

	gohelper.setActive(arg_9_0._btnShow, not arg_9_0._showUI)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.SwitchUIVisible, arg_9_0._showUI)
end

function var_0_0._btnshowOnClick(arg_10_0)
	if not arg_10_0._showUI and MainUISwitchController.instance:isClickEagle() then
		MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickEagle)

		return
	end

	arg_10_0:_btnHideOnClick()
end

function var_0_0._onSwitchUIVisible(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goblurmask, arg_11_1)
	gohelper.setActive(arg_11_0._goright, arg_11_1)
	gohelper.setActive(arg_11_0._goleft, arg_11_1)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._goshow = gohelper.findChild(arg_12_0.rootGO, "#btn_show")
	arg_12_0._rootAnimator = arg_12_0.viewGO:GetComponent("Animator")
	arg_12_0._useSingleMask = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive")
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onTabSwitchOpen(arg_14_0)
	if arg_14_0._rootAnimator then
		arg_14_0._rootAnimator:Play("open", 0, 0)
	end

	arg_14_0:_setrolesStoryMaskActive()
end

function var_0_0.onTabSwitchClose(arg_15_0, arg_15_1)
	arg_15_0:_resetrolesStoryMaskActive()
end

function var_0_0.onOpen(arg_16_0)
	MainUISwitchListModel.instance:initList()
	arg_16_0:_onSwitchUIVisible(true)
	arg_16_0:_showUIInfo(MainUISwitchModel.instance:getCurUseUI())

	arg_16_0._showUI = true

	gohelper.setActive(arg_16_0._btnShow, false)

	if not arg_16_0._goblurmask then
		arg_16_0._goblurmask = arg_16_0:getResInst(arg_16_0.viewContainer:getSetting().otherRes[4], arg_16_0._gomiddle)
	end

	arg_16_0:_setrolesStoryMaskActive()
	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	arg_16_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0._setrolesStoryMaskActive(arg_17_0)
	PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
end

function var_0_0._resetrolesStoryMaskActive(arg_18_0)
	PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", arg_18_0._useSingleMask)
end

function var_0_0._showUIInfo(arg_19_0, arg_19_1)
	arg_19_0._selectSkinId = arg_19_1

	arg_19_0:_showBtnStatus(arg_19_1)

	local var_19_0 = lua_scene_ui.configDict[arg_19_1]

	if var_19_0 then
		arg_19_0:_updateInfo(var_19_0.itemId, var_19_0.defaultUnlock)
	end
end

function var_0_0._showBtnStatus(arg_20_0, arg_20_1)
	local var_20_0 = MainUISwitchModel.getUIStatus(arg_20_1)
	local var_20_1 = arg_20_1 == MainUISwitchModel.instance:getCurUseUI()
	local var_20_2 = var_20_0 == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(arg_20_0._btnchange, not var_20_1 and var_20_2)
	gohelper.setActive(arg_20_0._btnget, not var_20_1 and var_20_0 == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(arg_20_0._goshowing, var_20_1 and var_20_2)
	gohelper.setActive(arg_20_0._goLocked, not var_20_1 and var_20_0 == MainSceneSwitchEnum.SceneStutas.Lock)
end

function var_0_0._updateInfo(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = lua_item.configDict[arg_21_1]

	if not var_21_0 then
		return
	end

	arg_21_0._txtSceneName.text = var_21_0.name
	arg_21_0._txtSceneDescr.text = var_21_0.desc

	if arg_21_2 == 1 then
		local var_21_1 = PlayerModel.instance:getPlayinfo()
		local var_21_2 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_21_1.registerTime / 1000))

		arg_21_0._txtTime.text = string.format(luaLang("receive_time"), var_21_2)
	else
		local var_21_3 = ItemModel.instance:getById(arg_21_1)

		if var_21_3 and var_21_3.quantity > 0 and var_21_3.lastUpdateTime then
			local var_21_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_21_3.lastUpdateTime / 1000))

			arg_21_0._txtTime.text = string.format(luaLang("receive_time"), var_21_4)
		else
			arg_21_0._txtTime.text = ""
		end
	end
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:_resetrolesStoryMaskActive()
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0
