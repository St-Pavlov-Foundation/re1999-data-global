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
	if arg_4_1 == 1 and arg_4_0.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.UI and arg_4_2 == MainEnum.SwitchType.Scene then
		arg_4_0:onTabSwitchOpen()
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
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onTabSwitchOpen(arg_14_0)
	if arg_14_0._rootAnimator then
		arg_14_0._rootAnimator:Play("open", 0, 0)
	end
end

function var_0_0.onOpen(arg_15_0)
	MainUISwitchListModel.instance:initList()
	arg_15_0:_onSwitchUIVisible(true)
	arg_15_0:_showUIInfo(MainUISwitchModel.instance:getCurUseUI())

	arg_15_0._showUI = true

	gohelper.setActive(arg_15_0._btnShow, false)

	if not arg_15_0._goblurmask then
		arg_15_0._goblurmask = arg_15_0:getResInst(arg_15_0.viewContainer:getSetting().otherRes[4], arg_15_0._gomiddle)
	end

	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	arg_15_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0._showUIInfo(arg_16_0, arg_16_1)
	arg_16_0._selectSkinId = arg_16_1

	arg_16_0:_showBtnStatus(arg_16_1)

	local var_16_0 = lua_scene_ui.configDict[arg_16_1]

	if var_16_0 then
		arg_16_0:_updateInfo(var_16_0.itemId, var_16_0.defaultUnlock)
	end
end

function var_0_0._showBtnStatus(arg_17_0, arg_17_1)
	local var_17_0 = MainUISwitchModel.getUIStatus(arg_17_1)
	local var_17_1 = arg_17_1 == MainUISwitchModel.instance:getCurUseUI()
	local var_17_2 = var_17_0 == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(arg_17_0._btnchange, not var_17_1 and var_17_2)
	gohelper.setActive(arg_17_0._btnget, not var_17_1 and var_17_0 == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(arg_17_0._goshowing, var_17_1 and var_17_2)
	gohelper.setActive(arg_17_0._goLocked, not var_17_1 and var_17_0 == MainSceneSwitchEnum.SceneStutas.Lock)
end

function var_0_0._updateInfo(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = lua_item.configDict[arg_18_1]

	if not var_18_0 then
		return
	end

	arg_18_0._txtSceneName.text = var_18_0.name
	arg_18_0._txtSceneDescr.text = var_18_0.desc

	if arg_18_2 == 1 then
		local var_18_1 = PlayerModel.instance:getPlayinfo()
		local var_18_2 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_18_1.registerTime / 1000))

		arg_18_0._txtTime.text = string.format(luaLang("receive_time"), var_18_2)
	else
		local var_18_3 = ItemModel.instance:getById(arg_18_1)

		if var_18_3 and var_18_3.quantity > 0 and var_18_3.lastUpdateTime then
			local var_18_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_18_3.lastUpdateTime / 1000))

			arg_18_0._txtTime.text = string.format(luaLang("receive_time"), var_18_4)
		else
			arg_18_0._txtTime.text = ""
		end
	end
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
