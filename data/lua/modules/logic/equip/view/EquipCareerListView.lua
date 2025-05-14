module("modules.logic.equip.view.EquipCareerListView", package.seeall)

local var_0_0 = class("EquipCareerListView", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.careerGoDrop = arg_1_1
	arg_1_0.careerDropClick = gohelper.findChildClick(arg_1_0.careerGoDrop, "clickArea")
	arg_1_0.careerGoTemplateContainer = gohelper.findChild(arg_1_0.careerGoDrop, "Template")
	arg_1_0.careerGoItem = gohelper.findChild(arg_1_0.careerGoDrop, "Template/Viewport/Content/Item")
	arg_1_0.txtLabel = gohelper.findChildText(arg_1_0.careerGoDrop, "Label")
	arg_1_0.iconLabel = gohelper.findChildImage(arg_1_0.careerGoDrop, "Icon")

	gohelper.setActive(arg_1_0.careerGoItem, false)
	arg_1_0.careerDropClick:AddClickListener(arg_1_0.onCareerDropClick, arg_1_0)

	arg_1_0.showingTemplateContainer = false
	arg_1_0.careerItemList = {}
	arg_1_0.itemCallback = arg_1_2
	arg_1_0.itemCallbackObj = arg_1_3
	arg_1_0.rectList = {}

	arg_1_0:initMoData()
	arg_1_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_1_0._onTouch, arg_1_0)
end

function var_0_0.initMoData(arg_2_0)
	arg_2_0.careerValueList = {
		EquipHelper.CareerValue.All,
		EquipHelper.CareerValue.Rock,
		EquipHelper.CareerValue.Star,
		EquipHelper.CareerValue.Wood,
		EquipHelper.CareerValue.Animal,
		EquipHelper.CareerValue.SAW
	}
	arg_2_0.careerMoList = {}
	arg_2_0.careerMoDict = {}

	local var_2_0 = {
		txt = luaLang("common_all")
	}

	var_2_0.iconName = nil
	var_2_0.career = arg_2_0.careerValueList[1]
	arg_2_0.careerMoDict[arg_2_0.careerValueList[1]] = var_2_0

	table.insert(arg_2_0.careerMoList, var_2_0)

	for iter_2_0 = 2, 6 do
		local var_2_1 = {}

		var_2_1.txt = nil
		var_2_1.iconName = "career_" .. arg_2_0.careerValueList[iter_2_0]
		var_2_1.career = arg_2_0.careerValueList[iter_2_0]
		arg_2_0.careerMoDict[arg_2_0.careerValueList[iter_2_0]] = var_2_1

		table.insert(arg_2_0.careerMoList, var_2_1)
	end
end

function var_0_0.onCareerDropClick(arg_3_0)
	arg_3_0.showingTemplateContainer = not arg_3_0.showingTemplateContainer

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
	gohelper.setActive(arg_3_0.careerGoTemplateContainer, arg_3_0.showingTemplateContainer)
	gohelper.setAsLastSibling(arg_3_0.careerGoTemplateContainer)
end

function var_0_0.onCareerItemClick(arg_4_0, arg_4_1)
	arg_4_0:setSelectCareer(arg_4_1.career)
	arg_4_0:refreshCareerLabel()
	arg_4_0:refreshCareerSelect()

	arg_4_0.showingTemplateContainer = false

	gohelper.setActive(arg_4_0.careerGoTemplateContainer, false)

	if arg_4_0.itemCallback then
		if arg_4_0.itemCallbackObj then
			arg_4_0.itemCallback(arg_4_0.itemCallbackObj, arg_4_1)
		else
			arg_4_0.itemCallback(arg_4_1)
		end
	end
end

function var_0_0.initTouchRectList(arg_5_0)
	table.insert(arg_5_0.rectList, arg_5_0:getRectTransformTouchRect(arg_5_0.careerDropClick.transform))
	table.insert(arg_5_0.rectList, arg_5_0:getRectTransformTouchRect(arg_5_0.careerGoTemplateContainer.transform))
end

function var_0_0.getRectTransformTouchRect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetWorldCorners()
	local var_6_1 = CameraMgr.instance:getUICamera()
	local var_6_2 = var_6_1:WorldToScreenPoint(var_6_0[0])
	local var_6_3 = var_6_1:WorldToScreenPoint(var_6_0[1])
	local var_6_4 = var_6_1:WorldToScreenPoint(var_6_0[2])
	local var_6_5 = var_6_1:WorldToScreenPoint(var_6_0[3])

	return {
		var_6_2,
		var_6_3,
		var_6_4,
		var_6_5
	}
end

function var_0_0._onTouch(arg_7_0)
	if not next(arg_7_0.rectList) then
		logWarn("touch area not init")

		return
	end

	local var_7_0 = GamepadController.instance:getMousePosition()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rectList) do
		if GameUtil.checkPointInRectangle(var_7_0, iter_7_1[1], iter_7_1[2], iter_7_1[3], iter_7_1[4]) then
			return
		end
	end

	arg_7_0.showingTemplateContainer = false

	gohelper.setActive(arg_7_0.careerGoTemplateContainer, false)
end

function var_0_0.getCareerMoList(arg_8_0)
	return arg_8_0.careerMoList
end

function var_0_0.setSelectCareer(arg_9_0, arg_9_1)
	arg_9_0.selectCareer = arg_9_1
end

function var_0_0.getSelectCareer(arg_10_0)
	return arg_10_0.selectCareer or EquipHelper.CareerValue.All
end

function var_0_0.getSelectCareerMo(arg_11_0)
	return arg_11_0.careerMoDict[arg_11_0:getSelectCareer()]
end

function var_0_0.refreshCareerSelect(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.careerItemList) do
		iter_12_1:refreshSelect(arg_12_0:getSelectCareer())
	end
end

function var_0_0.refreshCareerLabel(arg_13_0)
	local var_13_0 = arg_13_0:getSelectCareerMo()

	if not var_13_0 then
		logError("not set selected career, please check code!")

		return
	end

	if var_13_0.txt then
		arg_13_0.txtLabel.text = var_13_0.txt

		gohelper.setActive(arg_13_0.txtLabel.gameObject, true)
	else
		gohelper.setActive(arg_13_0.txtLabel.gameObject, false)
	end

	if var_13_0.iconName then
		UISpriteSetMgr.instance:setCommonSprite(arg_13_0.iconLabel, var_13_0.iconName)
		gohelper.setActive(arg_13_0.iconLabel.gameObject, true)
	else
		gohelper.setActive(arg_13_0.iconLabel.gameObject, false)
	end
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:setSelectCareer(EquipHelper.CareerValue.All)

	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.careerMoList) do
		local var_14_1 = EquipCareerItem.New()

		var_14_1:onInitView(gohelper.cloneInPlace(arg_14_0.careerGoItem, "career_" .. iter_14_1.career), arg_14_0.onCareerItemClick, arg_14_0)
		var_14_1:onUpdateMO(iter_14_1)
		table.insert(arg_14_0.careerItemList, var_14_1)
	end

	arg_14_0:initTouchRectList()
	arg_14_0:refreshCareerSelect()
	arg_14_0:refreshCareerLabel()
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0.careerDropClick:RemoveClickListener()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.careerItemList) do
		iter_15_1:onDestroyView()
	end

	arg_15_0.careerItemList = nil
	arg_15_0.careerMoList = nil
	arg_15_0.careerMoDict = nil

	arg_15_0:__onDispose()
end

return var_0_0
