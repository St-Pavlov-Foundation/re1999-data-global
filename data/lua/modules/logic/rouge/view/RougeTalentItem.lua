module("modules.logic.rouge.view.RougeTalentItem", package.seeall)

local var_0_0 = class("RougeTalentItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._canvasGroup = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._txtDescr = gohelper.findChildText(arg_4_0.viewGO, "txt_Descr")
	arg_4_0._icon = gohelper.findChildImage(arg_4_0.viewGO, "txt_Descr/go_Icon")
	arg_4_0._iconlight = gohelper.findChild(arg_4_0.viewGO, "txt_Descr/go_Icon/#light")
	arg_4_0._boardImg = gohelper.findChildImage(arg_4_0.viewGO, "go_Light")

	gohelper.setActive(arg_4_0._boardImg, false)

	arg_4_0._goSelected = arg_4_0:_findChild("go_Selected", false)
	arg_4_0._goConfirm = arg_4_0:_findChild("go_Selected/image_Tick", true)
	arg_4_0._goLineLight = arg_4_0:_findChild("go_LineLight", false)
	arg_4_0._goLineLight1 = arg_4_0:_findChild("go_LineLight1", false)
	arg_4_0._goLineLight2 = arg_4_0:_findChild("go_LineLight2", false)
	arg_4_0._goStar = arg_4_0:_findChild("go_Star", false)
	arg_4_0._goClick = arg_4_0:_findChild("click", false)
	arg_4_0.click = gohelper.getClickWithDefaultAudio(arg_4_0._goClick)

	arg_4_0.click:AddClickListener(arg_4_0.onClick, arg_4_0)

	arg_4_0.clickConfirm = gohelper.getClickWithDefaultAudio(arg_4_0._goSelected)

	arg_4_0.clickConfirm:AddClickListener(arg_4_0.onClickConfirm, arg_4_0)

	arg_4_0._goSelectedAnimator = arg_4_0._goSelected:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.setState(arg_5_0)
	local var_5_0 = arg_5_0._isSelected and arg_5_0._talentState == RougeEnum.TalentState.CanActivated

	gohelper.setActive(arg_5_0._goStar, false)
	gohelper.setActive(arg_5_0._goSelected, var_5_0)
	gohelper.setActive(arg_5_0._goClick, false)
	gohelper.setActive(arg_5_0._boardImg, false)
	gohelper.setActive(arg_5_0._goLineLight, false)
	gohelper.setActive(arg_5_0._goLineLight1, false)
	gohelper.setActive(arg_5_0._goLineLight2, false)

	if var_5_0 then
		arg_5_0._goSelectedAnimator:Play("open", 0, 0)
	end

	if arg_5_0._talentState == RougeEnum.TalentState.Disabled then
		local var_5_1 = GameUtil.parseColor("#D3CCBF")

		var_5_1.a = 0.2
		arg_5_0._txtDescr.color = var_5_1

		UISpriteSetMgr.instance:setRougeSprite(arg_5_0._icon, "rouge_talent_point_01")
		gohelper.setActive(arg_5_0._txtDescr, true)

		return
	end

	if arg_5_0._talentState == RougeEnum.TalentState.CannotActivated then
		local var_5_2 = GameUtil.parseColor("#D3CCBF")

		var_5_2.a = 0.2
		arg_5_0._txtDescr.color = var_5_2

		UISpriteSetMgr.instance:setRougeSprite(arg_5_0._icon, "rouge_talent_point_01")
		gohelper.setActive(arg_5_0._txtDescr, true)
		gohelper.setActive(arg_5_0._boardImg, true)

		local var_5_3 = arg_5_0._boardImg.color

		var_5_3.a = 0.4
		arg_5_0._boardImg.color = var_5_3

		return
	end

	if arg_5_0._talentState == RougeEnum.TalentState.CanActivated then
		local var_5_4 = GameUtil.parseColor("#C5BEA1")

		var_5_4.a = 1
		arg_5_0._txtDescr.color = var_5_4

		UISpriteSetMgr.instance:setRougeSprite(arg_5_0._icon, "rouge_talent_point_02")
		gohelper.setActive(arg_5_0._goStar, true)
		gohelper.setActive(arg_5_0._goClick, true)
		gohelper.setActive(arg_5_0._txtDescr, true)
		gohelper.setActive(arg_5_0._boardImg, not var_5_0)

		local var_5_5 = arg_5_0._boardImg.color

		var_5_5.a = 1
		arg_5_0._boardImg.color = var_5_5

		return
	end

	if arg_5_0._talentState == RougeEnum.TalentState.Activated then
		gohelper.setActive(arg_5_0._boardImg, false)

		local var_5_6 = GameUtil.parseColor("#D3CCBF")

		var_5_6.a = 1
		arg_5_0._txtDescr.color = var_5_6

		gohelper.setActive(arg_5_0._txtDescr, true)
		gohelper.setActive(arg_5_0._goStar, false)
		UISpriteSetMgr.instance:setRougeSprite(arg_5_0._icon, arg_5_0._isSpecial and "rouge_talent_point_04" or "rouge_talent_point_03")
		gohelper.setActive(arg_5_0._goLineLight, true)
		gohelper.setActive(arg_5_0._goLineLight1, true)
		gohelper.setActive(arg_5_0._goLineLight2, true)

		if arg_5_0._initState ~= arg_5_0._talentState then
			gohelper.setActive(arg_5_0._iconlight, true)
		end

		if arg_5_0._isSelected then
			gohelper.setActive(arg_5_0._goSelected, true)

			arg_5_0._isSelected = false

			arg_5_0._goSelectedAnimator:Play("close", 0, 0)
		end

		return
	end

	if arg_5_0._talentState == RougeEnum.TalentState.SiblingActivated then
		gohelper.setActive(arg_5_0._boardImg, false)
		gohelper.setActive(arg_5_0._txtDescr, true)
		gohelper.setActive(arg_5_0._goStar, false)

		arg_5_0._txtDescr.text = ""

		UISpriteSetMgr.instance:setRougeSprite(arg_5_0._icon, "rouge_talent_point_00")

		return
	end
end

function var_0_0.setSpecial(arg_6_0, arg_6_1)
	arg_6_0._isSpecial = arg_6_1
end

function var_0_0.setInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0._talentView = arg_7_1
	arg_7_0._index = arg_7_2
	arg_7_0._sliblingComp = arg_7_4
	arg_7_0._prevGroupComp = arg_7_5

	arg_7_0:updateInfo(arg_7_3)

	arg_7_0._talentId = arg_7_3.id
	arg_7_0._talentConfig = lua_rouge_style_talent.configDict[arg_7_0._talentId]
	arg_7_0._txtDescr.text = arg_7_0._talentConfig and arg_7_0._talentConfig.desc
end

function var_0_0.updateInfo(arg_8_0, arg_8_1)
	arg_8_0._talentMo = arg_8_1
end

function var_0_0.isRootPlayCloseAnim(arg_9_0)
	return arg_9_0._oldTalentState == RougeEnum.TalentState.CanActivated and arg_9_0._talentState == RougeEnum.TalentState.Activated
end

function var_0_0.isRootPlayOpenAnim(arg_10_0)
	return arg_10_0._oldTalentState == RougeEnum.TalentState.CannotActivated and arg_10_0._talentState == RougeEnum.TalentState.CanActivated
end

function var_0_0.updateState(arg_11_0, arg_11_1)
	arg_11_0._oldTalentState = arg_11_0._talentState

	arg_11_0:_checkState(arg_11_1)

	if not arg_11_0._initState then
		arg_11_0._initState = arg_11_0._talentState
	end

	arg_11_0:setState()
end

function var_0_0._checkState(arg_12_0, arg_12_1)
	if arg_12_0._talentMo.isActive == 1 then
		arg_12_0._talentState = RougeEnum.TalentState.Activated

		return
	end

	if arg_12_0._sliblingComp._talentMo.isActive == 1 then
		arg_12_0._talentState = RougeEnum.TalentState.SiblingActivated

		return
	end

	if arg_12_0:_parentGroupIsActive() and arg_12_1 then
		arg_12_0._talentState = RougeEnum.TalentState.CanActivated

		return
	end

	if arg_12_1 then
		arg_12_0._talentState = RougeEnum.TalentState.CannotActivated

		return
	end

	arg_12_0._talentState = RougeEnum.TalentState.Disabled
end

function var_0_0.canActivated(arg_13_0)
	return arg_13_0._talentState == RougeEnum.TalentState.CanActivated
end

function var_0_0.needCostTalentPoint(arg_14_0)
	return arg_14_0._talentState == RougeEnum.TalentState.CanActivated or arg_14_0._talentState == RougeEnum.TalentState.CannotActivated
end

function var_0_0._parentGroupIsActive(arg_15_0)
	if not arg_15_0._prevGroupComp then
		return true
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._prevGroupComp) do
		if iter_15_1._talentMo.isActive == 1 then
			return true
		end
	end

	return false
end

function var_0_0.onClick(arg_16_0)
	if arg_16_0._isSelected then
		return
	end

	arg_16_0._talentView:setTalentCompSelected(arg_16_0)
end

function var_0_0.setSelected(arg_17_0, arg_17_1)
	arg_17_0._isSelected = arg_17_1

	arg_17_0:setState()
end

function var_0_0.onClickConfirm(arg_18_0)
	if arg_18_0._talentState == RougeEnum.TalentState.Activated then
		return
	end

	arg_18_0._goSelectedAnimator:Play("close", 0, 0)
	arg_18_0._talentView:activeTalent(arg_18_0)
end

function var_0_0._findChild(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = gohelper.findChild(arg_19_0.viewGO, arg_19_1)

	gohelper.setActive(var_19_0, arg_19_2)

	return var_19_0
end

function var_0_0._editableAddEvents(arg_20_0)
	return
end

function var_0_0._editableRemoveEvents(arg_21_0)
	return
end

function var_0_0.onUpdateMO(arg_22_0, arg_22_1)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0.click:RemoveClickListener()
	arg_23_0.clickConfirm:RemoveClickListener()
end

return var_0_0
