module("modules.logic.fight.view.assistboss.FightAssistBoss5", package.seeall)

local var_0_0 = class("FightAssistBoss5", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss5.prefab"
end

var_0_0.State = {
	Clicked = 3,
	CantClick = 1,
	CanClick = 2,
	SuZhen = 4
}
var_0_0.MaxPower = 5

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)

	arg_2_0.pointList = {}

	for iter_2_0 = 1, var_0_0.MaxPower do
		arg_2_0:createPointItem(iter_2_0)
	end

	arg_2_0.goBgLevel1 = gohelper.findChild(arg_2_0.viewGo, "head/bg/level1")
	arg_2_0.goBgLevel2 = gohelper.findChild(arg_2_0.viewGo, "head/bg/level2")
	arg_2_0.goBgLevel3 = gohelper.findChild(arg_2_0.viewGo, "head/bg/level3")
	arg_2_0.goEffectLevel2 = gohelper.findChild(arg_2_0.viewGo, "head/level2_eff")
	arg_2_0.goEffectLevel3 = gohelper.findChild(arg_2_0.viewGo, "head/level3_eff")
end

function var_0_0.addEvents(arg_3_0)
	var_0_0.super.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PowerMaxChange, arg_3_0.onPowerMaxChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, arg_3_0.refreshPower, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, arg_3_0.refreshPower, arg_3_0)
end

function var_0_0.onPowerMaxChange(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = FightDataHelper.entityMgr:getAssistBoss()

	if not var_4_0 then
		return
	end

	if var_4_0.uid ~= arg_4_1 then
		return
	end

	if arg_4_2 ~= FightEnum.PowerType.AssistBoss then
		return
	end

	arg_4_0:refreshPower()
end

function var_0_0.createPointItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getUserDataTb_()
	local var_5_1 = gohelper.findChild(arg_5_0.viewGo, "head/point" .. arg_5_1)

	var_5_0.go = var_5_1
	var_5_0.goEnergy1 = gohelper.findChild(var_5_1, "energy1")
	var_5_0.goEnergy2 = gohelper.findChild(var_5_1, "energy2")
	var_5_0.goEnergy1Full = gohelper.findChild(var_5_0.goEnergy1, "dark")
	var_5_0.goEnergy1Light = gohelper.findChild(var_5_0.goEnergy1, "light")
	var_5_0.goEnergy2Full = gohelper.findChild(var_5_0.goEnergy2, "light")

	table.insert(arg_5_0.pointList, var_5_0)

	return var_5_0
end

function var_0_0.refreshPower(arg_6_0)
	arg_6_0:initRefreshFunc()

	local var_6_0 = arg_6_0:getCurState()

	arg_6_0:refreshBg(var_6_0)
	arg_6_0:refreshEffect(var_6_0)
	arg_6_0:refreshPointActive()

	local var_6_1 = arg_6_0.refreshFuncDict[var_6_0]

	if var_6_1 then
		var_6_1(arg_6_0)
	end

	arg_6_0:refreshHeadImageColor()
end

function var_0_0.initRefreshFunc(arg_7_0)
	if not arg_7_0.refreshFuncDict then
		arg_7_0.refreshFuncDict = {
			[var_0_0.State.CantClick] = arg_7_0.refreshCantClickUI,
			[var_0_0.State.CanClick] = arg_7_0.refreshCanClickUI,
			[var_0_0.State.Clicked] = arg_7_0.refreshClickedUI,
			[var_0_0.State.SuZhen] = arg_7_0.refreshSuZhenUI
		}
	end
end

function var_0_0.getCurState(arg_8_0)
	local var_8_0 = FightModel.instance:getMagicCircleInfo()

	if var_8_0 and var_8_0.magicCircleId == 1251001 then
		return var_0_0.State.SuZhen
	end

	local var_8_1 = FightDataHelper.paTaMgr:getUseCardCount()

	if var_8_1 and var_8_1 > 0 then
		return var_0_0.State.Clicked
	end

	local var_8_2 = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not var_8_2 then
		return var_0_0.State.CantClick
	end

	if FightDataHelper.paTaMgr:getNeedPower(var_8_2) <= FightDataHelper.paTaMgr:getAssistBossPower() then
		return var_0_0.State.CanClick
	end

	return var_0_0.State.CantClick
end

function var_0_0.refreshBg(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.goBgLevel1, arg_9_1 == var_0_0.State.CantClick)
	gohelper.setActive(arg_9_0.goBgLevel2, arg_9_1 == var_0_0.State.CanClick or arg_9_1 == var_0_0.State.Clicked)
	gohelper.setActive(arg_9_0.goBgLevel3, arg_9_1 == var_0_0.State.SuZhen)
end

function var_0_0.refreshEffect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.goEffectLevel2, arg_10_1 == var_0_0.State.CanClick or arg_10_1 == var_0_0.State.Clicked)
	gohelper.setActive(arg_10_0.goEffectLevel3, arg_10_1 == var_0_0.State.SuZhen)
end

function var_0_0.refreshPointActive(arg_11_0)
	local var_11_0, var_11_1 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local var_11_2 = math.min(var_0_0.MaxPower, var_11_1)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.pointList) do
		gohelper.setActive(iter_11_1.go, iter_11_0 <= var_11_2)
	end
end

function var_0_0.refreshCantClickUI(arg_12_0)
	local var_12_0 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.pointList) do
		gohelper.setActive(iter_12_1.goEnergy1, true)
		gohelper.setActive(iter_12_1.goEnergy2, false)
		gohelper.setActive(iter_12_1.goEnergy1Light, false)
		gohelper.setActive(iter_12_1.goEnergy1Full, iter_12_0 <= var_12_0)
	end
end

function var_0_0.refreshCanClickUI(arg_13_0)
	local var_13_0 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.pointList) do
		gohelper.setActive(iter_13_1.goEnergy1, true)
		gohelper.setActive(iter_13_1.goEnergy2, false)
		gohelper.setActive(iter_13_1.goEnergy1Light, false)
		gohelper.setActive(iter_13_1.goEnergy1Full, iter_13_0 <= var_13_0)
	end
end

function var_0_0.refreshClickedUI(arg_14_0)
	local var_14_0 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.pointList) do
		gohelper.setActive(iter_14_1.goEnergy1, true)
		gohelper.setActive(iter_14_1.goEnergy2, false)
		gohelper.setActive(iter_14_1.goEnergy1Light, iter_14_0 <= var_14_0)
		gohelper.setActive(iter_14_1.goEnergy1Full, iter_14_0 <= var_14_0)
	end
end

function var_0_0.refreshSuZhenUI(arg_15_0)
	local var_15_0 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.pointList) do
		gohelper.setActive(iter_15_1.goEnergy1, false)
		gohelper.setActive(iter_15_1.goEnergy2, true)
		gohelper.setActive(iter_15_1.goEnergy2Full, iter_15_0 <= var_15_0)
	end
end

function var_0_0.refreshCD(arg_16_0)
	if arg_16_0:getCurState() == var_0_0.State.SuZhen then
		gohelper.setActive(arg_16_0.goCD, false)
		arg_16_0:refreshHeadImageColor()

		return
	end

	var_0_0.super.refreshCD(arg_16_0)
end

function var_0_0.refreshHeadImageColor(arg_17_0)
	if arg_17_0:getCurState() == var_0_0.State.SuZhen then
		arg_17_0.headImage.color = Color.white

		return
	end

	var_0_0.super.refreshHeadImageColor(arg_17_0)
end

function var_0_0.refreshHeadImage(arg_18_0)
	arg_18_0.headSImage:LoadImage(ResUrl.monsterHeadIcon(6304101), arg_18_0.onImageLoaded, arg_18_0)
end

function var_0_0.onImageLoaded(arg_19_0)
	arg_19_0.headImage:SetNativeSize()
end

return var_0_0
