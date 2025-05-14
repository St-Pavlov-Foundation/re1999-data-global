module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapChapterLayout", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapChapterLayout", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._focusIndex = 0
	arg_4_0.rectTransform = arg_4_0.viewGO.transform

	local var_4_0 = Vector2(0, 1)

	arg_4_0.rectTransform.pivot = var_4_0
	arg_4_0.rectTransform.anchorMin = var_4_0
	arg_4_0.rectTransform.anchorMax = var_4_0
	arg_4_0.defaultY = arg_4_0.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(arg_4_0.rectTransform, arg_4_0.defaultY)

	arg_4_0.contentTransform = arg_4_0.viewParam.goChapterContent.transform
	arg_4_0._rawWidth = recthelper.getWidth(arg_4_0.rectTransform)
	arg_4_0._rawHeight = recthelper.getHeight(arg_4_0.rectTransform)

	recthelper.setSize(arg_4_0.contentTransform, arg_4_0._rawWidth, arg_4_0._rawHeight)

	arg_4_0._episodeItemDict = arg_4_0:getUserDataTb_()
	arg_4_0._episodeContainerItemList = arg_4_0:getUserDataTb_()

	local var_4_1 = "default"

	arg_4_0._golevellist = gohelper.findChild(arg_4_0.viewGO, string.format("%s/go_levellist", var_4_1))
	arg_4_0._gotemplatenormal = gohelper.findChild(arg_4_0.viewGO, string.format("%s/go_levellist/#go_templatenormal", var_4_1))
	arg_4_0.chapterGo = gohelper.findChild(arg_4_0.viewGO, var_4_1)

	gohelper.setActive(arg_4_0.chapterGo, true)

	local var_4_2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_4_3 = 600

	arg_4_0._offsetX = (var_4_2 - var_4_3) / 2 + var_4_3
	arg_4_0._constDungeonNormalPosX = var_4_2 - arg_4_0._offsetX
	arg_4_0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	arg_4_0._constDungeonNormalDeltaX = 100
	arg_4_0._timelineAnimation = gohelper.findChildComponent(arg_4_0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.VersionActivity1_5DungeonMapLevelView) then
		arg_4_0._timelineAnimation:Play("timeline_mask")
	end

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0.episodeItemPath = arg_4_0.viewContainer:getSetting().otherRes[1]
end

function var_0_0.setSelectEpisodeId(arg_5_0, arg_5_1)
	arg_5_0.selectedEpisodeItem = arg_5_0._episodeItemDict[arg_5_1]

	for iter_5_0, iter_5_1 in pairs(arg_5_0._episodeItemDict) do
		iter_5_1:updateSelectStatus(arg_5_0.selectedEpisodeItem)
	end
end

function var_0_0._onChangeFocusEpisodeItem(arg_6_0, arg_6_1)
	if GamepadController.instance:isOpen() then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._episodeContainerItemList) do
			if iter_6_1.episodeItem == arg_6_1 then
				arg_6_0._focusIndex = iter_6_0
			end
		end
	end
end

function var_0_0._onGamepadKeyUp(arg_7_0, arg_7_1)
	local var_7_0 = ViewMgr.instance:getOpenViewNameList()
	local var_7_1 = var_7_0[#var_7_0]

	if (var_7_1 == ViewName.VersionActivity1_5DungeonMapView or var_7_1 == ViewName.VersionActivity1_5DungeonMapLevelView) and arg_7_0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (arg_7_1 == GamepadEnum.KeyCode.LB or arg_7_1 == GamepadEnum.KeyCode.RB) then
		local var_7_2 = arg_7_1 == GamepadEnum.KeyCode.LB and -1 or 1
		local var_7_3 = arg_7_0._focusIndex + var_7_2
		local var_7_4 = math.max(1, var_7_3)
		local var_7_5 = math.min(var_7_4, #arg_7_0._episodeContainerItemList)

		if var_7_5 > 0 and var_7_5 <= #arg_7_0._episodeContainerItemList then
			arg_7_0._episodeContainerItemList[var_7_5].episodeItem:onClick(true)
		end
	end
end

function var_0_0.refreshEpisodeNodes(arg_8_0)
	arg_8_0._episodeItemDict = arg_8_0:getUserDataTb_()

	local var_8_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_8_0.activityDungeonMo.chapterId)
	local var_8_1 = 0
	local var_8_2
	local var_8_3

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_4 = iter_8_1 and DungeonModel.instance:getEpisodeInfo(iter_8_1.id) or nil

		if var_8_4 then
			var_8_1 = var_8_1 + 1

			local var_8_5 = arg_8_0:getEpisodeContainerItem(var_8_1)

			arg_8_0._episodeItemDict[iter_8_1.id] = var_8_5.episodeItem
			var_8_5.containerTr.name = iter_8_1.id

			var_8_5.episodeItem:refresh(iter_8_1, var_8_4)
		end
	end

	local var_8_6 = arg_8_0._episodeContainerItemList[var_8_1]
	local var_8_7 = recthelper.rectToRelativeAnchorPos(var_8_6.containerTr.position, arg_8_0.rectTransform).x + arg_8_0._offsetX

	recthelper.setSize(arg_8_0.contentTransform, var_8_7, arg_8_0._rawHeight)

	arg_8_0._contentWidth = var_8_7

	for iter_8_2 = var_8_1 + 1, #arg_8_0._episodeContainerItemList do
		gohelper.setActive(arg_8_0._episodeContainerItemList[iter_8_2].containerTr.gameObject, false)
	end

	arg_8_0:setFocusEpisodeId(arg_8_0.activityDungeonMo.episodeId, false)
end

function var_0_0.setFocusItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	local var_9_0 = -recthelper.rectToRelativeAnchorPos(arg_9_1.transform.position, arg_9_0.rectTransform).x + arg_9_0._constDungeonNormalPosX

	if arg_9_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_9_0.contentTransform, var_9_0, 0.26)
	else
		recthelper.setAnchorX(arg_9_0.contentTransform, var_9_0)
	end
end

function var_0_0.setFocusEpisodeItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = -arg_10_1.scrollContentPosX + arg_10_0._constDungeonNormalPosX

	if arg_10_2 then
		local var_10_1 = DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26

		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(arg_10_0.contentTransform, var_10_0, var_10_1)
	else
		recthelper.setAnchorX(arg_10_0.contentTransform, var_10_0)
	end
end

function var_0_0.setFocusEpisodeId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._episodeItemDict[arg_11_1]

	if var_11_0 and var_11_0.viewGO then
		arg_11_0:setFocusItem(var_11_0.viewGO, arg_11_2)
	end

	if var_11_0 then
		arg_11_0:_onChangeFocusEpisodeItem(var_11_0)
	end
end

function var_0_0.getEpisodeContainerItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._episodeContainerItemList[arg_12_1]

	if var_12_0 then
		gohelper.setActive(var_12_0.containerTr.gameObject, true)
		var_12_0.episodeItem:clearElementIdList()

		return var_12_0
	end

	local var_12_1 = gohelper.cloneInPlace(arg_12_0._gotemplatenormal, tostring(arg_12_1))

	gohelper.setActive(var_12_1, true)

	local var_12_2 = arg_12_0:getUserDataTb_()

	var_12_2.containerTr = var_12_1.transform

	if arg_12_1 > 1 then
		local var_12_3 = arg_12_0._episodeContainerItemList[arg_12_1 - 1]
		local var_12_4 = recthelper.getAnchorX(var_12_3.containerTr) or 0
		local var_12_5 = var_12_3.episodeItem

		recthelper.setAnchorX(var_12_2.containerTr, var_12_4 + var_12_5:getMaxWidth() + arg_12_0._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(var_12_2.containerTr, arg_12_0._constDungeonNormalPosX)
	end

	recthelper.setAnchorY(var_12_2.containerTr, arg_12_0._constDungeonNormalPosY)

	local var_12_6 = arg_12_0.viewContainer:getResInst(arg_12_0.episodeItemPath, var_12_1)
	local var_12_7 = arg_12_0.activityDungeonMo:getEpisodeItemClass().New()

	var_12_7.viewContainer = arg_12_0.viewContainer
	var_12_7.activityDungeonMo = arg_12_0.activityDungeonMo

	var_12_7:initView(var_12_6, {
		arg_12_0.contentTransform,
		arg_12_0
	})

	var_12_2.episodeItem = var_12_7

	table.insert(arg_12_0._episodeContainerItemList, var_12_2)

	return var_12_2
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_14_0._onOpenView, arg_14_0)
	arg_14_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_14_0._onCloseView, arg_14_0)
	arg_14_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_14_0.onActivityDungeonMoChange, arg_14_0)

	if GamepadController.instance:isOpen() then
		arg_14_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_14_0._onGamepadKeyUp, arg_14_0)
		arg_14_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_14_0._onChangeFocusEpisodeItem, arg_14_0)
	end
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_15_0._timelineAnimation:Play("timeline_mask")
		arg_15_0:setSelectEpisodeItem(arg_15_0._episodeItemDict[arg_15_0.activityDungeonMo.episodeId])
	end
end

function var_0_0._onCloseView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_16_0._timelineAnimation:Play("timeline_reset")
		arg_16_0:setSelectEpisodeItem(nil)
	end
end

function var_0_0.playAnimation(arg_17_0, arg_17_1)
	arg_17_0.animator:Play(arg_17_1, 0, 0)
end

function var_0_0.playEpisodeItemAnimation(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._episodeContainerItemList) do
		iter_18_1.episodeItem:playAnimation(arg_18_1)
	end
end

function var_0_0.setSelectEpisodeItem(arg_19_0, arg_19_1)
	arg_19_0.selectedEpisodeItem = arg_19_1

	for iter_19_0, iter_19_1 in pairs(arg_19_0._episodeItemDict) do
		iter_19_1:updateSelectStatus(arg_19_0.selectedEpisodeItem)
	end
end

function var_0_0.updateFocusStatus(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._episodeItemDict) do
		iter_20_1:refreshFocusStatus()
	end
end

function var_0_0.isSelectedEpisodeRightEpisode(arg_21_0, arg_21_1)
	if not arg_21_0.selectedEpisodeItem then
		return false
	end

	if DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_21_1._config.chapterId, arg_21_1._config.id) > DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_21_0.selectedEpisodeItem._config.chapterId, arg_21_0.selectedEpisodeItem._config.id) then
		return true
	end

	return false
end

function var_0_0.onActivityDungeonMoChange(arg_22_0)
	arg_22_0:updateFocusStatus()
	arg_22_0:setFocusEpisodeId(arg_22_0.activityDungeonMo.episodeId, true)
end

function var_0_0.onClose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._episodeContainerItemList) do
		iter_23_1.episodeItem:destroyView()
	end
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
