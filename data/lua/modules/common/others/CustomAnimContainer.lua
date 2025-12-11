module("modules.common.others.CustomAnimContainer", package.seeall)

local var_0_0 = BaseViewContainer
local var_0_1 = typeof(SLFramework.AnimatorPlayer)

var_0_0.superOnContainerInit = var_0_0.onContainerInit
var_0_0.superOnPlayOpenTransitionFinish = var_0_0.onPlayOpenTransitionFinish
var_0_0.superOnPlayCloseTransitionFinish = var_0_0.onPlayCloseTransitionFinish
var_0_0.superDestroyView = var_0_0.destroyView
var_0_0.openViewTime = 0.2
var_0_0.closeViewTime = 0.1
var_0_0.openViewEase = EaseType.Linear
var_0_0.closeViewEase = EaseType.Linear

local var_0_2

function var_0_0.initForceAnimViewList()
	var_0_2 = {
		ViewName.HeroGroupEditView,
		ViewName.RougeHeroGroupEditView,
		ViewName.HeroGroupPresetEditView,
		ViewName.V1a6_CachotHeroGroupEditView,
		ViewName.Season123HeroGroupEditView,
		ViewName.Season123_2_3HeroGroupEditView,
		ViewName.VersionActivity_1_2_HeroGroupEditView,
		ViewName.Act183HeroGroupEditView,
		ViewName.DungeonView,
		ViewName.DungeonStoryEntranceView,
		ViewName.TaskView,
		ViewName.ActivityNormalView,
		ViewName.PowerView,
		ViewName.RoomFormulaView,
		ViewName.RoomBlockPackageGetView,
		ViewName.VersionActivity1_2EnterView
	}
end

function var_0_0.onContainerInit(arg_2_0)
	var_0_0.superOnContainerInit(arg_2_0)

	if not arg_2_0.viewGO then
		return
	end

	local var_2_0 = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0:GetCurrentAnimatorStateInfo(0)
	local var_2_2 = var_2_1.normalizedTime

	if var_2_2 >= 1 then
		return
	end

	local var_2_3 = var_2_1.length * (1 - var_2_2)

	if var_2_3 <= 0 then
		return
	end

	var_0_0.openViewAnimStartTime = Time.time
	var_0_0.openViewAnimLength = math.min(var_2_3, 1)
end

function var_0_0.playOpenTransition(arg_3_0, arg_3_1)
	arg_3_0:_cancelBlock()
	arg_3_0:_stopOpenCloseAnim()

	if not arg_3_0._viewSetting.anim or arg_3_0._viewSetting.anim ~= ViewAnim.Default then
		if not string.nilorempty(arg_3_0._viewSetting.anim) then
			arg_3_0:_setAnimatorRes()

			if not arg_3_1 or not arg_3_1.noBlock then
				arg_3_0:startViewOpenBlock()
			end

			local var_3_0 = arg_3_0:__getAnimatorPlayer()

			if not gohelper.isNil(var_3_0) then
				local var_3_1 = arg_3_1 and arg_3_1.anim or "open"

				var_3_0:Play(var_3_1, arg_3_0.onPlayOpenTransitionFinish, arg_3_0)
			end

			local var_3_2 = arg_3_1 and arg_3_1.duration or 2

			TaskDispatcher.runDelay(arg_3_0.onPlayOpenTransitionFinish, arg_3_0, var_3_2)
		else
			arg_3_0:onPlayOpenTransitionFinish()
		end

		return
	end

	if not arg_3_0._canvasGroup then
		arg_3_0:onPlayOpenTransitionFinish()

		return
	end

	if not arg_3_1 or not arg_3_1.noBlock then
		arg_3_0:startViewOpenBlock()
	end

	arg_3_0:_animSetAlpha(0.01, true)

	local var_3_3 = arg_3_0._viewSetting.customAnimFadeTime and arg_3_0._viewSetting.customAnimFadeTime[1] or var_0_0.openViewTime
	local var_3_4 = var_0_0.openViewEase

	arg_3_0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0.01, 1, var_3_3, arg_3_0._onOpenTweenFrameCallback, arg_3_0._onOpenTweenFinishCallback, arg_3_0, nil, var_3_4)

	TaskDispatcher.runDelay(arg_3_0.onPlayOpenTransitionFinish, arg_3_0, 2)
end

function var_0_0.onPlayOpenTransitionFinish(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.onPlayOpenTransitionFinish, arg_4_0)
	arg_4_0:_cancelBlock()
	var_0_0.superOnPlayOpenTransitionFinish(arg_4_0)
end

function var_0_0._setAnimatorRes(arg_5_0)
	if string.find(arg_5_0._viewSetting.anim, ".controller") then
		gohelper.onceAddComponent(arg_5_0.viewGO, typeof(UnityEngine.Animator)).runtimeAnimatorController = arg_5_0._abLoader:getAssetItem(arg_5_0._viewSetting.anim):GetResource()
	end
end

function var_0_0.__getAnimatorPlayer(arg_6_0)
	if not arg_6_0.__animatorPlayer and not gohelper.isNil(arg_6_0.viewGO) then
		arg_6_0.__animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)
	end

	return arg_6_0.__animatorPlayer
end

function var_0_0._onOpenTweenFrameCallback(arg_7_0, arg_7_1)
	if arg_7_0._viewStatus ~= var_0_0.Status_Opening then
		return
	end

	arg_7_0:_animSetAlpha(arg_7_1, true)
end

function var_0_0._onOpenTweenFinishCallback(arg_8_0)
	arg_8_0._openAnimTweenId = nil

	if arg_8_0._viewStatus ~= var_0_0.Status_Opening then
		return
	end

	arg_8_0:_animSetAlpha(1)
	arg_8_0:onPlayOpenTransitionFinish()
end

function var_0_0._animSetAlpha(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._canvasGroup.alpha = arg_9_1

	do return end

	local var_9_0 = arg_9_1

	if arg_9_2 then
		var_9_0 = arg_9_1 <= 0.0001 and 0 or 1 / arg_9_1
	end

	local var_9_1 = arg_9_0:_animGetBgs()

	if not var_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		if iter_9_1.gameObject then
			iter_9_1:SetAlpha(var_9_0)
		end
	end
end

function var_0_0._animGetBgs(arg_10_0)
	if not arg_10_0._viewSetting.customAnimBg then
		return nil
	end

	if arg_10_0._animBgs then
		return arg_10_0._animBgs
	end

	arg_10_0._animBgs = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._viewSetting.customAnimBg) do
		local var_10_0 = gohelper.findChild(arg_10_0.viewGO, iter_10_1)

		if var_10_0 then
			local var_10_1 = var_10_0:GetComponent(typeof(UnityEngine.CanvasRenderer))

			if var_10_1 then
				table.insert(arg_10_0._animBgs, var_10_1)
			end

			local var_10_2 = var_10_0:GetComponentsInChildren(typeof(UnityEngine.CanvasRenderer), true):GetEnumerator()

			while var_10_2:MoveNext() do
				table.insert(arg_10_0._animBgs, var_10_2.Current)
			end
		end
	end

	return arg_10_0._animBgs
end

function var_0_0.animBgUpdate(arg_11_0)
	arg_11_0._animBgs = nil
end

function var_0_0.playCloseTransition(arg_12_0, arg_12_1)
	arg_12_0:_cancelBlock()
	arg_12_0:_stopOpenCloseAnim()

	if not var_0_2 then
		var_0_0.initForceAnimViewList()
	end

	if (not arg_12_0._viewSetting.anim or arg_12_0._viewSetting.anim ~= ViewAnim.Default) and not LuaUtil.tableContains(var_0_2, arg_12_0.viewName) then
		if not string.nilorempty(arg_12_0._viewSetting.anim) then
			arg_12_0:_setAnimatorRes()

			if not arg_12_1 or not arg_12_1.noBlock then
				arg_12_0:startViewCloseBlock()
			end

			local var_12_0 = arg_12_0:__getAnimatorPlayer()

			if not gohelper.isNil(var_12_0) then
				local var_12_1 = arg_12_1 and arg_12_1.anim or "close"

				var_12_0:Play(var_12_1, arg_12_0.onPlayCloseTransitionFinish, arg_12_0)
			end

			local var_12_2 = arg_12_1 and arg_12_1.duration or 2

			TaskDispatcher.runDelay(arg_12_0.onPlayCloseTransitionFinish, arg_12_0, var_12_2)
		else
			arg_12_0:onPlayCloseTransitionFinish()
		end

		return
	end

	if not arg_12_0._canvasGroup then
		arg_12_0:onPlayCloseTransitionFinish()

		return
	end

	if not arg_12_1 or not arg_12_1.noBlock then
		arg_12_0:startViewCloseBlock()
	end

	arg_12_0:_animSetAlpha(1)

	local var_12_3 = arg_12_0._viewSetting.customAnimFadeTime and arg_12_0._viewSetting.customAnimFadeTime[2] or var_0_0.closeViewTime
	local var_12_4 = var_0_0.closeViewEase

	arg_12_0._closeAnimTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, var_12_3, arg_12_0._onCloseTweenFrameCallback, arg_12_0._onCloseTweenFinishCallback, arg_12_0, nil, var_12_4)

	TaskDispatcher.runDelay(arg_12_0.onPlayCloseTransitionFinish, arg_12_0, 2)
end

function var_0_0.onPlayCloseTransitionFinish(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.onPlayCloseTransitionFinish, arg_13_0)
	arg_13_0:_cancelBlock()
	var_0_0.superOnPlayCloseTransitionFinish(arg_13_0)
end

function var_0_0._onCloseTweenFrameCallback(arg_14_0, arg_14_1)
	if arg_14_0._viewStatus ~= var_0_0.Status_Closing then
		return
	end

	arg_14_0:_animSetAlpha(arg_14_1)
end

function var_0_0._onCloseTweenFinishCallback(arg_15_0)
	arg_15_0._closeAnimTweenId = nil

	if arg_15_0._viewStatus ~= var_0_0.Status_Closing then
		return
	end

	arg_15_0:_animSetAlpha(0)
	arg_15_0:onPlayCloseTransitionFinish()
end

function var_0_0.startViewOpenBlock(arg_16_0)
	UIBlockMgr.instance:startBlock(arg_16_0:_getViewOpenBlock())
end

function var_0_0.startViewCloseBlock(arg_17_0)
	UIBlockMgr.instance:startBlock(arg_17_0:_getViewCloseBlock())
end

function var_0_0._cancelBlock(arg_18_0)
	UIBlockMgr.instance:endBlock(arg_18_0:_getViewOpenBlock())
	UIBlockMgr.instance:endBlock(arg_18_0:_getViewCloseBlock())
end

function var_0_0._getViewOpenBlock(arg_19_0)
	if not arg_19_0._viewOpenBlock then
		arg_19_0._viewOpenBlock = arg_19_0.viewName .. "ViewOpenAnim"
	end

	return arg_19_0._viewOpenBlock
end

function var_0_0._getViewCloseBlock(arg_20_0)
	if not arg_20_0._viewCloseBlock then
		arg_20_0._viewCloseBlock = arg_20_0.viewName .. "ViewCloseAnim"
	end

	return arg_20_0._viewCloseBlock
end

function var_0_0._stopOpenCloseAnim(arg_21_0)
	if arg_21_0._openAnimTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._openAnimTweenId)

		arg_21_0._openAnimTweenId = nil
	end

	if arg_21_0._closeAnimTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._closeAnimTweenId)

		arg_21_0._closeAnimTweenId = nil
	end

	if not gohelper.isNil(arg_21_0.__animatorPlayer) then
		arg_21_0.__animatorPlayer:Stop()
	end

	TaskDispatcher.cancelTask(arg_21_0.onPlayOpenTransitionFinish, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.onPlayCloseTransitionFinish, arg_21_0)
end

function var_0_0._stopAllAnimatorPlayers(arg_22_0)
	if not gohelper.isNil(arg_22_0.viewGO) then
		local var_22_0 = arg_22_0.viewGO:GetComponentsInChildren(var_0_1, true)

		if var_22_0 then
			for iter_22_0 = 0, var_22_0.Length - 1 do
				var_22_0[iter_22_0]:Stop()
			end
		end
	end
end

function var_0_0.destroyView(arg_23_0)
	arg_23_0:_cancelBlock()
	arg_23_0:_stopOpenCloseAnim()
	arg_23_0:_stopAllAnimatorPlayers()

	arg_23_0.__animatorPlayer = nil

	var_0_0.superDestroyView(arg_23_0)
end

function var_0_0.activateCustom()
	return
end

return var_0_0
