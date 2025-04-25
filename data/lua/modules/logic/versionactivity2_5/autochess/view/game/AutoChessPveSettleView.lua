module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveSettleView", package.seeall)

slot0 = class("AutoChessPveSettleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goSuccess = gohelper.findChild(slot0.viewGO, "#go_Success")
	slot0._goFail = gohelper.findChild(slot0.viewGO, "#go_Fail")
	slot0._btnRestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_Restart")
	slot0._btnExit = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_Exit")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRestart:AddClickListener(slot0._btnRestartOnClick, slot0)
	slot0._btnExit:AddClickListener(slot0._btnExitOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRestart:RemoveClickListener()
	slot0._btnExit:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
end

function slot0._btnRestartOnClick(slot0)
	slot0.restart = true

	slot0:closeThis()
end

function slot0._btnExitOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(ViewName.AutoChessPveSettleView, slot0._onEscBtnClick, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if AutoChessModel.instance.settleData then
		gohelper.setActive(slot0._goSuccess, tonumber(slot1.remainingHp) ~= 0)
		gohelper.setActive(slot0._goFail, tonumber(slot1.remainingHp) == 0)
	end
end

function slot0.onClose(slot0)
	slot1 = AutoChessModel.instance.episodeId

	AutoChessController.instance:onSettleViewClose()

	if slot0.restart then
		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(AutoChessEnum.ModuleId.PVE, slot1, lua_auto_chess_episode.configDict[slot1].masterId)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
