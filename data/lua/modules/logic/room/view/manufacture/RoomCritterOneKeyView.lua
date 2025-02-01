module("modules.logic.room.view.manufacture.RoomCritterOneKeyView", package.seeall)

slot0 = class("RoomCritterOneKeyView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotitlebefore = gohelper.findChild(slot0.viewGO, "title/#go_titlebefore")
	slot0._gotitleafter = gohelper.findChild(slot0.viewGO, "title/#go_titleafter")
	slot0._btnclose = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_close")
	slot0._godragarea = gohelper.findChild(slot0.viewGO, "#go_dragArea")
	slot0._goLayout = gohelper.findChild(slot0.viewGO, "#go_content/#go_Layout")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "#go_content/#go_Layout/#go_carditem")
	slot0._gocomplete = gohelper.findChild(slot0.viewGO, "#go_complete")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	slot0._isDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0._isDrag = false
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onCardItemDrag(slot0, slot1, slot2)
	slot0:_onBeginDrag()
	slot0:_onCardItemHover(slot1)
end

function slot0._onCardItemHover(slot0, slot1)
	if not slot0._isDrag then
		return
	end

	slot0:_callCritter(slot1)
end

function slot0._callCritter(slot0, slot1)
	if not slot0._waitCallCritterDict or not slot0._waitCallCritterDict[slot1] then
		return
	end

	if slot0._cardItemDict[slot1] then
		slot2.animator:Play("card", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_fenpai)
	end

	slot0._waitCallCritterDict[slot1] = nil

	slot0:checkComplete()
end

function slot0._editableInitView(slot0)
	slot0:clearVar()

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godragarea)
	slot0._goclosebtn = slot0._btnclose.gameObject
end

function slot0.onUpdateParam(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.type = slot0.viewParam.type
	slot0.infoList = slot0.viewParam.infoList or {}

	for slot4, slot5 in ipairs(slot0.infoList) do
		for slot9, slot10 in ipairs(slot5.critterUids) do
			slot0._waitCallCritterDict[slot10] = true
		end
	end
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0:initCritterCardItem()
	slot0:checkComplete()
end

function slot0.initCritterCardItem(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._waitCallCritterDict) do
		slot1[#slot1 + 1] = slot5
	end

	gohelper.CreateObjList(slot0, slot0.onSetCritterCardItem, slot1, slot0._goLayout, slot0._gocarditem)
end

function slot0.onSetCritterCardItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.critterUid = slot2
	slot4.animator = slot4.go:GetComponent(gohelper.Type_Animator)
	slot4.imagecardfrontbg = gohelper.findChildImage(slot1, "#simage_cardfrontbg")
	slot4.simagecritter = gohelper.findChildSingleImage(slot1, "#simage_cardfrontbg/#simage_critter")
	slot4.simagecardback = gohelper.findChildSingleImage(slot1, "#simage_cardback")

	slot4.animator:Play("idle", 0, 0)

	if CritterModel.instance:getCritterMOByUid(slot4.critterUid) then
		slot6 = slot5:getDefineId()

		slot4.simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot6))
		UISpriteSetMgr.instance:setCritterSprite(slot4.imagecardfrontbg, CritterConfig.instance:getBaseCard(CritterConfig.instance:getCritterCatalogue(slot6)))
	else
		logError(string.format("RoomCritterOneKeyView:onSetCritterCardItem no critterMO, critterUid:%s", slot2))
	end

	slot4.click = SLFramework.UGUI.UIClickListener.Get(slot4.go)
	slot4.drag = SLFramework.UGUI.UIDragListener.Get(slot4.go)
	slot4.press = SLFramework.UGUI.UILongPressListener.Get(slot4.go)

	slot4.click:AddClickListener(slot0._callCritter, slot0, slot2)
	slot4.drag:AddDragBeginListener(slot0._onCardItemDrag, slot0, slot2)
	slot4.drag:AddDragEndListener(slot0._onEndDrag, slot0)
	slot4.press:AddHoverListener(slot0._onCardItemHover, slot0, slot2)

	slot0._cardItemDict[slot2] = slot4
end

function slot0.checkComplete(slot0)
	if not next(slot0._waitCallCritterDict) then
		RoomRpc.instance:sendRouseCrittersRequest(slot0.type, slot0.infoList)
	end

	gohelper.setActive(slot0._gotitlebefore, not slot1)
	gohelper.setActive(slot0._godragarea, not slot1)
	gohelper.setActive(slot0._gotitleafter, slot1)
	gohelper.setActive(slot0._goclosebtn, slot1)
	gohelper.setActive(slot0._gocomplete, slot1)
end

function slot0.clearVar(slot0)
	slot0._waitCallCritterDict = {}

	if slot0._cardItemDict then
		for slot4, slot5 in pairs(slot0._cardItemDict) do
			slot5.simagecritter:UnLoadImage()
			slot5.simagecardback:UnLoadImage()
			slot5.click:RemoveClickListener()
			slot5.drag:RemoveDragBeginListener()
			slot5.drag:RemoveDragEndListener()
			slot5.press:RemoveHoverListener()
		end
	end

	slot0._cardItemDict = {}
	slot0._isDrag = false
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearVar()
end

return slot0
