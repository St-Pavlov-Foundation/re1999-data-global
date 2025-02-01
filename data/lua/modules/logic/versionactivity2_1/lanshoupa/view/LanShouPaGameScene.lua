module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameScene", package.seeall)

slot0 = class("LanShouPaGameScene", ChessGameScene)

function slot0._editableInitView(slot0)
	slot0._posuiGroundTbList = {}

	uv0.super._editableInitView(slot0)
end

function slot0.onResetGame(slot0)
	slot0:_resetMapId()
	slot0:_checkLoadMapScene()
	ChessGameModel.instance:clearRollbackNum()
	uv0.super.onResetGame(slot0)
end

function slot0._resetMapId(slot0)
	ChessGameModel.instance:initData(ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId(), ChessGameModel.instance:getNowMapIndex())
end

function slot0._checkLoadMapScene(slot0)
	if slot0._currentSceneResPath ~= ChessGameModel.instance:getNowMapResPath() then
		UIBlockMgr.instance:startBlock(ChessGameScene.BLOCK_KEY)
		slot0.super.changeMap(slot0, slot1)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function slot0._onGamePointReturn(slot0)
	slot0:_checkLoadMapScene()
	uv0.super.onResetGame(slot0)
end

function slot0.loadResCompleted(slot0, slot1)
	slot0._currentSceneResPath = ChessGameModel.instance:getNowMapResPath()

	uv0.super.loadResCompleted(slot0, slot1)

	if slot0._sceneGo then
		gohelper.destroy(slot2)
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)

	slot3 = ChessModel.instance:getEpisodeId()

	slot0:_initEventCb()
end

function slot0._initEventCb(slot0)
end

return slot0
