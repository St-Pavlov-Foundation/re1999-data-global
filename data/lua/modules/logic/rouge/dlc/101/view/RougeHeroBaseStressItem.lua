module("modules.logic.rouge.dlc.101.view.RougeHeroBaseStressItem", package.seeall)

local var_0_0 = class("RougeHeroBaseStressItem", LuaCompBase)

var_0_0.AssetUrl = RougeDLCEnum101.StressPrefabPath

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.gostress = arg_1_1
	arg_1_0.blueText = gohelper.findChildText(arg_1_1, "#txt_stress")
	arg_1_0.goBlue = gohelper.findChild(arg_1_1, "blue")
	arg_1_0.goRed = gohelper.findChild(arg_1_1, "red")

	local var_1_0 = gohelper.findChild(arg_1_1, "broken")
	local var_1_1 = gohelper.findChild(arg_1_1, "staunch")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, false)

	arg_1_0.status2GoDict = arg_1_0:getUserDataTb_()
	arg_1_0.status2GoDict[FightEnum.Status.Positive] = arg_1_0.goBlue
	arg_1_0.status2GoDict[FightEnum.Status.Negative] = arg_1_0.goRed
end

function var_0_0.onUpdateDLC(arg_2_0, arg_2_1)
	arg_2_0:refreshUI(arg_2_1)
end

function var_0_0.refreshUI(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getCurStress(arg_3_1)

	gohelper.setActive(arg_3_0.gostress, arg_3_1 ~= nil and var_3_0 ~= nil)

	if not var_3_0 then
		return
	end

	arg_3_0.blueText.text = var_3_0
	arg_3_0.status = FightHelper.getStressStatus(var_3_0)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.status2GoDict) do
		gohelper.setActive(iter_3_1, iter_3_0 == arg_3_0.status)
	end
end

function var_0_0.getCurStress(arg_4_0, arg_4_1)
	local var_4_0 = RougeModel.instance:getTeamInfo():getHeroInfo(arg_4_1 and arg_4_1.heroId)

	if not var_4_0 then
		return
	end

	return (var_4_0:getStressValue())
end

return var_0_0
