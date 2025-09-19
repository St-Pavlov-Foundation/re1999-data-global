module("modules.logic.survival.view.shelter.ShelterMapEventView", package.seeall)

local var_0_0 = class("ShelterMapEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_list")
	arg_1_0._eventItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_list/#go_item")

	gohelper.setActive(arg_1_0._eventItem, false)

	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Title/#txt_Title")
	arg_1_0._btnNpc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Title/#txt_Title/#btn_npc")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#scroll/viewport/content/#txt_Descr")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns")
	arg_1_0._gobtnitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_btn")

	gohelper.setActive(arg_1_0._gobtnitem, false)

	arg_1_0._gopos1 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos2/#go_pos1")
	arg_1_0._gopos2 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos2")
	arg_1_0._gopos3 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos4/#go_pos3")
	arg_1_0._gopos4 = gohelper.findChild(arg_1_0.viewGO, "Panel/Btns/#go_pos4")
	arg_1_0._imageModel = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#image_model")

	gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "Top"), false)

	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_info")
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clicknext")
	arg_1_0._goitemRoot = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward")

	gohelper.setActive(arg_1_0._goitemRoot, false)

	arg_1_0._btns = {}

	arg_1_0:initCamera()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.nextStep, arg_2_0)
	arg_2_0._btnNpc:AddClickListener(arg_2_0.showNpcInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnNpc:RemoveClickListener()
end

function var_0_0.showNpcInfo(arg_4_0)
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = arg_4_0.itemMo,
		goPanel = arg_4_0._goinfo
	})
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()

	local var_5_0 = GameSceneMgr.instance:getCurSceneType()

	if var_5_0 == SceneType.SurvivalShelter then
		SurvivalMapHelper.instance:getSceneFogComp():setRainEnable(false)
	elseif var_5_0 == SceneType.Survival then
		SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(false)
	end
end

function var_0_0.refreshParam(arg_6_0)
	arg_6_0.title = arg_6_0.viewParam.title
	arg_6_0.behaviorConfig = arg_6_0.viewParam.behaviorConfig
	arg_6_0.unitResPath = arg_6_0.viewParam.unitResPath
	arg_6_0.itemMo = arg_6_0.viewParam.itemMo
	arg_6_0.conditionParam = arg_6_0.viewParam.conditionParam
	arg_6_0.taskConfig = arg_6_0.viewParam.taskConfig
	arg_6_0.moduleId = arg_6_0.viewParam.moduleId

	if arg_6_0.taskConfig and arg_6_0.taskConfig.title then
		arg_6_0.title = arg_6_0.taskConfig.title
	end

	arg_6_0.eventID = arg_6_0.viewParam.eventID
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	gohelper.setActive(arg_8_0._btnNpc, arg_8_0.itemMo ~= nil)

	arg_8_0._txtTitle.text = arg_8_0.title or ""

	arg_8_0:refreshCamera()
	arg_8_0:startDialog()
end

function var_0_0.startDialog(arg_9_0)
	arg_9_0.stepIndex = 0
	arg_9_0._curDescIndex = 0
	arg_9_0._txtDesc.text = ""
	arg_9_0.curStepData = nil

	arg_9_0:hideOption()
	arg_9_0:nextStep()
end

function var_0_0.nextStep(arg_10_0)
	if arg_10_0.curStepData and arg_10_0._curDescIndex < arg_10_0.curStepData.descLen then
		arg_10_0:finishStep()

		return
	end

	arg_10_0.stepIndex = arg_10_0.stepIndex + 1

	local var_10_0 = arg_10_0:getStepCo(arg_10_0.stepIndex)

	if not var_10_0 then
		arg_10_0:finishDialog()

		return
	end

	local var_10_1 = GameUtil.getUCharArrWithoutRichTxt(var_10_0.content)

	arg_10_0.curStepData = {
		descArr = var_10_1,
		descLen = #var_10_1,
		desc = var_10_0.content,
		animType = var_10_0.animType
	}

	gohelper.setActive(arg_10_0._click, true)

	arg_10_0._curDescIndex = 0

	TaskDispatcher.cancelTask(arg_10_0._autoShowDesc, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._autoShowDesc, arg_10_0, 0.02)

	local var_10_2 = arg_10_0.curStepData.animType or 0

	if arg_10_0._curHeroPath then
		if var_10_2 == 0 then
			arg_10_0._modelComp:playAnim(arg_10_0._curHeroPath, "idle")
		elseif var_10_2 == 1 then
			arg_10_0._modelComp:playAnim(arg_10_0._curHeroPath, "jump")
		elseif var_10_2 == 2 then
			arg_10_0._modelComp:playAnim(arg_10_0._curHeroPath, "jump2")
		end
	end
end

function var_0_0.getStepCo(arg_11_0, arg_11_1)
	if arg_11_0.taskConfig then
		if arg_11_1 > 1 then
			return
		end

		local var_11_0 = {
			content = arg_11_0.taskConfig.desc
		}

		var_11_0.animType = 0

		return var_11_0
	end

	local var_11_1 = arg_11_0.behaviorConfig.dialogueId
	local var_11_2 = lua_survival_talk.configDict[var_11_1]

	return var_11_2 and var_11_2[arg_11_1]
end

function var_0_0.finishStep(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._autoShowDesc, arg_12_0)

	if arg_12_0.curStepData then
		arg_12_0._txtDesc.text = arg_12_0.curStepData.desc
		arg_12_0._curDescIndex = arg_12_0.curStepData.descLen
	end

	if not arg_12_0:getStepCo(arg_12_0.stepIndex + 1) then
		arg_12_0:finishDialog()
	end
end

function var_0_0.finishDialog(arg_13_0)
	arg_13_0._txtDesc.text = arg_13_0.curStepData and arg_13_0.curStepData.desc or ""

	gohelper.setActive(arg_13_0._click, false)
	arg_13_0:showOption()

	arg_13_0.curStepData = nil
end

function var_0_0._autoShowDesc(arg_14_0)
	if not arg_14_0.curStepData then
		return
	end

	arg_14_0._curDescIndex = arg_14_0._curDescIndex + 1
	arg_14_0._txtDesc.text = table.concat(arg_14_0.curStepData.descArr, "", 1, arg_14_0._curDescIndex)

	if arg_14_0._curDescIndex >= arg_14_0.curStepData.descLen then
		arg_14_0:finishStep()
	end
end

function var_0_0.showOption(arg_15_0)
	local var_15_0 = arg_15_0:getOptionDataList()

	for iter_15_0 = 1, math.max(#var_15_0, #arg_15_0._btns) do
		arg_15_0:getBtnItem(iter_15_0):updateData(var_15_0[iter_15_0])
	end

	gohelper.setActive(arg_15_0._gobtn, true)
end

function var_0_0.getOptionDataList(arg_16_0)
	local var_16_0 = {}
	local var_16_1
	local var_16_2

	if arg_16_0.behaviorConfig then
		var_16_1 = string.split(arg_16_0.behaviorConfig.chooseDesc, "|")
		var_16_2 = string.split(arg_16_0.behaviorConfig.chooseEvent, "&")
	end

	if arg_16_0.taskConfig then
		var_16_1 = {
			luaLang("ShelterMapEventView_looktask")
		}
		var_16_2 = {
			string.format("jumpTask#%s#%s", arg_16_0.moduleId, arg_16_0.taskConfig.id)
		}
	end

	if var_16_1 then
		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			local var_16_3 = SurvivalChoiceMo.Create({
				callback = arg_16_0.onClickOption,
				callobj = arg_16_0,
				desc = iter_16_1,
				param = var_16_2[iter_16_0]
			})

			table.insert(var_16_0, var_16_3)
		end
	end

	return var_16_0
end

function var_0_0.getBtnItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._btns[arg_17_1]

	if not var_17_0 then
		local var_17_1 = gohelper.clone(arg_17_0._gobtnitem, arg_17_0["_gopos" .. arg_17_1])

		gohelper.setAsFirstSibling(var_17_1)

		var_17_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_1, SurvivalEventChoiceItem)
		arg_17_0._btns[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.hideOption(arg_18_0)
	gohelper.setActive(arg_18_0._gobtn, false)
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._autoShowDesc, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	local var_20_0 = GameSceneMgr.instance:getCurSceneType()

	if var_20_0 == SceneType.SurvivalShelter then
		SurvivalMapHelper.instance:getSceneFogComp():setRainEnable(true)
	elseif var_20_0 == SceneType.Survival then
		SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(true)
	end
end

function var_0_0.refreshCamera(arg_21_0)
	local var_21_0 = arg_21_0.unitResPath
	local var_21_1
	local var_21_2 = false

	if arg_21_0.eventID then
		local var_21_3 = lua_survival_fight.configDict[arg_21_0.eventID] or SurvivalConfig.instance:getNpcConfig(arg_21_0.eventID, true)

		var_21_3 = var_21_3 or lua_survival_search.configDict[arg_21_0.eventID]
		var_21_3 = var_21_3 or lua_survival_mission.configDict[arg_21_0.eventID]

		if var_21_3 then
			var_21_0 = var_21_3.resource
			var_21_1 = var_21_3.camera
			var_21_2 = not string.nilorempty(var_21_3.grid)
		end
	end

	if var_21_0 and string.find(var_21_0, "^survival/buiding") then
		if var_21_1 == 2 then
			arg_21_0._curUnitPath = "node4/buiding3"
		elseif var_21_1 == 3 then
			arg_21_0._curUnitPath = "node5/buiding4"
		elseif var_21_2 or var_21_1 == 1 then
			arg_21_0._curUnitPath = "node3/buiding2"
		else
			arg_21_0._curUnitPath = "node2/buiding1"
			arg_21_0._curHeroPath = "node2/role"
		end
	else
		arg_21_0._curHeroPath = "node1/role"
		arg_21_0._curUnitPath = "node1/npc"
	end

	if arg_21_0._curUnitPath then
		arg_21_0._allResGo[arg_21_0._curUnitPath] = arg_21_0._modelComp:addModel(arg_21_0._curUnitPath, var_21_0)
	end

	arg_21_0:hideOtherModel()
end

function var_0_0.onClickOption(arg_22_0, arg_22_1)
	arg_22_0:hideOption()

	arg_22_0._eventIndex = 0
	arg_22_0._eventList = GameUtil.splitString2(arg_22_1, false) or {}

	arg_22_0:_playNext()
end

function var_0_0._playNext(arg_23_0)
	arg_23_0._eventIndex = arg_23_0._eventIndex + 1

	local var_23_0 = arg_23_0._eventList[arg_23_0._eventIndex]

	if not var_23_0 then
		arg_23_0:closeThis()

		return
	end

	local var_23_1 = var_23_0[1]

	if var_23_1 == "behavior" then
		arg_23_0:gotoBehavior(tonumber(var_23_0[2]))

		return
	end

	if var_23_1 == "acceptTask" then
		arg_23_0:acceptTask()

		return
	end

	if var_23_1 == "tipDialog" then
		TipDialogController.instance:openTipDialogView(tonumber(var_23_0[2]), arg_23_0._playNext, arg_23_0)

		return
	end

	if var_23_1 == "jumpTask" then
		arg_23_0:jumpTask(tonumber(var_23_0[2]), tonumber(var_23_0[3]))

		return
	end

	arg_23_0:closeThis()
end

function var_0_0.jumpTask(arg_24_0, arg_24_1, arg_24_2)
	ViewMgr.instance:openView(ViewName.ShelterTaskView, {
		moduleId = arg_24_1,
		taskId = arg_24_2
	})
	arg_24_0:closeThis()
end

function var_0_0.gotoBehavior(arg_25_0, arg_25_1)
	local var_25_0 = lua_survival_behavior.configDict[arg_25_1]

	if not var_25_0 then
		arg_25_0:closeThis()

		return
	end

	if not SurvivalMapHelper.instance:isBehaviorMeetCondition(var_25_0.condition, arg_25_0.conditionParam) then
		logError("ShelterMapEvent behavior condition not meet behaviorId = " .. arg_25_1)
		arg_25_0:closeThis()

		return
	end

	arg_25_0.behaviorConfig = var_25_0

	arg_25_0:startDialog()
end

function var_0_0.acceptTask(arg_26_0)
	local var_26_0 = arg_26_0.itemMo and arg_26_0.itemMo.id
	local var_26_1 = arg_26_0.behaviorConfig and arg_26_0.behaviorConfig.id

	if var_26_0 and var_26_1 then
		SurvivalWeekRpc.instance:sendSurvivalNpcAcceptTaskRequest(var_26_0, var_26_1)
	end

	arg_26_0:closeThis()
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

return var_0_0
