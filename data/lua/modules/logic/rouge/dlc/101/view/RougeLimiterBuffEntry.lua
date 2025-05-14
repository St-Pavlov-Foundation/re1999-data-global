module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffEntry", package.seeall)

local var_0_0 = class("RougeLimiterBuffEntry", LuaCompBase)

var_0_0.DefaultDifficultyFontSize = 38

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtdifficulty = gohelper.findChildText(arg_1_0.viewGO, "#txt_difficulty")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._gonamebg = gohelper.findChild(arg_1_0.viewGO, "namebg")
	arg_1_0._numAnim = gohelper.onceAddComponent(arg_1_0._txtnum.gameObject, gohelper.Type_Animator)
	arg_1_0._canvasgroup = gohelper.onceAddComponent(arg_1_0.viewGO, gohelper.Type_CanvasGroup)
	arg_1_0._selectIndex = 0
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, arg_2_0._onUpdateBuffState, arg_2_0)
	arg_2_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, arg_2_0._onUpdateLimiterGroup, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfo, arg_2_0._onUpdateRougeInfo, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.refreshUI(arg_4_0, arg_4_1)
	arg_4_0:refreshRisk()
	arg_4_0:refreshAllBuffEntry()
	arg_4_0:refreshRiskIcon(arg_4_1)
end

function var_0_0.refreshRisk(arg_5_0)
	local var_5_0 = arg_5_0:getTotalRiskValue()
	local var_5_1 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(var_5_0)

	arg_5_0._switchRiskStage = not arg_5_0._riskCo or not var_5_1 or arg_5_0._riskCo.id ~= var_5_1.id
	arg_5_0._riskCo = var_5_1
	arg_5_0._txtdifficulty.text = arg_5_0._riskCo and arg_5_0._riskCo.title
	arg_5_0._txtnum.text = var_5_0

	arg_5_0._numAnim:Play(arg_5_0._switchRiskStage and "refresh" or "idle", 0, 0)

	local var_5_2 = RougeDLCConfig101.instance:getMaxLevlRiskCo()

	arg_5_0._isCurMaxLevel = var_5_2 and arg_5_0._riskCo and var_5_2.id == arg_5_0._riskCo.id
end

function var_0_0.getTotalRiskValue(arg_6_0)
	return RougeDLCModel101.instance:getTotalRiskValue()
end

function var_0_0.refreshRiskIcon(arg_7_0, arg_7_1)
	local var_7_0 = false

	for iter_7_0 = 1, #lua_rouge_risk.configList do
		local var_7_1 = lua_rouge_risk.configList[iter_7_0]
		local var_7_2 = gohelper.findChild(arg_7_0.viewGO, "difficulty/" .. var_7_1.id)
		local var_7_3 = arg_7_0._riskCo and arg_7_0._riskCo.id == var_7_1.id

		gohelper.setActive(var_7_2, var_7_3)

		if var_7_3 then
			var_7_0 = true

			if arg_7_0._switchRiskStage and arg_7_1 then
				local var_7_4 = gohelper.onceAddComponent(var_7_2, gohelper.Type_Animator)

				var_7_4:Play("open", 0, 0)
				var_7_4:Update(0)
			end
		end
	end

	local var_7_5 = gohelper.findChild(arg_7_0.viewGO, "difficulty/none")

	gohelper.setActive(var_7_5, not var_7_0)

	if not var_7_0 and arg_7_1 then
		gohelper.onceAddComponent(var_7_5, gohelper.Type_Animator):Play("open", 0, 0)
	end
end

function var_0_0.refreshAllBuffEntry(arg_8_0)
	local var_8_0 = arg_8_0._riskCo and arg_8_0._riskCo.buffNum or 0
	local var_8_1 = arg_8_0:_getAllBuffTypes()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = iter_8_1 <= var_8_0

		arg_8_0:refreshBuffEntry(iter_8_1, var_8_2)
	end
end

function var_0_0._getAllBuffTypes(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(RougeDLCEnum101.LimiterBuffType) do
		table.insert(var_9_0, iter_9_1)
	end

	table.sort(var_9_0, var_0_0._sortBuffType)

	return var_9_0
end

function var_0_0._sortBuffType(arg_10_0, arg_10_1)
	return arg_10_0 < arg_10_1
end

function var_0_0.refreshBuffEntry(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:_getOrCreateBuffPart(arg_11_1)

	gohelper.setActive(var_11_0.gobuff, arg_11_2)

	if not arg_11_2 then
		return
	end

	local var_11_1 = arg_11_0:_getTypeBuffEquiped(arg_11_1)
	local var_11_2 = var_11_1 ~= nil
	local var_11_3 = var_11_1 and var_11_1.blank == 1
	local var_11_4 = arg_11_0._selectIndex == arg_11_1

	gohelper.setActive(var_11_0.imageunequiped.gameObject, not var_11_2)
	gohelper.setActive(var_11_0.imageequipednormal.gameObject, var_11_2 and not var_11_3)
	gohelper.setActive(var_11_0.goquipedblank, var_11_3 and not arg_11_0._isCurMaxLevel)
	gohelper.setActive(var_11_0.goequipedblankred, var_11_3 and arg_11_0._isCurMaxLevel)
	gohelper.setActive(var_11_0.imageselect.gameObject, var_11_4)

	local var_11_5 = string.format("rouge_dlc1_buffbtn" .. arg_11_1)

	if arg_11_0._isCurMaxLevel then
		var_11_5 = var_11_5 .. "_hong"
	end

	UISpriteSetMgr.instance:setRouge3Sprite(var_11_0.imageunequiped, var_11_5, true)
	UISpriteSetMgr.instance:setRouge3Sprite(var_11_0.imageequipednormal, var_11_5, true)
end

function var_0_0._getOrCreateBuffPart(arg_12_0, arg_12_1)
	arg_12_0._buffPartTab = arg_12_0._buffPartTab or arg_12_0:getUserDataTb_()

	local var_12_0 = arg_12_0._buffPartTab[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.gobuff = gohelper.findChild(arg_12_0.viewGO, "#go_buff" .. arg_12_1)
		var_12_0.imageunequiped = gohelper.findChildImage(var_12_0.gobuff, "unselect_unequip")
		var_12_0.imageequipednormal = gohelper.findChildImage(var_12_0.gobuff, "unselect_equiped")
		var_12_0.goquipedblank = gohelper.findChild(var_12_0.gobuff, "none")
		var_12_0.goequipedblankred = gohelper.findChild(var_12_0.gobuff, "none_red")
		var_12_0.imageselect = gohelper.findChildImage(var_12_0.gobuff, "select_equiped")
		var_12_0.btnclick = gohelper.findChildButtonWithAudio(var_12_0.gobuff, "btn_click")

		var_12_0.btnclick:AddClickListener(arg_12_0._btnbuffOnClick, arg_12_0, arg_12_1)

		arg_12_0._buffPartTab[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0._getTypeBuffEquiped(arg_13_0, arg_13_1)
	local var_13_0 = RougeModel.instance:getVersion()
	local var_13_1 = RougeDLCConfig101.instance:getAllLimiterBuffCosByType(var_13_0, arg_13_1)

	if var_13_1 then
		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			if RougeDLCModel101.instance:getLimiterBuffState(iter_13_1.id) == RougeDLCEnum101.BuffState.Equiped then
				return iter_13_1
			end
		end
	end
end

function var_0_0._onUpdateBuffState(arg_14_0, arg_14_1)
	local var_14_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_14_1)

	if not var_14_0 then
		return
	end

	arg_14_0:refreshBuffEntry(var_14_0.buffType, true)
end

function var_0_0._onUpdateLimiterGroup(arg_15_0, arg_15_1)
	arg_15_0:refreshUI(true)
end

function var_0_0._onUpdateRougeInfo(arg_16_0)
	arg_16_0:refreshUI()
end

function var_0_0._btnbuffOnClick(arg_17_0, arg_17_1)
	arg_17_0:selectBuffEntry(arg_17_1)
	RougeDLCController101.instance:openRougeLimiterBuffView({
		buffType = arg_17_1
	})
end

function var_0_0.selectBuffEntry(arg_18_0, arg_18_1)
	arg_18_0._selectIndex = arg_18_1 or 0

	arg_18_0:refreshAllBuffEntry()
end

function var_0_0.setDifficultyTxtFontSize(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or var_0_0.DefaultDifficultyFontSize
	arg_19_0._txtdifficulty.fontSize = arg_19_1
end

function var_0_0.setDifficultyVisible(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._txtdifficulty.gameObject, arg_20_1)
	gohelper.setActive(arg_20_0._gonamebg, arg_20_1)
end

function var_0_0.setPlaySwitchAnim(arg_21_0, arg_21_1)
	arg_21_0._enabledPlaySwitchAnim = arg_21_1
end

function var_0_0.setInteractable(arg_22_0, arg_22_1)
	arg_22_0._canvasgroup.interactable = arg_22_1
	arg_22_0._canvasgroup.blocksRaycasts = arg_22_1
end

function var_0_0.removeAllBuffPartClick(arg_23_0)
	if arg_23_0._buffPartTab then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._buffPartTab) do
			if iter_23_1.btnclick then
				iter_23_1.btnclick:RemoveClickListener()
			end
		end
	end
end

function var_0_0.onDestroy(arg_24_0)
	arg_24_0:removeAllBuffPartClick()
end

return var_0_0
