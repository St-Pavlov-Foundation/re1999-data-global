module("modules.logic.versionactivity2_3.act174.view.Act174MatchView", package.seeall)

local var_0_0 = class("Act174MatchView", BaseView)
local var_0_1 = 6

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosearching = gohelper.findChild(arg_1_0.viewGO, "#go_searching")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searching/#btn_cancel")
	arg_1_0._txtsearching = gohelper.findChildText(arg_1_0.viewGO, "#go_searching/#txt_searching")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._btncancelgrey = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_success/#btn_cancel_grey")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btncancelgrey:AddClickListener(arg_2_0._btncancelgreyOnClick, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0._onEscBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btncancelgrey:RemoveClickListener()
end

function var_0_0._btncancelOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	arg_4_0:closeThis()
end

function var_0_0._btncancelgreyOnClick(arg_5_0)
	return
end

function var_0_0._onEscBtnClick(arg_6_0)
	if arg_6_0._btncancelgrey.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.txtList = {}

	for iter_7_0 = 1, var_0_1 do
		local var_7_0 = gohelper.findChildText(arg_7_0.viewGO, "#go_searching/searching/#txt_searching" .. iter_7_0)

		arg_7_0.txtList[#arg_7_0.txtList + 1] = var_7_0
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:setRandomTxt()

	local var_9_0 = lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchWaitTime].value

	TaskDispatcher.runDelay(arg_9_0.waitEnd, arg_9_0, tonumber(var_9_0))
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_success)
end

function var_0_0.setRandomTxt(arg_10_0)
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	local var_10_0 = lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchTxt].value2
	local var_10_1 = string.split(var_10_0, "#")
	local var_10_2 = #var_10_1

	for iter_10_0 = 1, var_0_1 do
		local var_10_3 = math.random(iter_10_0, var_10_2)

		var_10_1[var_10_3], var_10_1[iter_10_0] = var_10_1[iter_10_0], var_10_1[var_10_3]
	end

	for iter_10_1, iter_10_2 in ipairs(arg_10_0.txtList) do
		iter_10_2.text = var_10_1[iter_10_1]
	end
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.waitEnd, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0.waitEnd(arg_13_0)
	local var_13_0 = Activity174Model.instance:getCurActId()

	Activity174Rpc.instance:sendStartAct174FightMatchRequest(var_13_0, arg_13_0.matchCallback, arg_13_0)
end

function var_0_0.matchCallback(arg_14_0)
	gohelper.setActive(arg_14_0._gosearching, false)
	gohelper.setActive(arg_14_0._gosuccess, true)
	Activity174Controller.instance:openFightReadyView()
	ViewMgr.instance:closeView(ViewName.Act174GameView, true)
	arg_14_0:closeThis()
end

return var_0_0
