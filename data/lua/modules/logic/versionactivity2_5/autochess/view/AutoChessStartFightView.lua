module("modules.logic.versionactivity2_5.autochess.view.AutoChessStartFightView", package.seeall)

slot0 = class("AutoChessStartFightView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._onEscapeBtnClick(slot0)
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(ViewName.AutoChessStartFightView, slot0._onEscapeBtnClick, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("autochess"), AudioMgr.instance:getIdFromString("battle"))
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_battle_enter)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 1.5)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
