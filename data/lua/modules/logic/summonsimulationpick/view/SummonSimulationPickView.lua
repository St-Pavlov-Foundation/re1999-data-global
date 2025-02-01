module("modules.logic.summonsimulationpick.view.SummonSimulationPickView", package.seeall)

slot0 = class("SummonSimulationPickView", BaseView)
slot0.SELECT_BG_OFFSET_X = -29.8
slot0.SELECT_BG_OFFSET_Y = 22.9
slot0.SAVE_ANIMATION = "save"
slot0.NORMAL_ANIMATION = "open"

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagedec = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg/#simage_dec")
	slot0._simagecurrent = gohelper.findChildSingleImage(slot0.viewGO, "go_saveresult/unsave/#simage_current")
	slot0._simagesaved = gohelper.findChildSingleImage(slot0.viewGO, "go_saveresult/unsave/#simage_saved")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_saveresult/unsave/Btn/#btn_cancel")
	slot0._btnconfirmsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_saveresult/unsave/Btn/#btn_confirmsave")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtresttime = gohelper.findChildText(slot0.viewGO, "go_confirmresult/select/rest/#txt_resttime")
	slot0._simageselectframe = gohelper.findChildSingleImage(slot0.viewGO, "go_confirmresult/select/#simage_selectframe")
	slot0._btnconfirmselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirmresult/select/#btn_confirmselect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirmsave:AddClickListener(slot0._btnconfirmsaveOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosepage:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnconfirmselect:AddClickListener(slot0._btnconfirmselectOnClick, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSaveResult, slot0.onSaveResult, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, slot0.closeThis, slot0)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectItem, slot0._btnSelectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirmsave:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosepage:RemoveClickListener()
	slot0._btnconfirmselect:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSaveResult, slot0.onSaveResult, slot0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, slot0.closeThis, slot0)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectItem, slot0._btnSelectOnClick, slot0)
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmsaveOnClick(slot0)
	SummonSimulationPickController.instance:saveResult(slot0._activityId)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmselectOnClick(slot0)
	SummonSimulationPickController.instance:selectResult(slot0._activityId, slot0.selectType)
end

function slot0._btnSelectOnClick(slot0, slot1)
	if slot0.pickType == SummonSimulationEnum.PickType.SaveResult then
		return
	end

	slot2 = SummonSimulationPickModel.instance:getActInfo(slot0._activityId)

	if slot2.leftTimes == slot2.maxCount - 1 or slot2.currentHeroIds == nil or #slot2.currentHeroIds <= 0 then
		return
	end

	slot3 = slot0._goSelectBg

	if slot0.selectType and slot0.selectType == slot1 then
		gohelper.setActive(slot3, false)

		slot0.selectType = slot0:_getDefaultState()

		slot0:_refreshConfirmBtnState()

		return
	end

	slot0.selectType = slot1
	slot3.transform.parent = slot1 == SummonSimulationEnum.SaveType.Current and slot0._summonCurrentResultComp:getTransform() or slot0._summonPreviousResultComp:getTransform()

	transformhelper.setLocalPosXY(slot3.transform, slot0.SELECT_BG_OFFSET_X, slot0.SELECT_BG_OFFSET_Y)
	gohelper.setActive(slot3, true)
	slot0:_refreshConfirmBtnState()
end

function slot0._editableInitView(slot0)
	slot0._goSaveCurrentResult = gohelper.findChild(slot0.viewGO, "go_saveresult/unsave/go_current/#go_summonpickitem")
	slot0._goSavePreviousResult = gohelper.findChild(slot0.viewGO, "go_saveresult/unsave/go_saved/#go_summonpickitem")
	slot0._goSaveSavedResult = gohelper.findChild(slot0.viewGO, "go_saveresult/go_single/#go_summonpickitem")
	slot0._goConfirmCurrentResult = gohelper.findChild(slot0.viewGO, "go_confirmresult/go_current/#go_summonpickitem")
	slot0._goConfirmPreviousResult = gohelper.findChild(slot0.viewGO, "go_confirmresult/go_saved/#go_summonpickitem")
	slot0._goConfirmSavedResult = gohelper.findChild(slot0.viewGO, "go_confirmresult/go_single/#go_summonpickitem")
	slot0._goSaveRoot = gohelper.findChild(slot0.viewGO, "go_saveresult")
	slot0._goConfirmRoot = gohelper.findChild(slot0.viewGO, "go_confirmresult")
	slot0._goSaveSelectRoot = gohelper.findChild(slot0.viewGO, "go_saveresult/saved")
	slot0._goSaveUnSelectRoot = gohelper.findChild(slot0.viewGO, "go_saveresult/unsave")
	slot0._goConfirmSelectRoot = gohelper.findChild(slot0.viewGO, "go_confirmresult/select")
	slot0._goConfirmUnSelectRoot = gohelper.findChild(slot0.viewGO, "go_confirmresult/unselect")
	slot0._goSelectBg = gohelper.findChild(slot0.viewGO, "go_confirmresult/#simage_selectframe")
	slot0._btnclosepage = gohelper.findChildButton(slot0.viewGO, "#simage_fullbg")
	slot0._animator = gohelper.findChildComponent(slot0.viewGO, "", gohelper.Type_Animator)
	slot1 = slot0.viewContainer
	slot2 = slot1._viewSetting.otherRes[1]
	slot0._summonPreviousResultComp = SummonSimulationPickItem.New()

	slot0._summonPreviousResultComp:init(slot1:getResInst(slot2, slot0.viewGO))

	slot0._summonCurrentResultComp = SummonSimulationPickItem.New()

	slot0._summonCurrentResultComp:init(slot1:getResInst(slot2, slot0.viewGO))

	slot0._summonSavedResultComp = SummonSimulationPickItem.New()

	slot0._summonSavedResultComp:init(slot1:getResInst(slot2, slot0.viewGO))
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0._animator:Play(slot0.NORMAL_ANIMATION, 0, 0)
	slot0:_refreshState()
end

function slot0._resetSelectState(slot0, slot1, slot2)
	slot3 = slot0._goSelectBg

	if slot1 then
		slot3.transform.parent = slot2:getTransform()

		transformhelper.setLocalPosXY(slot3.transform, slot0.SELECT_BG_OFFSET_X, slot0.SELECT_BG_OFFSET_Y)
		gohelper.setActive(slot3, true)
	else
		gohelper.setActive(slot0._goSelectBg, false)
	end

	slot0.selectType = slot0:_getDefaultState()

	slot0:_refreshConfirmBtnState()
end

function slot0.onSaveResult(slot0, slot1)
	if slot1 ~= slot0._activityId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2SummonSimulation.play_ui_mln_day_night)

	slot2 = slot0._summonSavedResultComp
	slot3 = SummonSimulationPickModel.instance:getActInfo(slot1)

	if slot3.leftTimes < slot3.maxCount - 1 then
		GameFacade.showToast(ToastEnum.SummonSimulationSaveResult)
	end

	slot2:setActive(true)
	slot2:setParent(slot0._goSaveSavedResult)
	gohelper.setActive(slot0._goSaveSelectRoot, true)
	gohelper.setActive(slot0._goSaveSavedResult.transform.parent, true)
	slot2:refreshData(slot3.saveHeroIds)
	slot0:_resetSelectState(false, slot2)
	slot0._animator:Play(slot0.SAVE_ANIMATION, 0, 0)
end

function slot0._getDefaultState(slot0)
	slot1 = SummonSimulationPickModel.instance:getActInfo(slot0._activityId)

	if slot0.pickType == SummonSimulationEnum.PickType.SaveResult and slot1:haveSaveCurrent() or slot1:haveSelect() then
		return SummonSimulationEnum.SaveType.Saved
	end

	return nil
end

function slot0._refreshConfirmBtnState(slot0)
	if slot0.pickType == SummonSimulationEnum.PickType.SaveResult then
		slot3 = SummonSimulationPickModel.instance:getActInfo(slot0._activityId):haveSaveCurrent()

		gohelper.setActive(slot0._goSaveUnSelectRoot, not slot3)
		gohelper.setActive(slot0._goSaveSelectRoot, slot3)
	else
		slot2 = slot0.selectType ~= nil

		gohelper.setActive(slot0._goConfirmUnSelectRoot, not slot2)
		gohelper.setActive(slot0._goConfirmSelectRoot, slot2)
	end
end

function slot0._refreshState(slot0)
	slot1 = slot0.viewParam
	slot2 = slot1.pickType
	slot0.pickType = slot2
	slot3 = slot1.activityId
	slot0._activityId = slot3
	slot4 = SummonSimulationPickModel.instance:getActInfo(slot3)
	slot5 = slot2 == SummonSimulationEnum.PickType.SaveResult

	gohelper.setActive(slot0._goSaveRoot, slot5)
	gohelper.setActive(slot0._goConfirmRoot, not slot5)

	slot9 = slot5 and slot4:haveSaveCurrent() or slot4:haveSelect()

	gohelper.setActive((slot5 and slot0._goSaveSavedResult or slot0._goConfirmSavedResult).transform.parent, slot9)
	gohelper.setActive((slot5 and slot0._goSaveCurrentResult or slot0._goConfirmCurrentResult).transform.parent, not slot9)
	gohelper.setActive((slot5 and slot0._goSavePreviousResult or slot0._goConfirmPreviousResult).transform.parent, not slot9)
	slot0._summonCurrentResultComp:setActive(not slot9)
	slot0._summonPreviousResultComp:setActive(not slot9)
	slot0._summonSavedResultComp:setActive(slot9)

	if not slot9 then
		slot12:setParent(slot7)
		slot12:refreshData(slot4.currentHeroIds, SummonSimulationEnum.SaveType.Current)
		slot13:setParent(slot8)
		slot13:refreshData(slot4.saveHeroIds, SummonSimulationEnum.SaveType.Saved)
	else
		slot14:setParent(slot6)
		slot14:refreshData(slot11, SummonSimulationEnum.SaveType.Saved)
	end

	if not slot5 then
		if not slot4:haveSelect() then
			-- Nothing
		end

		slot0.selectType = SummonSimulationEnum.SaveType.Saved
		slot0._txtresttime.text = string.format("<#E99B56>%s</color></size>/%s", slot4.leftTimes, slot4.maxCount)
	end

	slot0:_resetSelectState(slot9 and not slot5, slot14)
end

function slot0.onDestroyView(slot0)
	slot0._summonCurrentResultComp:onDestroy()
	slot0._summonPreviousResultComp:onDestroy()
	slot0._summonSavedResultComp:onDestroy()
end

return slot0
