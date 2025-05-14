module("modules.logic.fight.view.FightFocusCameraAdjustView", package.seeall)

local var_0_0 = class("FightFocusCameraAdjustView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gooffset = gohelper.findChild(arg_1_0.viewGO, "#go_container/component/#go_offset")
	arg_1_0._gooffset1 = gohelper.findChild(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset1")
	arg_1_0._gooffset2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset2")
	arg_1_0._gooffset3 = gohelper.findChild(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset3")
	arg_1_0._btnsaveOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	arg_1_0._btnresetOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_close")
	arg_1_0._txtskinId = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/label/#txt_skinId")
	arg_1_0._txtoffset = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/label/#txt_offset")
	arg_1_0._gomiddlecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_middlecontainer")
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "#go_middlecontainer/#go_middle")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnsaveOffset:AddClickListener(arg_2_0._btnsaveOffsetOnClick, arg_2_0)
	arg_2_0._btnresetOffset:AddClickListener(arg_2_0._btnresetOffsetOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnsaveOffset:RemoveClickListener()
	arg_3_0._btnresetOffset:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

var_0_0.SliderMaxValue = 50
var_0_0.SliderMinValue = -50
var_0_0.OffsetKey = {
	Z = "z",
	X = "x",
	Y = "y"
}

function var_0_0._btnblockOnClick(arg_4_0)
	return
end

function var_0_0._btnsaveOffsetOnClick(arg_5_0)
	return
end

function var_0_0._btnresetOffsetOnClick(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.sliderDict) do
		iter_6_1.slider:SetValue(0)
	end
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._onSliderValueChanged(arg_8_0)
	if not arg_8_0.initDone then
		return
	end

	local var_8_0 = arg_8_0.sliderDict[var_0_0.OffsetKey.X].slider:GetValue()
	local var_8_1 = arg_8_0.sliderDict[var_0_0.OffsetKey.Y].slider:GetValue()
	local var_8_2 = arg_8_0.sliderDict[var_0_0.OffsetKey.Z].slider:GetValue()

	arg_8_0.sliderDict[var_0_0.OffsetKey.X].text.text = var_8_0
	arg_8_0.sliderDict[var_0_0.OffsetKey.Y].text.text = var_8_1
	arg_8_0.sliderDict[var_0_0.OffsetKey.Z].text.text = var_8_2

	FightWorkFocusMonster.changeCameraPosition(var_8_0, var_8_1, var_8_2, arg_8_0.updateEntityMiddlePosition, arg_8_0)
	arg_8_0:refreshOffsetLabel(var_8_0, var_8_1, var_8_2)
end

function var_0_0.addBtnClick(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.slider:GetValue() + tonumber(arg_9_1.intervalField:GetText())

	arg_9_1.slider:SetValue(var_9_0)
end

function var_0_0.reduceBtnClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.slider:GetValue() - tonumber(arg_10_1.intervalField:GetText())

	arg_10_1.slider:SetValue(var_10_0)
end

function var_0_0._initSlider(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = gohelper.findChildSlider(arg_11_1, "slider_offset")

	var_11_0.slider.maxValue = var_0_0.SliderMaxValue
	var_11_0.slider.minValue = var_0_0.SliderMinValue

	var_11_0:AddOnValueChanged(arg_11_0._onSliderValueChanged, arg_11_0)
	var_11_0:SetValue(0)

	local var_11_1 = gohelper.findChildText(arg_11_1, "txt_offset")
	local var_11_2 = gohelper.findChildButtonWithAudio(arg_11_1, "AddBtn")
	local var_11_3 = gohelper.findChildButtonWithAudio(arg_11_1, "ReduceBtn")
	local var_11_4 = gohelper.findChildTextMeshInputField(arg_11_1, "IntervalField")
	local var_11_5 = arg_11_0:getUserDataTb_()

	var_11_5.slider = var_11_0
	var_11_5.text = var_11_1
	var_11_5.addBtn = var_11_2
	var_11_5.reduceBtn = var_11_3
	var_11_5.intervalField = var_11_4

	var_11_2:AddClickListener(arg_11_0.addBtnClick, arg_11_0, var_11_5)
	var_11_3:AddClickListener(arg_11_0.reduceBtnClick, arg_11_0, var_11_5)
	var_11_4:SetText(1)

	var_11_1.text = 0
	arg_11_0.sliderDict[arg_11_2] = var_11_5
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.initDone = false
	arg_12_0.sliderDict = arg_12_0:getUserDataTb_()

	arg_12_0:_initSlider(arg_12_0._gooffset1, var_0_0.OffsetKey.X)
	arg_12_0:_initSlider(arg_12_0._gooffset2, var_0_0.OffsetKey.Y)
	arg_12_0:_initSlider(arg_12_0._gooffset3, var_0_0.OffsetKey.Z)

	arg_12_0.unitCamera = CameraMgr.instance:getUnitCamera()
	arg_12_0.initDone = true
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:initEntity()

	arg_14_0._txtskinId.text = "皮肤ID : " .. arg_14_0:getFocusSkinId()

	arg_14_0:refreshOffsetLabel(0, 0, 0)
	FightWorkFocusMonster.changeCameraPosition(0, 0, 0, arg_14_0.updateEntityMiddlePosition, arg_14_0)
end

function var_0_0.getFocusSkinId(arg_15_0)
	return arg_15_0.entity and arg_15_0.entity:getMO().skin or ""
end

function var_0_0.initEntity(arg_16_0)
	local var_16_0 = ViewMgr.instance:getContainer(ViewName.FightSkillSelectView)

	if not var_16_0 then
		arg_16_0.entity = nil

		return
	end

	local var_16_1 = var_16_0._views[1]:getCurrentFocusEntityId()

	if not var_16_1 then
		arg_16_0.entity = nil

		return
	end

	local var_16_2 = FightHelper.getEntity(var_16_1)

	if not var_16_2 then
		arg_16_0.entity = nil

		return
	end

	arg_16_0.entity = var_16_2
	arg_16_0.mountMiddleGo = arg_16_0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
end

function var_0_0.refreshOffsetLabel(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._txtoffset.text = string.format("X : <color=red>%.4f</color>;    Y : <color=red>%.4f</color>;    Z : <color=red>%.4f</color>", arg_17_1, arg_17_2, arg_17_3)
end

function var_0_0.updateEntityMiddlePosition(arg_18_0)
	if not arg_18_0.mountMiddleGo then
		return
	end

	local var_18_0 = recthelper.worldPosToAnchorPos(arg_18_0.mountMiddleGo.transform.position, arg_18_0._gomiddlecontainer.transform, nil, arg_18_0.unitCamera)

	recthelper.setAnchor(arg_18_0._gomiddle.transform, var_18_0.x, var_18_0.y)
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.sliderDict) do
		iter_19_1.slider:RemoveOnValueChanged()
		iter_19_1.addBtn:RemoveClickListener()
		iter_19_1.reduceBtn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
