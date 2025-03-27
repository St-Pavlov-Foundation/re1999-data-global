module("modules.logic.room.view.record.RoomCritterHandBookItem", package.seeall)

slot0 = class("RoomCritterHandBookItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "empty")
	slot0._goshow = gohelper.findChild(slot0.viewGO, "show")
	slot0._gofront = gohelper.findChild(slot0.viewGO, "show/front")
	slot0._goback = gohelper.findChild(slot0.viewGO, "show/back")
	slot0._simagecritter = gohelper.findChildSingleImage(slot0.viewGO, "show/front/#simage_critter")
	slot0._imagecardbg = gohelper.findChildImage(slot0.viewGO, "show/front/#image_cardbg")
	slot0._simageutm = gohelper.findChildSingleImage(slot0.viewGO, "show/back/#simage_utm")
	slot0._gobackbgicon = gohelper.findChild(slot0.viewGO, "show/back/#simage_back/icon")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "show/#go_new")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click", AudioEnum.Room.play_ui_home_firmup_close)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClickBtn, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshBack, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, slot0.reverse, slot0)
	slot0:addEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, slot0.refreshMutate, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.refreshBack, slot0.refreshBack, slot0)
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, slot0.reverse, slot0)
	slot0:removeEventCb(RoomHandBookController.instance, RoomHandBookEvent.showMutate, slot0.refreshMutate, slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0._onClickBtn(slot0)
	slot0._view:selectCell(slot0._index, true)
	RoomHandBookModel.instance:setSelectMo(slot0._mo)

	if slot0._mo:checkNew() then
		CritterRpc.instance:sendMarkCritterBookNewReadRequest(slot0._id)
	end

	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.onClickHandBookItem, slot0._mo)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._id = slot1.id
	slot0._config = slot1:getConfig()
	slot2 = slot1:checkGotCritter()
	slot0._isreverse = slot1:checkIsReverse()

	gohelper.setActive(slot0._goempty, not slot2)
	gohelper.setActive(slot0._goshow, slot2)
	gohelper.setActive(slot0._gonew, slot1:checkNew())
	slot0:refreshUI()

	if slot0._isreverse ~= nil then
		if slot0._isreverse then
			slot0._animator:Play("empty", 0, 0)
		else
			slot0._animator:Play("show", 0, 0)
		end
	end
end

function slot0.reverse(slot0)
	slot0._isreverse = slot0._mo:checkIsReverse()

	if slot0._isreverse then
		slot0._animator:Play("to_empty", 0, 0)
	else
		slot0._animator:Play("to_show", 0, 0)
	end
end

function slot0.refreshUI(slot0)
	if slot0._mo:checkShowSpeicalSkin() then
		if lua_critter_skin.configDict[slot0._config.mutateSkin] then
			slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot1.largeIcon), function ()
				uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, slot0)
		end
	else
		slot0._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(slot0._id), function ()
			uv0._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, slot0)
	end

	slot1 = slot0._mo:getBackGroundId() and true or false

	gohelper.setActive(slot0._simageutm.gameObject, slot1)
	gohelper.setActive(slot0._gobackbgicon, not slot1)

	if slot1 then
		slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot0._mo:getBackGroundId()), function ()
			uv0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, slot0)
	end

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagecardbg, lua_critter_catalogue.configDict[slot0._config.catalogue].baseCard)
end

function slot0.refreshBack(slot0)
	slot1 = slot0._mo:getBackGroundId() and true or false

	gohelper.setActive(slot0._simageutm.gameObject, slot1)
	gohelper.setActive(slot0._gobackbgicon, not slot1)

	if slot1 then
		slot0._simageutm:LoadImage(ResUrl.getPropItemIcon(slot0._mo:getBackGroundId()), function ()
			uv0._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, slot0)
	end
end

function slot0.refreshMutate(slot0, slot1)
	if slot1.id ~= slot0._mo.id then
		return
	end

	if slot0._mo:checkShowMutate() then
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

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
