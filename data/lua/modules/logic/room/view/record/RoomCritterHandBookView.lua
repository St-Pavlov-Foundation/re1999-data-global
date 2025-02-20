module("modules.logic.room.view.record.RoomCritterHandBookView", package.seeall)

slot0 = class("RoomCritterHandBookView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_view")
	slot0._btnleftreverse = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_reverse")
	slot0._goleftbtnback = gohelper.findChild(slot0.viewGO, "left/#btn_reverse/back")
	slot0._goleftbtnfront = gohelper.findChild(slot0.viewGO, "left/#btn_reverse/front")
	slot0._txtcollectionnum = gohelper.findChildText(slot0.viewGO, "left/#txt_collectionnum")
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._goshow = gohelper.findChild(slot0.viewGO, "right/show")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "right/empty")
	slot0._gobtnmutate = gohelper.findChild(slot0.viewGO, "right/show/btnbg")
	slot0._btnmutate = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/show/btnbg/#btn_mutate")
	slot0._goshowmutate = gohelper.findChild(slot0.viewGO, "right/show/btnbg/#btn_mutate/selected")
	slot0._gohidemutate = gohelper.findChild(slot0.viewGO, "right/show/btnbg/#btn_mutate/unselet")
	slot0._btnyoung = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/show/btnbg/#btn_young")
	slot0._goshowyoung = gohelper.findChild(slot0.viewGO, "right/show/btnbg/#btn_young/selected")
	slot0._gohideyoung = gohelper.findChild(slot0.viewGO, "right/show/btnbg/#btn_young/unselect")
	slot0._btnrightbtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/show/#btn_reverse")
	slot0._goreversereddot = gohelper.findChild(slot0.viewGO, "right/show/#btn_reverse/#go_reversereddot")
	slot0._gofront = gohelper.findChild(slot0.viewGO, "right/show/front")
	slot0._goback = gohelper.findChild(slot0.viewGO, "right/show/back")
	slot0._imagecardbg = gohelper.findChildImage(slot0.viewGO, "right/show/front/#image_cardbg")
	slot0._simagecritter = gohelper.findChildSingleImage(slot0.viewGO, "right/show/front/#simage_critter")
	slot0._gobackbgicon = gohelper.findChild(slot0.viewGO, "right/show/back/#simage_back/icon")
	slot0._simageutm = gohelper.findChildSingleImage(slot0.viewGO, "right/show/back/#simage_utm")
	slot0._txtcrittername = gohelper.findChildText(slot0.viewGO, "right/show/#txt_crittername")
	slot0._txtcrittertype = gohelper.findChildText(slot0.viewGO, "right/show/#txt_crittername/#txt_crittertype")
	slot0._imagerelationship = gohelper.findChildImage(slot0.viewGO, "right/legend/layout/scroll/#simage_critter")
	slot0._txtreleationship = gohelper.findChildText(slot0.viewGO, "right/legend/layout/scroll/Viewport/Content/relationship/#txt_releationship")
	slot0._txtlegend = gohelper.findChildText(slot0.viewGO, "right/legend/layout/scroll2/Viewport/Content/#txt_legend")
	slot0._golengendempty = gohelper.findChild(slot0.viewGO, "right/legend/#go_legendempty")
	slot0._goscrolllegend = gohelper.findChild(slot0.viewGO, "right/legend/layout")
	slot0._goscrollrelationship = gohelper.findChild(slot0.viewGO, "right/legend/layout/scroll")
	slot0._goscroll2 = gohelper.findChild(slot0.viewGO, "right/legend/layout/scroll2")
	slot0._btnlog = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_log")
	slot0._gologreddot = gohelper.findChild(slot0.viewGO, "#btn_log/reddot")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "#btn_task/#go_taskreddot")
	slot0._rightanimator = slot0._goright:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnanimator = slot0._btnleftreverse.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gofoods = {}
	slot0._mo = nil
	slot0._scrollview = slot0.viewContainer:getHandBookScrollView()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleftreverse:AddClickListener(slot0._btnleftreverseOnClick, slot0)
	slot0._btnrightbtn:AddClickListener(slot0._btnrightbtnOnClick, slot0)
	slot0._btnmutate:AddClickListener(slot0._btnmutateOnClick, slot0)
	slot0._btnyoung:AddClickListener(slot0._btnyoungOnClick, slot0)
	slot0._btnlog:AddClickListener(slot0._btnlogOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, slot0.updateView, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshBack, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, slot0.refreshMutate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleftreverse:RemoveClickListener()
	slot0._btnrightbtn:RemoveClickListener()
	slot0._btnmutate:RemoveClickListener()
	slot0._btnyoung:RemoveClickListener()
	slot0._btnlog:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, slot0.updateView, slot0)
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshBack, slot0)
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, slot0.refreshMutate, slot0)
end

function slot0._btnlogOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Log,
		view = RoomRecordEnum.View.Log
	})
end

function slot0._btntaskOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Task,
		view = RoomRecordEnum.View.Task
	})
end

function slot0._btnleftreverseOnClick(slot0)
	RoomHandBookModel.instance:setScrollReverse()
	slot0:reverseIcon()

	slot0._isreverse = RoomHandBookModel.instance:getReverse()

	gohelper.setActive(slot0._goleftbtnback, slot0._isreverse)
	gohelper.setActive(slot0._goleftbtnfront, not slot0._isreverse)

	if slot0._isreverse then
		slot0._btnanimator:Play("to_front", 0, 0)
		TaskDispatcher.runDelay(slot0.reverseAnim, slot0, RoomRecordEnum.AnimTime)
	else
		slot0._btnanimator:Play("to_back", 0, 0)
		TaskDispatcher.runDelay(slot0.reverseAnim, slot0, RoomRecordEnum.AnimTime)
	end
end

function slot0.reverseAnim(slot0)
	TaskDispatcher.cancelTask(slot0.reverseAnim, slot0)

	if slot0._isreverse then
		slot0._btnanimator:Play("to_back", 0, 0)
	else
		slot0._btnanimator:Play("to_front", 0, 0)
	end
end

function slot0._btnrightbtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomCritterHandBookBackView)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.Newstriker, false)
end

function slot0._btnmutateOnClick(slot0)
	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(RoomHandBookModel.instance:getSelectMo().id, true)
end

function slot0._btnyoungOnClick(slot0)
	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(RoomHandBookModel.instance:getSelectMo().id, false)
end

function slot0._editableInitView(slot0)
	slot4 = "gameobject"
	slot0._goscroll2ArrowGo = gohelper.findChild(slot0._goscroll2, slot4)
	slot0._goscroll2ArrowTrans = slot0._goscroll2ArrowGo.transform
	slot0._goscroll2ArrowDefaultY = recthelper.getAnchorY(slot0._goscroll2ArrowTrans)

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "right/show/food/item" .. slot4)
		slot5.simage = gohelper.findChildSingleImage(slot5.go, "#simage_icon")

		gohelper.setActive(slot5.go, false)
		table.insert(slot0._gofoods, slot5)
	end
end

function slot0.updateView(slot0, slot1)
	if slot0._mo ~= slot1 then
		slot0._rightanimator:Play("switch", 0, 0)
	end

	slot0._mo = slot1 and slot1 or RoomHandBookModel.instance:getSelectMo()
	slot0._isSpecial = slot0._mo.UseSpecialSkin
	slot2 = slot0._mo:checkGotCritter()
	slot3 = slot0._mo:getConfig()

	gohelper.setActive(slot0._goshow, slot2)
	gohelper.setActive(slot0._goempty, not slot2)

	if slot2 then
		slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot3.id), function ()
			uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, slot0)
	end

	slot0._txtcrittername.text = slot2 and slot3.name or ""
	slot4 = slot3.catalogue

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagecardbg, lua_critter_catalogue.configDict[slot4].baseCard)

	slot0._txtcrittertype.text = slot2 and lua_critter_catalogue.configDict[slot4].name or ""
	slot7 = slot0._mo:checkShowMutate()

	gohelper.setActive(slot0._gobtnmutate, slot7)

	if slot7 then
		gohelper.setActive(slot0._btnmutate.gameObject, not slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._btnyoung.gameObject, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._goshowmutate, not slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._gohidemutate, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._goshowyoung, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._gohideyoung, not slot0._mo:checkShowSpeicalSkin())

		if slot0._mo:checkShowSpeicalSkin() then
			if lua_critter_skin.configDict[slot3.mutateSkin] then
				slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot8.largeIcon), function ()
					uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
				end, slot0)
			end
		else
			slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot3.id), function ()
				uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, slot0)
		end
	end

	slot0:refreshLikeFood(slot0._mo)
	slot0:refreshLegend(slot0._mo)

	slot9 = slot0._mo:getBackGroundId() and slot8 ~= 0

	gohelper.setActive(slot0._simageutm.gameObject, slot9)
	gohelper.setActive(slot0._gobackbgicon, not slot9)

	if slot8 and slot8 ~= 0 then
		slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot0._mo:getBackGroundId()), function ()
			uv0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end

	slot0._txtcollectionnum.text = string.format("<color=#cd5200>%s</color>/%s", RoomHandBookModel.instance:getCount(), CritterConfig.instance:getCritterCount())
end

function slot0.refreshLikeFood(slot0, slot1)
	if not slot1:getConfig() or string.nilorempty(slot2.foodLike) or not slot1:checkGotCritter() then
		for slot6 = 1, #slot0._gofoods do
			gohelper.setActive(slot0._gofoods[slot6].go, false)
		end

		return
	end

	slot4 = {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot2.foodLike)) do
		table.insert(slot4, slot9[1])
	end

	for slot8 = 1, #slot4 do
		slot9 = slot0._gofoods[slot8]

		slot9.simage:LoadImage(ResUrl.getPropItemIcon(ItemConfig.instance:getItemCo(tonumber(slot4[slot8])).icon))
		gohelper.setActive(slot9.go, true)
	end

	for slot8 = #slot0._gofoods, #slot4 + 1, -1 do
		gohelper.setActive(slot0._gofoods[slot8].go, false)
	end
end

function slot0.refreshLegend(slot0, slot1)
	slot2 = 446
	slot3 = 264
	slot5 = true

	if not slot1:getConfig() or not slot1:checkGotCritter() then
		slot5 = false
	end

	gohelper.setActive(slot0._golengendempty, not slot5)
	gohelper.setActive(slot0._goscrolllegend, slot5)

	if string.nilorempty(slot4.line) then
		gohelper.setActive(slot0._goscrollrelationship.gameObject, false)
		recthelper.setHeight(slot0._goscroll2.transform, slot2)
		recthelper.setAnchorY(slot0._goscroll2ArrowTrans, -137)
	else
		gohelper.setActive(slot0._goscrollrelationship.gameObject, true)

		slot0._txtreleationship.text = slot4.line

		recthelper.setHeight(slot0._goscroll2.transform, slot3)
		recthelper.setAnchorY(slot0._goscroll2ArrowTrans, slot0._goscroll2ArrowDefaultY)
	end

	slot0._txtlegend.text = slot4.story

	if not string.nilorempty(slot4.relation) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagerelationship, "room_handbook_relationship" .. slot4.relation)
	end
end

function slot0.reverseIcon(slot0)
	slot1 = RoomHandBookModel.instance:getReverse()
	slot2 = RoomHandBookModel.instance:getSelectMo()

	gohelper.setActive(slot0._gofront, not slot1)
	gohelper.setActive(slot0._goback, slot1)
	gohelper.setActive(slot0._goleftbtnback, not slot1)
	gohelper.setActive(slot0._goleftbtnfront, slot1)

	if slot1 then
		slot3 = slot2:getBackGroundId() and true or false

		gohelper.setActive(slot0._simageutm.gameObject, slot3)

		if slot3 then
			slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot2:getBackGroundId()), function ()
				uv0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, slot0)
		end

		gohelper.setActive(slot0._gobackbgicon, not slot3)
	end
end

function slot0.refreshBack(slot0)
	slot2 = RoomHandBookModel.instance:getSelectMo()

	if RoomHandBookModel.instance:getReverse() then
		slot3 = slot2:getBackGroundId() and true or false

		gohelper.setActive(slot0._simageutm.gameObject, slot3)

		if slot3 then
			slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot2:getBackGroundId()), function ()
				uv0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, slot0)
		end

		gohelper.setActive(slot0._gobackbgicon, not slot3)
	end
end

function slot0.refreshMutate(slot0, slot1)
	if slot0._mo:checkShowMutate() then
		gohelper.setActive(slot0._btnmutate.gameObject, not slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._btnyoung.gameObject, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._goshowmutate, not slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._gohidemutate, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._goshowyoung, slot0._mo:checkShowSpeicalSkin())
		gohelper.setActive(slot0._gohideyoung, not slot0._mo:checkShowSpeicalSkin())

		if slot1.UseSpecialSkin then
			if lua_critter_skin.configDict[slot0._mo:getConfig().mutateSkin] then
				slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot5.largeIcon), function ()
					uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
				end, slot0)
			end
		else
			slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot4.id), function ()
				uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, slot0)
		end
	end
end

function slot0.onOpen(slot0)
	RoomHandBookListModel.instance:init()
	slot0._scrollview:selectCell(1, true)
	gohelper.setActive(slot0._gofront, true)
	gohelper.setActive(slot0._goback, false)
	slot0:updateView()
	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(slot0._gologreddot, RedDotEnum.DotNode.CritterLog)
	RedDotController.instance:addRedDot(slot0._goreversereddot, RedDotEnum.DotNode.Newstriker)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.reverseAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
