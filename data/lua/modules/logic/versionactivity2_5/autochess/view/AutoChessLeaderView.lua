module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderView", package.seeall)

slot0 = class("AutoChessLeaderView", BaseView)

function slot0.onInitView(slot0)
	slot0._goItemRoot = gohelper.findChild(slot0.viewGO, "root/scroll_teamleaderlist/viewport/#go_ItemRoot")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_Start")
	slot0._goStartGray = gohelper.findChild(slot0.viewGO, "root/#btn_Start/#go_StartGray")
	slot0._btnFresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_Fresh")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
	slot0._btnFresh:AddClickListener(slot0._btnFreshOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStart:RemoveClickListener()
	slot0._btnFresh:RemoveClickListener()
end

function slot0._btnFreshOnClick(slot0)
	slot0.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(slot0._delayRefresh, slot0, 0.16)
end

function slot0._delayRefresh(slot0)
	Activity182Rpc.instance:sendAct182RefreshMasterRequest(slot0.actId, slot0.refreshBack, slot0)
end

function slot0.refreshBack(slot0, slot1, slot2)
	if slot2 == 0 then
		slot0:refreshUI()
	end
end

function slot0._btnStartOnClick(slot0)
	if not slot0.selectLeader then
		GameFacade.showToast(ToastEnum.AutoChessSelectLeader)

		return
	end

	AutoChessController.instance:openLeaderNextView({
		moduleId = slot0.moduleId,
		episodeId = slot0.viewParam.episodeId,
		leaderId = slot0.selectLeader.id
	})
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.actId = Activity182Model.instance:getCurActId()
	slot0.moduleId = AutoChessEnum.ModuleId.PVP
	slot0.leaderItemList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getResInst(AutoChessEnum.LeaderItemPath, slot0._goItemRoot)

		gohelper.setActive(slot5, false)

		slot0.leaderItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(slot5, AutoChessLeaderItem, slot0)
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_delete_features)

	if slot0.viewParam then
		slot0:refreshUI()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayRefresh, slot0)
	TaskDispatcher.cancelTask(slot0.delayShowLeader, slot0)
end

function slot0.refreshUI(slot0)
	slot1 = Activity182Model.instance:getActMo()
	slot0.gameMo = slot1.gameMoDic[slot0.moduleId]
	slot0.masterIdBox = slot0.gameMo.masterIdBox
	slot0.showIndex = 0

	slot0:delayShowLeader()
	TaskDispatcher.runRepeat(slot0.delayShowLeader, slot0, 0.1)
	gohelper.setActive(slot0._btnFresh, slot1:isEpisodePass(tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value)) and not slot0.gameMo.refreshed)
	gohelper.setActive(slot0._goStartGray, not slot0.selectLeader)
end

function slot0.delayShowLeader(slot0)
	slot0.showIndex = slot0.showIndex + 1
	slot1 = slot0.leaderItemList[slot0.showIndex]

	slot1:setData(slot0.masterIdBox[slot0.showIndex])
	gohelper.setActive(slot1.go, true)

	if slot0.showIndex >= 3 then
		TaskDispatcher.cancelTask(slot0.delayShowLeader, slot0)
	end
end

function slot0.onClickLeader(slot0, slot1)
	if slot0.selectLeader then
		if slot0.selectLeader == slot1 then
			return
		end

		slot0.selectLeader:refreshSelect(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
	slot1:refreshSelect(true)

	slot0.selectLeader = slot1

	gohelper.setActive(slot0._goStartGray, not slot0.selectLeader)
end

return slot0
