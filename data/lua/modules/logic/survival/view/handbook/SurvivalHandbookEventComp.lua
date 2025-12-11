module("modules.logic.survival.view.handbook.SurvivalHandbookEventComp", package.seeall)

local var_0_0 = class("SurvivalHandbookEventComp", SurvivalHandbookViewComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentView = arg_1_1
	arg_1_0.handBookType = SurvivalEnum.HandBookType.Event
	arg_1_0.ui3DPool = {}
	arg_1_0.Shader = UnityEngine.Shader
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.scroll = gohelper.findChild(arg_2_1, "#scroll")
	arg_2_0.tabs = {}

	local var_2_0 = {
		"#btnTask",
		"#btnFight",
		"#btnSearch"
	}
	local var_2_1 = SurvivalEnum.HandBookEventSubType
	local var_2_2 = {
		var_2_1.Task,
		var_2_1.Fight,
		var_2_1.Search
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_3 = gohelper.findChildButtonWithAudio(arg_2_1, "tab/" .. iter_2_1)
		local var_2_4 = gohelper.findChild(var_2_3.gameObject, "#go_Selected")
		local var_2_5 = gohelper.findChild(var_2_3.gameObject, "#go_redDot")
		local var_2_6 = var_2_2[iter_2_0]
		local var_2_7 = arg_2_0:getUserDataTb_()

		var_2_7.btnClick = var_2_3
		var_2_7.go_selected = var_2_4
		var_2_7.go_redDot = var_2_5
		var_2_7.subType = var_2_6

		table.insert(arg_2_0.tabs, var_2_7)
		gohelper.setActive(var_2_4, false)
		RedDotController.instance:addRedDot(var_2_5, RedDotEnum.DotNode.SurvivalHandbookEvent, var_2_6)
	end

	local var_2_8 = arg_2_0._parentView.viewContainer:getSetting().otherRes.survivalhandbookeventitem

	arg_2_0._item = arg_2_0._parentView:getResInst(var_2_8, arg_2_0.go)

	gohelper.setActive(arg_2_0._item, false)

	arg_2_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.scroll, SurvivalSimpleListPart)

	arg_2_0._simpleList:setCellUpdateCallBack(arg_2_0.createItem, arg_2_0, SurvivalHandbookEventItem, arg_2_0._item)
	arg_2_0:loadRainShader()
	arg_2_0:loadLightGo()
	arg_2_0:loadFogGo()
end

function var_0_0.loadFogGo(arg_3_0)
	SurvivalSceneFogUtil.instance:loadFog(arg_3_0.go)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:selectTab(1, true)
end

function var_0_0.onClose(arg_5_0)
	arg_5_0:selectTab(nil)
end

function var_0_0.addEventListeners(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.tabs) do
		arg_6_0:addClickCb(iter_6_1.btnClick, arg_6_0.onClickTab, arg_6_0, iter_6_0)
	end
end

function var_0_0.removeEventListeners(arg_7_0)
	return
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayDestroyFog, arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.ui3DPool) do
		UI3DRenderController.instance:removeSurvivalUI3DRender(iter_8_1)
	end

	tabletool.clear(arg_8_0.ui3DPool)

	if arg_8_0.keyWord then
		arg_8_0.Shader.DisableKeyword(arg_8_0.keyWord)
	end

	if arg_8_0._lightLoader then
		arg_8_0._lightLoader:dispose()

		arg_8_0._lightLoader = nil
	end

	SurvivalSceneAmbientUtil.instance:disable()
	SurvivalSceneFogUtil.instance:unLoadFog()

	if arg_8_0._instGO then
		gohelper.destroy(arg_8_0._instGO)

		arg_8_0._instGO = nil
	end
end

function var_0_0.onClickTab(arg_9_0, arg_9_1)
	arg_9_0:selectTab(arg_9_1)
end

function var_0_0.createItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:setSurvivalHandbookEventComp(arg_10_0)
	arg_10_1:updateMo(arg_10_2)
end

function var_0_0.refreshList(arg_11_0, arg_11_1)
	if arg_11_0.curSelect == nil then
		arg_11_0._simpleList:setList({})

		return
	end

	local var_11_0 = SurvivalHandbookModel.instance:getHandBookDatas(arg_11_0.handBookType, arg_11_0.tabs[arg_11_0.curSelect].subType)

	table.sort(var_11_0, SurvivalHandbookModel.instance.handBookSortFuncById)

	if arg_11_1 then
		arg_11_0._simpleList:setOpenAnimation(0.03)
	end

	arg_11_0._simpleList:setList(var_11_0)
end

function var_0_0.selectTab(arg_12_0, arg_12_1, arg_12_2)
	if (not arg_12_1 or not arg_12_0.curSelect or arg_12_0.curSelect ~= arg_12_1) and (not not arg_12_1 or not not arg_12_0.curSelect) then
		if arg_12_0.curSelect then
			gohelper.setActive(arg_12_0.tabs[arg_12_0.curSelect].go_selected, false)
		end

		arg_12_0.curSelect = arg_12_1

		if arg_12_0.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(arg_12_0.handBookType, arg_12_0.tabs[arg_12_0.curSelect].subType)
			gohelper.setActive(arg_12_0.tabs[arg_12_0.curSelect].go_selected, true)
		end

		arg_12_0:refreshList(arg_12_2)
	end
end

function var_0_0.popSurvivalUI3DRender(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1 = #arg_13_0.ui3DPool

	if var_13_1 <= 0 then
		var_13_0 = UI3DRenderController.instance:getSurvivalUI3DRender(arg_13_1, arg_13_2)
	else
		var_13_0 = arg_13_0.ui3DPool[var_13_1]
		arg_13_0.ui3DPool[var_13_1] = nil
	end

	return var_13_0
end

function var_0_0.pushSurvivalUI3DRender(arg_14_0, arg_14_1)
	table.insert(arg_14_0.ui3DPool, arg_14_1)
end

function var_0_0.loadRainShader(arg_15_0)
	local var_15_0 = SurvivalModel.instance:getOutSideInfo()
	local var_15_1 = SurvivalShelterModel.instance:getWeekInfo()

	if var_15_0.inWeek and var_15_1 then
		arg_15_0.keyWord = SurvivalRainParam[var_15_1.rainType].KeyWord
	else
		arg_15_0.keyWord = SurvivalRainParam[SurvivalEnum.RainType.Rain1].KeyWord
	end

	arg_15_0.Shader.EnableKeyword(arg_15_0.keyWord)
end

function var_0_0.getLightName(arg_16_0)
	return "light3"
end

function var_0_0.loadLightGo(arg_17_0)
	local var_17_0 = arg_17_0:getLightName()

	if not var_17_0 then
		return
	end

	local var_17_1 = "survival/common/light/" .. var_17_0 .. ".prefab"

	if not arg_17_0._lightLoader then
		local var_17_2 = gohelper.create3d(arg_17_0.go, "Light")

		arg_17_0._lightLoader = PrefabInstantiate.Create(var_17_2)
	end

	arg_17_0._lightLoader:dispose()
	arg_17_0._lightLoader:startLoad(var_17_1, arg_17_0._onLightLoaded, arg_17_0)
end

function var_0_0._onLightLoaded(arg_18_0)
	SurvivalSceneAmbientUtil.instance:_onLightLoaded(arg_18_0._lightLoader:getInstGO(), true)
end

return var_0_0
