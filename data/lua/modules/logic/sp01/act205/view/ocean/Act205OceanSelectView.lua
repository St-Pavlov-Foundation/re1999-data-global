module("modules.logic.sp01.act205.view.ocean.Act205OceanSelectView", package.seeall)

local var_0_0 = class("Act205OceanSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_firstStepContent/#simage_rightbg")
	arg_1_0._gofirstStepContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_firstStepContent")
	arg_1_0._txtgoalDesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_firstStepContent/#txt_goalDesc")
	arg_1_0._gogoalItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_firstStepContent/#go_goalItem")
	arg_1_0._godestPos1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_firstStepContent/#go_destPos1")
	arg_1_0._godestPos2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_firstStepContent/#go_destPos2")
	arg_1_0._godestPos3 = gohelper.findChild(arg_1_0.viewGO, "root/#go_firstStepContent/#go_destPos3")
	arg_1_0._gosecondStepContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_secondStepContent")
	arg_1_0._godiceContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_secondStepContent/#go_diceContent")
	arg_1_0._godiceItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_secondStepContent/#go_diceContent/#go_diceItem")
	arg_1_0._btnnextStep = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep")
	arg_1_0._gonextStep = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep/#go_nextStep")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep/#go_start")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep/#go_lock")
	arg_1_0._gostepIndex1 = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep/stepIndexContent/#go_stepIndex1")
	arg_1_0._gostepIndex2 = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#btn_nextStep/stepIndexContent/#go_stepIndex2")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottomInfo/#btn_back")
	arg_1_0._gocurNeedPoint = gohelper.findChild(arg_1_0.viewGO, "root/#go_secondStepContent/stepNameEn/#go_curNeedPoint")
	arg_1_0._txtcurNeedPoint = gohelper.findChildText(arg_1_0.viewGO, "root/#go_secondStepContent/stepNameEn/#go_curNeedPoint/#txt_curNeedPoint")
	arg_1_0._gogameTimes = gohelper.findChild(arg_1_0.viewGO, "root/bottomInfo/#go_gameTimes")
	arg_1_0._txtgameTimes = gohelper.findChildText(arg_1_0.viewGO, "root/bottomInfo/#go_gameTimes/#txt_gameTimes")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_rule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnextStep:AddClickListener(arg_2_0._btnnextStepOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0._btnruleOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnextStep:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnrule:RemoveClickListener()
end

function var_0_0._btnruleOnClick(arg_4_0)
	Act205Controller.instance:openRuleTipsView()
end

function var_0_0._btnnextStepOnClick(arg_5_0)
	if arg_5_0.curPageStep == 1 then
		arg_5_0.curPageStep = 2

		arg_5_0:refreshUI()
		arg_5_0._animPlayerView:Play("step2_in", nil, arg_5_0)
	elseif arg_5_0.curPageStep == 2 then
		if #arg_5_0.curSelectDictIdList < Act205Enum.oceanDiceMaxCount then
			GameFacade.showToast(ToastEnum.Act205OceanSelectDictNotEnough)

			return
		end

		if arg_5_0.isEnterShowView then
			return
		end

		arg_5_0.isEnterShowView = true

		Act205OceanModel.instance:setcurSelectDiceIdList(arg_5_0.curSelectDictIdList)
		arg_5_0._animPlayerView:Play("close", arg_5_0.enterShowView, arg_5_0)
	end
end

function var_0_0._btnbackOnClick(arg_6_0)
	if arg_6_0.curPageStep ~= 2 then
		return
	end

	arg_6_0.curSelectDictIdList = {}
	arg_6_0.curSelectDictMap = {}
	arg_6_0.curPageStep = 1

	arg_6_0:refreshUI()
	arg_6_0._animPlayerView:Play("step1_in", nil, arg_6_0)
end

function var_0_0._onGoalItemClick(arg_7_0, arg_7_1)
	if arg_7_0.curGoldId == arg_7_1.id then
		return
	end

	arg_7_0.curGoldId = arg_7_1.id

	Act205OceanModel.instance:setCurSelectGoldId(arg_7_1.id)
	arg_7_0:refreshGoldItemSelectState()
	arg_7_0._animPlayerView:Play("rightbg_in", nil, arg_7_0)
end

function var_0_0._onDiceItemAddClick(arg_8_0, arg_8_1)
	if #arg_8_0.curSelectDictIdList == Act205Enum.oceanDiceMaxCount then
		GameFacade.showToast(ToastEnum.Act205OceanSelectMaxCount)

		return
	end

	table.insert(arg_8_0.curSelectDictIdList, arg_8_1.id)

	arg_8_0.curSelectDictMap[arg_8_1.index] = not arg_8_0.curSelectDictMap[arg_8_1.index] and 1 or arg_8_0.curSelectDictMap[arg_8_1.index] + 1

	arg_8_0:refreshDiceSelectUI()
end

function var_0_0._onDiceItemSubClick(arg_9_0, arg_9_1)
	if #arg_9_0.curSelectDictIdList == 0 or not arg_9_0.curSelectDictMap[arg_9_1.index] or arg_9_0.curSelectDictMap[arg_9_1.index] == 0 then
		return
	end

	table.remove(arg_9_0.curSelectDictIdList)

	arg_9_0.curSelectDictMap[arg_9_1.index] = arg_9_0.curSelectDictMap[arg_9_1.index] > 0 and arg_9_0.curSelectDictMap[arg_9_1.index] - 1 or 0

	arg_9_0:refreshDiceSelectUI()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.goldItemMap = arg_10_0:getUserDataTb_()
	arg_10_0.stepItemMap = arg_10_0:getUserDataTb_()
	arg_10_0.diceItemMap = arg_10_0:getUserDataTb_()

	gohelper.setActive(arg_10_0._gogoalItem, false)
	gohelper.setActive(arg_10_0._godiceItem, false)

	arg_10_0.curSelectDictIdList = {}
	arg_10_0.curSelectDictMap = {}
	arg_10_0._gohardMask = gohelper.findChild(arg_10_0.viewGO, "root/simage_hardmask")
	arg_10_0._animPlayerView = SLFramework.AnimatorPlayer.Get(arg_10_0.viewGO)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.curPageStep = 1

	Act205OceanModel.instance:setCurSelectGoldId(nil)
	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshStepUI()

	if arg_12_0.curPageStep == 1 then
		arg_12_0:refreshFirstStepUI()
	elseif arg_12_0.curPageStep == 2 then
		arg_12_0:refreshSecondStepUI()
	end
end

function var_0_0.refreshStepUI(arg_13_0)
	gohelper.setActive(arg_13_0._gofirstStepContent, arg_13_0.curPageStep == 1)
	gohelper.setActive(arg_13_0._gosecondStepContent, arg_13_0.curPageStep == 2)
	gohelper.setActive(arg_13_0._gocurNeedPoint, arg_13_0.curPageStep == 2)
	gohelper.setActive(arg_13_0._gogameTimes, arg_13_0.curPageStep == 2)
	gohelper.setActive(arg_13_0._btnback.gameObject, arg_13_0.curPageStep == 2)
	gohelper.setActive(arg_13_0._gonextStep, arg_13_0.curPageStep == 1)
	gohelper.setActive(arg_13_0._gostart, arg_13_0.curPageStep == 2)
	gohelper.setActive(arg_13_0._golock, arg_13_0.curPageStep == 2)

	for iter_13_0 = 1, 2 do
		local var_13_0 = arg_13_0.stepItemMap[iter_13_0]

		if not var_13_0 then
			var_13_0 = {
				go = arg_13_0["_gostepIndex" .. iter_13_0]
			}
			var_13_0.goLight = gohelper.findChild(var_13_0.go, "go_light")
			var_13_0.goDark = gohelper.findChild(var_13_0.go, "go_dark")
			arg_13_0.stepItemMap[iter_13_0] = var_13_0
		end

		gohelper.setActive(var_13_0.goLight, iter_13_0 == arg_13_0.curPageStep)
		gohelper.setActive(var_13_0.goDark, iter_13_0 ~= arg_13_0.curPageStep)
	end

	arg_13_0.isEnterShowView = false

	arg_13_0:setCloseOverrideFunc()
end

function var_0_0.refreshFirstStepUI(arg_14_0)
	arg_14_0.goldIdList = Act205OceanModel.instance:getGoldList()

	arg_14_0:createAndRefreshGoldItem()
	arg_14_0:refreshGoldItemSelectState()
end

function var_0_0.createAndRefreshGoldItem(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.goldIdList) do
		local var_15_0 = arg_15_0.goldItemMap[iter_15_0]

		if not var_15_0 then
			var_15_0 = {
				pos = gohelper.findChild(arg_15_0["_godestPos" .. iter_15_0], "go_pos")
			}
			var_15_0.go = gohelper.clone(arg_15_0._gogoalItem, var_15_0.pos, "goalItem" .. iter_15_1)
			var_15_0.txtGoalName = gohelper.findChildText(var_15_0.go, "txt_goalName")
			var_15_0.txtNeedPoint = gohelper.findChildText(var_15_0.go, "needPoint/txt_needPoint")
			var_15_0.txtSelectGoldName = gohelper.findChildText(var_15_0.go, "go_select/txt_selectGoalName")
			var_15_0.txtSelectNeedPoint = gohelper.findChildText(var_15_0.go, "go_select/needPoint/txt_selectNeedPoint")
			var_15_0.goHardTag = gohelper.findChild(var_15_0.go, "go_hardTag")
			var_15_0.goSelect = gohelper.findChild(var_15_0.go, "go_select")
			var_15_0.btnClick = gohelper.findChildButtonWithAudio(var_15_0.go, "btn_click")
			arg_15_0.goldItemMap[iter_15_0] = var_15_0
		end

		var_15_0.btnClick:AddClickListener(arg_15_0._onGoalItemClick, arg_15_0, var_15_0)
		gohelper.setActive(var_15_0.go, true)

		var_15_0.id = iter_15_1
		var_15_0.index = iter_15_0
		var_15_0.config = Act205Config.instance:getDiceGoalConfig(iter_15_1)
		var_15_0.txtGoalName.text = var_15_0.config.goalname
		var_15_0.txtSelectGoldName.text = var_15_0.config.goalname

		gohelper.setActive(var_15_0.goHardTag, var_15_0.config.hardType == Act205Enum.oceanGoldHardType.Hard)

		local var_15_1 = string.split(var_15_0.config.goalRange, "#")

		var_15_0.txtNeedPoint.text = string.format("%s~%s", var_15_1[1], var_15_1[2])
		var_15_0.txtSelectNeedPoint.text = string.format("%s~%s", var_15_1[1], var_15_1[2])

		local var_15_2 = Act205OceanModel.instance:getCurSelectGoldId()

		if not var_15_2 or var_15_2 == 0 then
			Act205OceanModel.instance:setCurSelectGoldId(iter_15_1)
		end
	end
end

function var_0_0.refreshGoldItemSelectState(arg_16_0)
	local var_16_0 = Act205OceanModel.instance:getCurSelectGoldId()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.goldItemMap) do
		gohelper.setActive(iter_16_1.goSelect, iter_16_1.id == var_16_0)
	end

	local var_16_1 = Act205Config.instance:getDiceGoalConfig(var_16_0)

	arg_16_0._txtgoalDesc.text = var_16_1.goaldesc

	arg_16_0._simagerightBg:LoadImage(ResUrl.getV2a9ActOceanSingleBg(var_16_1.iconRes))

	local var_16_2 = var_16_1.hardType == Act205Enum.oceanGoldHardType.Hard

	gohelper.setActive(arg_16_0._gohardMask, var_16_2)
end

function var_0_0.refreshSecondStepUI(arg_17_0)
	local var_17_0 = Act205OceanModel.instance:getCurSelectGoldId()
	local var_17_1 = Act205Config.instance:getDiceGoalConfig(var_17_0)
	local var_17_2 = string.split(var_17_1.goalRange, "#")

	arg_17_0._txtcurNeedPoint.text = string.format("%s~%s", var_17_2[1], var_17_2[2])

	arg_17_0:createAndRefreshDiceItem()
	arg_17_0:refreshDiceSelectUI()
end

function var_0_0.createAndRefreshDiceItem(arg_18_0)
	local var_18_0 = Act205OceanModel.instance:getCurSelectGoldId()
	local var_18_1 = Act205OceanModel.instance:getGoldIndexByGoldId(var_18_0)

	arg_18_0.diceIdList = Act205OceanModel.instance:getDiceList(var_18_1)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.diceIdList) do
		local var_18_2 = arg_18_0.diceItemMap[iter_18_0]

		if not var_18_2 then
			var_18_2 = {
				go = gohelper.clone(arg_18_0._godiceItem, arg_18_0._godiceContent, "diceItem" .. iter_18_1)
			}
			var_18_2.imageShip = gohelper.findChildImage(var_18_2.go, "#image_ship")
			var_18_2.txtDiceName = gohelper.findChildText(var_18_2.go, "txt_diceName")
			var_18_2.txtDiceDesc = gohelper.findChildText(var_18_2.go, "#scroll_dice/Viewport/Content/txt_diceDesc")
			var_18_2.goDiceContent = gohelper.findChild(var_18_2.go, "go_diceContent")
			var_18_2.goDicePointItem = gohelper.findChild(var_18_2.go, "go_diceContent/go_dicePointItem")
			var_18_2.txtSelectNum = gohelper.findChildText(var_18_2.go, "num/txt_selectNum")
			var_18_2.btnAddNum = gohelper.findChildButtonWithAudio(var_18_2.go, "btn_addNum")
			var_18_2.goNormalAddIcon = gohelper.findChild(var_18_2.go, "btn_addNum/go_normalAddIcon")
			var_18_2.goLockAddIcon = gohelper.findChild(var_18_2.go, "btn_addNum/go_lockAddIcon")
			var_18_2.btnSubNum = gohelper.findChildButtonWithAudio(var_18_2.go, "btn_subNum")
			var_18_2.goNormalSubIcon = gohelper.findChild(var_18_2.go, "btn_subNum/go_normalSubIcon")
			var_18_2.goLockSubIcon = gohelper.findChild(var_18_2.go, "btn_subNum/go_lockSubIcon")
			var_18_2.goSelect = gohelper.findChild(var_18_2.go, "go_select")
			var_18_2.dicePointItemList = {}
			arg_18_0.diceItemMap[iter_18_0] = var_18_2
		end

		var_18_2.btnAddNum:AddClickListener(arg_18_0._onDiceItemAddClick, arg_18_0, var_18_2)
		var_18_2.btnSubNum:AddClickListener(arg_18_0._onDiceItemSubClick, arg_18_0, var_18_2)
		gohelper.setActive(var_18_2.go, true)
		gohelper.setActive(var_18_2.goDicePointItem, false)

		var_18_2.id = iter_18_1
		var_18_2.index = iter_18_0
		var_18_2.config = Act205Config.instance:getDicePoolConfig(iter_18_1)
		var_18_2.txtDiceName.text = var_18_2.config.name
		var_18_2.txtDiceDesc.text = var_18_2.config.desc

		UISpriteSetMgr.instance:setSp01Act205Sprite(var_18_2.imageShip, var_18_2.config.iconRes)
		arg_18_0:createAndShowDicePointItem(var_18_2)
	end
end

function var_0_0.createAndShowDicePointItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.config.winDice == 1 and {
		"?",
		"?",
		"?",
		"?",
		"?",
		"?"
	} or string.splitToNumber(arg_19_1.config.dicePoints, "#")

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_1 = arg_19_1.dicePointItemList[iter_19_0]

		if not var_19_1 then
			var_19_1 = {
				go = gohelper.clone(arg_19_1.goDicePointItem, arg_19_1.goDiceContent, "dicePointItem" .. iter_19_0)
			}
			var_19_1.goNormal = gohelper.findChild(var_19_1.go, "go_normal")
			var_19_1.txtPoint = gohelper.findChildText(var_19_1.go, "go_normal/txt_point")
			var_19_1.goWinDice = gohelper.findChild(var_19_1.go, "go_winDice")
			var_19_1.goSelect = gohelper.findChild(var_19_1.go, "go_select")
			var_19_1.isNormalPoint = type(iter_19_1) == "number"
			arg_19_1.dicePointItemList[iter_19_0] = var_19_1
		end

		gohelper.setActive(var_19_1.goNormal, var_19_1.isNormalPoint)
		gohelper.setActive(var_19_1.goWinDice, not var_19_1.isNormalPoint)
		gohelper.setActive(var_19_1.go, true)

		var_19_1.txtPoint.text = iter_19_1
	end
end

function var_0_0.refreshDiceSelectUI(arg_20_0)
	local var_20_0 = #arg_20_0.curSelectDictIdList == Act205Enum.oceanDiceMaxCount

	gohelper.setActive(arg_20_0._gostart, var_20_0)
	gohelper.setActive(arg_20_0._golock, not var_20_0)

	arg_20_0._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_ocean_selectDiceCount"), #arg_20_0.curSelectDictIdList, Act205Enum.oceanDiceMaxCount)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.diceItemMap) do
		arg_20_0.curSelectDictMap[iter_20_1.index] = arg_20_0.curSelectDictMap[iter_20_1.index] or 0

		gohelper.setActive(iter_20_1.goSelect, arg_20_0.curSelectDictMap[iter_20_1.index] > 0)

		iter_20_1.txtSelectNum.text = arg_20_0.curSelectDictMap[iter_20_1.index]

		gohelper.setActive(iter_20_1.goNormalAddIcon, #arg_20_0.curSelectDictIdList < Act205Enum.oceanDiceMaxCount)
		gohelper.setActive(iter_20_1.goLockAddIcon, #arg_20_0.curSelectDictIdList >= Act205Enum.oceanDiceMaxCount)
		gohelper.setActive(iter_20_1.goNormalSubIcon, arg_20_0.curSelectDictMap[iter_20_1.index] > 0)
		gohelper.setActive(iter_20_1.goLockSubIcon, arg_20_0.curSelectDictMap[iter_20_1.index] == 0)

		for iter_20_2, iter_20_3 in pairs(iter_20_1.dicePointItemList) do
			gohelper.setActive(iter_20_3.goSelect, arg_20_0.curSelectDictMap[iter_20_1.index] > 0)
		end
	end
end

function var_0_0.enterShowView(arg_21_0)
	Act205Controller.instance:openOceanShowView()
	TaskDispatcher.runDelay(arg_21_0.closeThis, arg_21_0, 0.1)
end

function var_0_0.setCloseOverrideFunc(arg_22_0)
	if arg_22_0.curPageStep == 2 then
		arg_22_0.viewContainer:setOverrideCloseClick(arg_22_0._btnbackOnClick, arg_22_0)
	else
		arg_22_0.viewContainer:setOverrideCloseClick(arg_22_0.closeThis, arg_22_0)
	end
end

function var_0_0.onClose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.goldItemMap) do
		iter_23_1.btnClick:RemoveClickListener()
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.diceItemMap) do
		iter_23_3.btnAddNum:RemoveClickListener()
		iter_23_3.btnSubNum:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_23_0.closeThis, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simagerightBg:UnLoadImage()
end

return var_0_0
