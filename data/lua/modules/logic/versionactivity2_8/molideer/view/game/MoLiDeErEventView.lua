module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventView", package.seeall)

local var_0_0 = class("MoLiDeErEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCloseBg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseBg")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._simagePic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Pic")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._scrollDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Desc")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_Desc/Viewport/Content/#txt_Desc")
	arg_1_0._goBtn = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn")
	arg_1_0._goBG1 = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn/#go_BG1")
	arg_1_0._goBG2 = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn/#go_BG2")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/#txt_Name")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/#txt_Descr")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/image_Icon/#txt_Num")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_options")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Skip")
	arg_1_0._goDispatchParent = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchParent")
	arg_1_0._animator = gohelper.findChildComponent(arg_1_0.viewGO, "", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseBg:AddClickListener(arg_2_0._btnCloseBgOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._btnSkipOnClick, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_2_0.onOptionSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_2_0.onTeamSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, arg_2_0.onDispatchTeam, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, arg_2_0.onWithdrawTeam, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, arg_2_0.onItemUse, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseBg:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_3_0.onOptionSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_3_0.onTeamSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, arg_3_0.onDispatchTeam, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, arg_3_0.onWithdrawTeam, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, arg_3_0.onItemUse, arg_3_0)
end

function var_0_0._btnCloseBgOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnSkipOnClick(arg_6_0)
	arg_6_0:onDescShowEnd()
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer._viewSetting.otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._goDispatchParent)

	arg_7_0._dispatchItem, arg_7_0._goDispatch = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, MoLiDeErDispatchItem), var_7_1
	arg_7_0._optionItemList = {}
	arg_7_0._optionParentPointList = {}

	local var_7_2 = arg_7_0._gooptions.transform.childCount

	for iter_7_0 = 1, var_7_2 do
		local var_7_3 = arg_7_0._gooptions.transform:GetChild(iter_7_0 - 1).gameObject

		table.insert(arg_7_0._optionParentPointList, var_7_3)
	end

	gohelper.setActive(arg_7_0._goBtn, false)
	gohelper.setActive(arg_7_0._goDispatch, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.eventId
	local var_9_1 = arg_9_0.viewParam.state
	local var_9_2 = arg_9_0.viewParam.optionId

	arg_9_0._eventId = var_9_0
	arg_9_0._state = var_9_1
	arg_9_0._optionId = var_9_2
	arg_9_0._eventConfig = MoLiDeErConfig.instance:getEventConfig(var_9_0)
	arg_9_0._eventInfo = MoLiDeErGameModel.instance:getCurGameInfo():getEventInfo(var_9_0)

	if var_9_1 == MoLiDeErEnum.DispatchState.Finish then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_jlbn_open)
	end

	arg_9_0:refreshInfo()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:playAnim()
	arg_10_0:refreshState()
	arg_10_0:refreshOptions()
	arg_10_0:refreshDispatch()
end

function var_0_0.onItemUse(arg_11_0)
	arg_11_0:refreshOptions()

	local var_11_0 = MoLiDeErGameModel.instance:getSelectOptionId()
	local var_11_1 = arg_11_0._optionItemList

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if iter_11_1.optionId and iter_11_1.optionId == var_11_0 and iter_11_1._canSelect == false then
			MoLiDeErGameModel.instance:setSelectOptionId(nil)

			return
		end
	end
end

function var_0_0.playAnim(arg_12_0)
	local var_12_0 = arg_12_0._state == MoLiDeErEnum.DispatchState.Finish and MoLiDeErEnum.AnimName.EventViewFinishOpen or MoLiDeErEnum.AnimName.EventViewSwitchOpen

	if arg_12_0._animator then
		arg_12_0._animator:Play(var_12_0, 0, 0)
	else
		logError("莫莉德尔角色活动 关卡页面动画组件不存在 动画名：" .. var_12_0)
	end
end

function var_0_0.refreshState(arg_13_0)
	local var_13_0 = arg_13_0._state

	gohelper.setActive(arg_13_0._gooptions, var_13_0 ~= MoLiDeErEnum.DispatchState.Finish)
	gohelper.setActive(arg_13_0._goDispatch, var_13_0 ~= MoLiDeErEnum.DispatchState.Finish)
end

function var_0_0.refreshOptions(arg_14_0)
	if arg_14_0._state ~= MoLiDeErEnum.DispatchState.Dispatch then
		gohelper.setActive(arg_14_0._gooptions, false)

		return
	end

	local var_14_0 = arg_14_0._eventInfo.options

	gohelper.setActive(arg_14_0._gooptions, var_14_0 ~= nil)

	if var_14_0 == nil then
		return
	end

	local var_14_1 = #var_14_0

	gohelper.setActive(arg_14_0._gooptions, var_14_1 > 0)

	if var_14_1 <= 0 then
		return
	end

	local var_14_2 = arg_14_0._optionItemList
	local var_14_3 = #var_14_2
	local var_14_4 = arg_14_0._optionParentPointList
	local var_14_5 = #arg_14_0._optionParentPointList

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_6

		if var_14_3 < iter_14_0 then
			if var_14_5 < iter_14_0 then
				logError("莫莉德尔角色活动 选项数量超过上限")
			else
				local var_14_7 = var_14_4[iter_14_0]
				local var_14_8 = gohelper.clone(arg_14_0._goBtn, var_14_7)

				var_14_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_8, MoLiDeErOptionItem)

				table.insert(var_14_2, var_14_6)
			end
		else
			var_14_6 = var_14_2[iter_14_0]
		end

		var_14_6:setActive(true)
		var_14_6:setData(iter_14_1)
	end

	if var_14_1 < var_14_3 then
		for iter_14_2 = var_14_1 + 1, var_14_3 do
			var_14_2[iter_14_2]:setActive(false)
		end
	end
end

function var_0_0.autoSpeak(arg_15_0)
	if not arg_15_0._curTxtData then
		return
	end

	local var_15_0 = (arg_15_0._curTxtData.index or 0) + 1

	arg_15_0._curTxtData.index = var_15_0
	arg_15_0._curTxtData.txt.text = table.concat(arg_15_0._curTxtData.chars, "", 1, var_15_0)
	arg_15_0._curTxtData.isEnd = var_15_0 >= arg_15_0._curTxtData.charCount

	if arg_15_0._curTxtData.isEnd then
		arg_15_0:onDescShowEnd()
	end
end

function var_0_0.onDescShowEnd(arg_16_0)
	if arg_16_0._curTxtData.isEnd == false then
		local var_16_0 = arg_16_0._eventConfig

		arg_16_0._txtDesc.text = var_16_0.desc
	end

	TaskDispatcher.cancelTask(arg_16_0.autoSpeak, arg_16_0)
	gohelper.setActive(arg_16_0._btnSkip, false)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	TaskDispatcher.runDelay(arg_16_0.onDescShowDelayTimEnd, arg_16_0, MoLiDeErEnum.DelayTime.DescBtnShowDelay)
	arg_16_0:_lockScreen(true)
end

function var_0_0.onDescShowDelayTimEnd(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onDescShowDelayTimEnd, arg_17_0)
	arg_17_0:_lockScreen(false)
	arg_17_0:refreshUI()
	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GuideDescShowEnd)
end

function var_0_0._lockScreen(arg_18_0, arg_18_1)
	if arg_18_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErEventView")
	else
		UIBlockMgr.instance:endBlock("MoLiDeErEventView")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.refreshDispatch(arg_19_0)
	local var_19_0 = arg_19_0._state
	local var_19_1 = var_19_0 == MoLiDeErEnum.DispatchState.Dispatch or var_19_0 == MoLiDeErEnum.DispatchState.Dispatching

	gohelper.setActive(arg_19_0._goDispatch, var_19_1)

	if not var_19_1 then
		return
	end

	arg_19_0._dispatchItem:setData(arg_19_0._state, arg_19_0._eventId, arg_19_0._optionId)
end

function var_0_0.refreshInfo(arg_20_0)
	local var_20_0 = arg_20_0._eventConfig
	local var_20_1 = arg_20_0._optionId and arg_20_0._optionId ~= 0 and arg_20_0._state == MoLiDeErEnum.DispatchState.Finish

	gohelper.setActive(arg_20_0._btnSkip, arg_20_0._state == MoLiDeErEnum.DispatchState.Dispatch)

	if var_20_1 then
		local var_20_2 = arg_20_0._optionId
		local var_20_3 = MoLiDeErConfig.instance:getOptionConfig(var_20_2)
		local var_20_4 = MoLiDeErConfig.instance:getOptionResultConfig(var_20_3.optionResultId)
		local var_20_5 = MoLiDeErHelper.getOptionResultEffectParamList(var_20_3.optionResultId)

		arg_20_0._txtTitle.text = var_20_4.name
		arg_20_0._txtDesc.text = GameUtil.getSubPlaceholderLuaLang(var_20_4.desc, var_20_5)

		arg_20_0:refreshUI()
	else
		arg_20_0._txtTitle.text = var_20_0.name

		if arg_20_0._state == MoLiDeErEnum.DispatchState.Dispatch then
			local var_20_6 = GameUtil.getUCharArrWithLineFeedWithoutRichTxt(var_20_0.desc)

			arg_20_0._curTxtData = {
				isEnd = false,
				txt = arg_20_0._txtDesc,
				chars = var_20_6,
				charCount = #var_20_6
			}

			TaskDispatcher.runRepeat(arg_20_0.autoSpeak, arg_20_0, MoLiDeErEnum.DelayTime.DescTextShowDelay)
		else
			arg_20_0._txtDesc.text = var_20_0.desc

			arg_20_0:refreshUI()
		end
	end
end

function var_0_0.onOptionSelect(arg_21_0, arg_21_1)
	if arg_21_1 == arg_21_0._selectOptionId then
		return
	end

	arg_21_0._selectOptionId = arg_21_1

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._optionItemList) do
		iter_21_1:setSelect(arg_21_1)
	end
end

function var_0_0.onTeamSelect(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		return
	end

	if arg_22_0._state == MoLiDeErEnum.DispatchState.Dispatch then
		arg_22_0:refreshOptions()
	end
end

function var_0_0.onDispatchTeam(arg_23_0)
	if arg_23_0._state == MoLiDeErEnum.DispatchState.Dispatch then
		arg_23_0:closeThis()
	end
end

function var_0_0.onWithdrawTeam(arg_24_0)
	if arg_24_0._state == MoLiDeErEnum.DispatchState.Dispatching then
		arg_24_0:closeThis()
	end
end

function var_0_0.onClose(arg_25_0)
	MoLiDeErGameModel.instance:resetSelect()
	TaskDispatcher.cancelTask(arg_25_0._autoSpeak, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
