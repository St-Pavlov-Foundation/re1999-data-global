module("modules.logic.versionactivity2_5.act186.view.Activity186GameBiscuitsView", package.seeall)

local var_0_0 = class("Activity186GameBiscuitsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goUnopen = gohelper.findChild(arg_1_0.viewGO, "unopen")
	arg_1_0.goOpened = gohelper.findChild(arg_1_0.viewGO, "opened")
	arg_1_0.txtReward = gohelper.findChildTextMesh(arg_1_0.viewGO, "opened/#txt_reward")
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addTouchEvents()
end

function var_0_0.removeEvents(arg_3_0)
	if not gohelper.isNil(arg_3_0._touchEventMgr) then
		TouchEventMgrHepler.remove(arg_3_0._touchEventMgr)
	end
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.config = arg_7_0.viewParam.config
	arg_7_0.act186Id = arg_7_0.viewParam.act186Id
	arg_7_0.actId = arg_7_0.config.activityId
	arg_7_0.id = arg_7_0.config.id
	arg_7_0.status = Activity186Enum.GameStatus.Start

	if Activity186SignModel.instance:getSignStatus(arg_7_0.actId, arg_7_0.act186Id, arg_7_0.id) == Activity186Enum.SignStatus.Canplay then
		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_help_switch)
		arg_7_0.anim:Play("open")
		arg_7_0:startGame()
	else
		arg_7_0.anim:Play("open1")
		arg_7_0:showResult()
	end
end

function var_0_0.startGame(arg_8_0)
	arg_8_0.status = Activity186Enum.GameStatus.Playing
end

function var_0_0.showResult(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_cookies_open)

	arg_9_0.status = Activity186Enum.GameStatus.Result

	Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, arg_9_0.act186Id, arg_9_0.id, 1)

	arg_9_0.txtReward.text = luaLang(string.format("act186_signview_day%s", arg_9_0.id))
end

function var_0_0.addTouchEvents(arg_10_0)
	if arg_10_0._touchEventMgr then
		return
	end

	arg_10_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_10_0.viewGO)

	arg_10_0._touchEventMgr:SetIgnoreUI(true)
	arg_10_0._touchEventMgr:SetOnlyTouch(true)
	arg_10_0._touchEventMgr:SetOnClickCb(arg_10_0.onClickBtnClose, arg_10_0)
	arg_10_0._touchEventMgr:SetOnDragEndCb(arg_10_0._onDragEnd, arg_10_0)
end

function var_0_0._onDragEnd(arg_11_0)
	if arg_11_0.status == Activity186Enum.GameStatus.Playing then
		arg_11_0.anim:Play("opened")
		arg_11_0:showResult()
	end
end

function var_0_0.onClose(arg_12_0)
	if arg_12_0.status == Activity186Enum.GameStatus.Result and arg_12_0.actId and arg_12_0.id and ActivityType101Model.instance:isType101RewardCouldGet(arg_12_0.actId, arg_12_0.id) then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_12_0.actId, arg_12_0.id)
	end
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
