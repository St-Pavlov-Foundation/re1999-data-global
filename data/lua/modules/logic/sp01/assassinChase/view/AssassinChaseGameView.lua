module("modules.logic.sp01.assassinChase.view.AssassinChaseGameView", package.seeall)

local var_0_0 = class("AssassinChaseGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goSelect = gohelper.findChild(arg_1_0.viewGO, "#go_Select")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_Select/Right/Choose/#go_Item")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Select/Right/Choose/#go_Item/#image_Icon")
	arg_1_0._txtPath = gohelper.findChildText(arg_1_0.viewGO, "#go_Select/Right/Choose/#go_Item/#txt_Path")
	arg_1_0._txtTargetDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Select/Right/Choose/#go_Item/#txt_TargetDescr")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Select/Right/Choose/#go_Item/#go_Selected")
	arg_1_0._txtSelectTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Select/Right/#txt_SelectTips")
	arg_1_0._btnOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Select/Right/#btn_OK")
	arg_1_0._goProgress = gohelper.findChild(arg_1_0.viewGO, "#go_Progress")
	arg_1_0._txtProgress = gohelper.findChildText(arg_1_0.viewGO, "#go_Progress/#txt_Progress")
	arg_1_0._txtProgressTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Progress/#txt_ProgressTips")
	arg_1_0._btnChoose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Progress/Right/#btn_Choose")
	arg_1_0._imageCurDirectionIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Progress/Right/#btn_Choose/#image_CurDirectionIcon")
	arg_1_0._txtCurDirectionPath = gohelper.findChildText(arg_1_0.viewGO, "#go_Progress/Right/#btn_Choose/#txt_CurDirectionPath")
	arg_1_0._btnChange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Progress/Right/#btn_Change")
	arg_1_0._txtChangeTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Progress/Right/#btn_Change/#txt_ChangeTips")
	arg_1_0._goResult = gohelper.findChild(arg_1_0.viewGO, "#go_Result")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Result/#simage_Mask")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_Result/Right/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_Result/Right/#go_fail")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Result/Right/#txt_Desc")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_Result/Right/#go_reward")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_Result/Right/#go_reward/#go_rewardItem")
	arg_1_0._btnfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Result/Right/LayoutGroup/#btn_finish")
	arg_1_0._btnnewGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Result/Right/LayoutGroup/#btn_newGame")
	arg_1_0._txtGameTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_Result/Right/LayoutGroup/#btn_newGame/#txt_GameTimes")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnOK:AddClickListener(arg_2_0._btnOKOnClick, arg_2_0)
	arg_2_0._btnChoose:AddClickListener(arg_2_0._btnChooseOnClick, arg_2_0)
	arg_2_0._btnChange:AddClickListener(arg_2_0._btnChangeOnClick, arg_2_0)
	arg_2_0._btnfinish:AddClickListener(arg_2_0._btnfinishOnClick, arg_2_0)
	arg_2_0._btnnewGame:AddClickListener(arg_2_0._btnnewGameOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnSelectDirection, arg_2_0.onSelectDirection, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, arg_2_0.onGetInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, arg_2_0.onGetReward, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnDialogueEnd, arg_2_0.refreshState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnOK:RemoveClickListener()
	arg_3_0._btnChoose:RemoveClickListener()
	arg_3_0._btnChange:RemoveClickListener()
	arg_3_0._btnfinish:RemoveClickListener()
	arg_3_0._btnnewGame:RemoveClickListener()
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnSelectDirection, arg_3_0.onSelectDirection, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, arg_3_0.onGetInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, arg_3_0.onGetReward, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnDialogueEnd, arg_3_0.refreshState, arg_3_0)
end

function var_0_0._btnOKOnClick(arg_4_0)
	if not AssassinChaseModel.instance:isCurActOpen(true) then
		return
	end

	local var_4_0 = AssassinChaseModel.instance:getCurDirectionId()

	if var_4_0 == nil then
		GameFacade.showToast(ToastEnum.AssassinChaseSelectDirectionTip)

		return
	end

	local var_4_1 = AssassinChaseModel.instance:getCurInfoMo()

	if var_4_1 == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	if var_4_1:isSelect() and var_4_1:canChangeDirection() == false then
		local var_4_2 = TimeUtil.timestampToString4(var_4_1.changeEndTime)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, var_4_2)

		return
	end

	AssassinChaseController.instance:selectionDirection(var_4_1.activityId, var_4_0)
end

function var_0_0._btnChooseOnClick(arg_5_0)
	arg_5_0:_btnChangeOnClick()
end

function var_0_0._btnChangeOnClick(arg_6_0)
	local var_6_0 = AssassinChaseModel.instance:getCurInfoMo()
	local var_6_1 = ServerTime.now()
	local var_6_2 = var_6_0.changeEndTime

	if var_6_2 <= var_6_1 then
		local var_6_3 = TimeUtil.timestampToString4(var_6_2)

		GameFacade.showToast(ToastEnum.AssassinChaseChangeTimeEndTip, var_6_3)

		return
	end

	local var_6_4 = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.DirectionChangeCount)
	local var_6_5 = tonumber(var_6_4.value)

	if var_6_0.chosenInfo.reselectedNum ~= nil and var_6_5 <= var_6_0.chosenInfo.reselectedNum then
		GameFacade.showToast(ToastEnum.AssassinChaseChangeNumsLimitTip)

		return
	end

	arg_6_0:changeState(AssassinChaseEnum.ViewState.Select)
end

function var_0_0._btnfinishOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnnewGameOnClick(arg_8_0)
	if not AssassinChaseModel.instance:isCurActOpen(true) then
		return
	end

	arg_8_0:refreshUI(false)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goItemParent = gohelper.findChild(arg_9_0.viewGO, "#go_Select/Right/Choose")

	gohelper.setActive(arg_9_0._goItem, false)

	arg_9_0._optionItemList = {}
	arg_9_0._useOptionItemList = {}
	arg_9_0._rewardItemList = {}

	gohelper.setActive(arg_9_0._gorewardItem, false)

	arg_9_0._animator = gohelper.findChildComponent(arg_9_0.viewGO, "", gohelper.Type_Animator)

	if arg_9_0._loader then
		arg_9_0._loader:dispose()

		arg_9_0._loader = nil
	end

	arg_9_0._loader = SequenceAbLoader.New()

	for iter_9_0, iter_9_1 in ipairs(AssassinChaseEnum.SpineResPath) do
		arg_9_0:addResToLoader(arg_9_0._loader, iter_9_1)
	end

	arg_9_0:addResToLoader(arg_9_0._loader, AssassinChaseEnum.MaterialResPath)
	arg_9_0._loader:setConcurrentCount(10)
	arg_9_0._loader:setLoadFailCallback(arg_9_0._onLoadOneFail)
	arg_9_0._loader:startLoad(arg_9_0._onLoadFinish, arg_9_0)

	arg_9_0._bgAnimation = gohelper.findChildComponent(arg_9_0.viewGO, "BG", gohelper.Type_Animation)
	arg_9_0._bgAnimation2 = gohelper.findChildComponent(arg_9_0.viewGO, "BG_Top", gohelper.Type_Animation)
end

function var_0_0.addResToLoader(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:addPath(arg_10_2)
end

function var_0_0._onLoadOneFail(arg_11_0, arg_11_1, arg_11_2)
	logError(string.format("%s:_onLoadOneFail 加载失败, url:%s", arg_11_0.__cname, arg_11_2.ResPath))

	if arg_11_0._callbackFunc and arg_11_0._callbackObj then
		arg_11_0._callbackFunc(arg_11_0._callbackObj)
	end

	arg_11_0._callbackFunc = nil
	arg_11_0._callbackObj = nil
end

function var_0_0._onLoadFinish(arg_12_0, arg_12_1)
	local var_12_0 = AssassinChaseEnum.MaterialResPath
	local var_12_1 = arg_12_1:getAssetItem(var_12_0):GetResource(var_12_0)

	arg_12_0._spineList = {}

	local var_12_2 = gohelper.findChild(arg_12_0.viewGO, "Anim")

	for iter_12_0, iter_12_1 in ipairs(AssassinChaseEnum.SpineResPath) do
		local var_12_3 = arg_12_1:getAssetItem(iter_12_1)

		if not var_12_3 then
			logError("can not find :" .. iter_12_1)
		else
			local var_12_4 = var_12_3:GetResource(iter_12_1)
			local var_12_5 = var_12_2.transform:GetChild(iter_12_0 - 1)
			local var_12_6 = gohelper.clone(var_12_4, var_12_5.gameObject, "spine")
			local var_12_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_5.gameObject, AssassinChaseSpineItem)

			var_12_7:replaceMaterial(var_12_1)
			table.insert(arg_12_0._spineList, var_12_7)
		end
	end

	if arg_12_0._callbackFunc and arg_12_0._callbackObj then
		arg_12_0._callbackFunc(arg_12_0._callbackObj)
	end

	arg_12_0._callbackFunc = nil
	arg_12_0._callbackObj = nil
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0.actId = AssassinChaseModel.instance:getCurActivityId()
	arg_14_0.infoMo = AssassinChaseModel.instance:getCurInfoMo()

	arg_14_0:refreshUI(true)
end

function var_0_0.onGetInfoUpdate(arg_15_0)
	logNormal("act206 onGetInfoUpdate")

	if arg_15_0.state ~= AssassinChaseEnum.ViewState.Result then
		logNormal("act206 onGetInfoUpdate result")
		arg_15_0:refreshUI(false)
	end
end

function var_0_0.refreshUI(arg_16_0, arg_16_1)
	arg_16_0:refreshState(arg_16_1)
end

function var_0_0.refreshState(arg_17_0, arg_17_1)
	if ViewMgr.instance:isOpen(ViewName.AssassinChaseChatView) then
		ViewMgr.instance:closeView(ViewName.AssassinChaseChatView)
	end

	local var_17_0 = arg_17_0.infoMo:getCurState()

	arg_17_0:changeState(var_17_0, arg_17_1)
end

function var_0_0.changeState(arg_18_0, arg_18_1, arg_18_2)
	logNormal("act206 changeState")

	local var_18_0

	if arg_18_1 == AssassinChaseEnum.ViewState.Select then
		if arg_18_2 then
			var_18_0 = arg_18_0.refreshChatState
		else
			var_18_0 = arg_18_0.refreshSelectState
		end
	elseif arg_18_1 == AssassinChaseEnum.ViewState.Result then
		var_18_0 = arg_18_0.refreshResultState
	else
		var_18_0 = arg_18_0.refreshProgressState
	end

	arg_18_0.state = arg_18_1
	arg_18_0.isOpen = arg_18_2

	TaskDispatcher.cancelTask(arg_18_0.delayRefreshNodeState, arg_18_0)

	if arg_18_2 then
		arg_18_0:delayRefreshNodeState()
	else
		TaskDispatcher.runDelay(arg_18_0.delayRefreshNodeState, arg_18_0, 0.167)
	end

	if arg_18_1 ~= AssassinChaseEnum.ViewState.Result then
		arg_18_0:playAnim(arg_18_1, arg_18_2)
	end

	if arg_18_0._spineList then
		var_18_0(arg_18_0)
	else
		arg_18_0._callbackFunc = var_18_0
		arg_18_0._callbackObj = arg_18_0
	end
end

function var_0_0.delayRefreshNodeState(arg_19_0)
	local var_19_0 = arg_19_0.state
	local var_19_1 = arg_19_0.isOpen

	logNormal("delayRefreshNodeState")
	TaskDispatcher.cancelTask(arg_19_0.delayRefreshNodeState, arg_19_0)
	gohelper.setActive(arg_19_0._goSelect, var_19_0 == AssassinChaseEnum.ViewState.Select and not var_19_1)
	gohelper.setActive(arg_19_0._goProgress, var_19_0 == AssassinChaseEnum.ViewState.Progress)
	gohelper.setActive(arg_19_0._goResult, var_19_0 == AssassinChaseEnum.ViewState.Result)
end

function var_0_0.refreshSpineState(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	local var_20_0
	local var_20_1 = AssassinChaseModel.instance:getCurInfoMo()

	if arg_20_1 == AssassinChaseEnum.ViewState.Select then
		if var_20_1:isSelect() then
			var_20_0 = AssassinChaseEnum.SpineState.Walk
		else
			var_20_0 = AssassinChaseEnum.SpineState.Idle
		end
	elseif arg_20_1 == AssassinChaseEnum.ViewState.Result then
		var_20_0 = AssassinChaseEnum.SpineState.Walk
	else
		var_20_0 = AssassinChaseEnum.SpineState.Walk
	end

	arg_20_0:playSpine(var_20_0)

	local var_20_2 = arg_20_0._spineList[AssassinChaseEnum.OtherRoleIndex]

	gohelper.setActive(var_20_2.go, var_20_1:isSelect() or arg_20_1 ~= AssassinChaseEnum.ViewState.Select)
end

function var_0_0.setOtherRolePosition(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0._spineList then
		local var_21_0 = arg_21_0._spineList[AssassinChaseEnum.OtherRoleIndex]

		if var_21_0 then
			var_21_0:setRolePosition(arg_21_1, arg_21_2, arg_21_3)
		end
	end
end

function var_0_0.setMainRolePosition(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0._spineList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._spineList) do
			if iter_22_0 ~= AssassinChaseEnum.OtherRoleIndex then
				iter_22_1:setRolePosition(arg_22_1, arg_22_2, arg_22_3)
			end
		end
	end
end

function var_0_0.playSpine(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._spineList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._spineList) do
			local var_23_0

			if iter_23_0 == AssassinChaseEnum.MainRoleIndex then
				var_23_0 = AssassinChaseEnum.MainRoleSpineState[arg_23_1]
			else
				var_23_0 = AssassinChaseEnum.OtherRoleSpineState[arg_23_1]
			end

			iter_23_1:play(var_23_0, true, false)
			iter_23_1:setBubbleActive(arg_23_2)
		end
	end
end

function var_0_0.playAnim(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if arg_24_2 then
		var_24_0 = "open"
	elseif arg_24_1 == AssassinChaseEnum.ViewState.Select then
		var_24_0 = "to_select"

		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_tan)
	else
		var_24_0 = arg_24_1 == AssassinChaseEnum.ViewState.Result and "finish" or "to_progress"
	end

	arg_24_0._animator:Play(var_24_0, 0, 0)
	logNormal("act206 playAnim AnimName: " .. var_24_0 .. " isOpen：" .. tostring(arg_24_2))
end

function var_0_0.playBgLoop(arg_25_0, arg_25_1)
	if arg_25_1 then
		arg_25_0._bgAnimation:Play()
		arg_25_0._bgAnimation2:Play()
	else
		arg_25_0._bgAnimation:Stop()
		arg_25_0._bgAnimation2:Stop()
	end
end

function var_0_0.refreshChatState(arg_26_0)
	logNormal("对话")
	arg_26_0:refreshSpineState(arg_26_0.state)
	arg_26_0:setMainRolePosition(-100, false)
	arg_26_0:setOtherRolePosition(-100, false)
	AssassinChaseController.instance:openDialogueView(arg_26_0.actId)
	arg_26_0:playBgLoop(false)
end

function var_0_0.refreshSelectState(arg_27_0)
	arg_27_0:refreshSpineState(arg_27_0.state)

	local var_27_0 = arg_27_0.infoMo

	if var_27_0:isSelect() then
		arg_27_0:playBgLoop(true)
		arg_27_0:setMainRolePosition(-50, true, 0.5)
		arg_27_0:setOtherRolePosition(200, true, 0.5)
	else
		arg_27_0:playBgLoop(false)
		arg_27_0:setMainRolePosition(-100, false)
		arg_27_0:setOtherRolePosition(-100, false)
	end

	local var_27_1 = var_27_0.optionDirections
	local var_27_2 = arg_27_0._optionItemList
	local var_27_3 = #var_27_1
	local var_27_4 = #var_27_2

	tabletool.clear(arg_27_0._useOptionItemList)

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		local var_27_5

		if var_27_4 < iter_27_0 then
			local var_27_6 = gohelper.clone(arg_27_0._goItem, arg_27_0._goItemParent)

			var_27_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_6, AssassinChaseOptionItem)

			table.insert(arg_27_0._optionItemList, var_27_5)
		else
			var_27_5 = var_27_2[iter_27_0]
		end

		table.insert(arg_27_0._useOptionItemList, var_27_5)
		var_27_5:setActive(true)
		var_27_5:setData(var_27_0.activityId, iter_27_1)
	end

	if var_27_3 < var_27_4 then
		for iter_27_2 = var_27_1 + 1, var_27_4 do
			var_27_2[iter_27_2]:clear()
		end
	end

	local var_27_7 = ServerTime.getToadyEndTimeStamp() + var_27_0.nextDayChangeOffset
	local var_27_8 = TimeUtil.timestampToString4(var_27_7)

	arg_27_0._txtSelectTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_change_direction_time_tip"), var_27_8)
end

function var_0_0.onSelectDirection(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._useOptionItemList) do
		iter_28_1:setSelect(arg_28_1)
		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_common_click_chase)
	end
end

function var_0_0.refreshProgressState(arg_29_0)
	arg_29_0:refreshSpineState(arg_29_0.state)

	if arg_29_0.isOpen then
		arg_29_0:setMainRolePosition(-50, false)
		arg_29_0:setOtherRolePosition(200, false)
	else
		arg_29_0:setMainRolePosition(-50, true, 0.5)
		arg_29_0:setOtherRolePosition(200, true, 0.5)
	end

	arg_29_0:playBgLoop(true)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_run)

	local var_29_0 = arg_29_0.infoMo
	local var_29_1 = var_29_0.rewardTime
	local var_29_2 = var_29_0.changeEndTime
	local var_29_3 = TimeUtil.timestampToString4(var_29_1)
	local var_29_4 = TimeUtil.timestampToString4(var_29_2)
	local var_29_5 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_get_reward_time_tip"), var_29_3)

	arg_29_0._txtProgressTips.text = var_29_5

	local var_29_6 = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.DirectionChangeCount)
	local var_29_7 = tonumber(var_29_6.value)

	if var_29_0.chosenInfo.reselectedNum ~= nil and var_29_7 <= var_29_0.chosenInfo.reselectedNum then
		arg_29_0._txtChangeTips.text = var_29_5
	else
		arg_29_0._txtChangeTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLangUTC("assassinChase_change_direction_time_tip"), var_29_4)
	end

	local var_29_8 = var_29_0.chosenInfo.currentDirection
	local var_29_9 = AssassinChaseConfig.instance:getDirectionConfig(arg_29_0.actId, var_29_8)

	if var_29_9 == nil then
		logError("奥德赛 下半活动 追逐游戏活动 方向id不存在 id:" .. var_29_8)
		arg_29_0:clear()

		return
	end

	arg_29_0._txtCurDirectionPath.text = var_29_9.name

	if string.nilorempty(var_29_9.pic) then
		return
	end

	UISpriteSetMgr.instance:setSp01Act205Sprite(arg_29_0._imageCurDirectionIcon, var_29_9.pic)
end

function var_0_0.refreshResultState(arg_30_0)
	logNormal("act206 refreshResultState")
	arg_30_0:refreshSpineState(arg_30_0.state)
	arg_30_0:playBgLoop(true)
	arg_30_0:setMainRolePosition(-50, false)
	arg_30_0:setOtherRolePosition(200, false)
	arg_30_0:setMainRolePosition(25, true, 0.5)
	arg_30_0:setOtherRolePosition(-25, true, 1.1)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_run)
	arg_30_0:autoGetReward()

	local var_30_0 = arg_30_0.infoMo

	if var_30_0 == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	local var_30_1 = AssassinChaseConfig.instance:getRewardConfig(var_30_0.chosenInfo.rewardId)

	arg_30_0._txtDesc.text = var_30_1.des

	arg_30_0:refreshReward(var_30_0.chosenInfo.rewardId, var_30_1.reward)
end

function var_0_0.onOtherRoleFinish(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.onOtherRoleFinish, arg_31_0)
end

function var_0_0.onMainRoleFinish(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.onMainRoleFinish, arg_32_0)
end

function var_0_0.autoGetReward(arg_33_0)
	arg_33_0:_lockScreen(true)
	logNormal("奥德赛 下半追逐游戏 自动领奖")
	TaskDispatcher.cancelTask(arg_33_0.playFinishAnim, arg_33_0)
	TaskDispatcher.runDelay(arg_33_0.playFinishAnim, arg_33_0, 1.2)
end

function var_0_0.playFinishAnim(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.playFinishAnim, arg_34_0)
	arg_34_0:playAnim(arg_34_0.state)
	arg_34_0:playSpine(AssassinChaseEnum.SpineState.Skill, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_win_chase)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.stop_ui_s01_yunying_run)
	arg_34_0:playBgLoop(false)
	TaskDispatcher.runDelay(arg_34_0.getReward, arg_34_0, 1.2)
end

function var_0_0.getReward(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.getReward, arg_35_0)

	local var_35_0 = arg_35_0.actId

	AssassinChaseController.instance:getReward(var_35_0)
end

function var_0_0.onGetReward(arg_36_0)
	logNormal("奥德赛 下半追逐游戏 领奖")

	for iter_36_0, iter_36_1 in ipairs(arg_36_0._rewardItemList) do
		iter_36_1:setGetState(true)
	end

	arg_36_0:_lockScreen(false)
end

function var_0_0.refreshReward(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = not string.nilorempty(arg_37_2)

	gohelper.setActive(arg_37_0._goreward, var_37_0)

	if var_37_0 == false then
		logError("奥德赛 下半活动 追逐游戏活动 奖励为空 id:" .. arg_37_1)

		return
	end

	local var_37_1 = string.split(arg_37_2, "|")
	local var_37_2 = arg_37_0._rewardItemList
	local var_37_3 = #var_37_2
	local var_37_4 = #var_37_1

	for iter_37_0, iter_37_1 in ipairs(var_37_1) do
		local var_37_5

		if var_37_3 < iter_37_0 then
			local var_37_6 = gohelper.clone(arg_37_0._gorewardItem, arg_37_0._goreward)

			var_37_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_37_6, AssassinChaseRewardItem)

			table.insert(var_37_2, var_37_5)
		else
			var_37_5 = var_37_2[iter_37_0]
		end

		var_37_5:setActive(true)
		var_37_5:setGetState(false)
		var_37_5:setData(iter_37_1)
	end

	if var_37_4 < var_37_3 then
		for iter_37_2 = var_37_4 + 1, var_37_3 do
			var_37_2[iter_37_2]:setActive(false)
		end
	end
end

function var_0_0._lockScreen(arg_38_0, arg_38_1)
	if arg_38_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AssassinChaseResultView")
		TaskDispatcher.runDelay(arg_38_0.forceEndLock, arg_38_0, AssassinChaseEnum.ForceEndLockTime)
	else
		UIBlockMgr.instance:endBlock("AssassinChaseResultView")
		UIBlockMgrExtend.setNeedCircleMv(true)
		TaskDispatcher.cancelTask(arg_38_0.forceEndLock, arg_38_0)
	end
end

function var_0_0.forceEndLock(arg_39_0)
	arg_39_0:_lockScreen(false)
	logError("奥德赛 下半活动 自动领奖失效")
end

function var_0_0.onClose(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.forceEndLock, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.getReward, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.playFinishAnim, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.delayRefreshNodeState, arg_40_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.stop_ui_s01_yunying_run)

	if arg_40_0.infoMo:isSelect() and ViewMgr.instance:isOpen(ViewName.Act205GameStartView) then
		ViewMgr.instance:closeView(ViewName.Act205GameStartView)
	end
end

function var_0_0.onDestroyView(arg_41_0)
	if arg_41_0._loader then
		arg_41_0._loader:dispose()

		arg_41_0._loader = nil
	end
end

return var_0_0
