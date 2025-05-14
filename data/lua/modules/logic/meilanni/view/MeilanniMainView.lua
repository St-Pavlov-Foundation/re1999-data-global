module("modules.logic.meilanni.view.MeilanniMainView", package.seeall)

local var_0_0 = class("MeilanniMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simageheroup1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_hero_up1")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_hero")
	arg_1_0._goday = gohelper.findChild(arg_1_0.viewGO, "remaintime/#go_day")
	arg_1_0._txtremainday = gohelper.findChildText(arg_1_0.viewGO, "remaintime/#go_day/#txt_remainday")
	arg_1_0._gohour = gohelper.findChild(arg_1_0.viewGO, "remaintime/#go_hour")
	arg_1_0._txtremainhour = gohelper.findChildText(arg_1_0.viewGO, "remaintime/#go_hour/#txt_remainhour")
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._gomaplist = gohelper.findChild(arg_1_0.viewGO, "#go_maplist")
	arg_1_0._btnend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_maplist/#btn_end")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._imageremainday = gohelper.findChildImage(arg_1_0.viewGO, "#go_lock/horizontal/part2/#image_remainday")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._gotaskredpoint = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_taskredpoint")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnend:AddClickListener(arg_2_0._btnendOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnend:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
end

function var_0_0._btnendOnClick(arg_4_0)
	MeilanniMapItem.playStoryList(MeilanniEnum.endStoryBindIndex)
end

function var_0_0._btntaskOnClick(arg_5_0)
	MeilanniController.instance:openMeilanniTaskView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	arg_6_0._simagehero:LoadImage(ResUrl.getMeilanniIcon("bg_renwu"))
	gohelper.addUIClickAudio(arg_6_0._btntask.gameObject, AudioEnum.UI.play_ui_common_pause)
	RedDotController.instance:addRedDot(arg_6_0._gotaskredpoint, RedDotEnum.DotNode.MeilanniTaskBtn)
	UIBlockMgr.instance:endAll()
end

function var_0_0._checkFinishAllMapStory(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(lua_activity108_map.configList) do
		local var_7_0 = iter_7_1.id

		if MeilanniModel.instance:getMapHighestScore(var_7_0) <= 0 then
			arg_7_0:_forceUpdateTime()

			return
		end
	end

	local var_7_1 = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishAllMap)

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		local var_7_2 = iter_7_3[1].story

		if not StoryModel.instance:isStoryFinished(var_7_2) then
			StoryController.instance:playStory(var_7_2, nil, arg_7_0._finishAllMapCallback, arg_7_0)

			return
		end
	end

	arg_7_0:_forceUpdateTime()
end

function var_0_0._finishAllMapCallback(arg_8_0)
	arg_8_0:_forceUpdateTime()
end

function var_0_0._forceUpdateTime(arg_9_0)
	if arg_9_0:_getLockTime() > 0 then
		arg_9_0:_showMapList()
	end

	arg_9_0._openMeilanniView = false

	arg_9_0:_updateTime()
end

function var_0_0._checkOpenDayAndFinishMapStory(arg_10_0)
	local var_10_0 = var_0_0.getOpenDayAndFinishMapStory()

	if var_10_0 then
		StoryController.instance:playStory(var_10_0)
	end
end

function var_0_0.getOpenDayAndFinishMapStory()
	local var_11_0 = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
	local var_11_1 = ServerTime.now() - var_11_0:getRealStartTimeStamp()

	if var_11_1 <= 0 then
		return
	end

	local var_11_2 = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDayAndFinishMap)
	local var_11_3 = math.ceil(var_11_1 / 86400)

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_4 = MeilanniModel.instance:getMapInfo(iter_11_1[3])

		if var_11_3 >= iter_11_1[2] and var_11_4 and (var_11_4:checkFinish() or var_11_4.highestScore > 0) then
			local var_11_5 = iter_11_1[1].story

			if not StoryModel.instance:isStoryFinished(var_11_5) then
				return var_11_5
			end

			break
		end
	end
end

function var_0_0._checkOpenDayStory(arg_12_0)
	local var_12_0 = ServerTime.now() - arg_12_0._actMO:getRealStartTimeStamp()

	if var_12_0 <= 0 then
		return
	end

	local var_12_1 = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDay)
	local var_12_2 = math.ceil(var_12_0 / 86400)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if var_12_2 >= iter_12_1[2] then
			local var_12_3 = iter_12_1[1].story

			if not StoryModel.instance:isStoryFinished(var_12_3) then
				StoryController.instance:playStory(var_12_3)
			end

			break
		end
	end
end

function var_0_0._checkStory(arg_13_0)
	if not (arg_13_0.viewParam and arg_13_0.viewParam.checkStory) then
		return
	end

	arg_13_0:_checkOpenDayStory()
	arg_13_0:_checkOpenDayAndFinishMapStory()
	arg_13_0:_checkFinishAllMapStory()
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.MeilanniView then
		TaskDispatcher.runDelay(arg_14_0._checkFinishAllMapStory, arg_14_0, 0)
	end

	if arg_14_1 == ViewName.StoryView and not arg_14_0._hasOpenMeilanniView then
		arg_14_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0._onOpenViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.MeilanniView then
		arg_15_0._openMeilanniView = true
		arg_15_0._hasOpenMeilanniView = true
	end
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_16_0._onCloseViewFinish, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_16_0._onOpenViewFinish, arg_16_0)

	arg_16_0._actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
	arg_16_0._endTime = arg_16_0._actMO:getRealEndTimeStamp()
	arg_16_0._mapItemList = arg_16_0:getUserDataTb_()

	arg_16_0:_showMapList()

	arg_16_0._unlockMapConfig = lua_activity108_map.configDict[MeilanniEnum.unlockMapId]
	arg_16_0._unlockStartTime = arg_16_0._actMO:getRealStartTimeStamp() + (arg_16_0._unlockMapConfig.onlineDay - 1) * 86400

	arg_16_0:_updateTime()
	TaskDispatcher.runRepeat(arg_16_0._updateTime, arg_16_0, 1)
	arg_16_0:_checkStory()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function var_0_0._updateTime(arg_17_0)
	local var_17_0 = arg_17_0._endTime - ServerTime.now()

	if var_17_0 <= 0 then
		ViewMgr.instance:closeView(ViewName.MeilanniTaskView)
		ViewMgr.instance:closeView(ViewName.MeilanniEntrustView)
		ViewMgr.instance:closeView(ViewName.MeilanniView)
		ViewMgr.instance:closeView(ViewName.MeilanniSettlementView)
		ViewMgr.instance:closeView(ViewName.MeilanniMainView)

		return
	end

	if arg_17_0._openMeilanniView then
		return
	end

	local var_17_1, var_17_2 = TimeUtil.secondsToDDHHMMSS(var_17_0)
	local var_17_3 = var_17_1 > 0

	if var_17_3 then
		arg_17_0._txtremainday.text = var_17_1
	else
		arg_17_0._txtremainhour.text = var_17_2
	end

	gohelper.setActive(arg_17_0._goday, var_17_3)
	gohelper.setActive(arg_17_0._gohour, not var_17_3)

	local var_17_4 = arg_17_0:_getLockTime()

	if var_17_4 > 0 then
		local var_17_5 = math.ceil(var_17_4 / 86400)
		local var_17_6 = math.max(math.min(var_17_5, 6), 1)

		UISpriteSetMgr.instance:setMeilanniSprite(arg_17_0._imageremainday, "bg_daojishi_" .. var_17_6)
		arg_17_0._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_2"))
	else
		gohelper.setActive(arg_17_0._golock, false)
		arg_17_0._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_1"))
		arg_17_0:_showMapList()
	end
end

function var_0_0._getLockTime(arg_18_0)
	return arg_18_0._unlockStartTime - ServerTime.now()
end

function var_0_0._showMapList(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(lua_activity108_map.configList) do
		local var_19_0 = gohelper.findChild(arg_19_0._gomaplist, "pos" .. iter_19_0)
		local var_19_1 = arg_19_0._mapItemList[iter_19_1.id] or arg_19_0:_getMapItem(var_19_0, iter_19_1)

		arg_19_0._mapItemList[iter_19_1.id] = var_19_1

		var_19_1:updateLockStatus()

		if iter_19_1.id == 104 then
			local var_19_2 = MeilanniModel.instance:getMapInfo(iter_19_1.id)

			gohelper.setActive(arg_19_0._btnend, var_19_2 and var_19_2.highestScore > 0)
		end
	end
end

function var_0_0._getMapItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = gohelper.findChild(arg_20_1, "item")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_20_0, MeilanniMapItem, arg_20_2))
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._updateTime, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._checkFinishAllMapStory, arg_21_0)
	arg_21_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_21_0._onCloseViewFinish, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._simagebg1:UnLoadImage()
	arg_22_0._simageheroup1:UnLoadImage()
	arg_22_0._simagehero:UnLoadImage()
end

return var_0_0
