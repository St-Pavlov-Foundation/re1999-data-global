module("modules.logic.survival.view.map.SurvivalMapTreeOpenFogView", package.seeall)

local var_0_0 = class("SurvivalMapTreeOpenFogView", BaseView)
local var_0_1 = {
	"BottomRight",
	"Left",
	"Top",
	"Bottom",
	"#go_lefttop"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_usedTips")
	arg_1_0._txtTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_usedTips/#txt_usedTips")
	arg_1_0._allUIs = arg_1_0:getUserDataTb_()

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		arg_1_0._allUIs[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, iter_1_1)
	end
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTreeOpenFog, arg_2_0._onUseFog, arg_2_0)
	arg_2_0.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, arg_2_0._onSceneClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTreeOpenFog, arg_3_0._onUseFog, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, arg_3_0._onSceneClick, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, false)
end

function var_0_0._onUseFog(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0._choiceData = arg_5_1

	local var_5_0 = SurvivalMapModel.instance:getCurMapCo().walkables
	local var_5_1 = SurvivalMapModel.instance:getSceneMo().player.pos
	local var_5_2 = SurvivalHelper.instance:getAllPointsByDis(var_5_1, arg_5_1.openFogRange)

	for iter_5_0 = #var_5_2, 1, -1 do
		if var_5_2[iter_5_0] == var_5_1 or not SurvivalHelper.instance:getValueFromDict(var_5_0, var_5_2[iter_5_0]) then
			table.remove(var_5_2, iter_5_0)
		end
	end

	arg_5_0._allCanUsePoints = {}

	for iter_5_1, iter_5_2 in ipairs(var_5_2) do
		table.insert(arg_5_0._allCanUsePoints, iter_5_2:clone())
		SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-2, iter_5_2.q, iter_5_2.r, 2)
	end

	gohelper.setActive(arg_5_0._gotips, true)

	for iter_5_3, iter_5_4 in ipairs(arg_5_0._allUIs) do
		gohelper.setActive(iter_5_4, false)
	end

	arg_5_0.viewContainer:setCloseFunc(arg_5_0.cancelOpenFog, arg_5_0)
end

function var_0_0._onSceneClick(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._choiceData then
		return
	end

	arg_6_2.use = true

	if tabletool.indexOf(arg_6_0._allCanUsePoints, arg_6_1) then
		SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", arg_6_0._choiceData.unitId, arg_6_0._choiceData.param, arg_6_0._choiceData.treeId)
		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, string.format("%d#%d#%d", arg_6_0._choiceData.param, arg_6_1.q, arg_6_1.r))
		arg_6_0:clearData()
	else
		arg_6_0:cancelOpenFog()
	end
end

function var_0_0.clearData(arg_7_0)
	gohelper.setActive(arg_7_0._gotips, false)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-2)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._allUIs) do
		gohelper.setActive(iter_7_1, true)
	end

	arg_7_0.viewContainer:setCloseFunc()

	arg_7_0._choiceData = nil
end

function var_0_0.cancelOpenFog(arg_8_0)
	arg_8_0:clearData()

	local var_8_0 = SurvivalMapModel.instance:getSceneMo()

	SurvivalMapHelper.instance:tryShowServerPanel(var_8_0.panel)
end

return var_0_0
