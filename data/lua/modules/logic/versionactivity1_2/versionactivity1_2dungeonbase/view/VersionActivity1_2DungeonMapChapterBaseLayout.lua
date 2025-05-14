module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapChapterBaseLayout", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapChapterBaseLayout", BaseChildView)

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
	arg_4_0.rectTransform = arg_4_0.viewGO.transform

	local var_4_0 = Vector2(0, 1)

	arg_4_0.rectTransform.pivot = var_4_0
	arg_4_0.rectTransform.anchorMin = var_4_0
	arg_4_0.rectTransform.anchorMax = var_4_0
	arg_4_0.defaultY = 100

	recthelper.setAnchorY(arg_4_0.rectTransform, arg_4_0.defaultY)

	arg_4_0._ContentTransform = arg_4_0.viewParam[1].transform
	arg_4_0._rawWidth = recthelper.getWidth(arg_4_0.rectTransform)
	arg_4_0._rawHeight = recthelper.getHeight(arg_4_0.rectTransform)

	recthelper.setSize(arg_4_0._ContentTransform, arg_4_0._rawWidth, arg_4_0._rawHeight)

	arg_4_0._episodeItemDict = arg_4_0:getUserDataTb_()
	arg_4_0._episodeContainerItemList = arg_4_0:getUserDataTb_()

	local var_4_1 = "default"

	arg_4_0._golevellist = gohelper.findChild(arg_4_0.viewGO, string.format("%s/go_levellist", var_4_1))
	arg_4_0._gotemplatenormal = gohelper.findChild(arg_4_0.viewGO, string.format("%s/go_levellist/#go_templatenormal", var_4_1))
	arg_4_0._gotemplatesp = gohelper.findChild(arg_4_0.viewGO, string.format("%s/go_levellist/#go_templatesp", var_4_1))
	arg_4_0.chapterGo = gohelper.findChild(arg_4_0.viewGO, var_4_1)

	gohelper.setActive(arg_4_0.chapterGo, true)

	local var_4_2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_4_3 = 600

	arg_4_0._offsetX = (var_4_2 - var_4_3) / 2 + var_4_3
	arg_4_0._constDungeonNormalPosX = var_4_2 - arg_4_0._offsetX
	arg_4_0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	arg_4_0._constDungeonNormalDeltaX = 100
	arg_4_0._timelineAnimation = gohelper.findChildComponent(arg_4_0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		arg_4_0._timelineAnimation:Play("timeline_mask")
	end

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0.episodeItemPath = arg_4_0.viewContainer:getSetting().otherRes[1]
end

function var_0_0.onRefresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._chapterId = arg_5_1
	arg_5_0._episodeItemDict = arg_5_0:getUserDataTb_()

	local var_5_0 = tabletool.copy(DungeonConfig.instance:getChapterEpisodeCOList(arg_5_0._chapterId))

	table.insert(var_5_0, 1, var_5_0[1])

	local var_5_1 = 0
	local var_5_2
	local var_5_3

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_4 = iter_5_1 and DungeonModel.instance:getEpisodeInfo(iter_5_1.id) or nil

		if var_5_4 then
			var_5_1 = var_5_1 + 1

			local var_5_5 = arg_5_0:getEpisodeContainerItem(var_5_1)

			arg_5_0._episodeItemDict[iter_5_1.id] = var_5_5.episodeItem
			var_5_5.containerTr.name = iter_5_1.id

			var_5_5.episodeItem:refresh(iter_5_1, var_5_4, var_5_1)
		end
	end

	local var_5_6 = arg_5_0._episodeContainerItemList[var_5_1]
	local var_5_7 = recthelper.rectToRelativeAnchorPos(var_5_6.containerTr.position, arg_5_0.rectTransform).x + arg_5_0._offsetX

	recthelper.setSize(arg_5_0._ContentTransform, var_5_7, arg_5_0._rawHeight)

	arg_5_0._contentWidth = var_5_7

	for iter_5_2 = var_5_1 + 1, #arg_5_0._episodeContainerItemList do
		gohelper.setActive(arg_5_0._episodeContainerItemList[iter_5_2].containerTr.gameObject, false)
	end

	arg_5_0:setFocusEpisodeId(arg_5_2 or var_5_6.episodeItem:getEpisodeId(), false)
end

function var_0_0.setFocusItem(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = -recthelper.rectToRelativeAnchorPos(arg_6_1.transform.position, arg_6_0.rectTransform).x + arg_6_0._constDungeonNormalPosX

	if arg_6_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_6_0._ContentTransform, var_6_0, 0.26)
	else
		recthelper.setAnchorX(arg_6_0._ContentTransform, var_6_0)
	end
end

function var_0_0.setFocusEpisodeItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = -arg_7_1.scrollContentPosX + arg_7_0._constDungeonNormalPosX

	if arg_7_2 then
		local var_7_1 = DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26

		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(arg_7_0._ContentTransform, var_7_0, var_7_1)
	else
		recthelper.setAnchorX(arg_7_0._ContentTransform, var_7_0)
	end

	arg_7_0._cueSelectIndex = arg_7_1._index

	local var_7_2 = arg_7_0._episodeContainerItemList[arg_7_0._cueSelectIndex].episodeItem._config

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, var_7_2)
end

function var_0_0.setFocusEpisodeId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._episodeItemDict[arg_8_1]

	if var_8_0 and var_8_0.viewGO then
		arg_8_0._cueSelectIndex = var_8_0._index

		arg_8_0:setFocusItem(var_8_0.viewGO, arg_8_2)
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, arg_8_1)

		local var_8_1 = arg_8_0._episodeContainerItemList[arg_8_0._cueSelectIndex].episodeItem._config

		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, var_8_1)
	end
end

function var_0_0.getEpisodeContainerItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._episodeContainerItemList[arg_9_1]

	if var_9_0 then
		gohelper.setActive(var_9_0.containerTr.gameObject, true)

		return var_9_0
	end

	local var_9_1 = gohelper.cloneInPlace(arg_9_0._gotemplatenormal, tostring(arg_9_1))

	gohelper.setActive(var_9_1, true)

	local var_9_2 = arg_9_0:getUserDataTb_()

	var_9_2.containerTr = var_9_1.transform

	if arg_9_1 > 1 then
		local var_9_3 = arg_9_0._episodeContainerItemList[arg_9_1 - 1]
		local var_9_4 = recthelper.getAnchorX(var_9_3.containerTr) or 0
		local var_9_5 = var_9_3.episodeItem

		recthelper.setAnchorX(var_9_2.containerTr, var_9_4 + var_9_5:getMaxWidth() + arg_9_0._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(var_9_2.containerTr, arg_9_0._constDungeonNormalPosX)
	end

	recthelper.setAnchorY(var_9_2.containerTr, arg_9_0._constDungeonNormalPosY)

	local var_9_6 = arg_9_0.viewContainer:getResInst(arg_9_0.episodeItemPath, var_9_1)
	local var_9_7 = arg_9_0:getEpisodeItemClass()

	var_9_7.viewContainer = arg_9_0.viewContainer

	var_9_7:initView(var_9_6, {
		arg_9_0._ContentTransform,
		arg_9_0
	})

	var_9_2.episodeItem = var_9_7

	table.insert(arg_9_0._episodeContainerItemList, var_9_2)

	return var_9_2
end

function var_0_0.getEpisodeItemClass(arg_10_0)
	return VersionActivity1_2MapEpisodeBaseItem.New()
end

function var_0_0.updateEpisodeItemsSelectedStatus(arg_11_0)
	local var_11_0 = arg_11_0._episodeItemDict[VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId()]

	if arg_11_0._episodeItemDict then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._episodeItemDict) do
			iter_11_1:updateSelectStatus(var_11_0)
		end
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0._ContentTransform = arg_13_0.viewParam[1].transform

	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_13_0._onOpenView, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)

	if GamepadController.instance:isOpen() then
		arg_13_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_13_0._onGamepadKeyUp, arg_13_0)
	end
end

function var_0_0._onGamepadKeyUp(arg_14_0, arg_14_1)
	local var_14_0 = ViewMgr.instance:getOpenViewNameList()
	local var_14_1 = var_14_0[#var_14_0]

	if (var_14_1 == ViewName.VersionActivity1_2DungeonView or var_14_1 == ViewName.VersionActivity1_2DungeonMapLevelView) and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (arg_14_1 == GamepadEnum.KeyCode.LB or arg_14_1 == GamepadEnum.KeyCode.RB) then
		local var_14_2 = arg_14_1 == GamepadEnum.KeyCode.LB and -1 or 1
		local var_14_3 = arg_14_0._cueSelectIndex + var_14_2

		if var_14_3 > 1 and var_14_3 <= #arg_14_0._episodeContainerItemList then
			arg_14_0._episodeContainerItemList[var_14_3].episodeItem:onClick()
		end
	end
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0:getDungeonMapLevelView() then
		arg_15_0._timelineAnimation:Play("timeline_mask")
	end
end

function var_0_0._onCloseView(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0:getDungeonMapLevelView() then
		arg_16_0._timelineAnimation:Play("timeline_reset")
		arg_16_0:setSelectEpisodeItem(nil)
	end
end

function var_0_0.getDungeonMapLevelView(arg_17_0)
	return ViewName.VersionActivityDungeonMapLevelView
end

function var_0_0.playAnimation(arg_18_0, arg_18_1)
	arg_18_0.animator:Play(arg_18_1, 0, 0)
end

function var_0_0.playEpisodeItemAnimation(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._episodeContainerItemList) do
		iter_19_1.episodeItem:playAnimation(arg_19_1)
	end
end

function var_0_0.setSelectEpisodeItem(arg_20_0, arg_20_1)
	arg_20_0.selectedEpisodeItem = arg_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeContainerItemList) do
		iter_20_1.episodeItem:updateSelectStatus(arg_20_0.selectedEpisodeItem)
	end
end

function var_0_0.isSelectedEpisodeRightEpisode(arg_21_0, arg_21_1)
	if arg_21_0.selectedEpisodeItem and arg_21_1._index > arg_21_0.selectedEpisodeItem._index then
		return true
	end

	return false
end

function var_0_0.onClose(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._episodeContainerItemList) do
		iter_22_1.episodeItem:destroyView()
	end
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._tweenId then
		ZProj.TweenHelper.KillById(arg_23_0._tweenId)
	end
end

return var_0_0
