module("modules.logic.season.view3_0.Season3_0SpecialMarketShowLevelItem", package.seeall)

local var_0_0 = class("Season3_0SpecialMarketShowLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0._goline = gohelper.findChild(arg_1_1, "#go_line")
	arg_1_0._goselectedpass = gohelper.findChild(arg_1_1, "#go_selectedpass")
	arg_1_0._txtselectpassindex = gohelper.findChildText(arg_1_1, "#go_selectedpass/#txt_selectpassindex")
	arg_1_0._goselectedunpass = gohelper.findChild(arg_1_1, "#go_selectedunpass")
	arg_1_0._txtselectunpassindex = gohelper.findChildText(arg_1_1, "#go_selectedunpass/#txt_selectunpassindex")
	arg_1_0._gopass = gohelper.findChild(arg_1_1, "#go_pass")
	arg_1_0._txtpassindex = gohelper.findChildText(arg_1_1, "#go_pass/#txt_passindex")
	arg_1_0._gounpass = gohelper.findChild(arg_1_1, "#go_unpass")
	arg_1_0._txtunpassindex = gohelper.findChildText(arg_1_1, "#go_unpass/#txt_unpassindex")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._txtlockindex = gohelper.findChildText(arg_1_1, "#go_lock/#txt_lockindex")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")

	arg_1_0._btnClick:AddClickListener(arg_1_0._btnOnClick, arg_1_0)
end

function var_0_0._btnOnClick(arg_2_0)
	local var_2_0 = Activity104Model.instance:getCurSeasonId()
	local var_2_1, var_2_2 = Activity104Model.instance:isSpecialLayerOpen(var_2_0, arg_2_0.index)

	if not var_2_1 then
		local var_2_3 = math.ceil(var_2_2 / TimeUtil.OneDaySecond)
		local var_2_4 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), var_2_3)

		GameFacade.showToastString(var_2_4)

		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSpecialEpisode, arg_2_0.index)
end

function var_0_0.reset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index = arg_3_1
	arg_3_0.targetIndex = arg_3_2
	arg_3_0.maxSpecialLayer = arg_3_3

	arg_3_0:_refreshItem()
end

function var_0_0._refreshItem(arg_4_0)
	gohelper.setActive(arg_4_0.go, true)

	local var_4_0 = Activity104Model.instance:getCurSeasonId()
	local var_4_1 = Activity104Model.instance:isSpecialLayerOpen(var_4_0, arg_4_0.index)

	gohelper.setActive(arg_4_0._golock, not var_4_1)

	if var_4_1 then
		local var_4_2 = Activity104Model.instance:isSpecialLayerPassed(arg_4_0.index)
		local var_4_3 = arg_4_0.targetIndex == arg_4_0.index

		gohelper.setActive(arg_4_0._gopass, var_4_2 and not var_4_3)
		gohelper.setActive(arg_4_0._gounpass, not var_4_2 and not var_4_3)
		gohelper.setActive(arg_4_0._goselectedpass, var_4_2 and var_4_3)
		gohelper.setActive(arg_4_0._goselectedunpass, not var_4_2 and var_4_3)
	else
		gohelper.setActive(arg_4_0._gopass, false)
		gohelper.setActive(arg_4_0._gounpass, false)
		gohelper.setActive(arg_4_0._goselectedpass, false)
		gohelper.setActive(arg_4_0._goselectedunpass, false)
	end

	gohelper.setActive(arg_4_0._goline, arg_4_0.index < arg_4_0.maxSpecialLayer)

	local var_4_4 = string.format("%02d", arg_4_0.index)

	arg_4_0._txtselectpassindex.text = var_4_4
	arg_4_0._txtselectunpassindex.text = var_4_4
	arg_4_0._txtpassindex.text = var_4_4
	arg_4_0._txtunpassindex.text = var_4_4
	arg_4_0._txtlockindex.text = var_4_4
end

function var_0_0.destroy(arg_5_0)
	arg_5_0._btnClick:RemoveClickListener()
end

return var_0_0
