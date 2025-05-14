module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAnim", package.seeall)

local var_0_0 = class("Activity1_3ChessMapViewAnim", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ShowPassEpisodeEffect, arg_2_0.playPathAnim, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.SetNodePathEffectToPassNode, arg_2_0.refreshPathToPassNode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._path1Mterials = arg_4_0:_findUIMeshMaterIals("Map/Path1/path_go")
	arg_4_0._path2Mterials = arg_4_0:_findUIMeshMaterIals("Map/Path2/path_go")
	arg_4_0._pathMaterialDict = {
		arg_4_0._path1Mterials,
		arg_4_0._path2Mterials
	}

	arg_4_0:_initPathAnimParams()
end

function var_0_0._findUIMeshMaterIals(arg_5_0, arg_5_1)
	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, arg_5_1):GetComponentsInChildren(typeof(UIMesh), true)
	local var_5_1 = arg_5_0:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(var_5_0, var_5_1)

	local var_5_2 = arg_5_0:getUserDataTb_()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_3 = iter_5_1.material

		if var_5_3 then
			var_5_2[#var_5_2 + 1] = var_5_3
		end
	end

	return var_5_2
end

local var_0_1 = {
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.78
		},
		{
			0.78,
			0.54
		},
		{
			0.54,
			0.27
		},
		{
			0.27,
			0
		}
	},
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.74
		},
		{
			0.74,
			0.52
		},
		{
			0.52,
			0.24
		},
		{
			0.24,
			0
		}
	}
}

function var_0_0._initPathAnimParams(arg_6_0)
	arg_6_0._pathConsDict = {}

	local var_6_0 = Va3ChessEnum.ActivityId.Act122
	local var_6_1 = Activity122Config.instance

	for iter_6_0, iter_6_1 in pairs(var_0_1) do
		local var_6_2 = var_6_1:getChapterEpisodeList(var_6_0, iter_6_0)

		if var_6_2 then
			local var_6_3 = var_6_1:getChapterEpisodeList(var_6_0, iter_6_0 - 1)
			local var_6_4 = var_6_1:getChapterEpisodeList(var_6_0, iter_6_0 + 1)
			local var_6_5 = {}

			arg_6_0._pathConsDict[iter_6_0] = var_6_5

			if var_6_3 and #var_6_3 > 0 then
				arg_6_0:_addPathAnimParams(var_6_5, iter_6_1, var_6_3[#var_6_3], false)
			end

			for iter_6_2, iter_6_3 in ipairs(var_6_2) do
				arg_6_0:_addPathAnimParams(var_6_5, iter_6_1, iter_6_3, true)
			end

			if var_6_4 and #var_6_4 > 0 then
				arg_6_0:_addPathAnimParams(var_6_5, iter_6_1, var_6_4[1], false)
			end
		end
	end
end

function var_0_0._addPathAnimParams(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = #arg_7_1 + 1

	if var_7_0 <= #arg_7_2 then
		local var_7_1 = {
			pathParams = arg_7_2[var_7_0],
			isEpisode = arg_7_4,
			episodeCfg = arg_7_3
		}

		table.insert(arg_7_1, var_7_1)
	end
end

function var_0_0.onOpen(arg_8_0)
	if not arg_8_0._pathToPassNode then
		arg_8_0:refreshPathToOpenNode()
	end
end

function var_0_0.onSetVisible(arg_9_0, arg_9_1)
	if arg_9_1 then
		-- block empty
	end
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._pathTweenId)

		arg_10_0._pathTweenId = nil
	end
end

function var_0_0.refreshPathToOpenNode(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._pathMaterialDict) do
		local var_11_0, var_11_1 = arg_11_0:_getPathPatams(iter_11_0)

		if var_11_0 and var_11_1 > 0 then
			arg_11_0:_setPathMaterialsValue(iter_11_1, var_11_0[2])
		else
			arg_11_0:_setPathMaterialsValue(iter_11_1, 1)
		end
	end
end

function var_0_0.refreshPathToPassNode(arg_12_0)
	arg_12_0._pathToPassNode = true

	for iter_12_0, iter_12_1 in pairs(arg_12_0._pathMaterialDict) do
		local var_12_0, var_12_1 = arg_12_0:_getPathPatams(iter_12_0)

		if var_12_0 and var_12_1 > 0 then
			arg_12_0:_setPathMaterialsValue(iter_12_1, var_12_0[1])
		else
			arg_12_0:_setPathMaterialsValue(iter_12_1, 1)
		end
	end
end

function var_0_0.playPathAnim(arg_13_0)
	arg_13_0._pathToPassNode = false

	local var_13_0 = Va3ChessEnum.ActivityId.Act122
	local var_13_1 = Activity122Model.instance:getCurEpisodeId()
	local var_13_2 = Activity122Config.instance:getEpisodeCo(var_13_0, var_13_1)

	if var_13_2 then
		local var_13_3, var_13_4 = arg_13_0:_getPathPatams(var_13_2.chapterId)

		if var_13_3 and var_13_4 > 0 then
			arg_13_0:_playPathAnim(arg_13_0._pathMaterialDict[var_13_2.chapterId], var_13_3)
		end
	end
end

function var_0_0._playPathAnim(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 or not arg_14_2 then
		return
	end

	if arg_14_0._tweenMaterials and arg_14_0._tweenParams then
		arg_14_0:_onPathFinish()
	end

	if arg_14_0._pathTweenId then
		ZProj.TweenHelper.KillById(arg_14_0._pathTweenId)

		arg_14_0._pathTweenId = nil
	end

	arg_14_0._tweenMaterials = arg_14_1
	arg_14_0._tweenParams = arg_14_2
	arg_14_0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 2, arg_14_0._onPathFrame, arg_14_0._onPathFinish, arg_14_0, nil, EaseType.Linear)
end

function var_0_0._onPathFrame(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._tweenParams[1] + (arg_15_0._tweenParams[2] - arg_15_0._tweenParams[1]) * arg_15_1

	arg_15_0:_setPathMaterialsValue(arg_15_0._tweenMaterials, var_15_0)
end

function var_0_0._onPathFinish(arg_16_0)
	local var_16_0 = arg_16_0._tweenParams[2]
	local var_16_1 = arg_16_0._tweenMaterials

	arg_16_0._tweenMaterials = nil
	arg_16_0._tweenParams = nil

	arg_16_0:_setPathMaterialsValue(var_16_1, var_16_0)
end

function var_0_0._setPathMaterialsValue(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = Vector4.New(arg_17_2, 0.01, 0, 0)

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		iter_17_1:SetVector("_DissolveControl", var_17_0)
	end
end

function var_0_0._getPathPatams(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._pathConsDict[arg_18_1]
	local var_18_1 = 0
	local var_18_2

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			local var_18_3 = iter_18_1.isEpisode and Activity122Model.instance:isEpisodeOpen(iter_18_1.episodeCfg.id)
			local var_18_4 = not iter_18_1.isEpisode and Activity1_3ChessController.instance:isChapterOpen(iter_18_1.episodeCfg.chapterId)

			if var_18_3 or var_18_4 then
				var_18_1 = iter_18_0
				var_18_2 = iter_18_1
			end
		end
	end

	if var_18_2 then
		return var_18_2.pathParams, var_18_1
	end

	return nil, var_18_1
end

return var_0_0
