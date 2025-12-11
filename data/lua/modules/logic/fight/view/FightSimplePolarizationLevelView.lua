module("modules.logic.fight.view.FightSimplePolarizationLevelView", package.seeall)

local var_0_0 = class("FightSimplePolarizationLevelView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_level")
	arg_1_0._nameText = gohelper.findChildText(arg_1_0.viewGO, "name")
	arg_1_0._levelText = gohelper.findChildText(arg_1_0.viewGO, "level")
	arg_1_0._tips = gohelper.findChild(arg_1_0.viewGO, "#go_leveltip")
	arg_1_0._btnClose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_leveltip/#btn_close")
	arg_1_0._title = gohelper.findChildText(arg_1_0.viewGO, "#go_leveltip/bg/#txt_title")
	arg_1_0._desc = gohelper.findChildText(arg_1_0.viewGO, "#go_leveltip/bg/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0._click, arg_2_0._onClick)
	arg_2_0:com_registClick(arg_2_0._btnClose, arg_2_0._onBtnClose)
	arg_2_0:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, arg_2_0._onRefreshSimplePolarizationLevel)
	arg_2_0:com_registFightEvent(FightEvent.TouchFightViewScreen, arg_2_0._onTouchFightViewScreen)
end

function var_0_0._onTouchFightViewScreen(arg_3_0)
	gohelper.setActive(arg_3_0._tips, false)
end

function var_0_0._onBtnClose(arg_4_0)
	gohelper.setActive(arg_4_0._tips, false)
end

function var_0_0._onClick(arg_5_0)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	gohelper.setActive(arg_5_0._tips, true)
end

function var_0_0._onRefreshSimplePolarizationLevel(arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	local var_8_0 = FightDataHelper.tempMgr.simplePolarizationLevel or 0
	local var_8_1 = lua_simple_polarization.configDict[var_8_0]

	arg_8_0._levelText.text = "LV." .. var_8_0

	if var_8_1 then
		arg_8_0._nameText.text = var_8_1.name
		arg_8_0._title.text = var_8_1.name
		arg_8_0._desc.text = HeroSkillModel.instance:skillDesToSpot(var_8_1.desc, "#c56131", "#7c93ad")
	else
		logError("减震表找不到等级:" .. var_8_0)
	end
end

return var_0_0
