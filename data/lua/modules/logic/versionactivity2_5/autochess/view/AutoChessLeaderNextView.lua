module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderNextView", package.seeall)

slot0 = class("AutoChessLeaderNextView", BaseView)

function slot0.onInitView(slot0)
	slot0._goLeaderRoot = gohelper.findChild(slot0.viewGO, "#go_LeaderRoot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if slot0.viewParam and slot0.viewParam.leaderId then
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.LeaderItemPath, slot0._goLeaderRoot), AutoChessLeaderItem):setData(slot0.viewParam.leaderId)
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 2)
	end
end

function slot0.onClose(slot0)
	AutoChessRpc.instance:sendAutoChessEnterSceneRequest(slot0.viewParam.moduleId, slot0.viewParam.episodeId, slot0.viewParam.leaderId)
end

function slot0.onDestroyView(slot0)
end

return slot0
