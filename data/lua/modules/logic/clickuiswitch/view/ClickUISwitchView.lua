module("modules.logic.clickuiswitch.view.ClickUISwitchView", package.seeall)

local var_0_0 = class("ClickUISwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "middle")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_change")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_get")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_Locked")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_card")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "left/LayoutGroup/#go_name")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_name/#txt_name")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "left/LayoutGroup/#go_name/#txt_name/#txt_Time")
	arg_1_0._txtdescr = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_descr")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "left")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/LayoutGroup/#go_name/#btn_namecheck")
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
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchClickUI, arg_2_0._onSwitchClickUI, arg_2_0)
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.UseClickUI, arg_2_0._onUseClickUI, arg_2_0)
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_2_0._loadUIPrefabs, arg_2_0)
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_2_0._loadUIPrefabs, arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchClickUI, arg_3_0._onSwitchClickUI, arg_3_0)
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_3_0._loadUIPrefabs, arg_3_0)
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, arg_3_0._loadUIPrefabs, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0._toSwitchTab(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 1 then
		if arg_4_0.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.Click then
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
	ClickUISwitchController.instance:setCurClickUIStyle(arg_5_0._selectSkinId, arg_5_0._showBtnStatus, arg_5_0)
	ClickUISwitchListModel.instance:refreshScroll()
end

function var_0_0._btngetOnClick(arg_6_0)
	local var_6_0 = lua_scene_click.configDict[arg_6_0._selectSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, var_6_0.itemId)
end

function var_0_0._onSwitchClickUI(arg_7_0, arg_7_1)
	arg_7_0:_showUIInfo(arg_7_1)
end

function var_0_0._onUseClickUI(arg_8_0, arg_8_1)
	arg_8_0:_showUIInfo(arg_8_0._selectSkinId)
	ClickUISwitchListModel.instance:refreshScroll()
end

function var_0_0._btnHideOnClick(arg_9_0)
	if arg_9_0._hideTime and Time.time - arg_9_0._hideTime < 0.2 then
		return
	end

	arg_9_0._hideTime = Time.time
	arg_9_0._showUI = not arg_9_0._showUI

	gohelper.setActive(arg_9_0._btnShow, not arg_9_0._showUI)
	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.SwitchVisible, arg_9_0._showUI)
end

function var_0_0._btnshowOnClick(arg_10_0)
	arg_10_0:_btnHideOnClick()
end

function var_0_0._onSwitchUIVisible(arg_11_0, arg_11_1)
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

function var_0_0.onTabSwitchClose(arg_15_0, arg_15_1)
	return
end

function var_0_0.onOpen(arg_16_0)
	ClickUISwitchListModel.instance:initList()
	arg_16_0:_onSwitchUIVisible(true)
	arg_16_0:_showUIInfo(ClickUISwitchModel.instance:getCurUseUI())

	arg_16_0._showUI = true

	gohelper.setActive(arg_16_0._btnShow, false)
	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	arg_16_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0._showUIInfo(arg_17_0, arg_17_1)
	arg_17_0._selectSkinId = arg_17_1

	arg_17_0:_showBtnStatus(arg_17_1)

	local var_17_0 = lua_scene_click.configDict[arg_17_1]

	if var_17_0 then
		arg_17_0:_updateInfo(var_17_0.itemId, var_17_0.defaultUnlock)
		arg_17_0:_showClickUI(var_17_0.effect)
	end
end

function var_0_0._showClickUI(arg_18_0, arg_18_1)
	if not arg_18_0._clickUIItems then
		arg_18_0._clickUIItems = {}
	end

	if not arg_18_0._clickUIItems[arg_18_1] then
		local var_18_0 = ClickUISwitchController.instance:getClickUIPrefab(arg_18_1)

		if not var_18_0 then
			return
		end

		local var_18_1 = gohelper.clone(var_18_0, arg_18_0._gomiddle)
		local var_18_2 = var_18_1:GetComponent(typeof(UnityEngine.Animation))
		local var_18_3 = var_18_2.clip.length

		arg_18_0._clickUIItems[arg_18_1] = {
			go = var_18_1,
			ani = var_18_2,
			animTime = var_18_3
		}
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._clickUIItems) do
		gohelper.setActive(iter_18_1.go, iter_18_0 == arg_18_1)
	end

	arg_18_0._clickUIPrefabName = arg_18_1

	local var_18_4 = arg_18_0._clickUIItems[arg_18_1] and arg_18_0._clickUIItems[arg_18_1].animTime or 0.5

	TaskDispatcher.cancelTask(arg_18_0._runRepeatClickUIAnim, arg_18_0)
	TaskDispatcher.runRepeat(arg_18_0._runRepeatClickUIAnim, arg_18_0, var_18_4)
end

function var_0_0._runRepeatClickUIAnim(arg_19_0)
	local var_19_0 = arg_19_0._clickUIItems[arg_19_0._clickUIPrefabName]

	if not var_19_0 then
		return
	end

	var_19_0.ani:Play()
end

function var_0_0._loadUIPrefabs(arg_20_0)
	local var_20_0 = lua_scene_click.configDict[arg_20_0._selectSkinId]

	if var_20_0 then
		arg_20_0:_showClickUI(var_20_0.effect)
	end
end

function var_0_0._showBtnStatus(arg_21_0, arg_21_1)
	local var_21_0 = ClickUISwitchModel.getUIStatus(arg_21_1)
	local var_21_1 = arg_21_1 == ClickUISwitchModel.instance:getCurUseUI()
	local var_21_2 = var_21_0 == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(arg_21_0._btnchange, not var_21_1 and var_21_2)
	gohelper.setActive(arg_21_0._btnget, not var_21_1 and var_21_0 == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(arg_21_0._goshowing, var_21_1 and var_21_2)
	gohelper.setActive(arg_21_0._goLocked, not var_21_1 and var_21_0 == MainSceneSwitchEnum.SceneStutas.Lock)
end

function var_0_0._updateInfo(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = lua_item.configDict[arg_22_1]

	if not var_22_0 then
		return
	end

	arg_22_0._txtname.text = var_22_0.name
	arg_22_0._txtdescr.text = var_22_0.desc

	if arg_22_2 == 1 then
		local var_22_1 = PlayerModel.instance:getPlayinfo()
		local var_22_2 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_22_1.registerTime / 1000))

		arg_22_0._txtTime.text = string.format(luaLang("receive_time"), var_22_2)
	else
		local var_22_3 = ItemModel.instance:getById(arg_22_1)

		if var_22_3 and var_22_3.quantity > 0 and var_22_3.lastUpdateTime then
			local var_22_4 = TimeUtil.timestampToString5(ServerTime.timeInLocal(var_22_3.lastUpdateTime / 1000))

			arg_22_0._txtTime.text = string.format(luaLang("receive_time"), var_22_4)
		else
			arg_22_0._txtTime.text = ""
		end
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._runRepeatClickUIAnim, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
