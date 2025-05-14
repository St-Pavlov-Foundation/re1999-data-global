module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessView", package.seeall)

local var_0_0 = class("ActivityTradeSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/main/iconbg/#simage_icon")
	arg_1_0._txtaddcount = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/main/iconbg/#txt_addcount")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/main/#txt_name")
	arg_1_0._txttotalget = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/main/bg/#txt_totalget")
	arg_1_0._txtnextgoal = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/main/nextstage/#txt_nextgoal")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "root/main/nextstage/#txt_nextgoal/#go_finish")
	arg_1_0._btnclose = gohelper.findChildClick(arg_1_0.viewGO, "root/#btn_close")

	gohelper.setActive(arg_1_0._gofinish, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageicon:LoadImage(ResUrl.getVersionTradeBargainBg("icon/icon_tuerjiuchi"))

	arg_4_0._txtname.text = luaLang("p_versionactivitytraderewardview_iconname")

	arg_4_0._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simageicon:UnLoadImage()
	arg_5_0._simagebg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_fadeout)
	arg_6_0:updateView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:updateView()
end

function var_0_0.updateView(arg_8_0)
	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.score or 0
	local var_8_1 = arg_8_0.viewParam and arg_8_0.viewParam.curScore or 0
	local var_8_2 = arg_8_0.viewParam and arg_8_0.viewParam.nextScore or 0

	arg_8_0:refreshText(var_8_0, var_8_1, var_8_2)
end

function var_0_0.refreshText(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.score = arg_9_1
	arg_9_0.curScore = arg_9_2
	arg_9_0.nextScore = arg_9_3
	arg_9_0._txtaddcount.text = string.format("+%s", arg_9_1)
	arg_9_0._txtnextgoal.text = formatLuaLang("versionactivity_1_2_tradesuccessview_nextgoal", arg_9_3)

	arg_9_0:_refreshTotalget(true)
end

function var_0_0._refreshTotalget(arg_10_0, arg_10_1)
	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end

	if arg_10_1 then
		arg_10_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, arg_10_0._tweenFrameCallback, arg_10_0._tweenFinishCallback, arg_10_0)
	else
		arg_10_0:_setTotal(arg_10_0.curScore + arg_10_0.score)
	end
end

function var_0_0._tweenFrameCallback(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 * arg_11_0.score + arg_11_0.curScore

	arg_11_0:_setTotal(var_11_0)
end

function var_0_0._tweenFinishCallback(arg_12_0)
	arg_12_0:_setTotal(arg_12_0.curScore + arg_12_0.score)
end

function var_0_0._setTotal(arg_13_0, arg_13_1)
	local var_13_0 = math.floor(arg_13_1)
	local var_13_1 = var_13_0 >= arg_13_0.nextScore and "#B9FF80" or "#D9A06F"
	local var_13_2 = {
		var_13_1,
		var_13_0
	}

	arg_13_0._txttotalget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_tradesuccessview_totalget"), var_13_2)

	gohelper.setActive(arg_13_0._gofinish, var_13_0 >= arg_13_0.nextScore)
end

function var_0_0.onClose(arg_14_0)
	if arg_14_0._tweenId then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId)

		arg_14_0._tweenId = nil
	end
end

function var_0_0._onClickClose(arg_15_0)
	arg_15_0:closeThis()
end

return var_0_0
