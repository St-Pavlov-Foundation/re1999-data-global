module("modules.logic.dragonboat.view.DragonBoatFestivalActivityView", package.seeall)

local var_0_0 = class("DragonBoatFestivalActivityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Layout/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._goDescr = gohelper.findChild(arg_1_0.viewGO, "Root/Layout/image_Descr")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/Layout/image_Descr/#txt_Descr")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._goPuzzlePicClose = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose")
	arg_1_0._goPuzzlePicBG1 = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG1")
	arg_1_0._goPuzzlePicBG2 = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG2")
	arg_1_0._goPuzzlePicFG = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicFG")
	arg_1_0._goPuzzlePicOpen = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicOpen")
	arg_1_0._imagePuzzlePic = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")

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
	arg_4_0._goContentRoot = gohelper.findChild(arg_4_0.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	arg_4_0._mapAnimator = arg_4_0._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._items = {}
	arg_4_0._hasClickReward = false
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	DragonBoatFestivalModel.instance:setCurDay(nil)

	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	arg_6_0:addCustomEvents()
	arg_6_0._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_dragonboat_panelbg"))
	arg_6_0:_refreshItems()
	arg_6_0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
	arg_6_0._mapAnimator:Play("open", 0, 0)
	arg_6_0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(arg_6_0._getRemainTimeStr, arg_6_0, 1)
end

function var_0_0.addCustomEvents(arg_7_0)
	arg_7_0:addEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, arg_7_0._onSelectItem, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	arg_7_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_7_0._refreshFestivalItem, arg_7_0)
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CommonPropView then
		arg_8_0._hasClickReward = true

		arg_8_0:_onSelectItem()
	end
end

function var_0_0._getRemainTimeStr(arg_9_0)
	local var_9_0 = ActivityEnum.Activity.DragonBoatFestival

	arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(var_9_0)
end

function var_0_0._onSelectItem(arg_10_0)
	local var_10_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_10_1 = DragonBoatFestivalModel.instance:isGiftUnlock(var_10_0)

	arg_10_0._hasClickReward = true

	if not arg_10_0._goPuzzlePicOpen.activeSelf then
		arg_10_0:_refreshItems()
		arg_10_0:_refreshMap()

		if var_10_1 then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock("mapAni")
			arg_10_0._mapAnimator:Play("open", 0, 0)
			TaskDispatcher.runDelay(arg_10_0._openFinished, arg_10_0, 2.33)
		end
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("mapAni")

		if var_10_1 then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			arg_10_0._mapAnimator:Play("switch", 0, 0)
			TaskDispatcher.runDelay(arg_10_0._switchMap, arg_10_0, 0.35)
		else
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			arg_10_0._mapAnimator:Play("close", 0, 0)
			arg_10_0:_refreshItems()
			TaskDispatcher.runDelay(arg_10_0._closeFinished, arg_10_0, 1)
		end
	end
end

function var_0_0._closeFinished(arg_11_0)
	arg_11_0:_refreshMap()
	UIBlockMgr.instance:endBlock("mapAni")
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.ShowMapFinished)
end

function var_0_0._switchMap(arg_12_0)
	arg_12_0:_refreshItems()
	arg_12_0:_refreshMap()
	TaskDispatcher.runDelay(arg_12_0._openFinished, arg_12_0, 0.59)
end

function var_0_0._openFinished(arg_13_0)
	UIBlockMgr.instance:endBlock("mapAni")
end

function var_0_0._refreshItems(arg_14_0)
	arg_14_0:_refreshFestivalItem()

	local var_14_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_14_1 = DragonBoatFestivalConfig.instance:getDragonBoatCo(var_14_0)
	local var_14_2 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local var_14_3 = DragonBoatFestivalModel.instance:isGiftGet(var_14_2)

	if var_14_0 == var_14_2 and not var_14_3 then
		gohelper.setActive(arg_14_0._goDescr, false)

		arg_14_0._txtDescr.text = ""
	else
		gohelper.setActive(arg_14_0._goDescr, true)

		arg_14_0._txtDescr.text = var_14_1.desc
	end
end

function var_0_0._refreshFestivalItem(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[1]
	local var_15_1 = ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if not arg_15_0._items[iter_15_1.id] then
			local var_15_2 = arg_15_0:getResInst(var_15_0, arg_15_0._goContentRoot)
			local var_15_3 = DragonBoatFestivalItem.New()

			var_15_3:init(var_15_2, iter_15_1.id)

			arg_15_0._items[iter_15_1.id] = var_15_3
		else
			arg_15_0._items[iter_15_1.id]:refresh(iter_15_1.id)
		end
	end
end

function var_0_0._refreshMap(arg_16_0)
	local var_16_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_16_1 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local var_16_2 = DragonBoatFestivalModel.instance:isGiftGet(var_16_1)
	local var_16_3 = DragonBoatFestivalConfig.instance:getDragonBoatCo(var_16_0)
	local var_16_4 = DragonBoatFestivalModel.instance:isGiftUnlock(var_16_0)

	if var_16_0 == var_16_1 and not var_16_2 and not arg_16_0._hasClickReward then
		var_16_4 = false
	end

	gohelper.setActive(arg_16_0._goPuzzlePicClose, not var_16_4)
	gohelper.setActive(arg_16_0._goPuzzlePicOpen, var_16_4)
	UISpriteSetMgr.instance:setDragonBoatSprite(arg_16_0._imagePuzzlePic, var_16_3.dayicon)
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:removeCustomEvents()
end

function var_0_0.removeCustomEvents(arg_18_0)
	arg_18_0:removeEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, arg_18_0._onSelectItem, arg_18_0)
	arg_18_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_18_0._onCloseViewFinish, arg_18_0)
	arg_18_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_18_0._refreshFestivalItem, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._getRemainTimeStr, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._closeToOpen, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._openFinished, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._closeFinished, arg_19_0)

	if arg_19_0._items then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._items) do
			iter_19_1:destroy()
		end
	end
end

return var_0_0
