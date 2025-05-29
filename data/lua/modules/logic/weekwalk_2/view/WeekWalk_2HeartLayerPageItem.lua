module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPageItem", package.seeall)

local var_0_0 = class("WeekWalk_2HeartLayerPageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unlock/#btn_click")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlock/#btn_click/#simage_icon")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lock/#btn_lock")
	arg_1_0._simagelockicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	arg_1_0._gochallenge = gohelper.findChild(arg_1_0.viewGO, "#go_challenge")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_name")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_progress")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._gorewardIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_rewardIcon")
	arg_1_0._gonormalIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_normalIcon")
	arg_1_0._gorewardfinish = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_rewardfinish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartView({
		mapId = arg_4_0._layerInfo.id
	})
end

function var_0_0._btnlockOnClick(arg_5_0)
	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function var_0_0._btndetailOnClick(arg_6_0)
	return
end

function var_0_0._btnrewardOnClick(arg_7_0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = arg_7_0._layerInfo.id
	})
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._gofinish, false)
	gohelper.setActive(arg_8_0._gochallenge, false)

	arg_8_0._animator = arg_8_0.viewGO:GetComponent("Animator")
end

function var_0_0._initChildNodes(arg_9_0, arg_9_1)
	if arg_9_0._starsList1 then
		return
	end

	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, string.format("info/type%s", arg_9_1))

	gohelper.setActive(var_9_0, true)

	arg_9_0._txtbattlename = gohelper.findChildText(arg_9_0.viewGO, string.format("info/type%s/txt_battlename", arg_9_1))
	arg_9_0._txtnameen = gohelper.findChildText(arg_9_0.viewGO, string.format("info/type%s/txt_nameen", arg_9_1))
	arg_9_0._txtindex = gohelper.findChildText(arg_9_0.viewGO, string.format("info/type%s/txt_index", arg_9_1))
	arg_9_0._go1 = gohelper.findChild(arg_9_0.viewGO, string.format("info/type%s/go_star/starlist/go_icons1/go_1", arg_9_1))
	arg_9_0._go2 = gohelper.findChild(arg_9_0.viewGO, string.format("info/type%s/go_star/starlist/go_icons2/go_2", arg_9_1))
	arg_9_0._starsList1 = arg_9_0:getUserDataTb_()
	arg_9_0._starsList2 = arg_9_0:getUserDataTb_()

	arg_9_0:_initStarsList(arg_9_0._starsList1, arg_9_0._go1)
	arg_9_0:_initStarsList(arg_9_0._starsList2, arg_9_0._go2)
end

function var_0_0._initStarsList(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_2, false)

	for iter_10_0 = 1, WeekWalk_2Enum.MaxStar do
		local var_10_0 = gohelper.cloneInPlace(arg_10_2)

		gohelper.setActive(var_10_0, true)

		local var_10_1 = gohelper.findChildImage(var_10_0, "icon")

		var_10_1.enabled = false

		local var_10_2 = arg_10_0._layerView:getResInst(arg_10_0._layerView.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_10_1.gameObject)

		table.insert(arg_10_1, var_10_2)
	end
end

function var_0_0._editableAddEvents(arg_11_0)
	arg_11_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_11_0._onWeekwalkTaskUpdate, arg_11_0)
	arg_11_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, arg_11_0._onChangeInfo, arg_11_0)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	arg_12_0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_12_0._onWeekwalkTaskUpdate, arg_12_0)
	arg_12_0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, arg_12_0._onChangeInfo, arg_12_0)
end

function var_0_0._onChangeInfo(arg_13_0)
	arg_13_0:_updateStatus()
end

function var_0_0._onWeekwalkTaskUpdate(arg_14_0)
	arg_14_0:_updateStatus()
end

function var_0_0.setFakeUnlock(arg_15_0, arg_15_1)
	arg_15_0._fakeUnlock = arg_15_1

	arg_15_0:_updateStatus()
end

function var_0_0.playUnlockAnim(arg_16_0)
	gohelper.setActive(arg_16_0._gounlock, true)
	gohelper.setActive(arg_16_0._golock, true)
	arg_16_0._animator:Play("unlock", 0, 0)
	TaskDispatcher.runDelay(arg_16_0._unlockAnimDone, arg_16_0, 1.5)
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unlock)
end

function var_0_0._unlockAnimDone(arg_17_0)
	gohelper.setActive(arg_17_0._golock, false)
end

function var_0_0.getIndex(arg_18_0)
	return arg_18_0._index
end

function var_0_0.getLayerId(arg_19_0)
	return arg_19_0._layerInfo and arg_19_0._layerInfo.id
end

function var_0_0.onUpdateMO(arg_20_0, arg_20_1)
	arg_20_0._index = arg_20_1.index
	arg_20_0._layerView = arg_20_1.layerView
	arg_20_0._typeIndex = arg_20_0._index == 4 and 1 or arg_20_0._index
	arg_20_0._fakeUnlock = true

	arg_20_0:_initChildNodes(arg_20_0._typeIndex)
	arg_20_0:_updateStatus()
end

function var_0_0._updateStatus(arg_21_0)
	arg_21_0._layerInfo = WeekWalk_2Model.instance:getLayerInfoByLayerIndex(arg_21_0._index)
	arg_21_0._layerSceneConfig = arg_21_0._layerInfo.sceneConfig
	arg_21_0._isUnLock = arg_21_0._layerInfo.unlock and arg_21_0._fakeUnlock

	gohelper.setActive(arg_21_0._golock, not arg_21_0._isUnLock)
	gohelper.setActive(arg_21_0._gounlock, arg_21_0._isUnLock)

	arg_21_0._txtbattlename.text = arg_21_0._layerSceneConfig.battleName
	arg_21_0._txtnameen.text = arg_21_0._layerSceneConfig.name_en
	arg_21_0._txtname.text = arg_21_0._layerSceneConfig.name
	arg_21_0._txtindex.text = tostring(arg_21_0._index)

	local var_21_0 = string.format("weekwalkheart_stage%s", arg_21_0._layerInfo.config.layer)

	arg_21_0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon(var_21_0))
	arg_21_0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon(var_21_0))
	arg_21_0:_updateStars()
	arg_21_0:_updateRewardStatus()
	arg_21_0:_updateProgress()

	local var_21_1 = arg_21_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local var_21_2 = arg_21_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)
	local var_21_3 = var_21_1.status == WeekWalk_2Enum.BattleStatus.Finished and var_21_2.status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(arg_21_0._gofinish, var_21_3)
	gohelper.setActive(arg_21_0._gochallenge, not var_21_3 and arg_21_0._isUnLock)
end

function var_0_0._updateProgress(arg_22_0)
	local var_22_0 = WeekWalk_2Config.instance:getWeekWalkRewardList(arg_22_0._layerInfo.config.layer)
	local var_22_1 = 0
	local var_22_2 = 0

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			local var_22_3 = lua_task_weekwalk_ver2.configDict[iter_22_0]

			if var_22_3 and WeekWalk_2TaskListModel.instance:checkPeriods(var_22_3) then
				var_22_2 = var_22_2 + iter_22_1

				local var_22_4 = WeekWalk_2TaskListModel.instance:getTaskMo(iter_22_0)
				local var_22_5 = lua_task_weekwalk_ver2.configDict[iter_22_0]

				if var_22_4 and var_22_4.finishCount >= var_22_5.maxFinishCount then
					var_22_1 = var_22_1 + iter_22_1
				end
			end
		end
	end

	arg_22_0._txtprogress.text = string.format("%s/%s", var_22_1, var_22_2)
	arg_22_0._txtprogress.alpha = var_22_2 <= var_22_1 and 0.45 or 1
end

function var_0_0._updateRewardStatus(arg_23_0)
	gohelper.setActive(arg_23_0._btnreward, true)

	local var_23_0 = arg_23_0._layerInfo.id
	local var_23_1 = WeekWalk_2Enum.TaskType.Season
	local var_23_2, var_23_3 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_23_1, var_23_0)
	local var_23_4 = var_23_2 > 0

	gohelper.setActive(arg_23_0._gorewardIcon, var_23_4)
	gohelper.setActive(arg_23_0._gorewardfinish, not var_23_4 and var_23_3 <= 0)
	gohelper.setActive(arg_23_0._gonormalIcon, not var_23_4 and var_23_3 > 0)
end

function var_0_0._updateStars(arg_24_0)
	local var_24_0 = arg_24_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local var_24_1 = arg_24_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

	arg_24_0:_updateStarList(arg_24_0._starsList1, var_24_0)
	arg_24_0:_updateStarList(arg_24_0._starsList2, var_24_1)
end

function var_0_0._updateStarList(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_0 = arg_25_2:getCupInfo(iter_25_0)
		local var_25_1 = (var_25_0 and var_25_0.result or 0) > 0

		gohelper.setActive(iter_25_1, var_25_1)

		if var_25_1 then
			WeekWalk_2Helper.setCupEffect(iter_25_1, var_25_0)
		end
	end
end

function var_0_0.onSelect(arg_26_0, arg_26_1)
	return
end

function var_0_0.onDestroyView(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._unlockAnimDone, arg_27_0)
end

return var_0_0
