module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErOptionItem", package.seeall)

local var_0_0 = class("MoLiDeErOptionItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goBG1 = gohelper.findChild(arg_1_0.viewGO, "#go_BG1")
	arg_1_0._goBG2 = gohelper.findChild(arg_1_0.viewGO, "#go_BG2")
	arg_1_0._goBG3 = gohelper.findChild(arg_1_0.viewGO, "#go_BG3")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#txt_Name")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_Descr")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Cost/#txt_Num")
	arg_1_0._btnSelect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "")
	arg_1_0._goCost = gohelper.findChild(arg_1_0.viewGO, "#go_Cost")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnSelect:AddClickListener(arg_2_0.onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnSelect:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0.optionInfo = arg_5_1
	arg_5_0.optionId = arg_5_1.optionId
	arg_5_0.optionConfig = MoLiDeErConfig.instance:getOptionConfig(arg_5_1.optionId)

	arg_5_0:refreshUI()
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, arg_6_1)
end

function var_0_0.onItemClick(arg_7_0)
	local var_7_0 = arg_7_0.optionId

	if var_7_0 == MoLiDeErGameModel.instance:getSelectOptionId() then
		return
	end

	if not arg_7_0._canSelect then
		local var_7_1 = MoLiDeErGameModel.instance:getCurGameInfo()
		local var_7_2 = MoLiDeErGameModel.instance:getSelectEventId()
		local var_7_3 = MoLiDeErHelper.getOptionItemCost(var_7_0)

		if var_7_3 and var_7_3[1] then
			for iter_7_0, iter_7_1 in ipairs(var_7_3) do
				local var_7_4 = iter_7_1[3]
				local var_7_5 = iter_7_1[2]

				if var_7_4 and var_7_5 then
					local var_7_6 = var_7_1:getEquipInfo(var_7_4)

					if var_7_6 == nil or var_7_6.quantity + var_7_5 < 0 then
						GameFacade.showToast(ToastEnum.Act194EquipCountNotEnough)

						return
					end
				end
			end
		end

		local var_7_7 = MoLiDeErGameModel.instance:getExecutionCostById(var_7_2, var_7_0)

		if var_7_1:isAllActTimesNotMatch() then
			GameFacade.showToast(ToastEnum.Act194AllTeamActTimesNotMatch)

			return
		end

		if var_7_7 + var_7_1.leftRoundEnergy < 0 then
			GameFacade.showToast(ToastEnum.Act194ExecutionNotEnough)

			return
		end

		GameFacade.showToast(ToastEnum.Act194NotMatchConditionTeam)

		return
	end

	MoLiDeErGameModel.instance:setSelectOptionId(var_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0.optionInfo
	local var_8_1 = arg_8_0.optionConfig

	arg_8_0._txtName.text = var_8_1.name

	local var_8_2 = var_8_0.isEverChosen
	local var_8_3 = arg_8_0.optionId
	local var_8_4 = var_8_0.isChosable and MoLiDeErHelper.isOptionCanChose(var_8_3)

	arg_8_0._canSelect = var_8_4

	local var_8_5 = var_8_2 and var_8_1.optionDesc or var_8_1.conditionDesc
	local var_8_6

	if MoLiDeErGameModel.instance:getSelectOptionId() == var_8_0.optionId then
		var_8_6 = MoLiDeErGameModel.instance:getSelectTeamId()
	end

	local var_8_7 = {}
	local var_8_8 = MoLiDeErHelper.getOptionRestrictionParamList(var_8_1.optionId)

	tabletool.addValues(var_8_7, var_8_8)

	local var_8_9 = MoLiDeErHelper.getOptionEffectParamList(var_8_1.optionId, var_8_6)

	tabletool.addValues(var_8_7, var_8_9)

	local var_8_10 = MoLiDeErHelper.getOptionResultEffectParamList(var_8_1.optionResultId, var_8_6)

	tabletool.addValues(var_8_7, var_8_10)

	arg_8_0._txtDescr.text = GameUtil.getSubPlaceholderLuaLang(var_8_5, var_8_7)

	gohelper.setActive(arg_8_0._goBG1, var_8_4)
	gohelper.setActive(arg_8_0._goBG2, false)
	gohelper.setActive(arg_8_0._goBG3, not var_8_4)

	local var_8_11 = MoLiDeErGameModel.instance:getSelectEventId()
	local var_8_12 = MoLiDeErGameModel.instance:getExecutionCostById(var_8_11, var_8_3, var_8_6)
	local var_8_13 = var_8_12 ~= 0

	gohelper.setActive(arg_8_0._goCost, var_8_13)

	if var_8_13 then
		arg_8_0._txtNum.text = tostring(var_8_12)
	end

	local var_8_14 = MoLiDeErGameModel.instance:getSelectOptionId()

	arg_8_0:setSelect(var_8_14)
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goBG2, arg_9_0.optionId == arg_9_1)
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
