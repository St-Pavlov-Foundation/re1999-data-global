module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaResultView", package.seeall)

local var_0_0 = class("TianShiNaNaResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "targets")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")
	arg_1_0._btnrollback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_rollback")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.exitGame, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0.exitGame, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnrollback:AddClickListener(arg_2_0._btnrollbackOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnrollback:RemoveClickListener()
end

function var_0_0.exitGame(arg_4_0)
	if arg_4_0._isWin then
		TianShiNaNaModel.instance:markEpisodeFinish(arg_4_0._index, arg_4_0.viewParam.star)
	end

	ViewMgr.instance:closeView(ViewName.TianShiNaNaLevelView)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:exitGame()
end

function var_0_0._btnrestartOnClick(arg_6_0)
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	arg_6_0:closeThis()
end

function var_0_0._btnrollbackOnClick(arg_7_0)
	Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._gotargetitem, false)

	arg_8_0._taskItems = {}
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._isWin = arg_9_0.viewParam.isWin

	if arg_9_0._isWin then
		TianShiNaNaModel.instance:sendStat("成功")
	else
		TianShiNaNaModel.instance:sendStat("失败")
	end

	arg_9_0._episodeCfg = TianShiNaNaModel.instance.episodeCo

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	if arg_10_0._episodeCfg then
		local var_10_0 = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
		local var_10_1 = tabletool.indexOf(var_10_0, arg_10_0._episodeCfg) or 1

		arg_10_0._index = var_10_1
		arg_10_0._txtclassnum.text = string.format("STAGE %02d", var_10_1)
		arg_10_0._txtclassname.text = arg_10_0._episodeCfg.name

		gohelper.setActive(arg_10_0._gotarget, arg_10_0._isWin)

		if arg_10_0._isWin then
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
			arg_10_0:refreshTaskConditions()
		else
			AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
		end

		gohelper.setActive(arg_10_0._gosuccess, arg_10_0._isWin)
		gohelper.setActive(arg_10_0._gofail, not arg_10_0._isWin)
		gohelper.setActive(arg_10_0._btnquitgame, not arg_10_0._isWin)
		gohelper.setActive(arg_10_0._btnrestart, not arg_10_0._isWin)
		gohelper.setActive(arg_10_0._btnrollback, not arg_10_0._isWin)
		gohelper.setActive(arg_10_0._btnclose, arg_10_0._isWin)
	end
end

function var_0_0.refreshTaskConditions(arg_11_0)
	local var_11_0 = arg_11_0._episodeCfg
	local var_11_1 = string.split(var_11_0.conditionStr, "#")

	gohelper.CreateObjList(arg_11_0, arg_11_0._createItem, var_11_1, arg_11_0._gotargetitem.transform.parent.gameObject, arg_11_0._gotargetitem)
end

function var_0_0._createItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "txt_taskdesc")
	local var_12_1 = gohelper.findChild(arg_12_1, "result/go_finish")
	local var_12_2 = gohelper.findChild(arg_12_1, "result/go_unfinish")

	var_12_0.text = arg_12_2

	gohelper.setActive(var_12_1, arg_12_3 <= arg_12_0.viewParam.star)
	gohelper.setActive(var_12_2, arg_12_3 > arg_12_0.viewParam.star)
end

return var_0_0
