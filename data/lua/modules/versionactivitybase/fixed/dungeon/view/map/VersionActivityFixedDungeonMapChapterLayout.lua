module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapChapterLayout", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapChapterLayout", BaseChildView)
local var_0_1 = "default"
local var_0_2 = 600
local var_0_3 = 100
local var_0_4 = 0.26

function var_0_0.onInitView(arg_1_0)
	arg_1_0.rectTransform = arg_1_0.viewGO.transform
	arg_1_0.contentTransform = arg_1_0.viewParam.goChapterContent.transform
	arg_1_0._golevellist = gohelper.findChild(arg_1_0.viewGO, string.format("%s/go_levellist", var_0_1))
	arg_1_0._gotemplatenormal = gohelper.findChild(arg_1_0.viewGO, string.format("%s/go_levellist/#go_templatenormal", var_0_1))
	arg_1_0.chapterGo = gohelper.findChild(arg_1_0.viewGO, var_0_1)

	gohelper.setActive(arg_1_0.chapterGo, true)

	arg_1_0._timelineAnimation = gohelper.findChildComponent(arg_1_0.viewGO, "timeline", typeof(UnityEngine.Animation))
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_2_0.onActivityDungeonMoChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.GuideShowElement, arg_2_0._GuideShowElement, arg_2_0)

	if GamepadController.instance:isOpen() then
		arg_2_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_2_0._onGamepadKeyUp, arg_2_0)
		arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_2_0._onChangeFocusEpisodeItem, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_3_0.onActivityDungeonMoChange, arg_3_0)
	arg_3_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_3_0._onGamepadKeyUp, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_3_0._onChangeFocusEpisodeItem, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.GuideShowElement, arg_3_0._GuideShowElement, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName() then
		arg_4_0._timelineAnimation:Play("timeline_mask")
		arg_4_0:setSelectEpisodeItem(arg_4_0._episodeItemDict[arg_4_0.activityDungeonMo.episodeId])
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName() then
		arg_5_0._timelineAnimation:Play("timeline_reset")
		arg_5_0:setSelectEpisodeItem(nil)
	end
end

function var_0_0.onActivityDungeonMoChange(arg_6_0)
	arg_6_0:updateFocusStatus()
	arg_6_0:setFocusEpisodeId(arg_6_0.activityDungeonMo.episodeId, true)
end

function var_0_0.updateFocusStatus(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._episodeItemDict) do
		iter_7_1:refreshFocusStatus()
	end
end

function var_0_0._onGamepadKeyUp(arg_8_0, arg_8_1)
	local var_8_0 = ViewMgr.instance:getOpenViewNameList()
	local var_8_1 = var_8_0[#var_8_0]

	if var_8_1 ~= VersionActivityFixedHelper.getVersionActivityDungeonMapViewName() and var_8_1 ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName() then
		return
	end

	local var_8_2 = arg_8_1 == GamepadEnum.KeyCode.LB
	local var_8_3 = var_8_2 or arg_8_1 == GamepadEnum.KeyCode.RB
	local var_8_4 = DungeonMapModel.instance:getMapInteractiveItemVisible()

	if arg_8_0._focusIndex and not var_8_4 and var_8_3 then
		local var_8_5 = var_8_2 and -1 or 1
		local var_8_6 = arg_8_0._focusIndex + var_8_5
		local var_8_7 = math.max(1, var_8_6)
		local var_8_8 = math.min(var_8_7, #arg_8_0._episodeContainerItemList)

		if var_8_8 > 0 and var_8_8 <= #arg_8_0._episodeContainerItemList then
			arg_8_0._episodeContainerItemList[var_8_8].episodeItem:onClick(true)
		end
	end
end

function var_0_0._onChangeFocusEpisodeItem(arg_9_0, arg_9_1)
	if GamepadController.instance:isOpen() then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._episodeContainerItemList) do
			if iter_9_1.episodeItem == arg_9_1 then
				arg_9_0._focusIndex = iter_9_0
			end
		end
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._focusIndex = 0
	arg_10_0._episodeItemDict = arg_10_0:getUserDataTb_()
	arg_10_0._episodeContainerItemList = arg_10_0:getUserDataTb_()
	arg_10_0.episodeItemPath = arg_10_0.viewContainer:getSetting().otherRes[1]

	local var_10_0 = Vector2(0, 1)

	arg_10_0.rectTransform.pivot = var_10_0
	arg_10_0.rectTransform.anchorMin = var_10_0
	arg_10_0.rectTransform.anchorMax = var_10_0
	arg_10_0.defaultY = arg_10_0.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(arg_10_0.rectTransform, arg_10_0.defaultY)

	arg_10_0._rawWidth = recthelper.getWidth(arg_10_0.rectTransform)
	arg_10_0._rawHeight = recthelper.getHeight(arg_10_0.rectTransform)

	recthelper.setSize(arg_10_0.contentTransform, arg_10_0._rawWidth, arg_10_0._rawHeight)

	local var_10_1 = ViewMgr.instance:getUIRoot().transform
	local var_10_2 = recthelper.getWidth(var_10_1)

	arg_10_0._offsetX = (var_10_2 - var_0_2) / 2 + var_0_2
	arg_10_0._constDungeonNormalPosX = var_10_2 - arg_10_0._offsetX
	arg_10_0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	arg_10_0._constDungeonNormalDeltaX = var_0_3

	if ViewMgr.instance:isOpening(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()) then
		arg_10_0._timelineAnimation:Play("timeline_mask")
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.refreshEpisodeNodes(arg_13_0)
	arg_13_0._episodeItemDict = arg_13_0:getUserDataTb_()

	local var_13_0 = 0
	local var_13_1
	local var_13_2
	local var_13_3 = DungeonConfig.instance:getChapterEpisodeCOList(arg_13_0.activityDungeonMo.chapterId)

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		local var_13_4 = iter_13_1 and DungeonModel.instance:getEpisodeInfo(iter_13_1.id) or nil

		if var_13_4 then
			var_13_0 = var_13_0 + 1

			local var_13_5 = arg_13_0:getEpisodeContainerItem(var_13_0)

			arg_13_0._episodeItemDict[iter_13_1.id] = var_13_5.episodeItem
			var_13_5.containerTr.name = iter_13_1.id

			var_13_5.episodeItem:refresh(iter_13_1, var_13_4)
			arg_13_0:_setEpisodeItemAnchorX(var_13_0, var_13_5)
		end
	end

	local var_13_6 = arg_13_0._episodeContainerItemList[var_13_0]
	local var_13_7 = recthelper.rectToRelativeAnchorPos(var_13_6.containerTr.position, arg_13_0.rectTransform).x + arg_13_0._offsetX

	recthelper.setSize(arg_13_0.contentTransform, var_13_7, arg_13_0._rawHeight)

	arg_13_0._contentWidth = var_13_7

	for iter_13_2 = var_13_0 + 1, #arg_13_0._episodeContainerItemList do
		gohelper.setActive(arg_13_0._episodeContainerItemList[iter_13_2].containerTr.gameObject, false)
	end

	arg_13_0:setFocusEpisodeId(arg_13_0.activityDungeonMo.episodeId, false)
end

function var_0_0.getEpisodeContainerItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._episodeContainerItemList[arg_14_1]

	if var_14_0 then
		gohelper.setActive(var_14_0.containerTr.gameObject, true)
		var_14_0.episodeItem:clearElementIdList()

		return var_14_0
	end

	local var_14_1 = arg_14_0:getUserDataTb_()
	local var_14_2 = gohelper.cloneInPlace(arg_14_0._gotemplatenormal, tostring(arg_14_1))

	gohelper.setActive(var_14_2, true)

	var_14_1.containerTr = var_14_2.transform

	recthelper.setAnchorY(var_14_1.containerTr, arg_14_0._constDungeonNormalPosY)

	local var_14_3 = arg_14_0.viewContainer:getResInst(arg_14_0.episodeItemPath, var_14_2)
	local var_14_4 = arg_14_0.activityDungeonMo:getEpisodeItemClass().New()

	var_14_4.viewContainer = arg_14_0.viewContainer
	var_14_4.activityDungeonMo = arg_14_0.activityDungeonMo

	var_14_4:initView(var_14_3, {
		arg_14_0.contentTransform,
		arg_14_0
	})

	var_14_1.episodeItem = var_14_4

	table.insert(arg_14_0._episodeContainerItemList, var_14_1)

	return var_14_1
end

function var_0_0._setEpisodeItemAnchorX(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 > 1 then
		local var_15_0 = arg_15_0._episodeContainerItemList[arg_15_1 - 1]
		local var_15_1 = recthelper.getAnchorX(var_15_0.containerTr) or 0
		local var_15_2 = var_15_0.episodeItem

		recthelper.setAnchorX(arg_15_2.containerTr, var_15_1 + var_15_2:getMaxWidth() + arg_15_0._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(arg_15_2.containerTr, arg_15_0._constDungeonNormalPosX)
	end
end

function var_0_0.setFocusEpisodeId(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._episodeItemDict[arg_16_1]

	if var_16_0 and var_16_0.viewGO then
		arg_16_0:setFocusItem(var_16_0.viewGO, arg_16_2)
	end

	if var_16_0 then
		arg_16_0:_onChangeFocusEpisodeItem(var_16_0)
	end
end

function var_0_0.setFocusItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = -recthelper.rectToRelativeAnchorPos(arg_17_1.transform.position, arg_17_0.rectTransform).x + arg_17_0._constDungeonNormalPosX

	if arg_17_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_17_0.contentTransform, var_17_0, var_0_4)
	else
		recthelper.setAnchorX(arg_17_0.contentTransform, var_17_0)
	end
end

function var_0_0.setFocusEpisodeItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = -arg_18_1.scrollContentPosX + arg_18_0._constDungeonNormalPosX

	if arg_18_2 then
		local var_18_1 = DungeonMapModel.instance.focusEpisodeTweenDuration or var_0_4

		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(arg_18_0.contentTransform, var_18_0, var_18_1)
	else
		recthelper.setAnchorX(arg_18_0.contentTransform, var_18_0)
	end
end

function var_0_0.setSelectEpisodeItem(arg_19_0, arg_19_1)
	arg_19_0.selectedEpisodeItem = arg_19_1

	for iter_19_0, iter_19_1 in pairs(arg_19_0._episodeItemDict) do
		iter_19_1:updateSelectStatus(arg_19_0.selectedEpisodeItem)
	end
end

function var_0_0.playAnimation(arg_20_0, arg_20_1)
	arg_20_0.animator:Play(arg_20_1, 0, 0)
end

function var_0_0.playEpisodeItemAnimation(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._episodeContainerItemList) do
		iter_21_1.episodeItem:playAnimation(arg_21_1)
	end
end

function var_0_0.setSelectEpisodeId(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.selectedEpisodeItem = arg_22_0._episodeItemDict[arg_22_1]

	for iter_22_0, iter_22_1 in pairs(arg_22_0._episodeItemDict) do
		iter_22_1:updateSelectStatus(arg_22_0.selectedEpisodeItem, arg_22_2)
	end
end

function var_0_0.isSelectedEpisodeRightEpisode(arg_23_0, arg_23_1)
	local var_23_0 = false

	if not arg_23_0.selectedEpisodeItem then
		return var_23_0
	end

	local var_23_1 = arg_23_1._config
	local var_23_2 = arg_23_0.selectedEpisodeItem._config

	if not var_23_1 then
		return var_23_0
	end

	if DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_23_1.chapterId, var_23_1.id) > DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_23_2.chapterId, var_23_2.id) then
		var_23_0 = true
	end

	return var_23_0
end

function var_0_0._GuideShowElement(arg_24_0, arg_24_1)
	local var_24_0 = tonumber(arg_24_1)
	local var_24_1 = DungeonConfig.instance:getChapterMapElement(var_24_0)

	if var_24_1 then
		local var_24_2 = var_24_1.mapId
		local var_24_3 = arg_24_0._episodeItemDict[var_24_2]

		if arg_24_0.selectedEpisodeItem ~= var_24_3 then
			arg_24_0.activityDungeonMo:changeEpisode(var_24_2)
			arg_24_0:setSelectEpisodeItem(var_24_3)
		end

		VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.FocusElement, var_24_0)
	end
end

function var_0_0.onClose(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._episodeContainerItemList) do
		iter_25_1.episodeItem:destroyView()
	end
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
