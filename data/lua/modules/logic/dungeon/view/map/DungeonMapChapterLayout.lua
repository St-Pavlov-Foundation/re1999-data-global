module("modules.logic.dungeon.view.map.DungeonMapChapterLayout", package.seeall)

local var_0_0 = class("DungeonMapChapterLayout", BaseChildView)

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
	local var_4_0 = arg_4_0.viewGO.transform
	local var_4_1 = Vector2(0, 1)

	var_4_0.pivot = var_4_1
	var_4_0.anchorMin = var_4_1
	var_4_0.anchorMax = var_4_1
	arg_4_0.defaultY = 100

	recthelper.setAnchorY(var_4_0, arg_4_0.defaultY)

	arg_4_0._ContentTransform = arg_4_0.viewParam[1].transform
	arg_4_0._rawWidth = recthelper.getWidth(var_4_0)
	arg_4_0._rawHeight = recthelper.getHeight(var_4_0)

	recthelper.setSize(arg_4_0._ContentTransform, arg_4_0._rawWidth, arg_4_0._rawHeight)

	arg_4_0._episodeItemList = arg_4_0:getUserDataTb_()

	local var_4_2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_4_3 = 600

	arg_4_0._offsetX = (var_4_2 - var_4_3) / 2 + var_4_3
	arg_4_0._constDungeonNormalPosX = var_4_2 - arg_4_0._offsetX
	arg_4_0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	arg_4_0._constDungeonNormalDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalDeltaX) - 220
	arg_4_0._constDungeonSPDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonSPDeltaX)
	arg_4_0._timelineAnimation = gohelper.findChildComponent(arg_4_0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		arg_4_0._timelineAnimation:Play("timeline_mask")
	end

	local var_4_4 = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if var_4_4 then
		var_4_4:Play(UIAnimationName.Open)
	end
end

function var_0_0.CheckVision(arg_5_0)
	local var_5_0
	local var_5_1
	local var_5_2
	local var_5_3
	local var_5_4 = recthelper.getAnchorX(arg_5_0._ContentTransform)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._episodeItemList) do
		if var_5_4 > iter_5_1.scrollVisiblePosX then
			break
		end

		if iter_5_1.unfinishedMap then
			var_5_3 = iter_5_1
		end

		if iter_5_1.starNum2 == false then
			var_5_0 = var_5_0 or iter_5_1
		end

		if iter_5_1.starNum3 == false then
			var_5_1 = var_5_1 or iter_5_1
		end

		if iter_5_1.starNum4 == false then
			var_5_2 = var_5_2 or iter_5_1
		end
	end

	if not arg_5_0._tempParam then
		arg_5_0._tempParam = {}
	end

	arg_5_0._tempParam[1] = var_5_0 or var_5_1 or var_5_2
	arg_5_0._tempParam[2] = var_5_3

	DungeonController.instance:dispatchEvent(DungeonEvent.OnCheckVision, arg_5_0._tempParam)
end

function var_0_0.isSpecial(arg_6_0, arg_6_1)
	return arg_6_1.id == 10217
end

function var_0_0.getFocusMap(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2
	local var_7_3
	local var_7_4 = false
	local var_7_5 = DungeonConfig.instance:getChapterEpisodeCOList(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs(var_7_5) do
		local var_7_6 = DungeonModel.instance:getEpisodeInfo(iter_7_1.id)

		if var_7_6 then
			local var_7_7 = DungeonModel.instance:isFinishElementList(iter_7_1)

			if iter_7_1.id == DungeonModel.instance.lastSendEpisodeId then
				var_7_0 = iter_7_1
			end

			if var_7_7 then
				var_7_3 = iter_7_1
			end

			if var_7_6.isNew and not var_7_1 then
				var_7_1 = iter_7_1

				if var_7_0 and var_7_7 and not var_7_4 then
					var_7_0 = var_7_1
				end
			end

			if arg_7_1 and iter_7_1.id == arg_7_1 then
				var_7_4 = true
				var_7_0 = iter_7_1
			end

			if not var_7_2 and not DungeonModel.instance:hasPassLevelAndStory(iter_7_1.id) and var_7_7 then
				var_7_2 = iter_7_1
			end
		end
	end

	var_7_0 = var_7_0 or var_7_2 or var_7_3

	return DungeonMapEpisodeItem.getMap(var_7_0)
end

function var_0_0.skipFocusItem(arg_8_0, arg_8_1)
	arg_8_0._skipFocusItem = arg_8_1
end

function var_0_0.onRefresh(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.viewGO.transform

	arg_9_0._ContentTransform = arg_9_0.viewParam[1].transform
	arg_9_0._ScrollView = arg_9_0.viewParam[2]
	arg_9_0._scrollTrans = arg_9_0.viewParam[3].transform
	arg_9_0._dungeonChapterView = arg_9_0.viewParam[4]
	arg_9_0._chapter = arg_9_0.viewParam[5]

	local var_9_1 = "default"
	local var_9_2 = gohelper.findChild(arg_9_0.viewGO, string.format("%s", var_9_1))

	gohelper.setActive(var_9_2.gameObject, true)

	arg_9_0._golevellist = gohelper.findChild(arg_9_0.viewGO, string.format("%s/go_levellist", var_9_1))
	arg_9_0._gotemplatenormal = gohelper.findChild(arg_9_0.viewGO, string.format("%s/go_levellist/#go_templatenormal", var_9_1))
	arg_9_0._gotemplatesp = gohelper.findChild(arg_9_0.viewGO, string.format("%s/go_levellist/#go_templatesp", var_9_1))

	local var_9_3 = DungeonConfig.instance:getChapterEpisodeCOList(DungeonModel.instance.curLookChapterId)

	arg_9_0._levelItemList = arg_9_0._levelItemList or arg_9_0:getUserDataTb_()

	local var_9_4
	local var_9_5
	local var_9_6
	local var_9_7
	local var_9_8
	local var_9_9
	local var_9_10
	local var_9_11
	local var_9_12 = false
	local var_9_13, var_9_14 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)

	arg_9_0:_initLevelList()

	local var_9_15 = 0
	local var_9_16 = 0
	local var_9_17

	arg_9_0._episodeOpenCount = 0
	arg_9_0._episodeCount = var_9_3 and #var_9_3 or 0

	gohelper.setActive(arg_9_0._scrollTrans, arg_9_0._episodeCount ~= 0)

	if arg_9_0._episodeCount == 0 then
		local var_9_18 = DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)

		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
			var_9_18
		})
	end

	if var_9_3 then
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_19 = iter_9_1.type == DungeonEnum.EpisodeType.Sp

			if var_9_19 then
				var_9_15 = var_9_15 + 1
				var_9_17 = var_9_15
			else
				var_9_16 = var_9_16 + 1
				var_9_17 = var_9_16
			end

			local var_9_20 = iter_9_1 and DungeonModel.instance:getEpisodeInfo(iter_9_1.id) or nil
			local var_9_21 = arg_9_0:_isSpShow(iter_9_1, var_9_3[iter_9_0 + 1])
			local var_9_22 = var_9_20 and not var_9_19 and arg_9_0:_getLevelContainer(iter_9_1)

			if var_9_20 and var_9_22 then
				if not var_9_19 then
					arg_9_0._episodeOpenCount = var_9_17
				end

				local var_9_23

				if var_9_22.childCount == 0 then
					local var_9_24 = arg_9_0._dungeonChapterView.viewContainer:getSetting().otherRes[1]

					var_9_23 = arg_9_0._dungeonChapterView:getResInst(var_9_24, var_9_22.gameObject)
				else
					var_9_23 = var_9_22:GetChild(0).gameObject
				end

				var_9_22.name = iter_9_1.id

				local var_9_25 = DungeonModel.instance:isFinishElementList(iter_9_1)
				local var_9_26 = arg_9_0._levelItemList[iter_9_1.id]
				local var_9_27 = {
					iter_9_1,
					var_9_20,
					arg_9_0._ContentTransform,
					var_9_17
				}

				if not var_9_26 then
					var_9_26 = DungeonMapEpisodeItem.New()

					var_9_26:initView(var_9_23, var_9_27)
					table.insert(arg_9_0._episodeItemList, var_9_26)

					arg_9_0._levelItemList[iter_9_1.id] = var_9_26
				else
					var_9_26:updateParam(var_9_27)
				end

				if iter_9_1.id == DungeonModel.instance.lastSendEpisodeId then
					DungeonModel.instance.lastSendEpisodeId = nil
					var_9_8 = var_9_23
				end

				if not var_9_10 or recthelper.getAnchorX(var_9_22) >= recthelper.getAnchorX(var_9_10) then
					var_9_10 = var_9_22
					var_9_9 = var_9_23
				end

				if not var_9_19 and not var_9_26:isLock() and var_9_25 then
					var_9_11 = var_9_23
				end

				if var_9_20.isNew then
					var_9_20.isNew = false

					if not var_9_5 then
						var_9_5 = var_9_23

						if not var_9_19 and var_9_8 and var_9_25 and not var_9_12 then
							var_9_8 = var_9_5

							var_9_26:showUnlockAnim()
						end
					end
				end

				if arg_9_1 and iter_9_1.id == arg_9_1 then
					var_9_12 = true
					var_9_8 = var_9_23
				end

				local var_9_28 = iter_9_1.chainEpisode ~= 0 and iter_9_1.chainEpisode or iter_9_1.id

				if not var_9_19 and not var_9_4 and not var_9_26:isLock() and not DungeonModel.instance:hasPassLevelAndStory(var_9_28) and var_9_25 then
					var_9_4 = var_9_23
				end

				local var_9_29 = DungeonConfig.instance:getHardEpisode(iter_9_1.id)

				if DungeonModel.instance:isOpenHardDungeon(iter_9_1.chapterId) and not var_9_19 and not var_9_7 and var_9_29 and not DungeonModel.instance:hasPassLevelAndStory(var_9_29.id) then
					-- block empty
				end

				if not var_9_19 and not var_9_6 and var_9_29 and var_9_20.star == DungeonEnum.StarType.Normal then
					-- block empty
				end
			elseif var_9_20 and not var_9_22 then
				-- block empty
			end
		end
	end

	if not var_9_8 then
		var_9_8 = var_9_4 or var_9_11
		var_9_8 = var_9_8 or arg_9_0._episodeItemList[1] and arg_9_0._episodeItemList[1].viewGO
	end

	if var_9_9 then
		local var_9_30 = recthelper.rectToRelativeAnchorPos(var_9_9.transform.position, var_9_0).x + arg_9_0._offsetX

		recthelper.setSize(arg_9_0._ContentTransform, var_9_30, arg_9_0._rawHeight)

		arg_9_0._contentWidth = var_9_30
	end

	if arg_9_0._skipFocusItem then
		return
	end

	arg_9_0:setFocusItem(var_9_8, false)
end

function var_0_0.setFocusItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0.viewGO.transform
	local var_10_1 = recthelper.rectToRelativeAnchorPos(arg_10_1.transform.position, var_10_0)
	local var_10_2 = recthelper.getWidth(arg_10_0._scrollTrans)
	local var_10_3 = recthelper.getHeight(arg_10_0._scrollTrans)
	local var_10_4 = -var_10_1.x + arg_10_0._constDungeonNormalPosX

	if arg_10_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_10_0._ContentTransform, var_10_4, 0.26)
	else
		recthelper.setAnchorX(arg_10_0._ContentTransform, var_10_4)
	end

	arg_10_0:CheckVision()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._episodeItemList) do
		if iter_10_1.viewGO == arg_10_1 then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, iter_10_1)

			break
		end
	end
end

function var_0_0.setFocusEpisodeItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = -arg_11_1.scrollContentPosX + arg_11_0._constDungeonNormalPosX

	if arg_11_2 then
		local var_11_1 = DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26

		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(arg_11_0._ContentTransform, var_11_0, var_11_1)
	else
		recthelper.setAnchorX(arg_11_0._ContentTransform, var_11_0)
	end

	arg_11_0:CheckVision()
end

function var_0_0.setFocusEpisodeId(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._levelItemList[arg_12_1]

	if var_12_0 and var_12_0.viewGO then
		arg_12_0:setFocusItem(var_12_0.viewGO, arg_12_2)
	end
end

function var_0_0.changeFocusEpisodeItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._levelItemList[arg_13_1]

	if not var_13_0 then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, var_13_0)
end

function var_0_0._initLevelList(arg_14_0)
	local var_14_0 = arg_14_0._golevellist.transform.childCount

	if not arg_14_0._itemTransformList then
		arg_14_0._itemTransformList = arg_14_0:getUserDataTb_()
		arg_14_0._rawGoList = arg_14_0:getUserDataTb_()
	end
end

function var_0_0._isSpShow(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.type == DungeonEnum.EpisodeType.Sp

	if var_15_0 and arg_15_2 and arg_15_2.preEpisode == arg_15_1.id and arg_15_2.type ~= DungeonEnum.EpisodeType.Sp then
		var_15_0 = false
	end

	return var_15_0
end

function var_0_0.getEpisodeCount(arg_16_0)
	return arg_16_0._episodeCount
end

function var_0_0._getLevelContainer(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.id
	local var_17_1 = arg_17_0._itemTransformList[var_17_0]

	if var_17_1 then
		return var_17_1
	end

	if not var_17_1 and #arg_17_0._rawGoList > 0 then
		var_17_1 = table.remove(arg_17_0._rawGoList, 1)
	end

	if not var_17_1 then
		local var_17_2 = arg_17_1.preEpisode
		local var_17_3 = arg_17_0._itemTransformList[var_17_2]
		local var_17_4 = var_17_3 and recthelper.getAnchorX(var_17_3)
		local var_17_5 = gohelper.cloneInPlace(arg_17_0._gotemplatenormal, var_17_0)

		gohelper.setActive(var_17_5, true)

		var_17_1 = var_17_5.transform

		if var_17_4 then
			local var_17_6 = arg_17_0._levelItemList[var_17_2]

			recthelper.setAnchorX(var_17_1, var_17_4 + var_17_6:getMaxWidth() + arg_17_0._constDungeonNormalDeltaX)
		else
			recthelper.setAnchorX(var_17_1, arg_17_0._constDungeonNormalPosX)
		end

		recthelper.setAnchorY(var_17_1, arg_17_0._constDungeonNormalPosY)
	end

	arg_17_0._itemTransformList[var_17_0] = var_17_1

	return var_17_1
end

function var_0_0.onUpdateParam(arg_18_0)
	return
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_19_0._onOpenView, arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_19_0._onCloseView, arg_19_0)

	if GamepadController.instance:isOpen() then
		arg_19_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_19_0._onGamepadKeyUp, arg_19_0)
	end

	arg_19_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_19_0._onChangeFocusEpisodeItem, arg_19_0)
end

function var_0_0._onChangeFocusEpisodeItem(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeItemList) do
		if iter_20_1 == arg_20_1 then
			arg_20_0._focusIndex = iter_20_0
		end
	end
end

function var_0_0._onGamepadKeyUp(arg_21_0, arg_21_1)
	local var_21_0 = ViewMgr.instance:getOpenViewNameList()
	local var_21_1 = var_21_0[#var_21_0]

	if (var_21_1 == ViewName.DungeonMapView or var_21_1 == ViewName.DungeonMapLevelView) and arg_21_0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (arg_21_1 == GamepadEnum.KeyCode.LB or arg_21_1 == GamepadEnum.KeyCode.RB) then
		local var_21_2 = arg_21_1 == GamepadEnum.KeyCode.LB and -1 or 1
		local var_21_3 = arg_21_0._focusIndex + var_21_2

		if var_21_3 > 0 and var_21_3 <= #arg_21_0._episodeItemList then
			arg_21_0._episodeItemList[var_21_3]:onClickHandler()
		end
	end
end

function var_0_0._onOpenView(arg_22_0, arg_22_1)
	if arg_22_1 == ViewName.DungeonMapLevelView then
		arg_22_0._timelineAnimation:Play("timeline_mask")
	end
end

function var_0_0._onCloseView(arg_23_0, arg_23_1)
	if arg_23_1 == ViewName.DungeonMapLevelView then
		arg_23_0._timelineAnimation:Play("timeline_reset")
	end
end

function var_0_0.onClose(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._levelItemList) do
		iter_24_1:destroyView()
	end
end

function var_0_0.onDestroyView(arg_25_0)
	if arg_25_0._tweenId then
		ZProj.TweenHelper.KillById(arg_25_0._tweenId)
	end
end

return var_0_0
