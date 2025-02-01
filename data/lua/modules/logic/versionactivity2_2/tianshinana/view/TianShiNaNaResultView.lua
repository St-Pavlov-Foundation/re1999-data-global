module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaResultView", package.seeall)

slot0 = class("TianShiNaNaResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "targets")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")
	slot0._btnrollback = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_rollback")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.exitGame, slot0)
	slot0._btnquitgame:AddClickListener(slot0.exitGame, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnrollback:AddClickListener(slot0._btnrollbackOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnrollback:RemoveClickListener()
end

function slot0.exitGame(slot0)
	if slot0._isWin then
		TianShiNaNaModel.instance:markEpisodeFinish(slot0._index, slot0.viewParam.star)
	end

	ViewMgr.instance:closeView(ViewName.TianShiNaNaLevelView)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:exitGame()
end

function slot0._btnrestartOnClick(slot0)
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	slot0:closeThis()
end

function slot0._btnrollbackOnClick(slot0)
	Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotargetitem, false)

	slot0._taskItems = {}
end

function slot0.onOpen(slot0)
	slot0._isWin = slot0.viewParam.isWin

	if slot0._isWin then
		TianShiNaNaModel.instance:sendStat("成功")
	else
		TianShiNaNaModel.instance:sendStat("失败")
	end

	slot0._episodeCfg = TianShiNaNaModel.instance.episodeCo

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if slot0._episodeCfg then
		slot2 = tabletool.indexOf(TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa), slot0._episodeCfg) or 1
		slot0._index = slot2
		slot0._txtclassnum.text = string.format("STAGE %02d", slot2)
		slot0._txtclassname.text = slot0._episodeCfg.name

		gohelper.setActive(slot0._gotarget, slot0._isWin)

		if slot0._isWin then
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
			slot0:refreshTaskConditions()
		else
			AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
		end

		gohelper.setActive(slot0._gosuccess, slot0._isWin)
		gohelper.setActive(slot0._gofail, not slot0._isWin)
		gohelper.setActive(slot0._btnquitgame, not slot0._isWin)
		gohelper.setActive(slot0._btnrestart, not slot0._isWin)
		gohelper.setActive(slot0._btnrollback, not slot0._isWin)
		gohelper.setActive(slot0._btnclose, slot0._isWin)
	end
end

function slot0.refreshTaskConditions(slot0)
	gohelper.CreateObjList(slot0, slot0._createItem, string.split(slot0._episodeCfg.conditionStr, "#"), slot0._gotargetitem.transform.parent.gameObject, slot0._gotargetitem)
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "txt_taskdesc").text = slot2

	gohelper.setActive(gohelper.findChild(slot1, "result/go_finish"), slot3 <= slot0.viewParam.star)
	gohelper.setActive(gohelper.findChild(slot1, "result/go_unfinish"), slot0.viewParam.star < slot3)
end

return slot0
