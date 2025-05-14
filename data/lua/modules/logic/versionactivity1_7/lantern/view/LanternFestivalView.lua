module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalView", package.seeall)

local var_0_0 = class("LanternFestivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._goPuzzlePicClose = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose")
	arg_1_0._goPuzzlePicOpen = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicOpen")
	arg_1_0._imagePuzzlePic = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

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
	arg_5_0._goClose = gohelper.findChild(arg_5_0.viewGO, "Close")
	arg_5_0._bgClick = gohelper.getClickWithAudio(arg_5_0._goClose)
	arg_5_0._mapAnimator = arg_5_0._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._viewAni = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._viewAni.enabled = true
	arg_5_0._items = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	arg_7_0:addCustomEvents()
	LanternFestivalModel.instance:setCurPuzzleId(0)
	arg_7_0:refreshItems()
	arg_7_0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(arg_7_0._getRemainTimeStr, arg_7_0, 1)
end

function var_0_0.addCustomEvents(arg_8_0)
	arg_8_0._bgClick:AddClickListener(arg_8_0._btnCloseOnClick, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, arg_8_0._showUnlockPuzzle, arg_8_0)
end

function var_0_0._getRemainTimeStr(arg_9_0)
	local var_9_0 = ActivityEnum.Activity.LanternFestival

	arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(var_9_0)
end

function var_0_0._showUnlockPuzzle(arg_10_0, arg_10_1)
	LanternFestivalModel.instance:setCurPuzzleId(arg_10_1)
	arg_10_0:refreshItems()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_spools_open)
	arg_10_0._mapAnimator:Play("open", 0, 0)
end

function var_0_0.refreshItems(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes[1]
	local var_11_1 = LanternFestivalConfig.instance:getAct154Cos()

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if not arg_11_0._items[iter_11_1.puzzleId] then
			local var_11_2 = arg_11_0:getResInst(var_11_0, arg_11_0._goContentRoot)
			local var_11_3 = LanternFestivalItem.New()

			var_11_3:init(var_11_2, iter_11_0, iter_11_1.puzzleId)

			arg_11_0._items[iter_11_1.puzzleId] = var_11_3
		else
			arg_11_0._items[iter_11_1.puzzleId]:refresh(iter_11_0, iter_11_1.puzzleId)
		end
	end

	local var_11_4 = LanternFestivalModel.instance:isAllPuzzleUnSolved()

	gohelper.setActive(arg_11_0._goPuzzlePicClose, var_11_4)
	gohelper.setActive(arg_11_0._goPuzzlePicOpen, not var_11_4)

	local var_11_5 = LanternFestivalModel.instance:getCurPuzzleId()
	local var_11_6 = LanternFestivalModel.instance:getPuzzleState(var_11_5)

	if var_11_6 == LanternFestivalEnum.PuzzleState.Solved or var_11_6 == LanternFestivalEnum.PuzzleState.RewardGet then
		local var_11_7 = LanternFestivalConfig.instance:getPuzzleCo(var_11_5)

		UISpriteSetMgr.instance:setV1a7LanternSprite(arg_11_0._imagePuzzlePic, var_11_7.puzzleIcon)
	end

	local var_11_8 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.LanternFestival)

	arg_11_0._txtDescr.text = var_11_8.actDesc
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._viewAni.enabled = false

	arg_12_0:removeCustomEvents()
end

function var_0_0.removeCustomEvents(arg_13_0)
	arg_13_0._bgClick:RemoveClickListener()
	arg_13_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, arg_13_0.refreshItems, arg_13_0)
	arg_13_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, arg_13_0.refreshItems, arg_13_0)
	arg_13_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, arg_13_0.refreshItems, arg_13_0)
	arg_13_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, arg_13_0._showUnlockPuzzle, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._getRemainTimeStr, arg_14_0)

	if arg_14_0._items then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._items) do
			iter_14_1:destroy()
		end
	end
end

return var_0_0
