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

function var_0_0.onRefresh(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.viewGO.transform

	arg_8_0._ContentTransform = arg_8_0.viewParam[1].transform
	arg_8_0._ScrollView = arg_8_0.viewParam[2]
	arg_8_0._scrollTrans = arg_8_0.viewParam[3].transform
	arg_8_0._dungeonChapterView = arg_8_0.viewParam[4]
	arg_8_0._chapter = arg_8_0.viewParam[5]

	local var_8_1 = "default"
	local var_8_2 = gohelper.findChild(arg_8_0.viewGO, string.format("%s", var_8_1))

	gohelper.setActive(var_8_2.gameObject, true)

	arg_8_0._golevellist = gohelper.findChild(arg_8_0.viewGO, string.format("%s/go_levellist", var_8_1))
	arg_8_0._gotemplatenormal = gohelper.findChild(arg_8_0.viewGO, string.format("%s/go_levellist/#go_templatenormal", var_8_1))
	arg_8_0._gotemplatesp = gohelper.findChild(arg_8_0.viewGO, string.format("%s/go_levellist/#go_templatesp", var_8_1))

	local var_8_3 = DungeonConfig.instance:getChapterEpisodeCOList(DungeonModel.instance.curLookChapterId)

	arg_8_0._levelItemList = arg_8_0._levelItemList or arg_8_0:getUserDataTb_()

	local var_8_4
	local var_8_5
	local var_8_6
	local var_8_7
	local var_8_8
	local var_8_9
	local var_8_10
	local var_8_11
	local var_8_12 = false
	local var_8_13, var_8_14 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)

	arg_8_0:_initLevelList()

	local var_8_15 = 0
	local var_8_16 = 0
	local var_8_17

	arg_8_0._episodeOpenCount = 0
	arg_8_0._episodeCount = var_8_3 and #var_8_3 or 0

	gohelper.setActive(arg_8_0._scrollTrans, arg_8_0._episodeCount ~= 0)

	if arg_8_0._episodeCount == 0 then
		local var_8_18 = DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)

		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
			var_8_18
		})
	end

	if var_8_3 then
		for iter_8_0, iter_8_1 in ipairs(var_8_3) do
			local var_8_19 = iter_8_1.type == DungeonEnum.EpisodeType.Sp

			if var_8_19 then
				var_8_15 = var_8_15 + 1
				var_8_17 = var_8_15
			else
				var_8_16 = var_8_16 + 1
				var_8_17 = var_8_16
			end

			local var_8_20 = iter_8_1 and DungeonModel.instance:getEpisodeInfo(iter_8_1.id) or nil
			local var_8_21 = arg_8_0:_isSpShow(iter_8_1, var_8_3[iter_8_0 + 1])
			local var_8_22 = var_8_20 and not var_8_19 and arg_8_0:_getLevelContainer(iter_8_1)

			if var_8_20 and var_8_22 then
				if not var_8_19 then
					arg_8_0._episodeOpenCount = var_8_17
				end

				local var_8_23

				if var_8_22.childCount == 0 then
					local var_8_24 = arg_8_0._dungeonChapterView.viewContainer:getSetting().otherRes[1]

					var_8_23 = arg_8_0._dungeonChapterView:getResInst(var_8_24, var_8_22.gameObject)
				else
					var_8_23 = var_8_22:GetChild(0).gameObject
				end

				var_8_22.name = iter_8_1.id

				local var_8_25 = DungeonModel.instance:isFinishElementList(iter_8_1)
				local var_8_26 = arg_8_0._levelItemList[iter_8_1.id]
				local var_8_27 = {
					iter_8_1,
					var_8_20,
					arg_8_0._ContentTransform,
					var_8_17
				}

				if not var_8_26 then
					var_8_26 = DungeonMapEpisodeItem.New()

					var_8_26:initView(var_8_23, var_8_27)
					table.insert(arg_8_0._episodeItemList, var_8_26)

					arg_8_0._levelItemList[iter_8_1.id] = var_8_26
				else
					var_8_26:updateParam(var_8_27)
				end

				if iter_8_1.id == DungeonModel.instance.lastSendEpisodeId then
					DungeonModel.instance.lastSendEpisodeId = nil
					var_8_8 = var_8_23
				end

				if not var_8_10 or recthelper.getAnchorX(var_8_22) >= recthelper.getAnchorX(var_8_10) then
					var_8_10 = var_8_22
					var_8_9 = var_8_23
				end

				if not var_8_19 and not var_8_26:isLock() and var_8_25 then
					var_8_11 = var_8_23
				end

				if var_8_20.isNew then
					var_8_20.isNew = false

					if not var_8_5 then
						var_8_5 = var_8_23

						if not var_8_19 and var_8_8 and var_8_25 and not var_8_12 then
							var_8_8 = var_8_5

							var_8_26:showUnlockAnim()
						end
					end
				end

				if arg_8_1 and iter_8_1.id == arg_8_1 then
					var_8_12 = true
					var_8_8 = var_8_23
				end

				local var_8_28 = iter_8_1.chainEpisode ~= 0 and iter_8_1.chainEpisode or iter_8_1.id

				if not var_8_19 and not var_8_4 and not var_8_26:isLock() and not DungeonModel.instance:hasPassLevelAndStory(var_8_28) and var_8_25 then
					var_8_4 = var_8_23
				end

				local var_8_29 = DungeonConfig.instance:getHardEpisode(iter_8_1.id)

				if DungeonModel.instance:isOpenHardDungeon(iter_8_1.chapterId) and not var_8_19 and not var_8_7 and var_8_29 and not DungeonModel.instance:hasPassLevelAndStory(var_8_29.id) then
					-- block empty
				end

				if not var_8_19 and not var_8_6 and var_8_29 and var_8_20.star == DungeonEnum.StarType.Normal then
					-- block empty
				end
			elseif var_8_20 and not var_8_22 then
				-- block empty
			end
		end
	end

	if not var_8_8 then
		var_8_8 = var_8_4 or var_8_11
		var_8_8 = var_8_8 or arg_8_0._episodeItemList[1] and arg_8_0._episodeItemList[1].viewGO
	end

	if var_8_9 then
		local var_8_30 = recthelper.rectToRelativeAnchorPos(var_8_9.transform.position, var_8_0).x + arg_8_0._offsetX

		recthelper.setSize(arg_8_0._ContentTransform, var_8_30, arg_8_0._rawHeight)

		arg_8_0._contentWidth = var_8_30
	end

	arg_8_0:setFocusItem(var_8_8, false)
end

function var_0_0.setFocusItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0.viewGO.transform
	local var_9_1 = recthelper.rectToRelativeAnchorPos(arg_9_1.transform.position, var_9_0)
	local var_9_2 = recthelper.getWidth(arg_9_0._scrollTrans)
	local var_9_3 = recthelper.getHeight(arg_9_0._scrollTrans)
	local var_9_4 = -var_9_1.x + arg_9_0._constDungeonNormalPosX

	if arg_9_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_9_0._ContentTransform, var_9_4, 0.26)
	else
		recthelper.setAnchorX(arg_9_0._ContentTransform, var_9_4)
	end

	arg_9_0:CheckVision()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._episodeItemList) do
		if iter_9_1.viewGO == arg_9_1 then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, iter_9_1)

			break
		end
	end
end

function var_0_0.setFocusEpisodeItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = -arg_10_1.scrollContentPosX + arg_10_0._constDungeonNormalPosX

	if arg_10_2 then
		local var_10_1 = DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26

		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(arg_10_0._ContentTransform, var_10_0, var_10_1)
	else
		recthelper.setAnchorX(arg_10_0._ContentTransform, var_10_0)
	end

	arg_10_0:CheckVision()
end

function var_0_0.setFocusEpisodeId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._levelItemList[arg_11_1]

	if var_11_0 and var_11_0.viewGO then
		arg_11_0:setFocusItem(var_11_0.viewGO, arg_11_2)
	end
end

function var_0_0.changeFocusEpisodeItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._levelItemList[arg_12_1]

	if not var_12_0 then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, var_12_0)
end

function var_0_0._initLevelList(arg_13_0)
	local var_13_0 = arg_13_0._golevellist.transform.childCount

	if not arg_13_0._itemTransformList then
		arg_13_0._itemTransformList = arg_13_0:getUserDataTb_()
		arg_13_0._rawGoList = arg_13_0:getUserDataTb_()
	end
end

function var_0_0._isSpShow(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.type == DungeonEnum.EpisodeType.Sp

	if var_14_0 and arg_14_2 and arg_14_2.preEpisode == arg_14_1.id and arg_14_2.type ~= DungeonEnum.EpisodeType.Sp then
		var_14_0 = false
	end

	return var_14_0
end

function var_0_0.getEpisodeCount(arg_15_0)
	return arg_15_0._episodeCount
end

function var_0_0._getLevelContainer(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.id
	local var_16_1 = arg_16_0._itemTransformList[var_16_0]

	if var_16_1 then
		return var_16_1
	end

	if not var_16_1 and #arg_16_0._rawGoList > 0 then
		var_16_1 = table.remove(arg_16_0._rawGoList, 1)
	end

	if not var_16_1 then
		local var_16_2 = arg_16_1.preEpisode
		local var_16_3 = arg_16_0._itemTransformList[var_16_2]
		local var_16_4 = var_16_3 and recthelper.getAnchorX(var_16_3)
		local var_16_5 = gohelper.cloneInPlace(arg_16_0._gotemplatenormal, var_16_0)

		gohelper.setActive(var_16_5, true)

		var_16_1 = var_16_5.transform

		if var_16_4 then
			local var_16_6 = arg_16_0._levelItemList[var_16_2]

			recthelper.setAnchorX(var_16_1, var_16_4 + var_16_6:getMaxWidth() + arg_16_0._constDungeonNormalDeltaX)
		else
			recthelper.setAnchorX(var_16_1, arg_16_0._constDungeonNormalPosX)
		end

		recthelper.setAnchorY(var_16_1, arg_16_0._constDungeonNormalPosY)
	end

	arg_16_0._itemTransformList[var_16_0] = var_16_1

	return var_16_1
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_18_0._onOpenView, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_18_0._onCloseView, arg_18_0)

	if GamepadController.instance:isOpen() then
		arg_18_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_18_0._onGamepadKeyUp, arg_18_0)
	end

	arg_18_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_18_0._onChangeFocusEpisodeItem, arg_18_0)
end

function var_0_0._onChangeFocusEpisodeItem(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._episodeItemList) do
		if iter_19_1 == arg_19_1 then
			arg_19_0._focusIndex = iter_19_0
		end
	end
end

function var_0_0._onGamepadKeyUp(arg_20_0, arg_20_1)
	local var_20_0 = ViewMgr.instance:getOpenViewNameList()
	local var_20_1 = var_20_0[#var_20_0]

	if (var_20_1 == ViewName.DungeonMapView or var_20_1 == ViewName.DungeonMapLevelView) and arg_20_0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (arg_20_1 == GamepadEnum.KeyCode.LB or arg_20_1 == GamepadEnum.KeyCode.RB) then
		local var_20_2 = arg_20_1 == GamepadEnum.KeyCode.LB and -1 or 1
		local var_20_3 = arg_20_0._focusIndex + var_20_2

		if var_20_3 > 0 and var_20_3 <= #arg_20_0._episodeItemList then
			arg_20_0._episodeItemList[var_20_3]:onClickHandler()
		end
	end
end

function var_0_0._onOpenView(arg_21_0, arg_21_1)
	if arg_21_1 == ViewName.DungeonMapLevelView then
		arg_21_0._timelineAnimation:Play("timeline_mask")
	end
end

function var_0_0._onCloseView(arg_22_0, arg_22_1)
	if arg_22_1 == ViewName.DungeonMapLevelView then
		arg_22_0._timelineAnimation:Play("timeline_reset")
	end
end

function var_0_0.onClose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._levelItemList) do
		iter_23_1:destroyView()
	end
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._tweenId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenId)
	end
end

return var_0_0
