module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelView", package.seeall)

local var_0_0 = class("VersionActivityPushBoxLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrolllevels = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_levels")
	arg_1_0._golevel10 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level10")
	arg_1_0._golevel9 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level9")
	arg_1_0._golevel8 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level8")
	arg_1_0._golevel7 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level7")
	arg_1_0._golevel6 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level6")
	arg_1_0._golevel5 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level5")
	arg_1_0._golevel4 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level4")
	arg_1_0._golevel3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level3")
	arg_1_0._golevel2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level2")
	arg_1_0._golevel1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_levels/Viewport/Content/#go_level1")
	arg_1_0._gotaskred = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_task_red")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "top/#txt_remaintime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, arg_2_0._onReceiveTaskRewardReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxTaskView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/full/bg"))

	arg_5_0._ani = gohelper.onceAddComponent(arg_5_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0._playOpenAudio(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function var_0_0.onOpen(arg_8_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityPushBoxNewLevelOpen, 0) then
		GameFacade.showToast(ToastEnum.VersionActivityPushBoxNewLevelOpen)
	end

	TaskDispatcher.runDelay(arg_8_0._playOpenAudio, arg_8_0, 0.5)

	arg_8_0._activity_data = ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]

	arg_8_0.viewContainer._navigateButtonView:setOverrideClose(arg_8_0._onNavigateCloseCallback, arg_8_0)
	arg_8_0.viewContainer._navigateButtonView:setOverrideHome(arg_8_0._onNavigateHomeCallback, arg_8_0)

	arg_8_0._episode_list = PushBoxEpisodeConfig.instance:getEpisodeList()

	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.id
	local var_8_1

	for iter_8_0 = 1, 10 do
		gohelper.findChildComponent(arg_8_0["_golevel" .. iter_8_0], "go_info/go_finish", typeof(UnityEngine.Animation)).enabled = false

		if not arg_8_0._episode_list[iter_8_0] then
			gohelper.setActive(arg_8_0["_golevel" .. iter_8_0], false)
		else
			if PushBoxModel.instance:getPassData(arg_8_0._episode_list[iter_8_0].id) then
				-- block empty
			else
				local var_8_2 = gohelper.findChild(arg_8_0["_golevel" .. iter_8_0], "go_info")

				if not var_8_1 then
					var_8_1 = true

					gohelper.setActive(var_8_2, true)
				else
					gohelper.setActive(var_8_2, false)
					arg_8_0["_golevel" .. iter_8_0]:GetComponent(typeof(UnityEngine.Animator)):Play("in")
				end
			end

			if var_8_0 == arg_8_0._episode_list[iter_8_0].id then
				if iter_8_0 <= 5 then
					-- block empty
				else
					recthelper.setAnchorX(gohelper.findChild(arg_8_0.viewGO, "#scroll_levels/Viewport/Content").transform, -950)
				end

				if arg_8_0.viewParam.win then
					arg_8_0._new_finish_episode = arg_8_0._episode_list[iter_8_0].id
				end
			end
		end
	end

	arg_8_0:_refreshLevelData()
	arg_8_0:_updateDeadline()
	TaskDispatcher.runRepeat(arg_8_0._updateDeadline, arg_8_0, 60)
end

function var_0_0._updateDeadline(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]

	arg_9_0._txtremaintime.text = string.format(luaLang("remain"), var_9_0:getRemainTimeStr2ByEndTime())
end

function var_0_0._refreshLevelData(arg_10_0)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._episode_list) do
		local var_10_1 = iter_10_1.id
		local var_10_2 = PushBoxModel.instance:getPassData(var_10_1)
		local var_10_3 = arg_10_0["_golevel" .. iter_10_0]

		gohelper.findChildTextMesh(var_10_3, "go_info/txt_title").text = iter_10_1.name

		local var_10_4 = gohelper.findChild(var_10_3, "go_info/go_lock")
		local var_10_5 = gohelper.findChild(var_10_3, "go_info/go_finish")
		local var_10_6 = gohelper.findChildImage(var_10_3, "simage_map")
		local var_10_7 = gohelper.findChildTextMesh(var_10_3, "go_info/go_lock/go_speciallock/txt_unlocktime")
		local var_10_8 = gohelper.findChild(var_10_3, "go_info/go_lock/go_speciallock")
		local var_10_9 = gohelper.findChild(var_10_3, "go_info/go_lock/go_normallock")
		local var_10_10 = gohelper.findChild(var_10_3, "go_info/txt_index")
		local var_10_11 = gohelper.findChild(var_10_3, "maplock")
		local var_10_12 = gohelper.findChild(var_10_3, "map")

		gohelper.setActive(var_10_11, not var_10_2)
		gohelper.setActive(var_10_12, var_10_2)

		var_10_11:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_10_0 and 1 or 0.5

		if var_10_2 then
			UISpriteSetMgr.instance:setPushBoxSprite(var_10_6, string.format("gk_%02d", iter_10_0), true)
		else
			UISpriteSetMgr.instance:setPushBoxSprite(var_10_6, string.format("gkj_%02d", iter_10_0), true)

			local var_10_13 = PushBoxModel.instance:getStageOpened(var_10_1)

			gohelper.setActive(var_10_8, not var_10_13)
			gohelper.setActive(var_10_9, var_10_13)

			if not var_10_13 then
				local var_10_14 = PushBoxModel.instance:getEpisodeOpenTime(var_10_1)

				var_10_7.text = os.date("%m.%d", var_10_14) .. luaLang("unlock")
			end
		end

		var_10_0 = var_10_2

		gohelper.setActive(var_10_5, var_10_2 and var_10_2.state == 1)
		gohelper.setActive(var_10_4, not var_10_2)
		gohelper.setActive(var_10_10, var_10_2)
		gohelper.findChildClickWithAudio(var_10_3, "btn_click"):AddClickListener(arg_10_0._episodeClick, arg_10_0, var_10_1)

		local var_10_15 = gohelper.findChild(var_10_3, "go_selectedbg")
		local var_10_16 = gohelper.findChild(var_10_3, "go_selected")

		gohelper.setActive(var_10_15, false)
		gohelper.setActive(var_10_16, false)

		if arg_10_0._new_finish_episode == var_10_1 then
			arg_10_0._new_finish_obj = var_10_5

			gohelper.setActive(var_10_5, false)
			TaskDispatcher.runDelay(arg_10_0._playNewFinish, arg_10_0, 1.5)
		end
	end

	RedDotController.instance:addRedDot(arg_10_0._gotaskred, RedDotEnum.DotNode.VersionActivityPushBoxTask)
end

function var_0_0._refreshTaskRed(arg_11_0)
	local var_11_0 = PushBoxEpisodeConfig.instance:getTaskList()
	local var_11_1 = false

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = PushBoxModel.instance:getTaskData(iter_11_1.taskId)

		if var_11_2 and not var_11_2.hasGetBonus and var_11_2.progress >= iter_11_1.maxProgress then
			var_11_1 = true

			break
		end
	end

	gohelper.setActive(arg_11_0._gotaskred, var_11_1)
end

function var_0_0._onReceiveTaskRewardReply(arg_12_0)
	return
end

function var_0_0._playNewFinish(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_mark_finish)
	gohelper.setActive(arg_13_0._new_finish_obj, true)

	local var_13_0 = gohelper.onceAddComponent(arg_13_0._new_finish_obj, typeof(UnityEngine.Animation))

	var_13_0.enabled = true

	var_13_0:Rewind()
	var_13_0:Play()
end

function var_0_0._episodeClick(arg_14_0, arg_14_1)
	if not PushBoxModel.instance:getPassData(arg_14_1) then
		if PushBoxModel.instance:getEpisodeOpenTime(arg_14_1) < ServerTime.now() then
			GameFacade.showToast(ToastEnum.ActivityPushBoxLevel)

			return
		else
			return
		end

		return
	end

	if arg_14_0._activity_data:isExpired() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_14_0 = PushBoxEpisodeConfig.instance:getConfig(arg_14_1)

	arg_14_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	arg_14_0._game_mgr:startGame(var_14_0.id)

	arg_14_0._cur_select_config = var_14_0

	local var_14_1 = tabletool.indexOf(arg_14_0._episode_list, var_14_0)
	local var_14_2 = arg_14_0["_golevel" .. var_14_1]
	local var_14_3 = gohelper.findChild(var_14_2, "go_info/go_selectedbg")
	local var_14_4 = gohelper.findChild(var_14_2, "go_info/go_selected")

	gohelper.setActive(var_14_3, true)
	gohelper.setActive(var_14_4, true)
	TaskDispatcher.runDelay(arg_14_0._delaySelectEpisode, arg_14_0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
end

function var_0_0._delaySelectEpisode(arg_15_0)
	arg_15_0._ani:Play("gameopen")
	TaskDispatcher.runDelay(arg_15_0._delayEnterGame, arg_15_0, 0.2)
end

function var_0_0._delayEnterGame(arg_16_0)
	recthelper.setAnchorX(arg_16_0.viewGO.transform, 10000)
	arg_16_0:onClose()
	GuideController.instance:dispatchEvent(GuideEvent["OnPushBoxEnter" .. arg_16_0._cur_select_config.id])
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxGameView)
	arg_16_0._game_mgr:playOpenAni()
end

function var_0_0._onNavigateCloseCallback(arg_17_0)
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	arg_17_0:onClose()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
	end)
end

function var_0_0._onNavigateHomeCallback(arg_19_0)
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	NavigateButtonsView.homeClick()
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playOpenAudio, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delaySelectEpisode, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delayEnterGame, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playNewFinish, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._updateDeadline, arg_20_0)

	if arg_20_0._episode_list then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._episode_list) do
			local var_20_0 = arg_20_0["_golevel" .. iter_20_0]

			gohelper.findChildClickWithAudio(var_20_0, "btn_click"):RemoveClickListener()
			var_20_0:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Close)
		end
	end

	arg_20_0.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	arg_20_0.viewContainer._navigateButtonView:setOverrideHome(nil, nil)
	arg_20_0:closeThis()
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg:UnLoadImage()
end

return var_0_0
