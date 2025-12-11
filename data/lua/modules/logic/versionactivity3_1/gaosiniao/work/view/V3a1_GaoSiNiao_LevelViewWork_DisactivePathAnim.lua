module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

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

	if not arg_4_0:viewObj() then
		arg_4_0:onFail()

		return
	end

	arg_4_0._needWaitCount = 0
	arg_4_0._episodeId = arg_4_0:currentPassedEpisodeId()

	local var_4_0, var_4_1 = arg_4_0:_getEpisodeCO_disactiveEpisodeInfoDict()

	if not arg_4_0._episodeId or arg_4_0._episodeId == 0 then
		arg_4_0:onSucc()

		return
	end

	local var_4_2 = arg_4_0:viewObj()._itemObjList

	for iter_4_0, iter_4_1 in ipairs(var_4_2 or {}) do
		local var_4_3 = var_4_0[iter_4_1:episodeId()]

		if var_4_3 then
			if var_4_1 then
				iter_4_1:playAnim_MarkIdle(var_4_3)
			else
				arg_4_0._needWaitCount = arg_4_0._needWaitCount + 1

				iter_4_1:playAnim_MarkFinish(var_4_3, arg_4_0._onItemAnimDone, arg_4_0)
			end
		else
			iter_4_1:setActive_goMark(nil)
		end
	end

	if var_4_1 then
		arg_4_0:onSucc()
	elseif arg_4_0._needWaitCount == 0 then
		arg_4_0:saveHasPlayedDisactiveAnimPath(arg_4_0._episodeId)
		arg_4_0:onSucc()
	end
end

function var_0_0._getEpisodeCO_disactiveEpisodeInfoDict(arg_5_0)
	local var_5_0 = arg_5_0:getEpisodeCO_disactiveEpisodeInfoDict(arg_5_0._episodeId)
	local var_5_1 = arg_5_0:hasPlayedDisactiveAnimPath(arg_5_0._episodeId)

	if not var_5_1 then
		local var_5_2 = arg_5_0:getPreEpisodeId(arg_5_0._episodeId)
		local var_5_3 = arg_5_0:getEpisodeCO_disactiveEpisodeInfoDict(var_5_2)

		if next(var_5_3) then
			var_5_1 = true

			for iter_5_0, iter_5_1 in pairs(var_5_0) do
				if var_5_3[iter_5_0] ~= iter_5_1 then
					var_5_1 = false
				end

				var_5_3[iter_5_0] = nil
			end

			if var_5_1 then
				var_5_1 = next(var_5_3) == nil

				arg_5_0:saveHasPlayedDisactiveAnimPath(arg_5_0._episodeId)
			end
		end
	end

	return var_5_0, var_5_1
end

function var_0_0._onItemAnimDone(arg_6_0)
	arg_6_0._needWaitCount = arg_6_0._needWaitCount - 1

	if arg_6_0._needWaitCount <= 0 then
		arg_6_0:saveHasPlayedDisactiveAnimPath(arg_6_0._episodeId)
		arg_6_0:onSucc()
	end
end

function var_0_0.clearWork(arg_7_0)
	arg_7_0._viewObj = nil
	arg_7_0._viewContainer = nil
	arg_7_0._needWaitCount = 0

	var_0_0.super.clearWork(arg_7_0)
end

return var_0_0
