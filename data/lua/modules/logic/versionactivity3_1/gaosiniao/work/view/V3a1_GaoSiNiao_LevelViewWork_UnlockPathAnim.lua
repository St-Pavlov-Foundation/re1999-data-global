module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

function var_0_0.s_create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	if arg_1_0 or arg_1_1 then
		var_1_0._viewObj = arg_1_0
		var_1_0._viewContainer = arg_1_1
	else
		local var_1_1 = ViewName.V3a1_GaoSiNiao_LevelView
		local var_1_2 = ViewMgr.instance:getContainer(var_1_1)

		if not var_1_2 then
			return nil
		end

		var_1_0._viewContainer = var_1_2
		var_1_0._viewObj = var_1_2:mainView()
	end

	if not var_1_0._viewObj then
		return nil
	end

	return var_1_0
end

function var_0_0.viewObj(arg_2_0)
	if arg_2_0._viewObj then
		return arg_2_0._viewObj
	end

	return var_0_0.super.viewObj(arg_2_0)
end

function var_0_0.baseViewContainer(arg_3_0)
	if arg_3_0._viewContainer then
		return arg_3_0._viewContainer
	end

	return var_0_0.super.baseViewContainer(arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	arg_4_0:clearWork()

	local var_4_0 = arg_4_0:viewObj()

	if not var_4_0 then
		arg_4_0:onFail()

		return
	end

	arg_4_0._needWaitCount = 0
	arg_4_0._curStageItemObj = arg_4_0:_getCurStageItemObjToPlayUnlockAnim()

	if not arg_4_0._curStageItemObj then
		logWarn("can not found current stage Item")
		arg_4_0:onSucc()

		return
	end

	var_4_0:playAnim_PathIdle(arg_4_0:_animIndex(true))

	if arg_4_0:hasPlayedUnlockedAnimPath(arg_4_0:_curEpisodeId()) then
		arg_4_0._curStageItemObj:playAnim_Idle()
		arg_4_0:onSucc()

		return
	end

	arg_4_0:_playAnim_PathUnlock()
end

function var_0_0._playAnim_PathUnlock(arg_5_0)
	arg_5_0._needWaitCount = 2

	arg_5_0:viewObj():playAnim_PathUnlock(arg_5_0:_animIndex(), arg_5_0._onPlayedUnlockDone, arg_5_0)
	arg_5_0._curStageItemObj:playAnim_Open(arg_5_0._onPlayedUnlockDone, arg_5_0)
end

function var_0_0._getCurStageItemObjToPlayUnlockAnim(arg_6_0)
	local var_6_0 = arg_6_0:viewObj()._itemObjList or {}
	local var_6_1 = arg_6_0:currentEpisodeIdToPlay(true)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1:episodeId() == var_6_1 then
			return iter_6_1
		end
	end

	return var_6_0[#var_6_0]
end

function var_0_0._onPlayedUnlockDone(arg_7_0)
	arg_7_0._needWaitCount = arg_7_0._needWaitCount - 1

	if arg_7_0._needWaitCount <= 0 then
		arg_7_0:saveHasPlayedUnlockedAnimPath(arg_7_0:_curEpisodeId())
		arg_7_0:onSucc()
	end
end

function var_0_0._curIndex(arg_8_0)
	if not arg_8_0._curStageItemObj then
		return 0
	end

	return arg_8_0._curStageItemObj:index() or 0
end

function var_0_0._curEpisodeId(arg_9_0)
	if not arg_9_0._curStageItemObj then
		return nil
	end

	return arg_9_0._curStageItemObj:episodeId()
end

function var_0_0._animIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_curIndex() - 1

	if arg_10_1 then
		return var_10_0
	end

	return GameUtil.clamp(var_10_0, 0, 7)
end

function var_0_0.clearWork(arg_11_0)
	arg_11_0._curStageItemObj = nil
	arg_11_0._viewObj = nil
	arg_11_0._viewContainer = nil
	arg_11_0._needWaitCount = 0

	var_0_0.super.clearWork(arg_11_0)
end

function var_0_0._logCur(arg_12_0)
	logError("curIndex:" .. tostring(arg_12_0:_curIndex()) .. ", curEpisodeId:" .. tostring(arg_12_0:_curEpisodeId()), "idleIndex:", tostring(arg_12_0:_animIndex()))
end

return var_0_0
