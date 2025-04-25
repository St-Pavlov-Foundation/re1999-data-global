module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteView", package.seeall)

slot0 = class("Activity186GameInviteView", BaseView)

function slot0.onInitView(slot0)
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "root/goSelect")
	slot0.goRight = gohelper.findChild(slot0.viewGO, "root/right")
	slot0.btnSure = gohelper.findChildButtonWithAudio(slot0.goSelect, "btnSure")
	slot0.btnCancel = gohelper.findChildButtonWithAudio(slot0.goSelect, "btnCancel")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.goSelect, "content")
	slot0.txtSure = gohelper.findChildTextMesh(slot0.goSelect, "btnSure/txt")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnSure, slot0.onClickBtnSure, slot0)
	slot0:addClickCb(slot0.btnCancel, slot0.onClickBtnCancel, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnSure(slot0)
	Activity186Controller.instance:enterGame(slot0.actId, slot0.gameId)
end

function slot0.onClickBtnCancel(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_leimi_theft_open)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.activityId
	slot0.gameId = slot0.viewParam.gameId
	slot0.gameStatus = slot0.viewParam.gameStatus
	slot0.gameType = slot0.viewParam.gameType
end

function slot0.refreshView(slot0)
	gohelper.setActive(slot0.goSelect, slot0.gameStatus == Activity186Enum.GameStatus.Start)
	gohelper.setActive(slot0.goRight, slot0.gameStatus == Activity186Enum.GameStatus.Playing)

	if slot0.gameStatus == Activity186Enum.GameStatus.Start then
		if slot0.gameType == 1 then
			slot0.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content1"))

			slot0.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title1")
			slot0.txtSure.text = luaLang("p_activity186gameinviteview_txt_start2")
		else
			slot0.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content2"))

			slot0.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title2")
			slot0.txtSure.text = luaLang("p_activity186gameinviteview_txt_start")
		end

		slot0:_showDeadline()
	else
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0._onRefreshDeadline(slot0)
	slot0:checkGameNotOnline()
end

function slot0.checkGameNotOnline(slot0)
	if not Activity186Model.instance:getById(slot0.actId) then
		return
	end

	if not slot1:getGameInfo(slot0.gameId) then
		return
	end

	if not slot1:isGameOnline(slot0.gameId) then
		slot0:closeThis()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0
