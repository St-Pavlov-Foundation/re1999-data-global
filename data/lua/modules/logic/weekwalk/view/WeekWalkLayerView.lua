module("modules.logic.weekwalk.view.WeekWalkLayerView", package.seeall)

slot0 = class("WeekWalkLayerView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_right")
	slot0._goshallow = gohelper.findChild(slot0.viewGO, "bottom_left/#go_shallow ")
	slot0._godeep = gohelper.findChild(slot0.viewGO, "bottom_left/#go_deep")
	slot0._gocountdown = gohelper.findChild(slot0.viewGO, "bottom_left/#go_deep/#go_countdown")
	slot0._txtcountday = gohelper.findChildText(slot0.viewGO, "bottom_left/#go_deep/#go_countdown/#txt_countday")
	slot0._goexcept = gohelper.findChild(slot0.viewGO, "bottom_left/#go_deep/#go_except")
	slot0._goruleIcon = gohelper.findChild(slot0.viewGO, "#go_ruleIcon")
	slot0._btnruleIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ruleIcon/#btn_ruleIcon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnruleIcon:AddClickListener(slot0._btnruleIconOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnruleIcon:RemoveClickListener()
end

function slot0._btnruleIconOnClick(slot0)
	WeekWalkController.instance:openWeekWalkRuleView()
end

function slot0._btnleftOnClick(slot0)
	slot1 = slot0._pageIndex
	slot0._pageIndex = slot1 - 1

	slot0:_tweenPos()
	slot0:_updateBtns()
	slot0:_pageTransition(slot1, slot0._pageIndex)
end

function slot0._btnrightOnClick(slot0)
	slot1 = slot0._pageIndex
	slot0._pageIndex = slot1 + 1

	slot0:_tweenPos()
	slot0:_updateBtns()
	slot0:_pageTransition(slot1, slot0._pageIndex)
end

function slot0._editableInitView(slot0)
	WeekWalkModel.instance:clearOldInfo()
	gohelper.addUIClickAudio(slot0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(slot0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "top_left")
end

function slot0._initPages(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(lua_weekwalk.configList) do
		if slot7.type <= 2 then
			slot10 = slot1[1] or {}

			table.insert(slot10, slot7)

			slot1[slot9] = slot10
		end
	end

	slot5 = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if WeekWalkConfig.instance:getDeepLayer(WeekWalkModel.instance:getInfo().issueId) then
		for slot9, slot10 in ipairs(slot4) do
			if not slot0.isVerifing or slot5 >= slot10.layer then
				slot12 = slot1[2] or {}

				table.insert(slot12, slot10)

				slot1[slot11] = slot12
			end
		end
	end

	slot0._pageList = slot1
	slot0._layerPageList = slot0:getUserDataTb_()
	slot0._pageIndex = 1
	slot0._maxPageIndex = 1
end

function slot0._addPages(slot0)
	for slot4, slot5 in ipairs(slot0._pageList) do
		slot0:_addPage(slot4, slot5)
	end
end

function slot0._addPage(slot0, slot1, slot2)
	if slot0._maxPageIndex < slot1 then
		slot0._maxPageIndex = slot1
	end

	if slot0._layerPageList[slot1] then
		return
	end

	slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent)
	slot5 = WeekWalkLayerPage.New()

	slot5:initView(slot4, {
		slot0,
		slot1,
		slot2
	})
	recthelper.setAnchorX(slot4.transform, (slot1 - 1) * 2808)

	slot0._layerPageList[slot1] = slot5
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnleft.gameObject, slot0._pageIndex > 1)

	slot1 = slot0._pageIndex < slot0._maxPageIndex and slot0:_shallowFinish()

	if slot0.isVerifing then
		slot1 = false
	end

	gohelper.setActive(slot0._btnright.gameObject, slot1)
	slot0:_updateTitles()
end

function slot0._shallowFinish(slot0)
	return WeekWalkModel.instance:getMapInfo(205) and slot1.isFinished > 0
end

function slot0._onChangeRightBtnVisible(slot0, slot1)
	if slot0:_shallowFinish() then
		return
	end

	if slot0.isVerifing then
		slot1 = false
	end

	gohelper.setActive(slot0._btnright.gameObject, slot1)
end

function slot0._updateTitles(slot0)
	slot1 = uv0.isShallowPage(slot0._pageIndex)

	gohelper.setActive(slot0._goshallow, slot1)
	gohelper.setActive(slot0._godeep, not slot1)

	if not slot1 then
		slot2 = WeekWalkModel.instance:getInfo()

		gohelper.setActive(slot0._goexcept, not slot2.isOpenDeep)
		gohelper.setActive(slot0._gocountdown, slot2.isOpenDeep)
	end

	gohelper.setActive(slot0._goruleIcon, slot0:_showDeepRuleBtn())
	slot0:_shallowPageOpenShow()
	slot0:_deepPageOpenShow()
end

function slot0._shallowPageOpenShow(slot0)
	if not uv0.isShallowPage(slot0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not slot0:_shallowFinish() then
		return
	end

	if GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShallowPageOpenShow)
end

function slot0._deepPageOpenShow(slot0)
	if uv0.isShallowPage(slot0._pageIndex) then
		return
	end

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		return
	end

	if not slot0:_shallowFinish() then
		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideDeepPageOpenShow)
end

function slot0.isShallowPage(slot0)
	return slot0 <= 1
end

function slot0._pageTransition(slot0, slot1, slot2)
	slot3 = slot0._layerPageList[slot1]

	gohelper.setAsLastSibling(slot0._layerPageList[slot2].viewGO)

	if slot1 < slot2 then
		slot4:playAnim("weekwalklayerpage_slideleft02")
		slot3:playAnim("weekwalklayerpage_slideleft01")
		slot4:playBgAnim("weekwalklayerpage_bg_slideleft02")
		slot3:playBgAnim("weekwalklayerpage_bg_slideleft01")
	else
		slot4:playAnim("weekwalklayerpage_slideright02")
		slot3:playAnim("weekwalklayerpage_slideright01")
		slot4:playBgAnim("weekwalklayerpage_bg_slideright02")
		slot3:playBgAnim("weekwalklayerpage_bg_slideright01")
	end
end

function slot0._tweenPos(slot0, slot1)
	if slot0._prevPageIndex == slot0._pageIndex then
		return
	end

	if slot0:_getAmbientSound(slot0._pageIndex) ~= slot0._ambientSoundId then
		slot0:_endAmbientSound()
	end

	slot0._prevPageIndex = slot0._pageIndex

	for slot5, slot6 in ipairs(slot0._layerPageList) do
		slot8 = slot5 == slot0._pageIndex

		slot6:setVisible(slot8)

		if slot8 then
			slot6:resetPos(slot0._targetId)

			slot0._targetId = nil

			recthelper.setAnchorX(slot6.viewGO.transform, 0)
		else
			recthelper.setAnchorX(slot7.transform, 10000)
		end
	end

	slot0:_movePageDone()
end

function slot0._movePageDone(slot0)
	slot0:_beginAmbientSound()

	if slot0._pageIndex == 2 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage3)
	end

	if slot0._pageIndex == 3 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideChangeToLayerPage5)
	end
end

function slot0._beginAmbientSound(slot0)
	if not slot0._isOpenFinish then
		return
	end

	if slot0._ambientSoundId then
		return
	end
end

function slot0._endAmbientSound(slot0)
	if not slot0._ambientSoundId then
		return
	end

	slot0._ambientSoundId = nil
end

function slot0._getAmbientSound(slot0, slot1)
	if slot1 <= 1 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_2
	elseif slot1 <= 2 then
		return AudioEnum.WeekWalk.play_artificial_layer_type_3
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeRightBtnVisible, slot0._onChangeRightBtnVisible, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.GuideMoveLayerPage, slot0._onGuideMoveLayerPage, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)

	slot0.isVerifing = VersionValidator.instance:isInReviewing()

	slot0:_initPages()
	slot0:_addPages()
	slot0:_moveTargetLayer()
	slot0:_updateBtns()
	slot0:_showDeadline()
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.WeekWalkView then
		slot0._animator.enabled = true

		slot0._animator:Play("weekwalklayerview_out", 0, 0)
		TaskDispatcher.cancelTask(slot0._delayHideBtnHelp, slot0)
		TaskDispatcher.runDelay(slot0._delayHideBtnHelp, slot0, 0.1)
		gohelper.setActive(slot0._goruleIcon, false)
	end
end

function slot0._delayHideBtnHelp(slot0)
	slot0.viewContainer:getNavBtnView():setHelpVisible(false)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.WeekWalkView then
		slot0._animator.enabled = true

		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0.viewContainer:getNavBtnView():setHelpVisible(true)
		gohelper.setActive(slot0._goruleIcon, slot0:_showDeepRuleBtn())
		slot0._layerPageList[slot0._pageIndex]:playAnim("weekwalklayerpage_in")
	end
end

function slot0._showDeepRuleBtn(slot0)
	if not slot0._pageIndex then
		return false
	end

	return not uv0.isShallowPage(slot0._pageIndex) and WeekWalkModel.instance:getInfo().isOpenDeep
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.WeekWalkView then
		slot0:_addPages()
		slot0:_updateBtns()
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideOnLayerViewOpen)
	end
end

function slot0.onOpenFinish(slot0)
	slot0._isOpenFinish = true

	slot0:_beginAmbientSound()
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot2, slot3 = TimeUtil.secondToRoughTime2(math.floor(slot1))
	slot0._txtcountday.text = slot2 .. slot3
end

function slot0._onGetInfo(slot0)
	slot0:_showDeadline()
	slot0:_updateTitles()
end

function slot0._onGuideMoveLayerPage(slot0, slot1)
	slot0._guideMoveMapId = tonumber(slot1)
end

function slot0._moveTargetLayer(slot0)
	slot0._targetId = slot0.viewParam and slot0.viewParam.mapId
	slot0._targetLayerId = slot0.viewParam and slot0.viewParam.layerId

	if not slot0._targetId and not slot0._targetLayerId then
		slot2, slot3 = WeekWalkModel.instance:getInfo():getNotFinishedMap()
		slot0._targetId = slot2.id
	end

	if slot0._guideMoveMapId then
		slot0._targetId = slot0._guideMoveMapId
		slot0._guideMoveMapId = nil
	end

	if slot0._targetId or slot0._targetLayerId then
		for slot4, slot5 in ipairs(slot0._pageList) do
			for slot9, slot10 in ipairs(slot5) do
				if slot10.id == slot0._targetId or slot10.layer == slot0._targetLayerId then
					slot0._pageIndex = slot4

					slot0:_tweenPos(true)

					slot11 = slot0._layerPageList[slot0._pageIndex]

					gohelper.setAsLastSibling(slot11.viewGO)
					slot11:playAnim("weekwalklayerpage_in")

					return
				end
			end
		end
	end
end

function slot0.onClose(slot0)
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._delayHideBtnHelp, slot4)
	slot0:_endAmbientSound()

	for slot4, slot5 in ipairs(slot0._layerPageList) do
		slot5:destroyView()
	end

	gohelper.setActive(slot0._gotopleft, false)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0
