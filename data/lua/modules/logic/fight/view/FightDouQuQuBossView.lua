module("modules.logic.fight.view.FightDouQuQuBossView", package.seeall)

local var_0_0 = class("FightDouQuQuBossView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.style1 = gohelper.findChild(arg_1_0.viewGO, "root/1")
	arg_1_0.style2 = gohelper.findChild(arg_1_0.viewGO, "root/2")
	arg_1_0.style3 = gohelper.findChild(arg_1_0.viewGO, "root/3")
	arg_1_0.max1 = gohelper.findChild(arg_1_0.viewGO, "root/1/max")
	arg_1_0.max2 = gohelper.findChild(arg_1_0.viewGO, "root/2/max")
	arg_1_0.max3 = gohelper.findChild(arg_1_0.viewGO, "root/3/max")
	arg_1_0.fill1 = gohelper.findChildImage(arg_1_0.viewGO, "root/1/#go_progress")
	arg_1_0.fill2 = gohelper.findChildImage(arg_1_0.viewGO, "root/2/#go_progress")
	arg_1_0.fill1.fillAmount = 1
	arg_1_0.fill2.fillAmount = 1
	arg_1_0.energyText = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_energy")
	arg_1_0.addGO = gohelper.findChild(arg_1_0.viewGO, "root/go_addNum")
	arg_1_0.addText = gohelper.findChildText(arg_1_0.viewGO, "root/go_addNum/#txt_num")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/#btn_clickarea")
	arg_1_0.switch = gohelper.findChild(arg_1_0.viewGO, "root/switch")

	gohelper.setActive(arg_1_0.addGO, false)
	gohelper.setActive(arg_1_0.switch, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
	arg_2_0:com_registFightEvent(FightEvent.PowerChange, arg_2_0.onPowerChange)
end

function var_0_0.onClick(arg_3_0)
	if not arg_3_0.config then
		return
	end

	local var_3_0 = recthelper.uiPosToScreenPos(arg_3_0.viewGO.transform)

	FightCommonTipController.instance:openCommonView("", arg_3_0.config.bossDesc, var_3_0, nil, nil, -600)
end

function var_0_0.onPowerChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not arg_4_0.config then
		return
	end

	if arg_4_2 ~= FightEnum.PowerType.Act191Boss then
		return
	end

	if arg_4_1 ~= arg_4_0.entityData.id then
		return
	end

	arg_4_0:refreshUI(arg_4_4 - arg_4_3)
end

function var_0_0.onConstructor(arg_5_0, arg_5_1)
	arg_5_0.entityData = arg_5_1
	arg_5_0.powerData = arg_5_0.entityData:getPowerInfo(FightEnum.PowerType.Act191Boss)
end

function var_0_0.onOpen(arg_6_0)
	transformhelper.setLocalScale(arg_6_0.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchor(arg_6_0.viewGO.transform, 54, -90)

	local var_6_0 = lua_activity191_assist_boss.configList

	arg_6_0.config = nil

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1.skinId == arg_6_0.entityData.skin then
			arg_6_0.config = iter_6_1

			break
		end
	end

	if not arg_6_0.config then
		arg_6_0:closeThis()

		return
	end

	gohelper.setActive(arg_6_0.style1, arg_6_0.config.uiForm == 1)
	gohelper.setActive(arg_6_0.style2, arg_6_0.config.uiForm == 2)
	gohelper.setActive(arg_6_0.style3, arg_6_0.config.uiForm == 3)

	arg_6_0.addText.text = ""

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	arg_7_0.energyText.text = GameUtil.getSubPlaceholderLuaLangTwoParam("▩1%s/▩2%s", arg_7_0.powerData.num, arg_7_0.powerData.max)

	if arg_7_1 then
		gohelper.setActive(arg_7_0.addGO, true)

		local var_7_0 = arg_7_1 > 0 and "+" or ""

		arg_7_0.addText.text = var_7_0 .. arg_7_1

		arg_7_0:com_registSingleTimer(arg_7_0.hideAddNum, 1)

		if arg_7_1 < 0 then
			gohelper.setActive(arg_7_0.switch, true)
			arg_7_0:com_registSingleTimer(arg_7_0.hideSwitch, 2)
			AudioMgr.instance:trigger(411000019)
		else
			AudioMgr.instance:trigger(411000018)
		end
	end

	local var_7_1 = arg_7_0.powerData.num >= arg_7_0.powerData.max

	gohelper.setActive(arg_7_0.max1, var_7_1)
	gohelper.setActive(arg_7_0.max2, var_7_1)
	gohelper.setActive(arg_7_0.max3, var_7_1)
end

function var_0_0.hideSwitch(arg_8_0)
	gohelper.setActive(arg_8_0.switch, false)
end

function var_0_0.hideAddNum(arg_9_0)
	gohelper.setActive(arg_9_0.addGO, false)
end

return var_0_0
