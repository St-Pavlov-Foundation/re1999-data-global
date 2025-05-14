module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewAnim", package.seeall)

local var_0_0 = class("JiaLaBoNaMapViewAnim", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

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
	arg_4_0._checkTaskMO = Activity120TaskMO.New()
	arg_4_0._viewAnimator = arg_4_0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	arg_4_0._rewardAnimator = arg_4_0:_findAnimator("RightTop/ani")
	arg_4_0._swicthSceneAnimator = arg_4_0:_findAnimator("#go_excessive")
	arg_4_0._path1Mterials = arg_4_0:_findUIMeshMaterIals("Map/Path1/path_go1")
	arg_4_0._path2Mterials = arg_4_0:_findUIMeshMaterIals("Map/Path2/path_go1")
	arg_4_0._pathMaterialDict = {
		[JiaLaBoNaEnum.Chapter.One] = arg_4_0._path1Mterials,
		[JiaLaBoNaEnum.Chapter.Two] = arg_4_0._path2Mterials
	}
	arg_4_0._propertyBlock = UnityEngine.MaterialPropertyBlock.New()

	arg_4_0:_initPathAnimParams()
end

function var_0_0._findAnimator(arg_5_0, arg_5_1)
	return gohelper.findChild(arg_5_0.viewGO, arg_5_1):GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

function var_0_0._findUIMeshMaterIals(arg_6_0, arg_6_1)
	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, arg_6_1):GetComponentsInChildren(JiaLaBoNaEnum.ComponentType.UIMesh, true)
	local var_6_1 = arg_6_0:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(var_6_0, var_6_1)

	local var_6_2 = arg_6_0:getUserDataTb_()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_3 = iter_6_1.material

		if var_6_3 then
			table.insert(var_6_2, var_6_3)
		end
	end

	return var_6_2
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.SelectEpisode, arg_7_0._onSelectEpisode, arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_7_0._refreshRewardAnim, arg_7_0)
	arg_7_0:_refreshUI()
	arg_7_0:refreshPathPoin()
	arg_7_0._viewAnimator:Play(UIAnimationName.Open)
end

function var_0_0._onSelectEpisode(arg_8_0)
	arg_8_0:_refreshRewardAnim()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0:_refreshRewardAnim()
end

function var_0_0._refreshRewardAnim(arg_10_0)
	local var_10_0 = arg_10_0:_isHasReward()

	if arg_10_0._lastIsHasReward ~= var_10_0 then
		arg_10_0._lastIsHasReward = var_10_0

		arg_10_0._rewardAnimator:Play(var_10_0 and "loop" or "idle")
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.playViewAnimator(arg_12_0, arg_12_1)
	arg_12_0._viewAnimator:Play(arg_12_1, 0, 0)
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._pathTweenId)

		arg_13_0._pathTweenId = nil
	end
end

function var_0_0._isHasReward(arg_14_0)
	local var_14_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity120)

	if var_14_0 ~= nil then
		local var_14_1 = Activity120Config.instance:getTaskByActId(Va3ChessEnum.ActivityId.Act120)
		local var_14_2 = arg_14_0._checkTaskMO

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			var_14_2:init(iter_14_1, var_14_0[iter_14_1.id])

			if var_14_2:alreadyGotReward() then
				return true
			end
		end
	end

	return false
end

var_0_0.SWIRCH_SCENE_BLOCK_KEY = "JiaLaBoNaMapViewAnim_switchScene_Key"

function var_0_0.switchScene(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 == true

	if arg_15_0._isLastSwitchStart ~= var_15_0 then
		arg_15_0._isLastSwitchStart = var_15_0

		gohelper.setActive(arg_15_0._goexcessive, true)
		arg_15_0._swicthSceneAnimator:Play(var_15_0 and "story" or "hard")

		if not arg_15_0._isSwitchSceneStartBlock then
			arg_15_0._isSwitchSceneStartBlock = true

			UIBlockMgr.instance:startBlock(var_0_0.SWIRCH_SCENE_BLOCK_KEY)
		else
			TaskDispatcher.cancelTask(arg_15_0._onHideSwitchScene, arg_15_0)
		end

		TaskDispatcher.runDelay(arg_15_0._onHideSwitchScene, arg_15_0, 1)
	end
end

function var_0_0._onHideSwitchScene(arg_16_0)
	arg_16_0._isSwitchSceneStartBlock = false

	UIBlockMgr.instance:endBlock(var_0_0.SWIRCH_SCENE_BLOCK_KEY)
end

function var_0_0._initPathAnimParams(arg_17_0)
	arg_17_0._pathConsDict = {}

	local var_17_0 = Va3ChessEnum.ActivityId.Act120
	local var_17_1 = Activity120Config.instance

	for iter_17_0, iter_17_1 in pairs(JiaLaBoNaEnum.ChapterPathAnimParam) do
		local var_17_2 = var_17_1:getChapterEpisodeList(var_17_0, iter_17_0)

		if var_17_2 then
			local var_17_3 = var_17_1:getChapterEpisodeList(var_17_0, iter_17_0 - 1)
			local var_17_4 = var_17_1:getChapterEpisodeList(var_17_0, iter_17_0 + 1)
			local var_17_5 = {}

			arg_17_0._pathConsDict[iter_17_0] = var_17_5

			if var_17_3 and #var_17_3 > 0 then
				arg_17_0:_addPathAnimParams(var_17_5, iter_17_1, var_17_3[#var_17_3], false)
			end

			for iter_17_2, iter_17_3 in ipairs(var_17_2) do
				arg_17_0:_addPathAnimParams(var_17_5, iter_17_1, iter_17_3, true)
			end

			if var_17_4 and #var_17_4 > 0 then
				arg_17_0:_addPathAnimParams(var_17_5, iter_17_1, var_17_4[1], false)
			end
		end
	end
end

function var_0_0._addPathAnimParams(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = #arg_18_1 + 1

	if var_18_0 <= #arg_18_2 then
		local var_18_1 = {
			pathParams = arg_18_2[var_18_0],
			isEpisode = arg_18_4,
			episodeCfg = arg_18_3
		}

		table.insert(arg_18_1, var_18_1)
	end
end

function var_0_0._getPathPatams(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._pathConsDict[arg_19_1]
	local var_19_1 = 0
	local var_19_2

	if var_19_0 then
		local var_19_3 = Activity120Model.instance

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if var_19_3:isEpisodeClear(iter_19_1.episodeCfg.id) or iter_19_1.episodeCfg.preEpisode == 0 or var_19_3:isEpisodeClear(iter_19_1.episodeCfg.preEpisode) and JiaLaBoNaHelper.isOpenChapterDay(iter_19_1.episodeCfg.chapterId) then
				var_19_1 = iter_19_0
				var_19_2 = iter_19_1
			end
		end
	end

	if var_19_2 then
		return var_19_2.pathParams, var_19_1
	end

	return nil, var_19_1
end

function var_0_0.refreshPathPoin(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._pathMaterialDict) do
		local var_20_0, var_20_1 = arg_20_0:_getPathPatams(iter_20_0)

		if var_20_0 and var_20_1 > 0 then
			arg_20_0:_setPathMaterialsValue(iter_20_1, var_20_0[2])
		else
			arg_20_0:_setPathMaterialsValue(iter_20_1, 1)
		end
	end
end

function var_0_0.playPathAnim(arg_21_0)
	local var_21_0 = Va3ChessEnum.ActivityId.Act120
	local var_21_1 = Activity120Model.instance:getCurEpisodeId()
	local var_21_2 = Activity120Config.instance:getEpisodeCo(var_21_0, var_21_1)

	if var_21_2 then
		local var_21_3, var_21_4 = arg_21_0:_getPathPatams(var_21_2.chapterId)

		if var_21_3 and var_21_4 > 0 then
			arg_21_0:_playPathAnim(arg_21_0._pathMaterialDict[var_21_2.chapterId], var_21_3)
		end
	end
end

function var_0_0._playPathAnim(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 or not arg_22_2 then
		return
	end

	if arg_22_0._tweenMaterials and arg_22_0._tweenParams then
		arg_22_0:_onPathFinish()
	end

	if arg_22_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._pathTweenId)

		arg_22_0._pathTweenId = nil
	end

	arg_22_0._tweenMaterials = arg_22_1
	arg_22_0._tweenParams = arg_22_2
	arg_22_0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, JiaLaBoNaEnum.AnimatorTime.ChapterPath or 1, arg_22_0._onPathFrame, arg_22_0._onPathFinish, arg_22_0, nil, EaseType.Linear)
end

function var_0_0._onPathFrame(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._tweenParams[1] + (arg_23_0._tweenParams[2] - arg_23_0._tweenParams[1]) * arg_23_1

	arg_23_0:_setPathMaterialsValue(arg_23_0._tweenMaterials, var_23_0)
end

function var_0_0._onPathFinish(arg_24_0)
	local var_24_0 = arg_24_0._tweenParams[2]
	local var_24_1 = arg_24_0._tweenMaterials

	arg_24_0._tweenMaterials = nil
	arg_24_0._tweenParams = nil

	arg_24_0:_setPathMaterialsValue(var_24_1, var_24_0)
end

function var_0_0._setPathMaterialsValue(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = Vector4.New(arg_25_2, 0.01, 0, 0)

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		iter_25_1:SetVector("_DissolveControl", var_25_0)
	end
end

return var_0_0
