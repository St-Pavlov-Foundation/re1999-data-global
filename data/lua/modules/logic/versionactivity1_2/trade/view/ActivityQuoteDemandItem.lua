module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteDemandItem", package.seeall)

local var_0_0 = class("ActivityQuoteDemandItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.go, "simage_bg")

	arg_1_0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	arg_1_0.goFinish = gohelper.findChild(arg_1_0.go, "go_finish")
	arg_1_0.txtCurProgress = gohelper.findChildTextMesh(arg_1_0.go, "layout/left/txt_curcount")
	arg_1_0.txtMaxProgress = gohelper.findChildTextMesh(arg_1_0.go, "layout/right/txt_curcount")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.go, "txt_desc")
	arg_1_0.txtPricerange = gohelper.findChildTextMesh(arg_1_0.go, "bargain/txt_pricerange")
	arg_1_0.btnJump = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_jump", AudioEnum.UI.play_ui_petrus_mission_skip)

	arg_1_0.btnJump:AddClickListener(arg_1_0.onClickJump, arg_1_0)

	arg_1_0.btnCancel = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_cancel", AudioEnum.UI.Play_UI_Rolesback)

	arg_1_0.btnCancel:AddClickListener(arg_1_0.onClickCancel, arg_1_0)

	arg_1_0.btnBargain = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_bargain")

	arg_1_0.btnBargain:AddClickListener(arg_1_0.onClickStartBargain, arg_1_0)

	arg_1_0._simageclickbg = gohelper.findChildSingleImage(arg_1_0.go, "click/bg")

	arg_1_0._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0.data = arg_2_1

	if not arg_2_1 then
		gohelper.setActive(arg_2_0.go, false)

		return
	end

	arg_2_0.index = arg_2_3
	arg_2_0.count = arg_2_4
	arg_2_0.callback = arg_2_5
	arg_2_0.callbackObj = arg_2_6

	gohelper.setActive(arg_2_0.go, true)

	local var_2_0 = arg_2_1:isProgressEnough()
	local var_2_1 = arg_2_1.hasGetBonus

	if arg_2_1.id == Activity117Model.instance:getSelectOrder(arg_2_1.activityId) then
		gohelper.setActive(arg_2_0.btnCancel, true)
		gohelper.setActive(arg_2_0.goFinish, false)
		gohelper.setActive(arg_2_0.btnJump, false)
		gohelper.setActive(arg_2_0.btnBargain, false)
	elseif arg_2_2 then
		gohelper.setActive(arg_2_0.goFinish, true)
		gohelper.setActive(arg_2_0.btnJump, false)
		gohelper.setActive(arg_2_0.btnBargain, false)
		gohelper.setActive(arg_2_0.btnCancel, false)
	else
		gohelper.setActive(arg_2_0.goFinish, var_2_1)
		gohelper.setActive(arg_2_0.btnJump, not var_2_0 and not var_2_1)
		gohelper.setActive(arg_2_0.btnBargain, var_2_0 and not var_2_1)
		gohelper.setActive(arg_2_0.btnCancel, false)
	end

	arg_2_0.txtCurProgress.text = (var_2_0 or var_2_1) and "1" or "0"
	arg_2_0.txtMaxProgress.text = "1"
	arg_2_0.txtDesc.text = arg_2_1:getDesc() or ""
	arg_2_0.txtPricerange.text = string.format("%s-%s", arg_2_1.minScore, arg_2_1.maxScore)

	if not arg_2_0.playedAnim then
		arg_2_0.playedAnim = true
		arg_2_0.anim.speed = 0

		local var_2_2 = (arg_2_3 - 1) * 0.06

		if var_2_2 and var_2_2 > 0 then
			TaskDispatcher.runDelay(arg_2_0.playOpenAnim, arg_2_0, var_2_2)
		else
			arg_2_0:playOpenAnim()
		end
	else
		arg_2_0:checkDoCallback()
	end
end

function var_0_0.playOpenAnim(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.playOpenAnim, arg_3_0)

	arg_3_0.anim.speed = 1

	arg_3_0.anim:Play(UIAnimationName.Open, 0, 0)
	arg_3_0:checkDoCallback()
end

function var_0_0.checkDoCallback(arg_4_0)
	if arg_4_0.index == arg_4_0.count and arg_4_0.callback then
		arg_4_0.callback(arg_4_0.callbackObj)

		arg_4_0.callback = nil
	end
end

function var_0_0.onAllAnimFinish(arg_5_0)
	if arg_5_0.data then
		local var_5_0 = gohelper.findChild(arg_5_0.btnBargain.gameObject, "huan")

		gohelper.setActive(var_5_0, false)
		gohelper.setActive(var_5_0, true)
	end
end

function var_0_0.onClickStartBargain(arg_6_0)
	if not arg_6_0.data then
		return
	end

	local var_6_0 = arg_6_0.data
	local var_6_1 = var_6_0.activityId

	Activity117Model.instance:setSelectOrder(var_6_1, var_6_0.id)
	Activity117Model.instance:setInQuote(var_6_1)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, var_6_1)
end

function var_0_0.onClickJump(arg_7_0)
	local var_7_0 = arg_7_0.data and arg_7_0.data.jumpId

	if not var_7_0 then
		return
	end

	local var_7_1 = {
		jumpId = 10011205,
		special = true,
		desc = luaLang("versionactivity_1_2_tradedemand"),
		sceneType = SceneType.Main,
		checkFunc = arg_7_0.data.isProgressEnough,
		checkFuncObj = arg_7_0.data
	}

	GameFacade.jump(var_7_0, nil, nil, var_7_1)
end

function var_0_0.onClickCancel(arg_8_0)
	if not arg_8_0.data then
		return
	end

	local var_8_0 = arg_8_0.data.activityId

	Activity117Model.instance:setSelectOrder(var_8_0)
	Activity117Model.instance:setInQuote(var_8_0)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, var_8_0)
end

function var_0_0.destory(arg_9_0)
	if arg_9_0.btnBargain then
		arg_9_0.btnBargain:RemoveClickListener()
	end

	if arg_9_0.btnJump then
		arg_9_0.btnJump:RemoveClickListener()
	end

	if arg_9_0.btnCancel then
		arg_9_0.btnCancel:RemoveClickListener()
	end

	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageclickbg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_9_0.playOpenAnim, arg_9_0)
	arg_9_0:__onDispose()
end

return var_0_0
