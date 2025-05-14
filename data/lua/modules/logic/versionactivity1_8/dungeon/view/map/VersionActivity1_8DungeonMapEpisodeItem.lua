module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapEpisodeItem", BaseChildView)
local var_0_1 = 30
local var_0_2 = 0.8

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/#txt_section")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_hard")
	arg_1_0._gostaricon = gohelper.findChild(arg_1_0.viewGO, "#go_scale/star/#go_staricon")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	arg_1_0._gotipitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_flag")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	arg_1_0._gomaxpos = gohelper.findChild(arg_1_0.viewGO, "#go_maxpos")
	arg_1_0._goraycast = gohelper.findChild(arg_1_0.viewGO, "#go_raycast")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_clickarea")
	arg_1_0._gobeselected = gohelper.findChild(arg_1_0.viewGO, "#go_beselected")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "#txt_locktips")
	arg_1_0._imagesuo = gohelper.findChildImage(arg_1_0.viewGO, "#txt_locktips/#image_suo")
	arg_1_0.goClick = gohelper.getClick(arg_1_0._goclickarea)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goLockAnimator = arg_1_0._golock:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0.beginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0.endShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_2_0.onChangeInProgressMissionGroup, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_2_0._onRepairComponent, arg_2_0)
	arg_2_0.goClick:AddClickListener(arg_2_0.onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_3_0.beginShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_3_0.endShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_3_0.onChangeInProgressMissionGroup, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_3_0._onRepairComponent, arg_3_0)
	arg_3_0.goClick:RemoveClickListener()
end

function var_0_0._onCloseView(arg_4_0)
	if arg_4_0._waitCloseFactoryView then
		local var_4_0 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
		local var_4_1 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

		if not var_4_0 and not var_4_1 then
			arg_4_0:_showAllElementTipView()

			arg_4_0._waitCloseFactoryView = false
		end
	end
end

function var_0_0.beginShowRewardView(arg_5_0)
	arg_5_0.beginReward = true
end

function var_0_0.endShowRewardView(arg_6_0)
	arg_6_0.beginReward = false

	if arg_6_0.needPlayUnLockAnimation then
		arg_6_0:playUnLockAnimation()

		arg_6_0.needPlayUnLockAnimation = nil
	end

	arg_6_0:_showAllElementTipView()
end

function var_0_0.playUnLockAnimation(arg_7_0)
	if not arg_7_0.goLockAnimator then
		return
	end

	arg_7_0.goLockAnimator.enabled = true
end

function var_0_0.onRemoveElement(arg_8_0, arg_8_1)
	if not arg_8_0.beginReward then
		arg_8_0:_showAllElementTipView()
	end

	arg_8_0:initElementIdList()

	if not arg_8_0.elementIdList then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.elementIdList) do
		if iter_8_1 == arg_8_1 then
			local var_8_0 = arg_8_0:checkLock()

			if var_8_0 == arg_8_0.isLock then
				break
			end

			if var_8_0 then
				arg_8_0:refreshLock()

				break
			else
				arg_8_0.isLock = var_8_0

				if arg_8_0.beginReward then
					arg_8_0.needPlayUnLockAnimation = true
				else
					arg_8_0:playUnLockAnimation()
				end
			end
		end
	end
end

function var_0_0.initElementIdList(arg_9_0)
	if not arg_9_0.elementIdList then
		local var_9_0 = arg_9_0._config.elementList

		if not string.nilorempty(var_9_0) then
			arg_9_0.elementIdList = string.splitToNumber(var_9_0, "#")
		end
	end
end

function var_0_0.onChangeInProgressMissionGroup(arg_10_0)
	if not Activity157Model.instance:getIsSideMissionUnlocked() then
		return
	end

	arg_10_0:_showAllElementTipView()
end

function var_0_0._onRepairComponent(arg_11_0)
	local var_11_0 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
	local var_11_1 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

	if var_11_0 or var_11_1 then
		arg_11_0._waitCloseFactoryView = true
	else
		arg_11_0:_showAllElementTipView()
	end
end

function var_0_0.onClick(arg_12_0)
	if arg_12_0.isLock then
		return
	end

	local var_12_0 = ViewMgr.instance:getContainer(ViewName.VersionActivity1_8DungeonMapLevelView)

	if var_12_0 then
		var_12_0:stopCloseViewTask()

		if var_12_0:getOpenedEpisodeId() == arg_12_0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)

			return
		end
	end

	local var_12_1 = arg_12_0:getEpisodeId()

	arg_12_0.activityDungeonMo:changeEpisode(var_12_1)
	arg_12_0._layout:setSelectEpisodeItem(arg_12_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
		episodeId = arg_12_0._config.id
	})
end

function var_0_0.getEpisodeId(arg_13_0)
	return arg_13_0._config and arg_13_0._config.id
end

function var_0_0._editableInitView(arg_14_0)
	gohelper.setActive(arg_14_0._gostaricon, false)
	gohelper.setActive(arg_14_0._goflag, false)
	gohelper.setActive(arg_14_0._gotipitem, false)
	gohelper.setActive(arg_14_0._gonormaleye, false)
	gohelper.setActive(arg_14_0._gohardeye, false)

	arg_14_0.starItemList = {}
	arg_14_0.elementItemList = {}

	table.insert(arg_14_0.starItemList, arg_14_0:createStarItem(arg_14_0._gostaricon))
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:initViewParam()
	arg_15_0:_showAllElementTipView()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:initViewParam()
end

function var_0_0.initViewParam(arg_17_0)
	arg_17_0._contentTransform = arg_17_0.viewParam[1]
	arg_17_0._layout = arg_17_0.viewParam[2]
	arg_17_0._mapSceneView = arg_17_0.viewContainer.mapScene
end

function var_0_0.refresh(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._config = arg_18_1
	arg_18_0._dungeonMo = arg_18_2
	arg_18_0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(arg_18_0._config)
	arg_18_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_18_0._config.id)
	arg_18_0._map = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(arg_18_0._config.id)

	arg_18_0:refreshUI()
	arg_18_0:calculatePosInContent()
	arg_18_0:playAnimation("selected")

	arg_18_0.isSelected = false
end

function var_0_0.refreshUI(arg_19_0)
	arg_19_0._txtsection.text = string.format("%02d", arg_19_0._levelIndex)
	arg_19_0._txtsectionname.text = arg_19_0._config.name
	arg_19_0._txtnameen.text = arg_19_0._config.name_En

	arg_19_0:refreshStar()
	arg_19_0:refreshFlag()
	arg_19_0:refreshUnlockContent()
	arg_19_0:refreshFocusStatus()
	arg_19_0:_showAllElementTipView()
	arg_19_0:_showEye()
	arg_19_0:refreshLock()
end

function var_0_0.refreshStar(arg_20_0)
	if arg_20_0.activityDungeonMo:isHardMode() then
		arg_20_0:refreshHardModeStar()
	else
		arg_20_0:refreshStoryModeStar()
	end
end

function var_0_0.refreshHardModeStar(arg_21_0)
	arg_21_0:refreshEpisodeStar(arg_21_0.starItemList[1], arg_21_0._config.id)

	for iter_21_0 = 2, #arg_21_0.starItemList do
		gohelper.setActive(arg_21_0.starItemList[iter_21_0].goStar, false)
	end
end

function var_0_0.refreshEpisodeStar(arg_22_0, arg_22_1, arg_22_2)
	gohelper.setActive(arg_22_1.goStar, true)

	local var_22_0 = DungeonModel.instance:getEpisodeInfo(arg_22_2)
	local var_22_1 = arg_22_0.pass and var_22_0 and var_22_0.star > DungeonEnum.StarType.None

	arg_22_0:setStarImage(arg_22_1.imgStar1, var_22_1, arg_22_2)

	local var_22_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_22_2)

	if string.nilorempty(var_22_2) then
		gohelper.setActive(arg_22_1.imgStar2.gameObject, false)
	else
		local var_22_3 = arg_22_0.pass and var_22_0 and var_22_0.star >= DungeonEnum.StarType.Advanced

		gohelper.setActive(arg_22_1.imgStar2.gameObject, true)
		arg_22_0:setStarImage(arg_22_1.imgStar2, var_22_3, arg_22_2)
	end
end

function var_0_0.setStarImage(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = DungeonConfig.instance:getEpisodeCO(arg_23_3)

	if not var_23_0 then
		return
	end

	local var_23_1 = VersionActivity1_8DungeonEnum.EpisodeStarType[var_23_0.chapterId]

	if arg_23_2 then
		local var_23_2 = var_23_1.light

		UISpriteSetMgr.instance:setV1a8DungeonSprite(arg_23_1, var_23_2)
	else
		local var_23_3 = var_23_1.empty

		UISpriteSetMgr.instance:setV1a8DungeonSprite(arg_23_1, var_23_3)
	end
end

function var_0_0.refreshStoryModeStar(arg_24_0)
	local var_24_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_24_0._config)

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_1 = arg_24_0.starItemList[iter_24_0]

		if not var_24_1 then
			local var_24_2 = gohelper.cloneInPlace(arg_24_0._gostaricon)

			var_24_1 = arg_24_0:createStarItem(var_24_2)

			table.insert(arg_24_0.starItemList, var_24_1)
		end

		arg_24_0:refreshEpisodeStar(var_24_1, iter_24_1.id)
	end
end

function var_0_0.createStarItem(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.goStar = arg_25_1
	var_25_0.imgStar1 = gohelper.findChildImage(arg_25_1, "starLayout/#image_star1")
	var_25_0.imgStar2 = gohelper.findChildImage(arg_25_1, "starLayout/#image_star2")

	return var_25_0
end

function var_0_0.refreshFlag(arg_26_0)
	gohelper.setActive(arg_26_0._goflag, false)
end

function var_0_0.refreshUnlockContent(arg_27_0)
	local var_27_0 = DungeonModel.instance:isReactivityEpisode(arg_27_0._config.id)

	if arg_27_0.pass or var_27_0 then
		gohelper.setActive(arg_27_0._txtlocktips.gameObject, false)

		return
	end

	local var_27_1 = OpenConfig.instance:getOpenShowInEpisode(arg_27_0._config.id)

	if var_27_1 and #var_27_1 > 0 then
		gohelper.setActive(arg_27_0._txtlocktips.gameObject, true)

		local var_27_2 = DungeonModel.instance:getUnlockContentList(arg_27_0._config.id)

		arg_27_0._txtlocktips.text = var_27_2 and #var_27_2 > 0 and var_27_2[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(arg_27_0._imagesuo, "unlock", true)
	else
		gohelper.setActive(arg_27_0._txtlocktips.gameObject, false)
	end
end

function var_0_0.refreshFocusStatus(arg_28_0)
	gohelper.setActive(arg_28_0._gobeselected, arg_28_0._config.id == arg_28_0.activityDungeonMo.episodeId)
end

function var_0_0._showAllElementTipView(arg_29_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) or not arg_29_0._map then
		gohelper.setActive(arg_29_0._gotipcontent, false)

		return
	end

	local var_29_0 = arg_29_0.activityDungeonMo:isHardMode()
	local var_29_1 = VersionActivity1_8DungeonModel.instance:getElementCoListWithFinish(arg_29_0._map.id, true)

	if var_29_0 or not var_29_1 or #var_29_1 < 1 then
		arg_29_0._showAllElementTip = false

		gohelper.setActive(arg_29_0._gotipcontent, false)

		return
	end

	local var_29_2 = 0
	local var_29_3 = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		local var_29_4 = Activity157Model.instance:getActId()
		local var_29_5 = iter_29_1.id
		local var_29_6 = Activity157Config.instance:getMissionIdByElementId(var_29_4, var_29_5)
		local var_29_7 = var_29_6 and Activity157Config.instance:isSideMission(var_29_4, var_29_6)
		local var_29_8 = DungeonMapModel.instance:elementIsFinished(var_29_5)

		if var_29_7 then
			local var_29_9 = Activity157Config.instance:getMissionGroup(var_29_4, var_29_6)

			if not Activity157Model.instance:isFinishAllMission(var_29_9) then
				var_29_3[#var_29_3 + 1] = var_29_5

				if var_29_8 then
					var_29_2 = var_29_2 + 1
				end
			end
		else
			var_29_3[#var_29_3 + 1] = var_29_5

			if var_29_8 then
				var_29_2 = var_29_2 + 1
			end
		end
	end

	if Activity157Model.instance:getIsSideMissionUnlocked() then
		local var_29_10 = Activity157Model.instance:getInProgressMissionGroup()

		if arg_29_0._lastProgressGroupId and arg_29_0._lastProgressGroupId ~= 0 and arg_29_0._lastProgressGroupId ~= var_29_10 then
			for iter_29_2, iter_29_3 in ipairs(arg_29_0.elementItemList) do
				iter_29_3.status = nil

				iter_29_3.animator:Play("idle", 0, 1)
				gohelper.setActive(iter_29_3.go, false)
			end
		end

		arg_29_0._lastProgressGroupId = var_29_10
	end

	for iter_29_4, iter_29_5 in ipairs(var_29_3) do
		local var_29_11 = arg_29_0.elementItemList[iter_29_4]

		if not var_29_11 then
			var_29_11 = arg_29_0:getUserDataTb_()
			var_29_11.go = gohelper.cloneInPlace(arg_29_0._gotipitem)
			var_29_11.goNotFinish = gohelper.findChild(var_29_11.go, "type1")
			var_29_11.goFinish = gohelper.findChild(var_29_11.go, "type2")
			var_29_11.animator = var_29_11.go:GetComponent(typeof(UnityEngine.Animator))
			var_29_11.status = nil

			table.insert(arg_29_0.elementItemList, var_29_11)
		end

		gohelper.setActive(var_29_11.go, true)

		local var_29_12 = arg_29_0.pass and iter_29_4 <= var_29_2

		gohelper.setActive(var_29_11.goNotFinish, not var_29_12)
		gohelper.setActive(var_29_11.goFinish, var_29_12)

		if var_29_11.status == false and var_29_12 then
			gohelper.setActive(var_29_11.goNotFinish, true)
			var_29_11.animator:Play("switch", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
		end

		var_29_11.status = var_29_12
	end

	local var_29_13 = #var_29_3
	local var_29_14 = #arg_29_0.elementItemList

	if var_29_13 < var_29_14 then
		for iter_29_6 = var_29_13 + 1, var_29_14 do
			local var_29_15 = arg_29_0.elementItemList[iter_29_6]

			if var_29_15 then
				var_29_15.status = nil

				var_29_15.animator:Play("idle", 0, 1)
				gohelper.setActive(var_29_15.go, false)
			end
		end
	end

	local var_29_16 = arg_29_0._showAllElementTip

	arg_29_0._showAllElementTip = arg_29_0.pass and var_29_2 ~= #var_29_3

	if var_29_16 and not arg_29_0._showAllElementTip then
		TaskDispatcher.cancelTask(arg_29_0._hideAllElementTip, arg_29_0)
		TaskDispatcher.runDelay(arg_29_0._hideAllElementTip, arg_29_0, var_0_2)
	else
		gohelper.setActive(arg_29_0._gotipcontent, arg_29_0._showAllElementTip)
	end
end

function var_0_0._hideAllElementTip(arg_30_0)
	gohelper.setActive(arg_30_0._gotipcontent, false)
end

function var_0_0._showEye(arg_31_0)
	if not (arg_31_0._config.displayMark == 1) then
		gohelper.setActive(arg_31_0._gonormaleye, false)
		gohelper.setActive(arg_31_0._gohardeye, false)

		return
	end

	local var_31_0 = arg_31_0._config.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_31_0._gonormaleye, not var_31_0)
	gohelper.setActive(arg_31_0._gohardeye, var_31_0)
end

function var_0_0.refreshLock(arg_32_0)
	arg_32_0.isLock = arg_32_0:checkLock()

	gohelper.setActive(arg_32_0._golock, arg_32_0.isLock)
end

function var_0_0.checkLock(arg_33_0)
	arg_33_0:initElementIdList()

	if not arg_33_0.elementIdList then
		return false
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_33_1) then
			return true
		end
	end

	return false
end

function var_0_0.updateSelectStatus(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_1 then
		if not arg_34_0.isSelected and arg_34_0.playLeftAnimation then
			arg_34_0:playAnimation("restore")
		end

		arg_34_0.isSelected = false

		return
	end

	arg_34_0.isSelected = arg_34_1._config.id == arg_34_0._config.id

	if arg_34_2 then
		return
	end

	if arg_34_1._config.id == arg_34_0._config.id then
		arg_34_0:playAnimation("selected")
	else
		arg_34_0.playLeftAnimation = true

		arg_34_0:playAnimation("notselected")
	end
end

function var_0_0.calculatePosInContent(arg_35_0)
	local var_35_0 = recthelper.getAnchorX(arg_35_0._txtsectionname.transform)
	local var_35_1 = recthelper.getAnchorX(arg_35_0._txtnameen.transform)
	local var_35_2 = var_35_0 + arg_35_0._txtsectionname.preferredWidth
	local var_35_3 = var_35_1 + arg_35_0._txtsectionname.preferredWidth
	local var_35_4 = math.max(var_35_2, var_35_3)

	arg_35_0._maxWidth = math.max(var_35_4 * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + var_0_1

	recthelper.setWidth(arg_35_0._goclickarea.transform, arg_35_0._maxWidth)
	recthelper.setWidth(arg_35_0._goraycast.transform, arg_35_0._maxWidth + arg_35_0._layout._constDungeonNormalDeltaX)

	arg_35_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_35_0.viewGO.transform.position, arg_35_0._contentTransform).x
end

function var_0_0.playAnimation(arg_36_0, arg_36_1)
	if arg_36_0.prePlayAnimName == arg_36_1 then
		return
	end

	arg_36_0.prePlayAnimName = arg_36_1

	arg_36_0.animator:Play(arg_36_1, 0, 0)
end

function var_0_0.getMaxWidth(arg_37_0)
	return arg_37_0._maxWidth
end

function var_0_0.clearElementIdList(arg_38_0)
	arg_38_0.elementIdList = nil
end

function var_0_0.onClose(arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._hideAllElementTip, arg_39_0)
end

function var_0_0.onDestroyView(arg_40_0)
	return
end

return var_0_0
