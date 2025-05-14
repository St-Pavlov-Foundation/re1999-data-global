module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalActivityView", package.seeall)

local var_0_0 = class("LanternFestivalActivityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._goPuzzlePicClose = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_PuzzlePicClose")
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
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	LanternFestivalModel.instance:setCurPuzzleId(0)
	arg_6_0:addCustomEvents()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_task_page)
	arg_6_0:refreshItems()
	arg_6_0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(arg_6_0._getRemainTimeStr, arg_6_0, 1)
end

function var_0_0._getRemainTimeStr(arg_7_0)
	local var_7_0 = ActivityEnum.Activity.LanternFestival

	arg_7_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(var_7_0)
end

function var_0_0.addCustomEvents(arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, arg_8_0.refreshItems, arg_8_0)
	arg_8_0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, arg_8_0._showUnlockPuzzle, arg_8_0)
end

function var_0_0._showUnlockPuzzle(arg_9_0, arg_9_1)
	LanternFestivalModel.instance:setCurPuzzleId(arg_9_1)
	arg_9_0:refreshItems()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_spools_open)
	arg_9_0._mapAnimator:Play("open", 0, 0)
end

function var_0_0.refreshItems(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[1]
	local var_10_1 = LanternFestivalConfig.instance:getAct154Cos()

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if not arg_10_0._items[iter_10_1.puzzleId] then
			local var_10_2 = arg_10_0:getResInst(var_10_0, arg_10_0._goContentRoot)
			local var_10_3 = LanternFestivalItem.New()

			var_10_3:init(var_10_2, iter_10_0, iter_10_1.puzzleId)

			arg_10_0._items[iter_10_1.puzzleId] = var_10_3
		else
			arg_10_0._items[iter_10_1.puzzleId]:refresh(iter_10_0, iter_10_1.puzzleId)
		end
	end

	local var_10_4 = LanternFestivalModel.instance:isAllPuzzleUnSolved()

	gohelper.setActive(arg_10_0._goPuzzlePicClose, var_10_4)
	gohelper.setActive(arg_10_0._goPuzzlePicOpen, not var_10_4)

	local var_10_5 = LanternFestivalModel.instance:getCurPuzzleId()
	local var_10_6 = LanternFestivalModel.instance:getPuzzleState(var_10_5)

	if var_10_6 == LanternFestivalEnum.PuzzleState.Solved or var_10_6 == LanternFestivalEnum.PuzzleState.RewardGet then
		local var_10_7 = LanternFestivalConfig.instance:getPuzzleCo(var_10_5)

		UISpriteSetMgr.instance:setV1a7LanternSprite(arg_10_0._imagePuzzlePic, var_10_7.puzzleIcon)
	end

	local var_10_8 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.LanternFestival)

	arg_10_0._txtDescr.text = var_10_8.actDesc
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeCustomEvents()
end

function var_0_0.removeCustomEvents(arg_12_0)
	arg_12_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, arg_12_0.refreshItems, arg_12_0)
	arg_12_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, arg_12_0.refreshItems, arg_12_0)
	arg_12_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, arg_12_0.refreshItems, arg_12_0)
	arg_12_0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, arg_12_0._showUnlockPuzzle, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._getRemainTimeStr, arg_13_0)

	if arg_13_0._items then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._items) do
			iter_13_1:destroy()
		end
	end
end

return var_0_0
