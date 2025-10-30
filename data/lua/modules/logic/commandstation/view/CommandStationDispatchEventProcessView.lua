module("modules.logic.commandstation.view.CommandStationDispatchEventProcessView", package.seeall)

local var_0_0 = class("CommandStationDispatchEventProcessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goDispatchEvent = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent")
	arg_1_0._goDispatchPanel = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#txt_title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Scroll DecView/Viewport/#txt_Descr")
	arg_1_0._goHerocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer")
	arg_1_0._txtspecialtip = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer/#txt_specialtip")
	arg_1_0._goselectheroitem = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer/herocontainer/#go_selectheroitem")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Reward/#go_Item")
	arg_1_0._godispatch = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch")
	arg_1_0._txtcosttime2 = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch/#txt_costtime2")
	arg_1_0._btndispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch/#btn_dispatch")
	arg_1_0._going = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing/#txt_time")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing/#slider_progress")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/header/#btn_close2")
	arg_1_0._scrollhero = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/Mask/#scroll_hero")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchEvent/#go_DispatchPanel/#go_topright")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndispatch:AddClickListener(arg_2_0._btndispatchOnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndispatch:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._btnclose2OnClick(arg_4_0)
	arg_4_0:_changeHeroContainerVisible(false)
end

function var_0_0._btndispatchOnClick(arg_5_0)
	local var_5_0 = arg_5_0:_getEventConfig()

	if not var_5_0 then
		return
	end

	arg_5_0:_changeHeroContainerVisible(false)

	if CommandStationHeroListModel.instance:getSelectedHeroNum() ~= var_5_0.chaNum then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	local var_5_1 = CommandStationHeroListModel.instance:getSelectedHeroIdList()

	CommandStationRpc.instance:sendCommandPostDispatchRequest(var_5_0.id, var_5_1, arg_5_0._onDispatchSuccess, arg_5_0)
end

function var_0_0._onDispatchSuccess(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	local var_6_0 = arg_6_0:_getEventConfig()

	if not var_6_0 then
		return
	end

	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
	arg_6_0:_updateEventState(var_6_0)
	arg_6_0:_updateBtnState(var_6_0)
	arg_6_0:_updateEventInfo(var_6_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchStart)
end

function var_0_0._btnreturnOnClick(arg_7_0)
	return
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._animator = arg_8_0.viewGO:GetComponent("Animator")

	gohelper.setActive(arg_8_0._goherocontainer, false)
	arg_8_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchHeroListChange, arg_8_0._onDispatchHeroListChange, arg_8_0)
end

function var_0_0._onDispatchHeroListChange(arg_9_0)
	local var_9_0 = arg_9_0:_getEventConfig()

	if not var_9_0 then
		return
	end

	arg_9_0:_updateHeroList(var_9_0)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchChangeTab, arg_11_0._onDispatchChangeTab, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0._OnCloseViewFinish, arg_11_0)
	arg_11_0:_initHeroList()
end

function var_0_0._OnCloseViewFinish(arg_12_0)
	arg_12_0:_sendFinishEventRequest()
end

function var_0_0._onDispatchChangeTab(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._isShow and not arg_13_1 and arg_13_2 ~= nil then
		if not arg_13_0._oldEventConfig then
			return
		end

		arg_13_0._isPlaySwitchAnim = true

		arg_13_0:_updateAllInfo(arg_13_0._oldEventConfig)
		arg_13_0._animator:Play(arg_13_2 and "switchleft" or "switchright", 0, 0)
		TaskDispatcher.cancelTask(arg_13_0._afterSwitchUpdateEventInfo, arg_13_0)
		TaskDispatcher.runDelay(arg_13_0._afterSwitchUpdateEventInfo, arg_13_0, 0.167)
	end
end

function var_0_0._afterSwitchUpdateEventInfo(arg_14_0)
	arg_14_0._isPlaySwitchAnim = false

	arg_14_0:_updateAllInfo(arg_14_0._eventConfig)
end

function var_0_0.onTabSwitchOpen(arg_15_0)
	if not arg_15_0._isShow then
		arg_15_0._animator:Play("open", 0, 0)
	end

	arg_15_0._heroContainerVisible = false
	arg_15_0._isShow = true
	arg_15_0._oldEventConfig = arg_15_0._eventConfig
	arg_15_0._eventConfig = arg_15_0.viewContainer:getCurrentEventConfig()

	arg_15_0:_updateAllInfo(arg_15_0._eventConfig)
end

function var_0_0._getEventConfig(arg_16_0)
	if arg_16_0._isPlaySwitchAnim then
		return nil
	end

	return arg_16_0._eventConfig
end

function var_0_0._updateAllInfo(arg_17_0, arg_17_1)
	CommandStationHeroListModel.instance:initAllEventSelectedHeroList()
	CommandStationHeroListModel.instance:setSpecialHeroList(arg_17_1.chaId)
	CommandStationHeroListModel.instance:setSelectedHeroNum(arg_17_1.chaNum)
	arg_17_0:_updateEventState(arg_17_1)
	arg_17_0:_updateEventInfo(arg_17_1)
	arg_17_0:_updateHeroList(arg_17_1)
	arg_17_0:_updateBtnState(arg_17_1)
	arg_17_0:_showReward(arg_17_1)
end

function var_0_0.onTabSwitchClose(arg_18_0)
	arg_18_0._isShow = false

	CommandStationHeroListModel.instance:clearHeroList()
	CommandStationHeroListModel.instance:clearSelectedHeroList()
	arg_18_0:_killTween()
	gohelper.setActive(arg_18_0._goherocontainer, false)
end

function var_0_0._updateHeroList(arg_19_0, arg_19_1)
	arg_19_0._specialHeroNum = 0

	if arg_19_0._eventState == CommandStationEnum.DispatchState.NotStart then
		arg_19_0:_updateNotStartHeroList(arg_19_1)
	else
		arg_19_0:_updateStartedHeroList(arg_19_1)
	end
end

function var_0_0._updateNotStartHeroList(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.chaNum

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroList) do
		local var_20_1 = iter_20_0 <= var_20_0

		gohelper.setActive(iter_20_1.item, var_20_1)

		local var_20_2 = CommandStationHeroListModel.instance:getHeroByIndex(iter_20_0)

		var_20_1 = var_20_1 and var_20_2

		gohelper.setActive(iter_20_1.container, var_20_1)

		if var_20_1 then
			local var_20_3 = var_20_2.config
			local var_20_4 = var_20_3.skinId
			local var_20_5 = SkinConfig.instance:getSkinCo(var_20_4)

			iter_20_1.icon:LoadImage(ResUrl.getHeadIconSmall(var_20_5.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(iter_20_1.career, "lssx_" .. var_20_3.career)

			if CommandStationHeroListModel.instance:heroIsSpecial(var_20_2.heroId) then
				arg_20_0._specialHeroNum = arg_20_0._specialHeroNum + 1
			end
		end
	end

	local var_20_6 = arg_20_0._specialHeroNum > 0 and arg_20_1.allTime - arg_20_1.reduceTime or arg_20_1.allTime

	arg_20_0:_updateCostTime(var_20_6)
end

function var_0_0._updateStartedHeroList(arg_21_0)
	local var_21_0 = arg_21_0._eventInfo.heroIds

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._heroList) do
		local var_21_1 = var_21_0[iter_21_0]
		local var_21_2 = HeroModel.instance:getByHeroId(var_21_1)

		if var_21_2 then
			gohelper.setActive(iter_21_1.container, true)

			local var_21_3 = var_21_2.config
			local var_21_4 = var_21_3.skinId
			local var_21_5 = SkinConfig.instance:getSkinCo(var_21_4)

			iter_21_1.icon:LoadImage(ResUrl.getHeadIconSmall(var_21_5.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(iter_21_1.career, "lssx_" .. var_21_3.career)
		end

		if CommandStationHeroListModel.instance:heroIsSpecial(var_21_1) then
			arg_21_0._specialHeroNum = arg_21_0._specialHeroNum + 1
		end
	end
end

function var_0_0._updateCostTime(arg_22_0, arg_22_1)
	arg_22_0._txtcosttime2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("commandstation_dispatch_event_forecast_time"), tostring(arg_22_1) .. "s")
end

function var_0_0._formatTime(arg_23_0, arg_23_1)
	local var_23_0, var_23_1, var_23_2 = TimeUtil.secondToHMS(arg_23_1)

	return string.format("%s:%s:%s", arg_23_0:_formatNum(var_23_0), arg_23_0:_formatNum(var_23_1), arg_23_0:_formatNum(var_23_2))
end

function var_0_0._formatNum(arg_24_0, arg_24_1)
	if arg_24_1 >= 10 then
		return arg_24_1
	end

	return "0" .. arg_24_1
end

function var_0_0._initHeroList(arg_25_0)
	if arg_25_0._addBtnList then
		return
	end

	arg_25_0._addBtnList = arg_25_0:getUserDataTb_()
	arg_25_0._heroList = arg_25_0:getUserDataTb_()

	for iter_25_0 = 2, CommandStationEnum.DispatchCharacterNum do
		local var_25_0 = gohelper.cloneInPlace(arg_25_0._goselectheroitem)

		arg_25_0:_initHeroItem(var_25_0, iter_25_0)
	end

	arg_25_0:_initHeroItem(arg_25_0._goselectheroitem, 1)
end

function var_0_0._initHeroItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = gohelper.findChildButtonWithAudio(arg_26_1, "add")

	var_26_0:AddClickListener(arg_26_0._btnAddOnClick, arg_26_0)

	arg_26_0._addBtnList[arg_26_2] = var_26_0

	local var_26_1 = gohelper.findChild(arg_26_1, "go_hero")
	local var_26_2 = gohelper.findChildSingleImage(arg_26_1, "go_hero/simage_heroicon")
	local var_26_3 = gohelper.findChildImage(arg_26_1, "go_hero/image_career")

	gohelper.setActive(var_26_1, false)

	arg_26_0._heroList[arg_26_2] = {
		item = arg_26_1,
		container = var_26_1,
		icon = var_26_2,
		career = var_26_3
	}
end

function var_0_0._btnAddOnClick(arg_27_0)
	if arg_27_0._eventState ~= CommandStationEnum.DispatchState.NotStart then
		return
	end

	arg_27_0:_changeHeroContainerVisible(true)
	CommandStationHeroListModel.instance:initHeroList()
end

function var_0_0._changeHeroContainerVisible(arg_28_0, arg_28_1)
	if arg_28_0._heroContainerVisible == arg_28_1 then
		return
	end

	arg_28_0._heroContainerVisible = arg_28_1

	gohelper.setActive(arg_28_0._goherocontainer, true)
	arg_28_0._animator:Play(arg_28_1 and "leftin" or "leftout", 0, 0)
end

function var_0_0._updateEventInfo(arg_29_0, arg_29_1)
	local var_29_0 = string.splitToNumber(arg_29_1.eventTextId, "#")
	local var_29_1 = arg_29_0._eventState == CommandStationEnum.DispatchState.GetReward and var_29_0[2] or var_29_0[1]
	local var_29_2 = var_29_1 and lua_copost_event_text.configDict[var_29_1]

	arg_29_0._txtDescr.text = var_29_2 and var_29_2.text
	arg_29_0._txtspecialtip.text = arg_29_1.needchaText
end

function var_0_0._updateEventState(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.id

	arg_30_0._eventInfo = CommandStationModel.instance:getDispatchEventInfo(var_30_0)
	arg_30_0._eventState = CommandStationModel.instance:getDispatchEventState(var_30_0)
end

function var_0_0._updateBtnState(arg_31_0, arg_31_1)
	gohelper.setActive(arg_31_0._godispatch, arg_31_0._eventState == CommandStationEnum.DispatchState.NotStart)
	gohelper.setActive(arg_31_0._going, arg_31_0._eventState ~= CommandStationEnum.DispatchState.NotStart)

	if arg_31_0._eventState == CommandStationEnum.DispatchState.NotStart then
		return
	end

	arg_31_0:_updateProgress(arg_31_1)
end

function var_0_0._killTween(arg_32_0)
	if arg_32_0._tweenId then
		ZProj.TweenHelper.KillById(arg_32_0._tweenId)

		arg_32_0._tweenId = nil
	end
end

function var_0_0._startTween(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_33_1, arg_33_2, arg_33_3, arg_33_0._onTweenUpdate, arg_33_0._onTweenFinish, arg_33_0)
end

function var_0_0._onTweenUpdate(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._remainTime - (Time.realtimeSinceStartup - arg_34_0._startTweenTime)
	local var_34_1 = math.max(var_34_0, 0)

	arg_34_0._txttime.text = string.format("%ss", math.ceil(var_34_1))

	arg_34_0._sliderprogress:SetValue(var_34_1 / arg_34_0._totalTime)
end

function var_0_0._onTweenFinish(arg_35_0)
	arg_35_0._needFinishRequest = true

	arg_35_0:_sendFinishEventRequest()
end

function var_0_0._sendFinishEventRequest(arg_36_0)
	local var_36_0 = arg_36_0:_getEventConfig()

	if not var_36_0 then
		return
	end

	if arg_36_0._isShow and arg_36_0._needFinishRequest and ViewHelper.instance:checkViewOnTheTop(ViewName.CommandStationDispatchEventMainView) then
		arg_36_0._needFinishRequest = false

		CommandStationRpc.instance:sendFinishCommandPostEventRequest(var_36_0.id, arg_36_0._finishCommand, arg_36_0)
	end
end

function var_0_0._updateProgress(arg_37_0, arg_37_1)
	local var_37_0, var_37_1 = arg_37_0._eventInfo:getTimeInfo()

	arg_37_0._remainTime = math.min(var_37_0, var_37_1)
	arg_37_0._startTweenTime = Time.realtimeSinceStartup
	arg_37_0._totalTime = var_37_1

	arg_37_0:_killTween()
	arg_37_0:_startTween(var_37_0 / var_37_1, 0, var_37_0)
end

function var_0_0._finishCommand(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_2 ~= 0 then
		return
	end

	local var_38_0 = arg_38_0:_getEventConfig()

	if not var_38_0 then
		return
	end

	arg_38_0:_updateEventState(var_38_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchFinish)
end

function var_0_0._showReward(arg_39_0, arg_39_1)
	gohelper.setActive(arg_39_0._goItem, false)

	arg_39_0._itemList = arg_39_0._itemList or arg_39_0:getUserDataTb_()

	local var_39_0 = string.split(arg_39_1.bonus, "|")

	for iter_39_0 = 1, #var_39_0 do
		local var_39_1 = arg_39_0._itemList[iter_39_0]

		if not var_39_1 then
			var_39_1 = {
				parentGo = gohelper.cloneInPlace(arg_39_0._goItem)
			}
			var_39_1.commonitemicon = gohelper.findChild(var_39_1.parentGo, "commonitemicon")
			var_39_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_39_1.commonitemicon)
			arg_39_0._itemList[iter_39_0] = var_39_1
		end

		local var_39_2 = string.splitToNumber(var_39_0[iter_39_0], "#")

		gohelper.setActive(var_39_1.parentGo, true)
		var_39_1.itemIcon:setMOValue(var_39_2[1], var_39_2[2], var_39_2[3], nil, true)
		var_39_1.itemIcon:isShowCount(var_39_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_39_1.itemIcon:setCountFontSize(40)
		var_39_1.itemIcon:showStackableNum2()
		var_39_1.itemIcon:setHideLvAndBreakFlag(true)
		var_39_1.itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_39_1 = #var_39_0 + 1, #arg_39_0._itemList do
		local var_39_3 = arg_39_0._itemList[iter_39_1]

		if var_39_3 then
			gohelper.setActive(var_39_3.parentGo, false)
		end
	end
end

function var_0_0.onClose(arg_40_0)
	if arg_40_0._addBtnList then
		for iter_40_0, iter_40_1 in ipairs(arg_40_0._addBtnList) do
			iter_40_1:RemoveClickListener()
		end
	end

	arg_40_0._animator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(arg_40_0._afterSwitchUpdateEventInfo, arg_40_0)
end

function var_0_0.onDestroyView(arg_41_0)
	return
end

return var_0_0
