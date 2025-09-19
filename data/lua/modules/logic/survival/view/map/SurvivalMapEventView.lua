module("modules.logic.survival.view.map.SurvivalMapEventView", package.seeall)

local var_0_0 = class("SurvivalMapEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_list")
	arg_1_0._eventItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_list/#go_item")
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Title/#txt_Title")
	arg_1_0._btnNpc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Title/#txt_Title/#btn_npc")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#scroll/viewport/content/#txt_Descr")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns")
	arg_1_0._gobtnitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_btn")
	arg_1_0._gopos1 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos2/#go_pos1")
	arg_1_0._gopos2 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos2")
	arg_1_0._gopos3 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos4/#go_pos3")
	arg_1_0._gopos4 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos4")
	arg_1_0._imageModel = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#image_model")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_info")
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clicknext")
	arg_1_0._goitemRoot = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward/Viewport/Content/#go_rewarditem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.nextStep, arg_2_0)
	arg_2_0._btnNpc:AddClickListener(arg_2_0.showNpcInfo, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, arg_2_0._onUnitDel, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEventViewSelectChange, arg_2_0.onEventSelectChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnNpc:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, arg_3_0._onUnitDel, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEventViewSelectChange, arg_3_0.onEventSelectChange, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = true

	if not arg_4_0._infoPanel then
		local var_4_1 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
		local var_4_2 = arg_4_0:getResInst(var_4_1, arg_4_0._goinfo)

		arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagInfoPart)

		arg_4_0._infoPanel:updateMo()
		arg_4_0._infoPanel:setCloseShow(true)
		gohelper.setActive(arg_4_0._goitemRoot, false)
		gohelper.setActive(arg_4_0._gobtnitem, true)

		arg_4_0._btns = {}

		for iter_4_0 = 1, 4 do
			local var_4_3 = gohelper.clone(arg_4_0._gobtnitem, arg_4_0["_gopos" .. iter_4_0])

			gohelper.setAsFirstSibling(var_4_3)

			arg_4_0._btns[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, SurvivalEventChoiceItem)
		end

		gohelper.setActive(arg_4_0._gobtnitem, false)
		arg_4_0:initCamera()
	else
		var_4_0 = false
	end

	SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(false)
	arg_4_0:_refreshView()

	if var_4_0 and arg_4_0._panelUnitMo then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_refreshView()
end

function var_0_0._refreshView(arg_6_0)
	if arg_6_0.viewParam.panel then
		arg_6_0._curMo = nil

		gohelper.setActive(arg_6_0._golist, false)
		arg_6_0:updateChoiceByServer()
	else
		gohelper.setActive(arg_6_0._golist, true)
		gohelper.setActive(arg_6_0._click, false)
		gohelper.setActive(arg_6_0._gobtn, true)
		gohelper.setActive(arg_6_0._goitemRoot, false)
		gohelper.CreateObjList(arg_6_0, arg_6_0._createEventItem, arg_6_0.viewParam.allUnitMo, nil, arg_6_0._eventItem, SurvivalEventViewItem)
		arg_6_0:onEventSelectChange(1)
	end
end

function var_0_0._createEventItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1:initData(arg_7_2, arg_7_3)
end

function var_0_0.onEventSelectChange(arg_8_0, arg_8_1)
	if arg_8_0._curMo and arg_8_0._curMo ~= arg_8_0.viewParam.allUnitMo[arg_8_1] then
		arg_8_0._curMo = arg_8_0.viewParam.allUnitMo[arg_8_1]
		arg_8_0._anim.enabled = true

		arg_8_0._anim:Play("switch", 0, 0)
		UIBlockHelper.instance:startBlock("SurvivalMapEventView_onEventSelectChange", 0.167)
		TaskDispatcher.runDelay(arg_8_0.refreshView, arg_8_0, 0.167)
	else
		arg_8_0._curMo = arg_8_0.viewParam.allUnitMo[arg_8_1]

		arg_8_0:refreshView()
	end
end

function var_0_0._onUnitDel(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_0.viewParam.panel then
		var_9_0 = arg_9_0.viewParam.panel.unitId
	else
		var_9_0 = arg_9_0._curMo.id
	end

	if var_9_0 == arg_9_1.id then
		arg_9_0:closeThis()
	end
end

function var_0_0.refreshView(arg_10_0)
	if arg_10_0._curMo and arg_10_0._curMo.co then
		arg_10_0:setUnitMo(arg_10_0._curMo)

		arg_10_0._txtTitle.text = arg_10_0._curMo.co.name
		arg_10_0._txtDesc.text = arg_10_0._curMo.co.desc

		local var_10_0 = (arg_10_0["getChoiceData" .. SurvivalEnum.UnitTypeToName[arg_10_0._curMo.unitType]] or arg_10_0.getChoiceDataDefault)(arg_10_0)

		arg_10_0:setBtnDatas(var_10_0)

		if arg_10_0._curMo.unitType == SurvivalEnum.UnitType.Search then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_1)
		else
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
		end
	end
end

function var_0_0.getChoiceDataSearch(arg_11_0)
	local var_11_0 = arg_11_0._curMo.extraParam == "true"
	local var_11_1 = arg_11_0:getChoiceDataDefault()

	if var_11_1[1] then
		if var_11_0 then
			var_11_1[1].conditionStr = nil
			var_11_1[1].resultStr = nil
		end

		var_11_1[1].icon = SurvivalEnum.EventChoiceIcon.Search

		var_11_1[1]:refreshData()
	end

	return var_11_1
end

function var_0_0.getChoiceDataDefault(arg_12_0)
	local var_12_0 = {}

	if not string.nilorempty(arg_12_0._curMo.co.choiceText) then
		local var_12_1 = string.split(arg_12_0._curMo.co.choiceText, "#")
		local var_12_2 = string.splitToNumber(arg_12_0._curMo.co.consume, "#") or {}
		local var_12_3 = var_12_2[1] and var_12_2[1] > 0
		local var_12_4
		local var_12_5

		if var_12_3 then
			var_12_5 = "CostGameTime|" .. var_12_2[1]
		end

		var_12_0[1] = SurvivalChoiceMo.Create({
			callback = arg_12_0.onClickOption,
			callobj = arg_12_0,
			desc = var_12_1[1],
			conditionStr = var_12_4,
			resultStr = var_12_5
		})
		var_12_0[2] = SurvivalChoiceMo.Create({
			callback = arg_12_0.closeThis,
			callobj = arg_12_0,
			desc = var_12_1[2]
		})
	end

	return var_12_0
end

function var_0_0.setBtnDatas(arg_13_0, arg_13_1)
	for iter_13_0 = 1, 4 do
		arg_13_0._btns[iter_13_0]:updateData(arg_13_1[iter_13_0])
	end
end

function var_0_0.onClickOption(arg_14_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.TriggerEvent, tostring(arg_14_0._curMo.id))
	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", arg_14_0._curMo.id, 1, 0)
end

function var_0_0.updateChoiceByServer(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.viewParam.panel
	local var_15_1 = SurvivalMapModel.instance:getSceneMo()
	local var_15_2 = var_15_0.unitId
	local var_15_3 = var_15_1.unitsById[var_15_2]

	arg_15_0._panelUnitMo = var_15_3

	if not var_15_3 then
		logError("元件数据不存在" .. tostring(var_15_2))

		return
	end

	local var_15_4 = var_15_0.dialogueId
	local var_15_5 = lua_survival_talk.configDict[var_15_4]

	if not var_15_5 then
		logError("对话不存在" .. tostring(var_15_4))

		return
	end

	arg_15_0:setUnitMo(var_15_3)

	arg_15_0._stepList = {}
	arg_15_0._curDescIndex = 0
	arg_15_0._curStepCo = nil

	if arg_15_1 then
		local var_15_6 = var_15_5[#var_15_5]

		table.insert(arg_15_0._stepList, {
			descArr = GameUtil.getUCharArrWithoutRichTxt(var_15_6.content),
			animType = var_15_6.animType
		})
	else
		for iter_15_0, iter_15_1 in ipairs(var_15_5) do
			table.insert(arg_15_0._stepList, {
				descArr = GameUtil.getUCharArrWithoutRichTxt(iter_15_1.content),
				animType = iter_15_1.animType
			})
		end
	end

	arg_15_0._txtTitle.text = var_15_3.co.name
	arg_15_0._txtDesc.text = ""

	local var_15_7 = {}

	for iter_15_2, iter_15_3 in ipairs(var_15_0.param) do
		local var_15_8 = string.split(iter_15_3, "|") or {}
		local var_15_9 = tonumber(var_15_8[1]) or 0
		local var_15_10 = var_15_8[2] and table.concat(var_15_8, "|", 2) or ""
		local var_15_11 = lua_survival_tree_desc.configDict[var_15_0.treeId][var_15_9]
		local var_15_12 = var_15_11 and var_15_11.desc

		var_15_7[iter_15_2] = SurvivalChoiceMo.Create({
			callback = arg_15_0.onClickServerChoice,
			callobj = arg_15_0,
			desc = var_15_12,
			param = var_15_9,
			icon = var_15_11.icon,
			conditionStr = var_15_11.condition,
			resultStr = var_15_11.result,
			unitId = var_15_2,
			treeId = var_15_0.treeId,
			otherParam = var_15_10
		})

		if var_15_7[iter_15_2].isShowBogusBtn then
			var_15_7[iter_15_2].callback = arg_15_0.onClickBogusBtn
			var_15_7[iter_15_2].exStr_bogus = var_15_7[iter_15_2].exStr
			var_15_7[iter_15_2].isValid_bogus = var_15_7[iter_15_2].isValid
			var_15_7[iter_15_2].exStr = nil
			var_15_7[iter_15_2].isValid = true
		elseif var_15_7[iter_15_2].exStepDesc then
			local var_15_13 = arg_15_0._stepList[#arg_15_0._stepList]

			if var_15_13 then
				table.insert(var_15_13.descArr, "\n")
				tabletool.addValues(var_15_13.descArr, GameUtil.getUCharArrWithoutRichTxt(var_15_7[iter_15_2].exStepDesc))

				var_15_13.items = var_15_7[iter_15_2].exShowItemMos
			else
				table.insert(arg_15_0._stepList, {
					descArr = GameUtil.getUCharArrWithoutRichTxt(var_15_7[iter_15_2].exStepDesc),
					items = var_15_7[iter_15_2].exShowItemMos
				})
			end
		end
	end

	gohelper.setActive(arg_15_0._gobtn, false)
	arg_15_0:setBtnDatas(var_15_7)
	arg_15_0:nextStep()
end

function var_0_0.nextStep(arg_16_0)
	if not arg_16_0._stepList then
		return
	end

	if arg_16_0._curStepCo then
		arg_16_0:finishStep()

		return
	end

	gohelper.setActive(arg_16_0._click, true)

	arg_16_0._curStepCo = table.remove(arg_16_0._stepList, 1)

	if arg_16_0._curStepCo then
		gohelper.setActive(arg_16_0._goitemRoot, false)

		arg_16_0._curDescIndex = 0

		TaskDispatcher.runRepeat(arg_16_0._autoShowDesc, arg_16_0, 0.02)
	else
		gohelper.setActive(arg_16_0._click, false)
		gohelper.setActive(arg_16_0._gobtn, true)
	end

	local var_16_0 = arg_16_0._curStepCo and arg_16_0._curStepCo.animType or 0

	if arg_16_0._curHeroPath then
		if var_16_0 == 0 then
			arg_16_0._modelComp:playAnim(arg_16_0._curHeroPath, "idle")
		elseif var_16_0 == 1 then
			arg_16_0._modelComp:playAnim(arg_16_0._curHeroPath, "jump")
		elseif var_16_0 == 2 then
			arg_16_0._modelComp:playAnim(arg_16_0._curHeroPath, "jump2")
		end
	end
end

function var_0_0._autoShowDesc(arg_17_0)
	if not arg_17_0._curStepCo then
		return
	end

	arg_17_0._curDescIndex = arg_17_0._curDescIndex + 1
	arg_17_0._txtDesc.text = table.concat(arg_17_0._curStepCo.descArr, "", 1, arg_17_0._curDescIndex)

	if arg_17_0._curDescIndex >= #arg_17_0._curStepCo.descArr then
		arg_17_0:finishStep()
	end
end

function var_0_0.finishStep(arg_18_0)
	arg_18_0._txtDesc.text = table.concat(arg_18_0._curStepCo.descArr, "")

	TaskDispatcher.cancelTask(arg_18_0._autoShowDesc, arg_18_0)

	if not arg_18_0._stepList[1] then
		gohelper.setActive(arg_18_0._click, false)
		gohelper.setActive(arg_18_0._gobtn, true)
	end

	if arg_18_0._curStepCo.items then
		gohelper.setActive(arg_18_0._goitemRoot, true)
		gohelper.CreateObjList(arg_18_0, arg_18_0._createItem, arg_18_0._curStepCo.items, nil, arg_18_0._goitem)
	else
		gohelper.setActive(arg_18_0._goitemRoot, false)
	end

	arg_18_0._curStepCo = nil
end

function var_0_0._createItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChild(arg_19_1, "go_icon/inst")
	local var_19_1 = gohelper.findChildTextMesh(arg_19_1, "#txt_Num")
	local var_19_2 = gohelper.findChild(arg_19_1, "#go_gray")
	local var_19_3

	if not var_19_0 then
		local var_19_4 = arg_19_0.viewContainer:getSetting().otherRes.itemRes

		var_19_0 = arg_19_0:getResInst(var_19_4, gohelper.findChild(arg_19_1, "go_icon"), "inst")
		var_19_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_0, SurvivalBagItem)
	else
		var_19_3 = MonoHelper.getLuaComFromGo(var_19_0, SurvivalBagItem)
	end

	var_19_3:updateMo(arg_19_2)
	var_19_3:setShowNum(false)
	var_19_3:setClickCallback(arg_19_0._onClickItem, arg_19_0)

	local var_19_5 = SurvivalMapModel.instance:getSceneMo().bag:getItemCountPlus(arg_19_2.id)

	gohelper.setActive(var_19_2, var_19_5 < arg_19_2.count)

	local var_19_6 = arg_19_0:numberDisplay(var_19_5)

	if var_19_5 >= arg_19_2.count then
		var_19_1.text = var_19_6 .. "/" .. arg_19_2.count
	else
		var_19_1.text = "<color=#D74242>" .. var_19_6 .. "</color>/" .. arg_19_2.count
	end
end

function var_0_0.numberDisplay(arg_20_0, arg_20_1)
	local var_20_0 = tonumber(arg_20_1)

	if var_20_0 >= 1000000 then
		return math.floor(var_20_0 / 100000) / 10 .. "M"
	elseif var_20_0 >= 1000 then
		return math.floor(var_20_0 / 100) / 10 .. "K"
	else
		return var_20_0
	end
end

function var_0_0._onClickItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1._mo:clone()

	var_21_0.count = 1

	arg_21_0._infoPanel:updateMo(var_21_0)
end

function var_0_0.showNpcInfo(arg_22_0)
	arg_22_0._infoPanel:updateMo(arg_22_0._npcItemMo)
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._autoShowDesc, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshView, arg_23_0)
end

function var_0_0.onCloseFinish(arg_24_0)
	SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(true)
end

function var_0_0.onClickServerChoice(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 and arg_25_2.npcWorthCheck then
		ViewMgr.instance:openView(ViewName.SurvivalCommitItemView, arg_25_2)

		return
	end

	if arg_25_2 and arg_25_2.openFogRange then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTreeOpenFog, arg_25_2)
		arg_25_0:closeThis()

		return
	end

	if SurvivalMapHelper.instance:isInFlow() then
		return
	end

	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", arg_25_2.unitId, arg_25_1, arg_25_2.treeId)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, tostring(arg_25_1))
end

function var_0_0.onClickBogusBtn(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._stepList = {}
	arg_26_0._curDescIndex = 0
	arg_26_0._curStepCo = nil
	arg_26_0._txtDesc.text = ""

	local var_26_0 = {
		arg_26_2
	}

	if arg_26_2.exBogusData then
		arg_26_2.exStr_bogus = arg_26_2.exBogusData.exStr
		arg_26_2.isValid_bogus = arg_26_2.exBogusData.isValid
		arg_26_2.exShowItemMos_bogus = arg_26_2.exBogusData.exShowItemMos
		arg_26_2.exStepDesc_bogus = arg_26_2.exBogusData.exStepDesc
		arg_26_2.exBogusData = nil
		arg_26_2.useExBogusData = true
	else
		arg_26_2.exStr = arg_26_2.exStr_bogus
		arg_26_2.isValid = arg_26_2.isValid_bogus

		if arg_26_2.useExBogusData then
			arg_26_2.exShowItemMos = arg_26_2.exShowItemMos_bogus
			arg_26_2.exStepDesc = arg_26_2.exStepDesc_bogus
			arg_26_2.useExBogusData = nil
		end

		arg_26_2.callback = arg_26_0.onClickServerChoice
	end

	var_26_0[2] = SurvivalChoiceMo.Create({
		param = true,
		callback = arg_26_0.updateChoiceByServer,
		callobj = arg_26_0,
		desc = luaLang("survival_eventview_leave"),
		icon = SurvivalEnum.EventChoiceIcon.Return
	})

	table.insert(arg_26_0._stepList, {
		descArr = GameUtil.getUCharArrWithoutRichTxt(arg_26_2.exStepDesc),
		items = arg_26_2.exShowItemMos
	})
	gohelper.setActive(arg_26_0._gobtn, false)
	arg_26_0:setBtnDatas(var_26_0)
	arg_26_0:nextStep()
end

function var_0_0.initCamera(arg_27_0)
	arg_27_0._modelComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_27_0._imageModel, Survival3DModelComp, {
		xOffset = 8000
	})

	local var_27_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)

	arg_27_0._allResGo = arg_27_0:getUserDataTb_()
	arg_27_0._allResGo["node1/role"] = arg_27_0._modelComp:addModel("node1/role", var_27_0)
	arg_27_0._allResGo["node2/role"] = arg_27_0._modelComp:addModel("node2/role", var_27_0)

	arg_27_0:hideOtherModel()
end

function var_0_0.hideOtherModel(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0._allResGo) do
		gohelper.setActive(iter_28_1, iter_28_0 == arg_28_0._curHeroPath or iter_28_0 == arg_28_0._curUnitPath)
	end
end

function var_0_0.setUnitMo(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._btnNpc, arg_29_1.unitType == SurvivalEnum.UnitType.NPC)

	if arg_29_1.unitType == SurvivalEnum.UnitType.NPC then
		arg_29_0._npcItemMo = SurvivalBagItemMo.New()

		local var_29_0 = SurvivalConfig.instance.npcIdToItemCo[arg_29_1.cfgId]

		arg_29_0._npcItemMo:init({
			count = 1,
			id = var_29_0 and var_29_0.id or 0
		})
	end

	local var_29_1 = arg_29_1:getResPath()
	local var_29_2 = arg_29_1.unitType == SurvivalEnum.UnitType.Search

	arg_29_0._curHeroPath = nil
	arg_29_0._curUnitPath = nil

	if string.find(var_29_1, "^survival/buiding") then
		if arg_29_1.co.camera == 2 then
			arg_29_0._curUnitPath = "node4/buiding3"
		elseif arg_29_1.co.camera == 3 then
			arg_29_0._curUnitPath = "node5/buiding4"
		elseif next(arg_29_1.exPoints) or arg_29_1.co.camera == 1 then
			arg_29_0._curUnitPath = "node3/buiding2"
		else
			arg_29_0._curUnitPath = "node2/buiding1"
			arg_29_0._curHeroPath = "node2/role"
		end
	else
		arg_29_0._curHeroPath = "node1/role"
		arg_29_0._curUnitPath = "node1/npc"
	end

	if arg_29_0._curUnitPath then
		arg_29_0._allResGo[arg_29_0._curUnitPath] = arg_29_0._modelComp:addModel(arg_29_0._curUnitPath, var_29_1)
	end

	if arg_29_0._curUnitPath then
		arg_29_0._allResGo[arg_29_0._curUnitPath] = arg_29_0._modelComp:addModel(arg_29_0._curUnitPath, var_29_1)
	end

	if arg_29_0._curHeroPath then
		arg_29_0._modelComp:setModelPathActive(arg_29_0._curHeroPath, "#go_effect", var_29_2)
		arg_29_0._modelComp:playAnim(arg_29_0._curHeroPath, var_29_2 and "search" or "idle")
	end

	arg_29_0:hideOtherModel()
end

return var_0_0
