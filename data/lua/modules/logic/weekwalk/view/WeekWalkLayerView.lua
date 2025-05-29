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

	arg_7_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_7_0._OnGetInfo, arg_7_0)
end

function var_0_0._OnGetInfo(arg_8_0)
	arg_8_0:_initPageList()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._layerPageList) do
		iter_8_1:updateLayerList(arg_8_0._pageList[iter_8_0])
	end
end

function var_0_0._initPageList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_weekwalk.configList) do
		if iter_9_1.type <= 2 then
			local var_9_2 = 1
			local var_9_3 = var_9_0[var_9_2] or {}

			table.insert(var_9_3, iter_9_1)

			var_9_0[var_9_2] = var_9_3
		end
	end

	local var_9_4 = WeekWalkModel.instance:getInfo()
	local var_9_5 = WeekWalkConfig.instance:getDeepLayer(var_9_4.issueId)
	local var_9_6 = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if var_9_5 then
		for iter_9_2, iter_9_3 in ipairs(var_9_5) do
			if not arg_9_0.isVerifing or not (var_9_6 < iter_9_3.layer) then
				local var_9_7 = 2
				local var_9_8 = var_9_0[var_9_7] or {}

				table.insert(var_9_8, iter_9_3)

				var_9_0[var_9_7] = var_9_8
			end
		end
	end

	arg_9_0._pageList = var_9_0
end

function var_0_0._initPages(arg_10_0)
	arg_10_0:_initPageList()

	arg_10_0._layerPageList = arg_10_0:getUserDataTb_()
	arg_10_0._pageIndex = 1
	arg_10_0._maxPageIndex = 1
end

function var_0_0._addPages(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._pageList) do
		arg_11_0:_addPage(iter_11_0, iter_11_1)
	end
end

function var_0_0._addPage(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 > arg_12_0._maxPageIndex then
		arg_12_0._maxPageIndex = arg_12_1
	end

	if arg_12_0._layerPageList[arg_12_1] then
		return
	end

	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes[1]
	local var_12_1 = arg_12_0:getResInst(var_12_0, arg_12_0._gocontent)
	local var_12_2 = WeekWalkLayerPage.New()

	var_12_2:initView(var_12_1, {
		arg_12_0,
		arg_12_1,
		arg_12_2
	})
	recthelper.setAnchorX(var_12_1.transform, (arg_12_1 - 1) * 2808)

	arg_12_0._layerPageList[arg_12_1] = var_12_2
end

function var_0_0._updateBtns(arg_13_0)
	gohelper.setActive(arg_13_0._btnleft.gameObject, arg_13_0._pageIndex > 1)

	local var_13_0 = arg_13_0._pageIndex < arg_13_0._maxPageIndex

	var_13_0 = var_13_0 and arg_13_0:_shallowFinish()

	if arg_13_0.isVerifing then
		var_13_0 = false
	end

	gohelper.setActive(arg_13_0._btnright.gameObject, var_13_0)
	arg_13_0:_updateTitles()
end

function var_0_0._shallowFinish(arg_14_0)
	local var_14_0 = WeekWalkModel.instance:getMapInfo(205)

	return var_14_0 and var_14_0.isFinished > 0
end

function var_0_0._onChangeRightBtnVisible(arg_15_0, arg_15_1)
	if arg_15_0:_shallowFinish() then
		return
	end

	if arg_15_0.isVerifing then
		arg_15_1 = false
	end

	gohelper.setActive(arg_15_0._btnright.gameObject, arg_15_1)
end

function var_0_0._updateTitles(arg_16_0)
	local var_16_0 = var_0_0.isShallowPage(arg_16_0._pageIndex)

	gohelper.setActive(arg_16_0._goshallow, var_16_0)
	gohelper.setActive(arg_16_0._godeep, not var_16_0)

	if not var_16_0 then
		local var_16_1 = WeekWalkModel.instance:getInfo()

		gohelper.setActive(arg_16_0._goexcept, not var_16_1.isOpenDeep)
		gohelper.setActive(arg_16_0._gocountdown, var_16_1.isOpenDeep)
	end

	gohelper.setActive(arg_16_0._goruleIcon, arg_16_0:_showDeepRuleBtn())
	arg_16_0:_shallowPageOpenShow()
	arg_16_0:_deepPageOpenShow()
end

function var_0_0._shallowPageOpenShow(arg_17_0)
	if not var_0_0.isShallowPage(arg_17_0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not arg_17_0:_shallowFinish() then
		return
	end

	if GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShallowPageOpenShow)
end

function var_0_0._deepPageOpenShow(arg_18_0)
	if var_0_0.isShallowPage(arg_18_0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not arg_18_0:_shallowFinish() then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideDeepPageOpenShow)
end

function var_0_0.isShallowPage(arg_19_0)
	return arg_19_0 <= 1
end

function var_0_0._pageTransition(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._layerPageList[arg_20_1]
	local var_20_1 = arg_20_0._layerPageList[arg_20_2]

	gohelper.setAsLastSibling(var_20_1.viewGO)

	if arg_20_1 < arg_20_2 then
		var_20_1:playAnim("weekwalklayerpage_slideleft02")
		var_20_0:playAnim("weekwalklayerpage_slideleft01")
		var_20_1:playBgAnim("weekwalklayerpage_bg_slideleft02")
		var_20_0:playBgAnim("weekwalklayerpage_bg_slideleft01")
	else
		var_20_1:playAnim("weekwalklayerpage_slideright02")
		var_20_0:playAnim("weekwalklayerpage_slideright01")
		var_20_1:playBgAnim("weekwalklayerpage_bg_slideright02")
		var_20_0:playBgAnim("weekwalklayerpage_bg_slideright01")
	end
end

function var_0_0._tweenPos(arg_21_0, arg_21_1)
	if arg_21_0._prevPageIndex == arg_21_0._pageIndex then
		return
	end

	if arg_21_0:_getAmbientSound(arg_21_0._pageIndex) ~= arg_21_0._ambientSoundId then
		arg_21_0:_endAmbientSound()
	end

	arg_21_0._prevPageIndex = arg_21_0._pageIndex

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._layerPageList) do
		local var_21_0 = iter_21_1.viewGO
		local var_21_1 = iter_21_0 == arg_21_0._pageIndex

		iter_21_1:setVisible(var_21_1)

		if var_21_1 then
			iter_21_1:resetPos(arg_21_0._targetId)

			arg_21_0._targetId = nil

			recthelper.setAnchorX(var_21_0.transform, 0)
		else
			recthelper.setAnchorX(var_21_0.transform, 10000)
		end
	end

	arg_21_0:_movePageDone()
end

function var_0_0._movePageDone(arg_22_0)
	arg_22_0:_beginAmbientSound()

	if arg_22_0._pageIndex == 2 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage3)
	end

	if arg_22_0._pageIndex == 3 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage5)
	end
end

function var_0_0._beginAmbientSound(arg_23_0)
	if not arg_23_0._isOpenFinish then
		return
	end

	if arg_23_0._ambientSoundId then
		return
	end
end

function var_0_0._endAmbientSound(arg_24_0)
	if not arg_24_0._ambientSoundId then
		return
	end

	arg_24_0._ambientSoundId = nil
end

function var_0_0._getAmbientSound(arg_25_0, arg_25_1)
	if arg_25_1 <= 1 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_2
	elseif arg_25_1 <= 2 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_3
	end
end

function var_0_0.onUpdateParam(arg_26_0)
	return
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_27_0._onGetInfo, arg_27_0)
	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeRightBtnVisible, arg_27_0._onChangeRightBtnVisible, arg_27_0)
	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.GuideMoveLayerPage, arg_27_0._onGuideMoveLayerPage, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_27_0._onCloseViewFinish, arg_27_0, LuaEventSystem.Low)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_27_0._onOpenView, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_27_0._onCloseView, arg_27_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)

	arg_27_0.isVerifing = VersionValidator.instance:isInReviewing()

	arg_27_0:_initPages()
	arg_27_0:_addPages()
	arg_27_0:_moveTargetLayer()
	arg_27_0:_updateBtns()
	arg_27_0:_showDeadline()
end

function var_0_0._onOpenView(arg_28_0, arg_28_1)
	if arg_28_1 == ViewName.WeekWalkView then
		arg_28_0._animator.enabled = true

		arg_28_0._animator:Play("weekwalklayerview_out", 0, 0)
		TaskDispatcher.cancelTask(arg_28_0._delayHideBtnHelp, arg_28_0)
		TaskDispatcher.runDelay(arg_28_0._delayHideBtnHelp, arg_28_0, 0.1)
		gohelper.setActive(arg_28_0._goruleIcon, false)
	end
end

function var_0_0._delayHideBtnHelp(arg_29_0)
	arg_29_0.viewContainer:getNavBtnView():setHelpVisible(false)
end

function var_0_0._onCloseView(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.WeekWalkView then
		arg_30_0._animator.enabled = true

		arg_30_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_30_0.viewContainer:getNavBtnView():setHelpVisible(true)
		gohelper.setActive(arg_30_0._goruleIcon, arg_30_0:_showDeepRuleBtn())
		arg_30_0._layerPageList[arg_30_0._pageIndex]:playAnim("weekwalklayerpage_in")
	end
end

function var_0_0._showDeepRuleBtn(arg_31_0)
	if not arg_31_0._pageIndex then
		return false
	end

	local var_31_0 = var_0_0.isShallowPage(arg_31_0._pageIndex)
	local var_31_1 = WeekWalkModel.instance:getInfo()

	return not var_31_0 and var_31_1.isOpenDeep
end

function var_0_0._onCloseViewFinish(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.WeekWalkView then
		arg_32_0:_addPages()
		arg_32_0:_updateBtns()
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)
	end
end

function var_0_0.onOpenFinish(arg_33_0)
	arg_33_0._isOpenFinish = true

	arg_33_0:_beginAmbientSound()
end

function var_0_0._showDeadline(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onRefreshDeadline, arg_34_0)

	arg_34_0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_34_0._onRefreshDeadline, arg_34_0, 1)
	arg_34_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_35_0)
	local var_35_0 = arg_35_0._endTime - ServerTime.now()

	if var_35_0 <= 0 then
		TaskDispatcher.cancelTask(arg_35_0._onRefreshDeadline, arg_35_0)
	end

	local var_35_1, var_35_2 = TimeUtil.secondToRoughTime2(math.floor(var_35_0))

	arg_35_0._txtcountday.text = var_35_1 .. var_35_2
end

function var_0_0._onGetInfo(arg_36_0)
	arg_36_0:_showDeadline()
	arg_36_0:_updateTitles()
end

function var_0_0._onGuideMoveLayerPage(arg_37_0, arg_37_1)
	arg_37_0._guideMoveMapId = tonumber(arg_37_1)
end

function var_0_0._moveTargetLayer(arg_38_0)
	arg_38_0._targetId = arg_38_0.viewParam and arg_38_0.viewParam.mapId
	arg_38_0._targetLayerId = arg_38_0.viewParam and arg_38_0.viewParam.layerId

	if not arg_38_0._targetId and not arg_38_0._targetLayerId then
		local var_38_0, var_38_1 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

		arg_38_0._targetId = var_38_0.id
	end

	if arg_38_0._guideMoveMapId then
		arg_38_0._targetId = arg_38_0._guideMoveMapId
		arg_38_0._guideMoveMapId = nil
	end

	if arg_38_0._targetId or arg_38_0._targetLayerId then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0._pageList) do
			for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
				if iter_38_3.id == arg_38_0._targetId or iter_38_3.layer == arg_38_0._targetLayerId then
					arg_38_0._pageIndex = iter_38_0

					arg_38_0:_tweenPos(true)

					local var_38_2 = arg_38_0._layerPageList[arg_38_0._pageIndex]

					gohelper.setAsLastSibling(var_38_2.viewGO)
					var_38_2:playAnim("weekwalklayerpage_in")

					return
				end
			end
		end
	end
end

function var_0_0.onClose(arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._delayHideBtnHelp, arg_39_0)
	arg_39_0:_endAmbientSound()

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._layerPageList) do
		iter_39_1:destroyView()
	end

	gohelper.setActive(arg_39_0._gotopleft, false)
end

function var_0_0.onDestroyView(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._onRefreshDeadline, arg_40_0)
end

return var_0_0
