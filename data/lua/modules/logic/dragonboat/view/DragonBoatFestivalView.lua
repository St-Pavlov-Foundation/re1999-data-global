module("modules.logic.dragonboat.view.DragonBoatFestivalView", package.seeall)

local var_0_0 = class("DragonBoatFestivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageLogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Logo")
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
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goContentRoot = gohelper.findChild(arg_5_0.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	arg_5_0._mapAnimator = arg_5_0._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._viewAni = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._viewAni.enabled = true
	arg_5_0._items = {}
	arg_5_0._hasClickReward = false
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	DragonBoatFestivalModel.instance:setCurDay(nil)
	arg_7_0:addCustomEvents()
	arg_7_0._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_dragonboat_panelbg"))
	arg_7_0._simageLogo:LoadImage(ResUrl.getV1a9LogoSingleBg("v1a9_logo2"))
	arg_7_0:_refreshItems()
	arg_7_0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
	arg_7_0._mapAnimator:Play("open", 0, 0)
	arg_7_0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(arg_7_0._getRemainTimeStr, arg_7_0, 1)
end

function var_0_0.addCustomEvents(arg_8_0)
	arg_8_0:addEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, arg_8_0._onSelectItem, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_8_0._refreshFestivalItem, arg_8_0)
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CommonPropView then
		arg_9_0._hasClickReward = true

		arg_9_0:_onSelectItem()
	end
end

function var_0_0._getRemainTimeStr(arg_10_0)
	local var_10_0 = ActivityEnum.Activity.DragonBoatFestival

	arg_10_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(var_10_0)
end

function var_0_0._onSelectItem(arg_11_0)
	local var_11_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_11_1 = DragonBoatFestivalModel.instance:isGiftUnlock(var_11_0)

	arg_11_0._hasClickReward = true

	if not arg_11_0._goPuzzlePicOpen.activeSelf then
		arg_11_0:_refreshItems()
		arg_11_0:_refreshMap()

		if var_11_1 then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock("mapAni")
			arg_11_0._mapAnimator:Play("open", 0, 0)
			TaskDispatcher.runDelay(arg_11_0._openFinished, arg_11_0, 2.33)
		end
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("mapAni")

		if var_11_1 then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			arg_11_0._mapAnimator:Play("switch", 0, 0)
			TaskDispatcher.runDelay(arg_11_0._switchMap, arg_11_0, 0.35)
		else
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			arg_11_0._mapAnimator:Play("close", 0, 0)
			arg_11_0:_refreshItems()
			TaskDispatcher.runDelay(arg_11_0._closeFinished, arg_11_0, 1)
		end
	end
end

function var_0_0._closeFinished(arg_12_0)
	arg_12_0:_refreshMap()
	UIBlockMgr.instance:endBlock("mapAni")
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.ShowMapFinished)
end

function var_0_0._switchMap(arg_13_0)
	arg_13_0:_refreshItems()
	arg_13_0:_refreshMap()
	TaskDispatcher.runDelay(arg_13_0._openFinished, arg_13_0, 0.59)
end

function var_0_0._openFinished(arg_14_0)
	UIBlockMgr.instance:endBlock("mapAni")
end

function var_0_0._refreshItems(arg_15_0)
	arg_15_0:_refreshFestivalItem()

	local var_15_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_15_1 = DragonBoatFestivalConfig.instance:getDragonBoatCo(var_15_0)
	local var_15_2 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local var_15_3 = DragonBoatFestivalModel.instance:isGiftGet(var_15_2)

	if var_15_0 == var_15_2 and not var_15_3 then
		gohelper.setActive(arg_15_0._goDescr, false)

		arg_15_0._txtDescr.text = ""
	else
		gohelper.setActive(arg_15_0._goDescr, true)

		arg_15_0._txtDescr.text = var_15_1.desc
	end
end

function var_0_0._refreshFestivalItem(arg_16_0)
	local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[1]
	local var_16_1 = ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if not arg_16_0._items[iter_16_1.id] then
			local var_16_2 = arg_16_0:getResInst(var_16_0, arg_16_0._goContentRoot)
			local var_16_3 = DragonBoatFestivalItem.New()

			var_16_3:init(var_16_2, iter_16_1.id)

			arg_16_0._items[iter_16_1.id] = var_16_3
		else
			arg_16_0._items[iter_16_1.id]:refresh(iter_16_1.id)
		end
	end
end

function var_0_0._refreshMap(arg_17_0)
	local var_17_0 = DragonBoatFestivalModel.instance:getCurDay()
	local var_17_1 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local var_17_2 = DragonBoatFestivalModel.instance:isGiftGet(var_17_1)
	local var_17_3 = DragonBoatFestivalModel.instance:isGiftUnlock(var_17_0)

	if var_17_0 == var_17_1 and not var_17_2 and not arg_17_0._hasClickReward then
		var_17_3 = false
	end

	local var_17_4 = DragonBoatFestivalConfig.instance:getDragonBoatCo(var_17_0)

	gohelper.setActive(arg_17_0._goPuzzlePicClose, not var_17_3)
	gohelper.setActive(arg_17_0._goPuzzlePicOpen, var_17_3)
	UISpriteSetMgr.instance:setDragonBoatSprite(arg_17_0._imagePuzzlePic, var_17_4.dayicon)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._viewAni.enabled = false

	arg_18_0:removeCustomEvents()
end

function var_0_0.removeCustomEvents(arg_19_0)
	arg_19_0:removeEventCb(DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, arg_19_0._onSelectItem, arg_19_0)
	arg_19_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_19_0._onCloseViewFinish, arg_19_0)
	arg_19_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_19_0._refreshFestivalItem, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._getRemainTimeStr, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._closeToOpen, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._openFinished, arg_20_0)

	if arg_20_0._items then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._items) do
			iter_20_1:destroy()
		end
	end
end

return var_0_0
