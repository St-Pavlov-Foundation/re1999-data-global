module("modules.logic.activity.view.V1a6_Spring_PanelSignView", package.seeall)

slot0 = class("V1a6_Spring_PanelSignView", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")
	slot0._txtDate = gohelper.findChildText(slot0.viewGO, "Root/#txt_Date")
	slot0._txtgoodDesc = gohelper.findChildText(slot0.viewGO, "Root/image_yi/image_Mood/#txt_goodDesc")
	slot0._txtbadDesc = gohelper.findChildText(slot0.viewGO, "Root/image_ji/image_Mood/#txt_badDesc")
	slot0._txtSmallTitle = gohelper.findChildText(slot0.viewGO, "Root/image_SmallTitle/#txt_SmallTitle")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Root/ScrollView/Viewport/#txt_Desc")
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyRight")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity101SignViewBase.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity101SignViewBase.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._anims = slot0:getUserDataTb_()

	table.insert(slot0._anims, slot0:_findAnimCmp("Root/image_yi/image_Mood"))
	table.insert(slot0._anims, slot0:_findAnimCmp("Root/image_ji/image_Mood"))
end

function slot0._findAnimCmp(slot0, slot1)
	return gohelper.findChild(slot0.viewGO, slot1):GetComponent(gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	slot0._txtLimitTime.text = ""
	slot0._txtDate.text = ""
	slot0._txtSmallTitle.text = ""
	slot0._txtDesc.text = ""
	slot0._txtgoodDesc.text = ""
	slot0._txtbadDesc.text = ""

	slot0:internal_set_actId(slot0.viewParam.actId)
	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	slot0:internal_onOpen()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

slot1 = "Key_V1a6_Spring_PanelSignView"

function slot0.onOpenFinish(slot0)
	if not slot0:_getCurrentDayCO() then
		return
	end

	if GameUtil.playerPrefsGetNumberByUserId(uv0, -1) ~= slot1.day then
		for slot7, slot8 in ipairs(slot0._anims or {}) do
			slot8:Play(UIAnimationName.Open, 0, 0)
		end

		GameUtil.playerPrefsSetNumberByUserId(uv0, slot2)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
	slot0:_refreshDesc()
end

function slot0._refreshDesc(slot0)
	if not slot0:_getCurrentDayCO() then
		return
	end

	slot0._txtDate.text = slot1.name
	slot0._txtSmallTitle.text = slot1.simpleDesc
	slot0._txtDesc.text = slot1.detailDesc
	slot0._txtgoodDesc.text = slot1.goodDesc
	slot0._txtbadDesc.text = slot1.badDesc
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0._getCurrentDayCO(slot0)
	if not ActivityModel.instance:getActMO(slot0:actId()) then
		return
	end

	if not ActivityType101Config.instance:getSpringSignMaxDay(slot1) or slot3 <= 0 then
		return
	end

	if ServerTime.now() < slot2.startTime / 1000 or slot2.endTime / 1000 < slot6 then
		return
	end

	if slot3 <= TimeUtil.secondsToDDHHMMSS(slot6 - slot4) then
		slot8 = slot8 % slot3
	end

	return ActivityType101Config.instance:getSpringSignByDay(slot1, slot8 + 1)
end

function slot0._onDailyRefresh(slot0)
	slot0:_refreshDesc()
end

return slot0
