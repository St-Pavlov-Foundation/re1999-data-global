module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderView", package.seeall)

local var_0_0 = class("AutoChessLeaderView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goItemRoot = gohelper.findChild(arg_1_0.viewGO, "root/scroll_teamleaderlist/viewport/#go_ItemRoot")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Start")
	arg_1_0._goStartGray = gohelper.findChild(arg_1_0.viewGO, "root/#btn_Start/#go_StartGray")
	arg_1_0._btnFresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Fresh")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0._btnFresh:AddClickListener(arg_2_0._btnFreshOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnFresh:RemoveClickListener()
end

function var_0_0._btnFreshOnClick(arg_4_0)
	arg_4_0.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(arg_4_0._delayRefresh, arg_4_0, 0.16)
end

function var_0_0._delayRefresh(arg_5_0)
	Activity182Rpc.instance:sendAct182RefreshMasterRequest(arg_5_0.actId, arg_5_0.refreshBack, arg_5_0)
end

function var_0_0.refreshBack(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 0 then
		arg_6_0:refreshUI()
	end
end

function var_0_0._btnStartOnClick(arg_7_0)
	if not arg_7_0.selectLeader then
		GameFacade.showToast(ToastEnum.AutoChessSelectLeader)

		return
	end

	local var_7_0 = {
		actId = arg_7_0.actId,
		moduleId = arg_7_0.moduleId,
		episodeId = AutoChessConfig.instance:getPvpEpisodeCo(arg_7_0.actId).id,
		leaderId = arg_7_0.selectLeader.id
	}

	AutoChessController.instance:openLeaderNextView(var_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.anim = arg_8_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_8_0.leaderItemList = {}

	for iter_8_0 = 1, 3 do
		local var_8_0 = arg_8_0:getResInst(AutoChessStrEnum.ResPath.LeaderItem, arg_8_0._goItemRoot)

		gohelper.setActive(var_8_0, false)

		local var_8_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0, AutoChessLeaderItem, arg_8_0)

		arg_8_0.leaderItemList[iter_8_0] = var_8_1
	end
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_delete_features)

	arg_9_0.actId = arg_9_0.viewParam.actId
	arg_9_0.moduleId = arg_9_0.viewParam.moduleId

	arg_9_0:refreshUI()
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayRefresh, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.delayShowLeader, arg_10_0)
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.gameMo = Activity182Model.instance:getActMo():getGameMo(arg_11_0.actId, arg_11_0.moduleId)
	arg_11_0.masterIdBox = arg_11_0.gameMo.masterIdBox
	arg_11_0.showIndex = 0

	arg_11_0:delayShowLeader()
	TaskDispatcher.runRepeat(arg_11_0.delayShowLeader, arg_11_0, 0.1)
	gohelper.setActive(arg_11_0._btnFresh, not arg_11_0.gameMo.refreshed)
	gohelper.setActive(arg_11_0._goStartGray, not arg_11_0.selectLeader)
end

function var_0_0.delayShowLeader(arg_12_0)
	arg_12_0.showIndex = arg_12_0.showIndex + 1

	local var_12_0 = arg_12_0.leaderItemList[arg_12_0.showIndex]

	var_12_0:setData(arg_12_0.masterIdBox[arg_12_0.showIndex])
	gohelper.setActive(var_12_0.go, true)

	if arg_12_0.showIndex >= 3 then
		TaskDispatcher.cancelTask(arg_12_0.delayShowLeader, arg_12_0)
	end
end

function var_0_0.onClickLeader(arg_13_0, arg_13_1)
	if arg_13_0.selectLeader then
		if arg_13_0.selectLeader == arg_13_1 then
			return
		end

		arg_13_0.selectLeader:refreshSelect(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
	arg_13_1:refreshSelect(true)

	arg_13_0.selectLeader = arg_13_1

	gohelper.setActive(arg_13_0._goStartGray, not arg_13_0.selectLeader)
end

return var_0_0
