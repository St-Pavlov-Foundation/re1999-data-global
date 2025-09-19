module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapView", package.seeall)

local var_0_0 = class("LanShouPaMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#go_time/#txt_limittime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task", AudioEnum.UI.play_ui_mission_open)
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gotaskani = gohelper.findChild(arg_1_0.viewGO, "#btn_task/ani")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goblack = gohelper.findChild(arg_1_0.viewGO, "black")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._animPath = gohelper.findChild(arg_1_0._goscrollcontent, "path/path_2"):GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnimage_TryBtn:AddClickListener(arg_2_0._btnimage_TryBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnimage_TryBtn:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	LanShouPaController.instance:openTaskView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._viewAnimator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._pathAnimator = gohelper.findChild(arg_5_0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._excessAnimator = arg_5_0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._blackAnimator = arg_5_0._goblack:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._taskAnimator = arg_5_0._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_5_0._gored, RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)
	gohelper.setActive(arg_5_0._gotime, false)

	arg_5_0._btnimage_TryBtn = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "#go_Try/image_TryBtn")
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_initStages()
	arg_6_0:refreshTime()
	arg_6_0:_refreshTask()
	arg_6_0:_addEvents()
end

function var_0_0._initStages(arg_7_0)
	if arg_7_0._stageItemList then
		return
	end

	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[1]

	arg_7_0._stageItemList = {}

	local var_7_1 = Activity164Model.instance:getUnlockCount()
	local var_7_2 = VersionActivity2_1Enum.ActivityId.LanShouPa
	local var_7_3 = Activity164Config.instance:getEpisodeCoList(var_7_2)
	local var_7_4 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. var_7_2, "1")
	local var_7_5

	var_7_5 = tonumber(var_7_4) or 1

	local var_7_6 = Mathf.Clamp(var_7_5, 1, var_7_1 + 1)
	local var_7_7 = var_7_3[var_7_6] and var_7_3[var_7_6].id or var_7_3[1].id

	Activity164Model.instance:setCurEpisodeId(var_7_7)

	for iter_7_0 = 1, #var_7_3 do
		local var_7_8 = gohelper.findChild(arg_7_0._gostages, "stage" .. iter_7_0)
		local var_7_9 = arg_7_0:getResInst(var_7_0, var_7_8)
		local var_7_10 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_9, LanShouPaMapViewStageItem, arg_7_0)

		var_7_10:refreshItem(var_7_3[iter_7_0], iter_7_0)
		table.insert(arg_7_0._stageItemList, var_7_10)
	end

	if var_7_1 == 0 then
		arg_7_0._animPath.speed = 0

		arg_7_0._animPath:Play("go1", 0, 0)
	else
		arg_7_0._animPath.speed = 1

		arg_7_0._animPath:Play("go" .. var_7_1, 0, 1)
	end

	arg_7_0:_setToPos(var_7_6)
end

function var_0_0._refreshStageItem(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, #arg_8_0._stageItemList do
		local var_8_0 = VersionActivity2_1Enum.ActivityId.LanShouPa
		local var_8_1 = Activity164Config.instance:getActivity164EpisodeCo(var_8_0, iter_8_0)

		arg_8_0._stageItemList[iter_8_0]:refreshItem(var_8_1, iter_8_0)
	end
end

function var_0_0.refreshTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.LanShouPa]

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:getRealEndTimeStamp() - ServerTime.now()

	arg_9_0._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(var_9_1)
end

function var_0_0._refreshTask(arg_10_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa) then
		arg_10_0._taskAnimator:Play("loop", 0, 0)
	else
		arg_10_0._taskAnimator:Play("idle", 0, 0)
	end
end

function var_0_0._onEpisodeFinish(arg_11_0)
	local var_11_0 = Activity164Model.instance:getUnlockCount()

	arg_11_0._animPath.speed = 1

	arg_11_0._animPath:Play("go" .. var_11_0, 0, 0)
	arg_11_0._stageItemList[var_11_0]:onPlayFinish()

	if arg_11_0._stageItemList[var_11_0 + 1] then
		arg_11_0._stageItemList[var_11_0 + 1]:onPlayUnlock()
	end

	arg_11_0:_setToPos(var_11_0)
end

function var_0_0.getRemainTimeStr(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActMO(VersionActivity2_1Enum.ActivityId.LanShouPa)

	if var_12_0 then
		return string.format(luaLang("activity_warmup_remain_time"), var_12_0:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:_removeEvents()
end

function var_0_0._onDragBegin(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._initDragPos = arg_14_2.position.x
end

function var_0_0._onDrag(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = recthelper.getAnchorX(arg_15_0._goscrollcontent.transform) + arg_15_2.delta.x * LanShouPaEnum.SlideSpeed

	arg_15_0:setDragPosX(-var_15_0)
end

function var_0_0._onDragEnd(arg_16_0, arg_16_1, arg_16_2)
	return
end

function var_0_0._getInfoSuccess(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 ~= 0 then
		return
	end

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.NewEpisodeUnlock)
	arg_17_0:_backToLevelView()
end

function var_0_0._setToPos(arg_18_0, arg_18_1)
	local var_18_0 = VersionActivity2_1Enum.ActivityId.LanShouPa
	local var_18_1 = Activity164Config.instance:getEpisodeCoList(var_18_0)
	local var_18_2 = (arg_18_1 - LanShouPaEnum.MaxShowEpisodeCount) * LanShouPaEnum.MaxSlideX / (#var_18_1 - LanShouPaEnum.MaxShowEpisodeCount)

	arg_18_0:setDragPosX(var_18_2)
end

function var_0_0._onScreenResize(arg_19_0)
	local var_19_0 = recthelper.getAnchorX(arg_19_0._goscrollcontent.transform)

	arg_19_0:setDragPosX(-var_19_0)
end

function var_0_0.setDragPosX(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = UnityEngine.Screen.width / UnityEngine.Screen.height
	local var_20_2 = 1.7777777777777777

	if var_20_2 - var_20_1 < 0 then
		var_20_0 = (var_20_1 / var_20_2 - 1) * recthelper.getWidth(arg_20_0._gopath.transform) / 2
		var_20_0 = Mathf.Clamp(var_20_0, 0, 400)
	end

	if var_20_0 <= LanShouPaEnum.MaxSlideX - var_20_0 then
		arg_20_1 = Mathf.Clamp(arg_20_1, var_20_0, LanShouPaEnum.MaxSlideX - var_20_0)
	else
		arg_20_1 = var_20_0
	end

	transformhelper.setLocalPos(arg_20_0._goscrollcontent.transform, -arg_20_1, 0, 0)

	local var_20_3 = -arg_20_1 * LanShouPaEnum.SceneMaxX / LanShouPaEnum.MaxSlideX

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.SetScenePos, var_20_3)
end

function var_0_0._onEnterGameView(arg_21_0)
	arg_21_0._viewAnimator:Play("close", 0, 0)
end

function var_0_0._realEnterGameView(arg_22_0)
	arg_22_0:closeThis()
end

function var_0_0._onViewClose(arg_23_0, arg_23_1)
	if arg_23_1 == ViewName.LanShouPaGameView then
		arg_23_0._viewAnimator:Play("open", 0, 0)
	end
end

function var_0_0._addEvents(arg_24_0)
	arg_24_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_24_0._gopath.gameObject)

	arg_24_0._drag:AddDragBeginListener(arg_24_0._onDragBegin, arg_24_0)
	arg_24_0._drag:AddDragEndListener(arg_24_0._onDragEnd, arg_24_0)
	arg_24_0._drag:AddDragListener(arg_24_0._onDrag, arg_24_0)
	arg_24_0:addEventCb(LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, arg_24_0._onEnterGameView, arg_24_0)
	arg_24_0:addEventCb(LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, arg_24_0._onEpisodeFinish, arg_24_0)
	arg_24_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_24_0._onViewClose, arg_24_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_24_0._onScreenResize, arg_24_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_24_0._refreshTask, arg_24_0)
end

function var_0_0._removeEvents(arg_25_0)
	arg_25_0._drag:RemoveDragBeginListener()
	arg_25_0._drag:RemoveDragListener()
	arg_25_0._drag:RemoveDragEndListener()
	arg_25_0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, arg_25_0._onEnterGameView, arg_25_0)
	arg_25_0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, arg_25_0._onEpisodeFinish, arg_25_0)
	arg_25_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_25_0._onViewClose, arg_25_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_25_0._onScreenResize, arg_25_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_25_0._refreshTask, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._showUnlockFinished, arg_26_0)

	if arg_26_0._stageItemList then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._stageItemList) do
			iter_26_1:onDestroyView()
		end

		arg_26_0._stageItemList = nil
	end
end

local var_0_1 = 10012117

function var_0_0._btnimage_TryBtnOnClick(arg_27_0)
	GameFacade.jump(var_0_1)
end

return var_0_0
