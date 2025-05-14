module("modules.logic.versionactivity1_2.jiexika.view.Activity114TimeView", package.seeall)

local var_0_0 = class("Activity114TimeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.viewGO, "time/today/daytitle/#txt_day")
	arg_1_0._txtdayen = gohelper.findChildText(arg_1_0.viewGO, "time/today/daytitle/#txt_day/#txt_dayen")
	arg_1_0._txtkeyDay = gohelper.findChildText(arg_1_0.viewGO, "time/nextKeyDay/#txt_keyDay")
	arg_1_0._goedubg = gohelper.findChild(arg_1_0.viewGO, "time/today/eduTime/go_edubg")
	arg_1_0._txteduTime = gohelper.findChildText(arg_1_0.viewGO, "time/today/eduTime/#txt_eduTime")
	arg_1_0._txteduTimeEn = gohelper.findChildText(arg_1_0.viewGO, "time/today/eduTime/#txt_eduTime/txten")
	arg_1_0._gofreebg = gohelper.findChild(arg_1_0.viewGO, "time/today/freeTime/go_freebg")
	arg_1_0._txtfreeTime = gohelper.findChildText(arg_1_0.viewGO, "time/today/freeTime/#txt_freeTime")
	arg_1_0._txtfreeTimeEn = gohelper.findChildText(arg_1_0.viewGO, "time/today/freeTime/#txt_freeTime/txten")
	arg_1_0._imageprocess = gohelper.findChildImage(arg_1_0.viewGO, "time/today/round/bgline/#image_process")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, arg_2_0.onRoundChange, arg_2_0)
	arg_2_0.viewContainer:registerCallback(Activity114Event.MainViewAnimBegin, arg_2_0.onMainViewAnimBegin, arg_2_0)
	arg_2_0.viewContainer:registerCallback(Activity114Event.MainViewAnimEnd, arg_2_0.onMainViewAnimEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, arg_3_0.onRoundChange, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(Activity114Event.MainViewAnimBegin, arg_3_0.onMainViewAnimBegin, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(Activity114Event.MainViewAnimEnd, arg_3_0.onMainViewAnimEnd, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.rounds = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.rounds[iter_4_0] = arg_4_0:getUserDataTb_()
		arg_4_0.rounds[iter_4_0].type1 = gohelper.findChild(arg_4_0.viewGO, "time/today/round/round" .. iter_4_0 .. "/type1")
		arg_4_0.rounds[iter_4_0].type2 = gohelper.findChild(arg_4_0.viewGO, "time/today/round/round" .. iter_4_0 .. "/type2")
		arg_4_0.rounds[iter_4_0].type3 = gohelper.findChild(arg_4_0.viewGO, "time/today/round/round" .. iter_4_0 .. "/type3")
		arg_4_0.rounds[iter_4_0].actdesc = gohelper.findChildText(arg_4_0.viewGO, "time/today/round/round" .. iter_4_0 .. "/txt_actdesc")
	end

	arg_4_0:onRoundChange()
end

function var_0_0.onMainViewAnimBegin(arg_5_0)
	local var_5_0 = Activity114Model.instance.serverData.round

	if not arg_5_0.rounds[var_5_0 - 1] then
		return
	end

	gohelper.setActive(arg_5_0.rounds[var_5_0 - 1].type1, false)
end

function var_0_0.onMainViewAnimEnd(arg_6_0)
	local var_6_0 = Activity114Model.instance.serverData.round

	if not arg_6_0.rounds[var_6_0 - 1] then
		return
	end

	gohelper.setActive(arg_6_0.rounds[var_6_0 - 1].type1, true)
	ZProj.ProjAnimatorPlayer.Get(arg_6_0.rounds[var_6_0 - 1].type1):Play(UIAnimationName.Open)
end

function var_0_0.onRoundChange(arg_7_0)
	local var_7_0 = Activity114Model.instance.serverData.day
	local var_7_1 = Activity114Model.instance.serverData.round
	local var_7_2 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, var_7_0, var_7_1)
	local var_7_3 = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, var_7_0)

	if not var_7_2 or not var_7_3 or var_7_2.type == Activity114Enum.RoundType.KeyDay then
		return
	end

	for iter_7_0 = 1, 4 do
		gohelper.setActive(arg_7_0.rounds[iter_7_0].type1, iter_7_0 < var_7_1 and not Activity114Model.instance.isPlayingOpenAnim)
		gohelper.setActive(arg_7_0.rounds[iter_7_0].type2, iter_7_0 == var_7_1)
		gohelper.setActive(arg_7_0.rounds[iter_7_0].type3, var_7_1 < iter_7_0)

		local var_7_4 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, var_7_0, iter_7_0)

		arg_7_0.rounds[iter_7_0].actdesc.text = var_7_4.desc

		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0.rounds[iter_7_0].actdesc, iter_7_0 == var_7_1 and "#B389D7" or "#CECECE")
	end

	arg_7_0._imageprocess.fillAmount = (var_7_1 - 1) / 3
	arg_7_0._txtday.text = formatLuaLang("versionactivity_1_2_114daydes", GameUtil.getNum2Chinese(var_7_0))
	arg_7_0._txtdayen.text = "DAY " .. var_7_0

	local var_7_5 = {
		var_7_3.desc,
		var_7_3.day - var_7_0
	}

	arg_7_0._txtkeyDay.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_114keydaydes"), var_7_5)

	gohelper.setActive(arg_7_0._goedubg, var_7_2.type == Activity114Enum.RoundType.Edu)
	gohelper.setActive(arg_7_0._gofreebg, var_7_2.type == Activity114Enum.RoundType.Free)

	arg_7_0._txteduTime.alpha = var_7_2.type == Activity114Enum.RoundType.Edu and 1 or 0.102
	arg_7_0._txteduTimeEn.alpha = var_7_2.type == Activity114Enum.RoundType.Edu and 0.2 or 0.051
	arg_7_0._txtfreeTime.alpha = var_7_2.type == Activity114Enum.RoundType.Free and 1 or 0.102
	arg_7_0._txtfreeTimeEn.alpha = var_7_2.type == Activity114Enum.RoundType.Free and 0.2 or 0.051
end

return var_0_0
