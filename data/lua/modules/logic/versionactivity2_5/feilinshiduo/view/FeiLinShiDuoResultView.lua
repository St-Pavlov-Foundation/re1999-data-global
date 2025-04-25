module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoResultView", package.seeall)

slot0 = class("FeiLinShiDuoResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._txttaskdesc = gohelper.findChildText(slot0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem/result/#go_finish")
	slot0._gounfinish = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	slot0._gobtn = gohelper.findChild(slot0.viewGO, "#go_btn")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_restart")
	slot0._btnsuccessClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_successClick")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnsuccessClick:AddClickListener(slot0._btnquitgameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnsuccessClick:RemoveClickListener()
end

function slot0._btnquitgameOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.FeiLinShiDuoGameView, false, true)
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.ResultResetGame)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)

	slot0.isSuccess = slot0.viewParam.isSuccess

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gosuccess, slot0.isSuccess)
	gohelper.setActive(slot0._gofinish, slot0.isSuccess)
	gohelper.setActive(slot0._gobtn, not slot0.isSuccess)
	gohelper.setActive(slot0._gofail, not slot0.isSuccess)
	gohelper.setActive(slot0._gounfinish, not slot0.isSuccess)
	gohelper.setActive(slot0._btnsuccessClick.gameObject, slot0.isSuccess)

	slot0._txttaskdesc.text = luaLang("act185_gametarget")

	if slot0.isSuccess then
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_challenge_fail)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
