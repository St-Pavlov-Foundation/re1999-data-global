module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameScene", package.seeall)

local var_0_0 = class("LanShouPaGameScene", ChessGameScene)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._posuiGroundTbList = {}

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.onResetGame(arg_2_0)
	arg_2_0:_resetMapId()
	arg_2_0:_checkLoadMapScene()
	ChessGameModel.instance:clearRollbackNum()
	var_0_0.super.onResetGame(arg_2_0)
end

function var_0_0._resetMapId(arg_3_0)
	ChessGameModel.instance:initData(ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId(), ChessGameModel.instance:getNowMapIndex())
end

function var_0_0._checkLoadMapScene(arg_4_0)
	local var_4_0 = ChessGameModel.instance:getNowMapResPath()

	if arg_4_0._currentSceneResPath ~= var_4_0 then
		UIBlockMgr.instance:startBlock(ChessGameScene.BLOCK_KEY)
		arg_4_0.super.changeMap(arg_4_0, var_4_0)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function var_0_0._onGamePointReturn(arg_5_0)
	arg_5_0:_checkLoadMapScene()
	var_0_0.super.onResetGame(arg_5_0)
end

function var_0_0.loadResCompleted(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._sceneGo

	arg_6_0._currentSceneResPath = ChessGameModel.instance:getNowMapResPath()

	var_0_0.super.loadResCompleted(arg_6_0, arg_6_1)

	if var_6_0 then
		gohelper.destroy(var_6_0)
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)

	local var_6_1 = ChessModel.instance:getEpisodeId()

	arg_6_0:_initEventCb()
end

function var_0_0._initEventCb(arg_7_0)
	return
end

return var_0_0
