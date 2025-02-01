module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalView", package.seeall)

slot0 = class("LanternFestivalView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")
	slot0._goPuzzlePicClose = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicClose")
	slot0._goPuzzlePicOpen = gohelper.findChild(slot0.viewGO, "Root/Right/#go_PuzzlePicOpen")
	slot0._imagePuzzlePic = gohelper.findChildImage(slot0.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goContentRoot = gohelper.findChild(slot0.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	slot0._goClose = gohelper.findChild(slot0.viewGO, "Close")
	slot0._bgClick = gohelper.getClickWithAudio(slot0._goClose)
	slot0._mapAnimator = slot0._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAni = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAni.enabled = true
	slot0._items = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	slot0:addCustomEvents()
	LanternFestivalModel.instance:setCurPuzzleId(0)
	slot0:refreshItems()
	slot0:_getRemainTimeStr()
	TaskDispatcher.runRepeat(slot0._getRemainTimeStr, slot0, 1)
end

function slot0.addCustomEvents(slot0)
	slot0._bgClick:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, slot0.refreshItems, slot0)
	slot0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, slot0.refreshItems, slot0)
	slot0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, slot0.refreshItems, slot0)
	slot0:addEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, slot0._showUnlockPuzzle, slot0)
end

function slot0._getRemainTimeStr(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.LanternFestival)
end

function slot0._showUnlockPuzzle(slot0, slot1)
	LanternFestivalModel.instance:setCurPuzzleId(slot1)
	slot0:refreshItems()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_spools_open)
	slot0._mapAnimator:Play("open", 0, 0)
end

function slot0.refreshItems(slot0)
	for slot6, slot7 in ipairs(LanternFestivalConfig.instance:getAct154Cos()) do
		if not slot0._items[slot7.puzzleId] then
			slot9 = LanternFestivalItem.New()

			slot9:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContentRoot), slot6, slot7.puzzleId)

			slot0._items[slot7.puzzleId] = slot9
		else
			slot0._items[slot7.puzzleId]:refresh(slot6, slot7.puzzleId)
		end
	end

	slot3 = LanternFestivalModel.instance:isAllPuzzleUnSolved()

	gohelper.setActive(slot0._goPuzzlePicClose, slot3)
	gohelper.setActive(slot0._goPuzzlePicOpen, not slot3)

	if LanternFestivalModel.instance:getPuzzleState(LanternFestivalModel.instance:getCurPuzzleId()) == LanternFestivalEnum.PuzzleState.Solved or slot5 == LanternFestivalEnum.PuzzleState.RewardGet then
		UISpriteSetMgr.instance:setV1a7LanternSprite(slot0._imagePuzzlePic, LanternFestivalConfig.instance:getPuzzleCo(slot4).puzzleIcon)
	end

	slot0._txtDescr.text = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.LanternFestival).actDesc
end

function slot0.onClose(slot0)
	slot0._viewAni.enabled = false

	slot0:removeCustomEvents()
end

function slot0.removeCustomEvents(slot0)
	slot0._bgClick:RemoveClickListener()
	slot0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, slot0.refreshItems, slot0)
	slot0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, slot0.refreshItems, slot0)
	slot0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, slot0.refreshItems, slot0)
	slot0:removeEventCb(LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, slot0._showUnlockPuzzle, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._getRemainTimeStr, slot0)

	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end
	end
end

return slot0
