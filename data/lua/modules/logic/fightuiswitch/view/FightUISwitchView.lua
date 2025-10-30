module("modules.logic.fightuiswitch.view.FightUISwitchView", package.seeall)

local var_0_0 = class("FightUISwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._goScene = gohelper.findChild(arg_1_0.viewGO, "root/#go_Scene")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_left")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect")
	arg_1_0._goeffectItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem")
	arg_1_0._goSceneName = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName")
	arg_1_0._txtSceneName = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName/#txt_Time")
	arg_1_0._btnclickname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName/#btn_name")
	arg_1_0._txtSceneDescr = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#txt_SceneDescr")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "root/#go_right")
	arg_1_0._scrollstyle = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_right/#scroll_style")
	arg_1_0._gostylestate = gohelper.findChild(arg_1_0.viewGO, "root/#go_right/#go_stylestate")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#go_right/#go_stylestate/#go_select")
	arg_1_0._goobtain = gohelper.findChild(arg_1_0.viewGO, "root/#go_right/#go_stylestate/#go_obtain")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/#go_right/#go_stylestate/#go_lock")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "root/#go_right/#go_stylestate/#go_use")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:_addEventCb()
	arg_2_0._btnselect:AddClickListener(arg_2_0.onClickSelect, arg_2_0)
	arg_2_0._btnobtain:AddClickListener(arg_2_0.onClickObtain, arg_2_0)
	arg_2_0._btnclickname:AddClickListener(arg_2_0.onClickName, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:_removeEventCb()
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btnobtain:RemoveClickListener()
	arg_3_0._btnclickname:RemoveClickListener()
end

function var_0_0.onClickSelect(arg_4_0)
	FightUISwitchModel.instance:useCurStyleId()
end

function var_0_0.onClickObtain(arg_5_0)
	local var_5_0 = FightUISwitchModel.instance:getCurStyleMo()
	local var_5_1 = var_5_0 and var_5_0:getItemConfig()

	if var_5_1 then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, var_5_1.id)
	end
end

function var_0_0.onClickName(arg_6_0)
	local var_6_0 = FightUISwitchModel.instance:getCurStyleMo()

	FightUISwitchController.instance:openSceneView(var_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._goeffectItem, false)

	arg_7_0._btnselect = SLFramework.UGUI.UIClickListener.Get(arg_7_0._goselect.gameObject)
	arg_7_0._btnobtain = SLFramework.UGUI.UIClickListener.Get(arg_7_0._goobtain.gameObject)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0._addEventCb(arg_9_0)
	arg_9_0:addEventCb(FightUISwitchController.instance, FightUISwitchEvent.UseFightUIStyle, arg_9_0._onUseFightUIStyle, arg_9_0)
	arg_9_0:addEventCb(FightUISwitchController.instance, FightUISwitchEvent.SelectFightUIStyle, arg_9_0._onSelectFightUIStyle, arg_9_0)
	arg_9_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_9_0._onUpdateItemList, arg_9_0)
	arg_9_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_9_0._toSwitchTab, arg_9_0)
end

function var_0_0._removeEventCb(arg_10_0)
	arg_10_0:removeEventCb(FightUISwitchController.instance, FightUISwitchEvent.UseFightUIStyle, arg_10_0._onUseFightUIStyle, arg_10_0)
	arg_10_0:removeEventCb(FightUISwitchController.instance, FightUISwitchEvent.SelectFightUIStyle, arg_10_0._onSelectFightUIStyle, arg_10_0)
	arg_10_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0._onUpdateItemList, arg_10_0)
	arg_10_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_10_0._toSwitchTab, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._classifyBtnClickCb, arg_10_0)
end

function var_0_0._onUseFightUIStyle(arg_11_0, arg_11_1, arg_11_2)
	FightUISwitchListModel.instance:onModelUpdate()
	arg_11_0:_refreshBtn()

	arg_11_1 = arg_11_1 or FightUISwitchModel.instance:getCurShowStyleClassify()

	local var_11_0 = FightUISwitchEnum.StyleClassifyInfo[arg_11_1]
	local var_11_1 = luaLang(var_11_0.ClassifyTitle)

	ToastController.instance:showToast(ToastEnum.FightUISwitchSuccess, var_11_1)
end

function var_0_0._onSelectFightUIStyle(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_refreshStyle()
end

function var_0_0._onUpdateItemList(arg_13_0)
	arg_13_0:_refreshStyle()
end

function var_0_0._toSwitchTab(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._effectComp:clearEffectAnim()
end

function var_0_0.onOpen(arg_15_0)
	FightUISwitchModel.instance:setCurShowStyleClassify(FightUISwitchEnum.StyleClassify.FightCard)

	arg_15_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._gobottom, FightUISwitchEffectComp)

	FightUISwitchModel.instance:initMo()
	arg_15_0:_initClassify()
	arg_15_0:_refreshStyle()
	arg_15_0._animator:Play(FightUISwitchEnum.AnimKey.Open)
end

function var_0_0._initClassify(arg_16_0)
	arg_16_0._classifyItems = arg_16_0:getUserDataTb_()
	arg_16_0._styleClassify = {}

	for iter_16_0, iter_16_1 in pairs(FightUISwitchEnum.StyleClassifyInfo) do
		iter_16_1.Classify = iter_16_0

		table.insert(arg_16_0._styleClassify, iter_16_1)
		table.sort(arg_16_0._styleClassify, arg_16_0._sortClassify)
	end

	local var_16_0 = FightUISwitchModel.instance:getNewUnlockIds()

	arg_16_0._classifyIndex = FightUISwitchModel.instance:getCurShowStyleClassify()

	for iter_16_2, iter_16_3 in ipairs(arg_16_0._styleClassify) do
		local var_16_1 = arg_16_0:_getClassifyItem(iter_16_2)
		local var_16_2 = iter_16_3.Classify

		var_16_1.classify = var_16_2

		var_16_1:onUpdateMO(var_16_2, iter_16_2)
		var_16_1:addBtnListeners(arg_16_0._clickClassifyBtn, arg_16_0)
		var_16_1:setTxt(luaLang(iter_16_3.ClassifyTitle))

		local var_16_3 = arg_16_0._classifyIndex == var_16_2

		var_16_1:onSelect(var_16_3)
		var_16_1:showLine(iter_16_2 < #arg_16_0._styleClassify)

		local var_16_4 = var_16_0[var_16_2] and LuaUtil.tableNotEmpty(var_16_0[var_16_2])

		if var_16_3 then
			var_16_1:showReddot(false)
			arg_16_0:_cancelNewUnlockClassifyReddot(var_16_2)
		else
			var_16_1:showReddot(var_16_4)
		end
	end
end

function var_0_0._sortClassify(arg_17_0, arg_17_1)
	return arg_17_0.Sort < arg_17_1.Sort
end

function var_0_0._getClassifyItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._classifyItems[arg_18_1]

	if not var_18_0 then
		local var_18_1 = arg_18_0.viewContainer:getSetting().otherRes[3]
		local var_18_2 = arg_18_0:getResInst(var_18_1, arg_18_0._goleft, "classify" .. arg_18_1)

		var_18_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_2, MainSwitchClassifyItem)
		arg_18_0._classifyItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0._clickClassifyBtn(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._styleClassify[arg_19_1].Classify

	if arg_19_0._classifyIndex == var_19_0 then
		return
	end

	arg_19_0._effectComp:clearEffectAnim()

	arg_19_0._classifyIndex = var_19_0

	arg_19_0:playSwitchAnim()
	TaskDispatcher.cancelTask(arg_19_0._classifyBtnClickCb, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._classifyBtnClickCb, arg_19_0, FightUISwitchEnum.SwitchAnimDelayTime)
	arg_19_0:_refreshClassifyReddot(var_19_0, arg_19_1)
end

function var_0_0._refreshClassifyReddot(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = FightUISwitchModel.instance:getNewUnlockIds()

	if var_20_0[arg_20_1] and LuaUtil.tableNotEmpty(var_20_0[arg_20_1]) then
		arg_20_0:_cancelNewUnlockClassifyReddot(arg_20_1)
		arg_20_0:_getClassifyItem(arg_20_2):showReddot(false)
	end
end

function var_0_0._cancelNewUnlockClassifyReddot(arg_21_0, arg_21_1)
	FightUISwitchModel.instance:cancelNewUnlockClassifyReddot(arg_21_1)
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.cancelClassifyReddot, arg_21_1)
end

function var_0_0.playSwitchAnim(arg_22_0)
	arg_22_0._animator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
end

function var_0_0._classifyBtnClickCb(arg_23_0)
	FightUISwitchModel.instance:setCurShowStyleClassify(arg_23_0._classifyIndex)
	arg_23_0:_refreshStyle()
	FightUISwitchListModel.instance:setMoList()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._classifyItems) do
		iter_23_1:onSelect(arg_23_0._classifyIndex == iter_23_1.classify)
	end
end

function var_0_0._refreshStyle(arg_24_0)
	local var_24_0 = FightUISwitchModel.instance:getCurStyleMo()
	local var_24_1 = var_24_0 and var_24_0:getItemConfig()

	if var_24_1 then
		arg_24_0._txtSceneName.text = var_24_1.name
		arg_24_0._txtSceneDescr.text = var_24_1.desc
	end

	arg_24_0._txtTime.text = var_24_0:getObtainTime() or ""

	arg_24_0._effectComp:refreshEffect(arg_24_0._goScene, FightUISwitchModel.instance:getCurStyleMo(), arg_24_0.viewName)
	arg_24_0._effectComp:setViewAnim(arg_24_0._animator)
	arg_24_0:_refreshBtn()
end

function var_0_0._refreshBtn(arg_25_0)
	local var_25_0 = FightUISwitchModel.instance:getCurStyleMo()
	local var_25_1 = var_25_0:isUse()
	local var_25_2 = var_25_0:isUnlock()
	local var_25_3 = var_25_0:canJump()

	gohelper.setActive(arg_25_0._gouse, var_25_1)
	gohelper.setActive(arg_25_0._goobtain, not var_25_2 and var_25_3)
	gohelper.setActive(arg_25_0._goselect, var_25_2 and not var_25_1)
	gohelper.setActive(arg_25_0._golock, not var_25_2 and not var_25_3)
end

function var_0_0.playCloseAnim(arg_26_0)
	return
end

function var_0_0.onClose(arg_27_0)
	arg_27_0._effectComp:onClose()
	FightUISwitchController.instance:dispose()
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._effectComp:onDestroy()
end

return var_0_0
