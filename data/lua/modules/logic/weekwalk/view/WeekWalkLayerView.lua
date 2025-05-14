module("modules.logic.weekwalk.view.WeekWalkLayerView", package.seeall)

local var_0_0 = class("WeekWalkLayerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_right")
	arg_1_0._goshallow = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_shallow ")
	arg_1_0._godeep = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_deep")
	arg_1_0._gocountdown = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_deep/#go_countdown")
	arg_1_0._txtcountday = gohelper.findChildText(arg_1_0.viewGO, "bottom_left/#go_deep/#go_countdown/#txt_countday")
	arg_1_0._goexcept = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_deep/#go_except")
	arg_1_0._goruleIcon = gohelper.findChild(arg_1_0.viewGO, "#go_ruleIcon")
	arg_1_0._btnruleIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ruleIcon/#btn_ruleIcon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnruleIcon:AddClickListener(arg_2_0._btnruleIconOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnruleIcon:RemoveClickListener()
end

function var_0_0._btnruleIconOnClick(arg_4_0)
	WeekWalkController.instance:openWeekWalkRuleView()
end

function var_0_0._btnleftOnClick(arg_5_0)
	local var_5_0 = arg_5_0._pageIndex

	arg_5_0._pageIndex = var_5_0 - 1

	arg_5_0:_tweenPos()
	arg_5_0:_updateBtns()
	arg_5_0:_pageTransition(var_5_0, arg_5_0._pageIndex)
end

function var_0_0._btnrightOnClick(arg_6_0)
	local var_6_0 = arg_6_0._pageIndex

	arg_6_0._pageIndex = var_6_0 + 1

	arg_6_0:_tweenPos()
	arg_6_0:_updateBtns()
	arg_6_0:_pageTransition(var_6_0, arg_6_0._pageIndex)
end

function var_0_0._editableInitView(arg_7_0)
	WeekWalkModel.instance:clearOldInfo()
	gohelper.addUIClickAudio(arg_7_0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(arg_7_0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._gotopleft = gohelper.findChild(arg_7_0.viewGO, "top_left")
end

function var_0_0._initPages(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_weekwalk.configList) do
		if iter_8_1.type <= 2 then
			local var_8_2 = 1
			local var_8_3 = var_8_0[var_8_2] or {}

			table.insert(var_8_3, iter_8_1)

			var_8_0[var_8_2] = var_8_3
		end
	end

	local var_8_4 = WeekWalkModel.instance:getInfo()
	local var_8_5 = WeekWalkConfig.instance:getDeepLayer(var_8_4.issueId)
	local var_8_6 = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if var_8_5 then
		for iter_8_2, iter_8_3 in ipairs(var_8_5) do
			if not arg_8_0.isVerifing or not (var_8_6 < iter_8_3.layer) then
				local var_8_7 = 2
				local var_8_8 = var_8_0[var_8_7] or {}

				table.insert(var_8_8, iter_8_3)

				var_8_0[var_8_7] = var_8_8
			end
		end
	end

	arg_8_0._pageList = var_8_0
	arg_8_0._layerPageList = arg_8_0:getUserDataTb_()
	arg_8_0._pageIndex = 1
	arg_8_0._maxPageIndex = 1
end

function var_0_0._addPages(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._pageList) do
		arg_9_0:_addPage(iter_9_0, iter_9_1)
	end
end

function var_0_0._addPage(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 > arg_10_0._maxPageIndex then
		arg_10_0._maxPageIndex = arg_10_1
	end

	if arg_10_0._layerPageList[arg_10_1] then
		return
	end

	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[1]
	local var_10_1 = arg_10_0:getResInst(var_10_0, arg_10_0._gocontent)
	local var_10_2 = WeekWalkLayerPage.New()

	var_10_2:initView(var_10_1, {
		arg_10_0,
		arg_10_1,
		arg_10_2
	})
	recthelper.setAnchorX(var_10_1.transform, (arg_10_1 - 1) * 2808)

	arg_10_0._layerPageList[arg_10_1] = var_10_2
end

function var_0_0._updateBtns(arg_11_0)
	gohelper.setActive(arg_11_0._btnleft.gameObject, arg_11_0._pageIndex > 1)

	local var_11_0 = arg_11_0._pageIndex < arg_11_0._maxPageIndex

	var_11_0 = var_11_0 and arg_11_0:_shallowFinish()

	if arg_11_0.isVerifing then
		var_11_0 = false
	end

	gohelper.setActive(arg_11_0._btnright.gameObject, var_11_0)
	arg_11_0:_updateTitles()
end

function var_0_0._shallowFinish(arg_12_0)
	local var_12_0 = WeekWalkModel.instance:getMapInfo(205)

	return var_12_0 and var_12_0.isFinished > 0
end

function var_0_0._onChangeRightBtnVisible(arg_13_0, arg_13_1)
	if arg_13_0:_shallowFinish() then
		return
	end

	if arg_13_0.isVerifing then
		arg_13_1 = false
	end

	gohelper.setActive(arg_13_0._btnright.gameObject, arg_13_1)
end

function var_0_0._updateTitles(arg_14_0)
	local var_14_0 = var_0_0.isShallowPage(arg_14_0._pageIndex)

	gohelper.setActive(arg_14_0._goshallow, var_14_0)
	gohelper.setActive(arg_14_0._godeep, not var_14_0)

	if not var_14_0 then
		local var_14_1 = WeekWalkModel.instance:getInfo()

		gohelper.setActive(arg_14_0._goexcept, not var_14_1.isOpenDeep)
		gohelper.setActive(arg_14_0._gocountdown, var_14_1.isOpenDeep)
	end

	gohelper.setActive(arg_14_0._goruleIcon, arg_14_0:_showDeepRuleBtn())
	arg_14_0:_shallowPageOpenShow()
	arg_14_0:_deepPageOpenShow()
end

function var_0_0._shallowPageOpenShow(arg_15_0)
	if not var_0_0.isShallowPage(arg_15_0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not arg_15_0:_shallowFinish() then
		return
	end

	if GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShallowPageOpenShow)
end

function var_0_0._deepPageOpenShow(arg_16_0)
	if var_0_0.isShallowPage(arg_16_0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not arg_16_0:_shallowFinish() then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideDeepPageOpenShow)
end

function var_0_0.isShallowPage(arg_17_0)
	return arg_17_0 <= 1
end

function var_0_0._pageTransition(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._layerPageList[arg_18_1]
	local var_18_1 = arg_18_0._layerPageList[arg_18_2]

	gohelper.setAsLastSibling(var_18_1.viewGO)

	if arg_18_1 < arg_18_2 then
		var_18_1:playAnim("weekwalklayerpage_slideleft02")
		var_18_0:playAnim("weekwalklayerpage_slideleft01")
		var_18_1:playBgAnim("weekwalklayerpage_bg_slideleft02")
		var_18_0:playBgAnim("weekwalklayerpage_bg_slideleft01")
	else
		var_18_1:playAnim("weekwalklayerpage_slideright02")
		var_18_0:playAnim("weekwalklayerpage_slideright01")
		var_18_1:playBgAnim("weekwalklayerpage_bg_slideright02")
		var_18_0:playBgAnim("weekwalklayerpage_bg_slideright01")
	end
end

function var_0_0._tweenPos(arg_19_0, arg_19_1)
	if arg_19_0._prevPageIndex == arg_19_0._pageIndex then
		return
	end

	if arg_19_0:_getAmbientSound(arg_19_0._pageIndex) ~= arg_19_0._ambientSoundId then
		arg_19_0:_endAmbientSound()
	end

	arg_19_0._prevPageIndex = arg_19_0._pageIndex

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._layerPageList) do
		local var_19_0 = iter_19_1.viewGO
		local var_19_1 = iter_19_0 == arg_19_0._pageIndex

		iter_19_1:setVisible(var_19_1)

		if var_19_1 then
			iter_19_1:resetPos(arg_19_0._targetId)

			arg_19_0._targetId = nil

			recthelper.setAnchorX(var_19_0.transform, 0)
		else
			recthelper.setAnchorX(var_19_0.transform, 10000)
		end
	end

	arg_19_0:_movePageDone()
end

function var_0_0._movePageDone(arg_20_0)
	arg_20_0:_beginAmbientSound()

	if arg_20_0._pageIndex == 2 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage3)
	end

	if arg_20_0._pageIndex == 3 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage5)
	end
end

function var_0_0._beginAmbientSound(arg_21_0)
	if not arg_21_0._isOpenFinish then
		return
	end

	if arg_21_0._ambientSoundId then
		return
	end
end

function var_0_0._endAmbientSound(arg_22_0)
	if not arg_22_0._ambientSoundId then
		return
	end

	arg_22_0._ambientSoundId = nil
end

function var_0_0._getAmbientSound(arg_23_0, arg_23_1)
	if arg_23_1 <= 1 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_2
	elseif arg_23_1 <= 2 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_3
	end
end

function var_0_0.onUpdateParam(arg_24_0)
	return
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_25_0._onGetInfo, arg_25_0)
	arg_25_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeRightBtnVisible, arg_25_0._onChangeRightBtnVisible, arg_25_0)
	arg_25_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.GuideMoveLayerPage, arg_25_0._onGuideMoveLayerPage, arg_25_0)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_25_0._onCloseViewFinish, arg_25_0, LuaEventSystem.Low)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_25_0._onOpenView, arg_25_0)
	arg_25_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_25_0._onCloseView, arg_25_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)

	arg_25_0.isVerifing = VersionValidator.instance:isInReviewing()

	arg_25_0:_initPages()
	arg_25_0:_addPages()
	arg_25_0:_moveTargetLayer()
	arg_25_0:_updateBtns()
	arg_25_0:_showDeadline()
end

function var_0_0._onOpenView(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.WeekWalkView then
		arg_26_0._animator.enabled = true

		arg_26_0._animator:Play("weekwalklayerview_out", 0, 0)
		TaskDispatcher.cancelTask(arg_26_0._delayHideBtnHelp, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0._delayHideBtnHelp, arg_26_0, 0.1)
		gohelper.setActive(arg_26_0._goruleIcon, false)
	end
end

function var_0_0._delayHideBtnHelp(arg_27_0)
	arg_27_0.viewContainer:getNavBtnView():setHelpVisible(false)
end

function var_0_0._onCloseView(arg_28_0, arg_28_1)
	if arg_28_1 == ViewName.WeekWalkView then
		arg_28_0._animator.enabled = true

		arg_28_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_28_0.viewContainer:getNavBtnView():setHelpVisible(true)
		gohelper.setActive(arg_28_0._goruleIcon, arg_28_0:_showDeepRuleBtn())
		arg_28_0._layerPageList[arg_28_0._pageIndex]:playAnim("weekwalklayerpage_in")
	end
end

function var_0_0._showDeepRuleBtn(arg_29_0)
	if not arg_29_0._pageIndex then
		return false
	end

	local var_29_0 = var_0_0.isShallowPage(arg_29_0._pageIndex)
	local var_29_1 = WeekWalkModel.instance:getInfo()

	return not var_29_0 and var_29_1.isOpenDeep
end

function var_0_0._onCloseViewFinish(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.WeekWalkView then
		arg_30_0:_addPages()
		arg_30_0:_updateBtns()
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)
	end
end

function var_0_0.onOpenFinish(arg_31_0)
	arg_31_0._isOpenFinish = true

	arg_31_0:_beginAmbientSound()
end

function var_0_0._showDeadline(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onRefreshDeadline, arg_32_0)

	arg_32_0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_32_0._onRefreshDeadline, arg_32_0, 1)
	arg_32_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_33_0)
	local var_33_0 = arg_33_0._endTime - ServerTime.now()

	if var_33_0 <= 0 then
		TaskDispatcher.cancelTask(arg_33_0._onRefreshDeadline, arg_33_0)
	end

	local var_33_1, var_33_2 = TimeUtil.secondToRoughTime2(math.floor(var_33_0))

	arg_33_0._txtcountday.text = var_33_1 .. var_33_2
end

function var_0_0._onGetInfo(arg_34_0)
	arg_34_0:_showDeadline()
	arg_34_0:_updateTitles()
end

function var_0_0._onGuideMoveLayerPage(arg_35_0, arg_35_1)
	arg_35_0._guideMoveMapId = tonumber(arg_35_1)
end

function var_0_0._moveTargetLayer(arg_36_0)
	arg_36_0._targetId = arg_36_0.viewParam and arg_36_0.viewParam.mapId
	arg_36_0._targetLayerId = arg_36_0.viewParam and arg_36_0.viewParam.layerId

	if not arg_36_0._targetId and not arg_36_0._targetLayerId then
		local var_36_0, var_36_1 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

		arg_36_0._targetId = var_36_0.id
	end

	if arg_36_0._guideMoveMapId then
		arg_36_0._targetId = arg_36_0._guideMoveMapId
		arg_36_0._guideMoveMapId = nil
	end

	if arg_36_0._targetId or arg_36_0._targetLayerId then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._pageList) do
			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				if iter_36_3.id == arg_36_0._targetId or iter_36_3.layer == arg_36_0._targetLayerId then
					arg_36_0._pageIndex = iter_36_0

					arg_36_0:_tweenPos(true)

					local var_36_2 = arg_36_0._layerPageList[arg_36_0._pageIndex]

					gohelper.setAsLastSibling(var_36_2.viewGO)
					var_36_2:playAnim("weekwalklayerpage_in")

					return
				end
			end
		end
	end
end

function var_0_0.onClose(arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._delayHideBtnHelp, arg_37_0)
	arg_37_0:_endAmbientSound()

	for iter_37_0, iter_37_1 in ipairs(arg_37_0._layerPageList) do
		iter_37_1:destroyView()
	end

	gohelper.setActive(arg_37_0._gotopleft, false)
end

function var_0_0.onDestroyView(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._onRefreshDeadline, arg_38_0)
end

return var_0_0
