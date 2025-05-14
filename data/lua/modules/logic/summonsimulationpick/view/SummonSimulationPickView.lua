module("modules.logic.summonsimulationpick.view.SummonSimulationPickView", package.seeall)

local var_0_0 = class("SummonSimulationPickView", BaseView)

var_0_0.SELECT_BG_OFFSET_X = -29.8
var_0_0.SELECT_BG_OFFSET_Y = 22.9
var_0_0.SAVE_ANIMATION = "save"
var_0_0.NORMAL_ANIMATION = "open"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagedec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#simage_dec")
	arg_1_0._simagecurrent = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_saveresult/unsave/#simage_current")
	arg_1_0._simagesaved = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_saveresult/unsave/#simage_saved")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_saveresult/unsave/Btn/#btn_cancel")
	arg_1_0._btnconfirmsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_saveresult/unsave/Btn/#btn_confirmsave")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtresttime = gohelper.findChildText(arg_1_0.viewGO, "go_confirmresult/select/rest/#txt_resttime")
	arg_1_0._simageselectframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_confirmresult/select/#simage_selectframe")
	arg_1_0._btnconfirmselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_confirmresult/select/#btn_confirmselect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirmsave:AddClickListener(arg_2_0._btnconfirmsaveOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosepage:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnconfirmselect:AddClickListener(arg_2_0._btnconfirmselectOnClick, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSaveResult, arg_2_0.onSaveResult, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, arg_2_0.closeThis, arg_2_0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectItem, arg_2_0._btnSelectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirmsave:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosepage:RemoveClickListener()
	arg_3_0._btnconfirmselect:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSaveResult, arg_3_0.onSaveResult, arg_3_0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, arg_3_0.closeThis, arg_3_0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectItem, arg_3_0._btnSelectOnClick, arg_3_0)
end

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnconfirmsaveOnClick(arg_5_0)
	SummonSimulationPickController.instance:saveResult(arg_5_0._activityId)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnconfirmselectOnClick(arg_7_0)
	SummonSimulationPickController.instance:selectResult(arg_7_0._activityId, arg_7_0.selectType)
end

function var_0_0._btnSelectOnClick(arg_8_0, arg_8_1)
	if arg_8_0.pickType == SummonSimulationEnum.PickType.SaveResult then
		return
	end

	local var_8_0 = SummonSimulationPickModel.instance:getActInfo(arg_8_0._activityId)

	if var_8_0.leftTimes == var_8_0.maxCount - 1 or var_8_0.currentHeroIds == nil or #var_8_0.currentHeroIds <= 0 then
		return
	end

	local var_8_1 = arg_8_0._goSelectBg

	if arg_8_0.selectType and arg_8_0.selectType == arg_8_1 then
		gohelper.setActive(var_8_1, false)

		arg_8_0.selectType = arg_8_0:_getDefaultState()

		arg_8_0:_refreshConfirmBtnState()

		return
	end

	arg_8_0.selectType = arg_8_1

	local var_8_2 = arg_8_1 == SummonSimulationEnum.SaveType.Current and arg_8_0._summonCurrentResultComp:getTransform() or arg_8_0._summonPreviousResultComp:getTransform()

	var_8_1.transform.parent = var_8_2

	transformhelper.setLocalPosXY(var_8_1.transform, arg_8_0.SELECT_BG_OFFSET_X, arg_8_0.SELECT_BG_OFFSET_Y)
	gohelper.setActive(var_8_1, true)
	arg_8_0:_refreshConfirmBtnState()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goSaveCurrentResult = gohelper.findChild(arg_9_0.viewGO, "go_saveresult/unsave/go_current/#go_summonpickitem")
	arg_9_0._goSavePreviousResult = gohelper.findChild(arg_9_0.viewGO, "go_saveresult/unsave/go_saved/#go_summonpickitem")
	arg_9_0._goSaveSavedResult = gohelper.findChild(arg_9_0.viewGO, "go_saveresult/go_single/#go_summonpickitem")
	arg_9_0._goConfirmCurrentResult = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/go_current/#go_summonpickitem")
	arg_9_0._goConfirmPreviousResult = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/go_saved/#go_summonpickitem")
	arg_9_0._goConfirmSavedResult = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/go_single/#go_summonpickitem")
	arg_9_0._goSaveRoot = gohelper.findChild(arg_9_0.viewGO, "go_saveresult")
	arg_9_0._goConfirmRoot = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult")
	arg_9_0._goSaveSelectRoot = gohelper.findChild(arg_9_0.viewGO, "go_saveresult/saved")
	arg_9_0._goSaveUnSelectRoot = gohelper.findChild(arg_9_0.viewGO, "go_saveresult/unsave")
	arg_9_0._goConfirmSelectRoot = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/select")
	arg_9_0._goConfirmUnSelectRoot = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/unselect")
	arg_9_0._goSelectBg = gohelper.findChild(arg_9_0.viewGO, "go_confirmresult/#simage_selectframe")
	arg_9_0._btnclosepage = gohelper.findChildButton(arg_9_0.viewGO, "#simage_fullbg")
	arg_9_0._animator = gohelper.findChildComponent(arg_9_0.viewGO, "", gohelper.Type_Animator)

	local var_9_0 = arg_9_0.viewContainer
	local var_9_1 = var_9_0._viewSetting.otherRes[1]
	local var_9_2 = var_9_0:getResInst(var_9_1, arg_9_0.viewGO)
	local var_9_3 = var_9_0:getResInst(var_9_1, arg_9_0.viewGO)
	local var_9_4 = var_9_0:getResInst(var_9_1, arg_9_0.viewGO)

	arg_9_0._summonPreviousResultComp = SummonSimulationPickItem.New()

	arg_9_0._summonPreviousResultComp:init(var_9_2)

	arg_9_0._summonCurrentResultComp = SummonSimulationPickItem.New()

	arg_9_0._summonCurrentResultComp:init(var_9_3)

	arg_9_0._summonSavedResultComp = SummonSimulationPickItem.New()

	arg_9_0._summonSavedResultComp:init(var_9_4)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshUI()
end

function var_0_0._refreshUI(arg_11_0)
	arg_11_0._animator:Play(arg_11_0.NORMAL_ANIMATION, 0, 0)
	arg_11_0:_refreshState()
end

function var_0_0._resetSelectState(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._goSelectBg

	if arg_12_1 then
		var_12_0.transform.parent = arg_12_2:getTransform()

		transformhelper.setLocalPosXY(var_12_0.transform, arg_12_0.SELECT_BG_OFFSET_X, arg_12_0.SELECT_BG_OFFSET_Y)
		gohelper.setActive(var_12_0, true)
	else
		gohelper.setActive(arg_12_0._goSelectBg, false)
	end

	arg_12_0.selectType = arg_12_0:_getDefaultState()

	arg_12_0:_refreshConfirmBtnState()
end

function var_0_0.onSaveResult(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0._activityId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2SummonSimulation.play_ui_mln_day_night)

	local var_13_0 = arg_13_0._summonSavedResultComp
	local var_13_1 = SummonSimulationPickModel.instance:getActInfo(arg_13_1)

	if var_13_1.leftTimes < var_13_1.maxCount - 1 then
		GameFacade.showToast(ToastEnum.SummonSimulationSaveResult)
	end

	var_13_0:setActive(true)
	var_13_0:setParent(arg_13_0._goSaveSavedResult)
	gohelper.setActive(arg_13_0._goSaveSelectRoot, true)
	gohelper.setActive(arg_13_0._goSaveSavedResult.transform.parent, true)
	var_13_0:refreshData(var_13_1.saveHeroIds)
	arg_13_0:_resetSelectState(false, var_13_0)
	arg_13_0._animator:Play(arg_13_0.SAVE_ANIMATION, 0, 0)
end

function var_0_0._getDefaultState(arg_14_0)
	local var_14_0 = SummonSimulationPickModel.instance:getActInfo(arg_14_0._activityId)

	if arg_14_0.pickType == SummonSimulationEnum.PickType.SaveResult and var_14_0:haveSaveCurrent() or var_14_0:haveSelect() then
		return SummonSimulationEnum.SaveType.Saved
	end

	return nil
end

function var_0_0._refreshConfirmBtnState(arg_15_0)
	if arg_15_0.pickType == SummonSimulationEnum.PickType.SaveResult then
		local var_15_0 = SummonSimulationPickModel.instance:getActInfo(arg_15_0._activityId):haveSaveCurrent()

		gohelper.setActive(arg_15_0._goSaveUnSelectRoot, not var_15_0)
		gohelper.setActive(arg_15_0._goSaveSelectRoot, var_15_0)
	else
		local var_15_1 = arg_15_0.selectType ~= nil

		gohelper.setActive(arg_15_0._goConfirmUnSelectRoot, not var_15_1)
		gohelper.setActive(arg_15_0._goConfirmSelectRoot, var_15_1)
	end
end

function var_0_0._refreshState(arg_16_0)
	local var_16_0 = arg_16_0.viewParam
	local var_16_1 = var_16_0.pickType

	arg_16_0.pickType = var_16_1

	local var_16_2 = var_16_0.activityId

	arg_16_0._activityId = var_16_2

	local var_16_3 = SummonSimulationPickModel.instance:getActInfo(var_16_2)
	local var_16_4 = var_16_1 == SummonSimulationEnum.PickType.SaveResult

	gohelper.setActive(arg_16_0._goSaveRoot, var_16_4)
	gohelper.setActive(arg_16_0._goConfirmRoot, not var_16_4)

	local var_16_5 = var_16_4 and arg_16_0._goSaveSavedResult or arg_16_0._goConfirmSavedResult
	local var_16_6 = var_16_4 and arg_16_0._goSaveCurrentResult or arg_16_0._goConfirmCurrentResult
	local var_16_7 = var_16_4 and arg_16_0._goSavePreviousResult or arg_16_0._goConfirmPreviousResult
	local var_16_8 = var_16_4 and var_16_3:haveSaveCurrent() or var_16_3:haveSelect()
	local var_16_9 = var_16_3.currentHeroIds
	local var_16_10 = var_16_3.saveHeroIds
	local var_16_11 = arg_16_0._summonCurrentResultComp
	local var_16_12 = arg_16_0._summonPreviousResultComp
	local var_16_13 = arg_16_0._summonSavedResultComp

	gohelper.setActive(var_16_5.transform.parent, var_16_8)
	gohelper.setActive(var_16_6.transform.parent, not var_16_8)
	gohelper.setActive(var_16_7.transform.parent, not var_16_8)
	var_16_11:setActive(not var_16_8)
	var_16_12:setActive(not var_16_8)
	var_16_13:setActive(var_16_8)

	if not var_16_8 then
		var_16_11:setParent(var_16_6)
		var_16_11:refreshData(var_16_9, SummonSimulationEnum.SaveType.Current)
		var_16_12:setParent(var_16_7)
		var_16_12:refreshData(var_16_10, SummonSimulationEnum.SaveType.Saved)
	else
		var_16_13:setParent(var_16_5)
		var_16_13:refreshData(var_16_10, SummonSimulationEnum.SaveType.Saved)
	end

	if not var_16_4 and (var_16_3:haveSelect() or true) then
		arg_16_0.selectType = SummonSimulationEnum.SaveType.Saved
		arg_16_0._txtresttime.text = string.format("<#E99B56>%s</color></size>/%s", var_16_3.leftTimes, var_16_3.maxCount)
	end

	arg_16_0:_resetSelectState(var_16_8 and not var_16_4, var_16_13)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._summonCurrentResultComp:onDestroy()
	arg_17_0._summonPreviousResultComp:onDestroy()
	arg_17_0._summonSavedResultComp:onDestroy()
end

return var_0_0
