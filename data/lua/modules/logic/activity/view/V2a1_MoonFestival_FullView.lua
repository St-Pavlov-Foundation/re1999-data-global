module("modules.logic.activity.view.V2a1_MoonFestival_FullView", package.seeall)

slot0 = class("V2a1_MoonFestival_FullView", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDec = gohelper.findChildText(slot0.viewGO, "Root/image_DecBG/scroll_desc/Viewport/Content/#txt_Dec")
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/Task/#go_NormalBG")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	slot0._simagereward = gohelper.findChildSingleImage(slot0.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "Root/Task/#go_canget")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/Task/#go_FinishedBG")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity101SignViewBase.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	Activity101SignViewBase.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	slot0:_setActive_canget(false)
	slot0:_setActive_goFinishedBG(false)
end

function slot0.onOpen(slot0)
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick")

	slot0._itemClick = gohelper.getClickWithAudio(slot0._goNormalBG)

	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0:internal_onOpen()
	slot0:_clearTimeTick()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick")
	slot0:_clearTimeTick()
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
	slot0:_clearTimeTick()
end

function slot0._clearTimeTick(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
	slot0:_refreshLeftTop()
	slot0:_refreshRightTop()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0._refreshLeftTop(slot0)
	if not slot0.viewContainer:getCurrentDayCO() then
		slot0._txtDec.text = ""

		return
	end

	slot0._txtDec.text = slot1.desc
end

function slot0._refreshRightTop(slot0)
	if not slot0.viewContainer:getCurrentTaskCO() then
		slot0._txtdec.text = ""

		slot0._simagereward:UnLoadImage()

		slot0._txtnum.text = ""

		return
	end

	slot3 = GameUtil.splitString2(slot1.bonus, true)[1]
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot3[1], slot3[2])

	slot0:_setActive_canget(slot0.viewContainer:isRewardable(slot1.id))
	slot0:_setActive_goFinishedBG(slot0.viewContainer:isFinishedTask(slot1.id))

	slot0._txtdec.text = slot1.taskDesc

	GameUtil.loadSImage(slot0._simagereward, slot7)

	slot0._txtnum.text = slot0.viewContainer:isNone(slot1.id) and gohelper.getRichColorText("0/1", "#ff9673") or "1/1"
	slot0._bonusItem = slot3
end

function slot0._onItemClick(slot0)
	if not slot0.viewContainer:sendGet101SpBonusRequest(slot0._onReceiveGet101SpBonusReplySucc, slot0) and slot0._bonusItem then
		MaterialTipController.instance:showMaterialInfo(slot0._bonusItem[1], slot0._bonusItem[2])
	end
end

function slot0._setActive_canget(slot0, slot1)
	gohelper.setActive(slot0._gocanget, slot1)
end

function slot0._setActive_goFinishedBG(slot0, slot1)
	gohelper.setActive(slot0._goFinishedBG, slot1)
end

function slot0._onReceiveGet101SpBonusReplySucc(slot0)
	slot0:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(slot0:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

return slot0
