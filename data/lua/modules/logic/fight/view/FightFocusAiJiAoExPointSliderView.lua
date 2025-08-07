module("modules.logic.fight.view.FightFocusAiJiAoExPointSliderView", package.seeall)

local var_0_0 = class("FightFocusAiJiAoExPointSliderView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.preImg = gohelper.findChildImage(arg_1_0.viewGO, "root/go_pre")
	arg_1_0.preImg.fillAmount = 0
	arg_1_0.energyImg = gohelper.findChildImage(arg_1_0.viewGO, "root/go_energy")
	arg_1_0.text = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_energy")
	arg_1_0.btnTips = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/#btn_tips/clickarea")
	arg_1_0.tips = gohelper.findChild(arg_1_0.viewGO, "root/tips")
	arg_1_0.descText = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#txt_skilldesc")

	gohelper.setActive(arg_1_0.tips, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.TouchFightViewScreen, arg_2_0.onTouchFightViewScreen)
	arg_2_0:com_registClick(arg_2_0.btnTips, arg_2_0.onBtnTips)
end

function var_0_0.onBtnTips(arg_3_0)
	gohelper.setActive(arg_3_0.tips, true)
end

function var_0_0.onTouchFightViewScreen(arg_4_0)
	gohelper.setActive(arg_4_0.tips, false)
end

function var_0_0.onConstructor(arg_5_0, arg_5_1)
	arg_5_0.entityMO = arg_5_1
end

function var_0_0.refreshEntityMO(arg_6_0, arg_6_1)
	arg_6_0.entityMO = arg_6_1

	if arg_6_0.viewGO then
		arg_6_0:refreshData()
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshData()

	arg_7_0.descText.text = luaLang("aijiao_expoint_desc")
end

function var_0_0.refreshData(arg_8_0)
	local var_8_0 = arg_8_0.entityMO:getMaxExPoint()
	local var_8_1 = arg_8_0.entityMO.exPoint
	local var_8_2 = var_8_1 / var_8_0

	arg_8_0.energyImg.fillAmount = var_8_2
	arg_8_0.text.text = string.format("%d/%d", var_8_1, var_8_0)
end

return var_0_0
