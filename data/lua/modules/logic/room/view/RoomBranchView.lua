module("modules.logic.room.view.RoomBranchView", package.seeall)

slot0 = class("RoomBranchView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._goselectitem = gohelper.findChild(slot0.viewGO, "#go_select/viewport/content/#go_selectitem")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#simage_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_info")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_content/#go_spine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0._btnnextOnClick(slot0)
	RoomCharacterController.instance:trynextDialogInteraction()
end

function slot0._btnclickOnClick(slot0, slot1)
	RoomCharacterController.instance:nextDialogInteraction(slot1)
end

function slot0.OnStoryDialogSelect(slot0, slot1)
	if slot1 > 0 and slot1 <= #slot0._selectItemList then
		RoomCharacterController.instance:nextDialogInteraction(slot1)
	end
end

function slot0._editableInitView(slot0)
	slot0._scene = RoomCameraController.instance:getRoomScene()
	slot0._gocontentTrs = slot0._gocontent.transform
	slot0._gospineTrs = slot0._gospine.transform

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	gohelper.setActive(slot0._goselectitem, false)

	slot0._selectItemList = {}
	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
end

function slot0._refreshUI(slot0)
	if not RoomCharacterController.instance:getPlayingInteractionParam() then
		return
	end

	slot0._selectParam = slot1.selectParam
	slot0._dialogId = slot1.dialogId
	slot0._stepId = slot1.stepId
	slot0._critterUid = slot1.critterUid
	slot0._heroId = slot1.heroId
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0._critterUid)

	if slot0._critterMO then
		slot0:_addPostionEventCb()

		if not slot0._critterItem then
			slot0._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gospine, RoomCritterTrainCritterItem, slot0)

			slot0._critterItem:init(slot0._gospine)
		end
	else
		slot0:_removePostionEventCb()
	end

	gohelper.setActive(slot0._gospine, slot0._critterMO ~= nil)
	gohelper.setActive(slot0._goselect, slot0._selectParam)
	gohelper.setActive(slot0._gocontent, not slot0._selectParam and slot0._dialogId and slot0._stepId)

	if slot0._selectParam then
		slot0:_refreshSelect()
	elseif slot0._dialogId and slot0._stepId then
		slot0:_refreshDialog()
	end
end

function slot0._refreshSelect(slot0)
	for slot4 = 1, #slot0._selectParam do
		slot6 = slot0._selectParam[slot4][1]

		if not slot0._selectItemList[slot4] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot4
			slot7.go = gohelper.cloneInPlace(slot0._goselectitem, "item" .. slot4)
			slot7.txtcontent = gohelper.findChildText(slot7.go, "bgdark/txtcontentdark")
			slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btnselect")

			slot7.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot7.index)
			PCInputController.instance:showkeyTips(gohelper.findChild(slot7.go, "bgdark/#go_pcbtn"), nil, , slot4)
			table.insert(slot0._selectItemList, slot7)
		end

		slot7.txtcontent.text = RoomConfig.instance:getCharacterDialogSelectConfig(slot6).content

		gohelper.setActive(slot7.go, true)
	end

	for slot4 = #slot0._selectParam + 1, #slot0._selectItemList do
		gohelper.setActive(slot0._selectItemList[slot4].go, false)
	end
end

function slot0._refreshDialog(slot0)
	if RoomConfig.instance:getCharacterDialogConfig(slot0._dialogId, slot0._stepId) then
		slot2 = nil

		if string.nilorempty(slot1.relateContent) then
			slot2 = slot1.content
		end

		if not string.nilorempty(slot0:_getSpeakerName(slot1)) then
			slot2 = string.format("%s:  %s", slot3, slot2)
		end

		slot4 = StoryTool.getMarkTopTextList(slot2)
		slot0._txtinfo.text = StoryTool.filterMarkTop(slot2)

		if slot0._critterMO and slot0._critterItem then
			slot0:_refreshCritterItem(slot1.critteremoji)
		end

		TaskDispatcher.runDelay(function ()
			uv0._conMark:SetMarksTop(uv1)
		end, nil, 0.01)
	end
end

function slot0._refreshCritterItem(slot0, slot1)
	if not slot0._critterMO or not slot0._critterItem then
		return
	end

	if slot1 and slot1 ~= 0 then
		slot0._critterItem:fadeIn()
		slot0._critterItem:setEffectByType(slot1)
		slot0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
		slot0:_refreshPosition()
	else
		slot0._critterItem:setEffectByType(0)
		slot0._critterItem:hideEffects()
	end
end

function slot0._getSpeakerName(slot0, slot1)
	if not string.nilorempty(slot1.speaker) then
		return slot1.speaker
	end

	if slot0._critterMO then
		if slot1.speakerType == RoomEnum.DialogSpeakerType.Hero then
			return HeroConfig.instance:getHeroCO(slot0._heroId) and slot2.name
		elseif slot1.speakerType == RoomEnum.DialogSpeakerType.Critter then
			return slot0._critterMO:getName()
		end
	end

	return nil
end

function slot0._onEscape(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.RoomBranchView, slot0._onEscape, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, slot0._refreshUI, slot0)
end

function slot0._addPostionEventCb(slot0)
	if not slot0._isAddPostionEven then
		slot0._isAddPostionEven = true

		slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
		slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._refreshPosition, slot0)
	end
end

function slot0._removePostionEventCb(slot0)
	if slot0._isAddPostionEven then
		slot0._isAddPostionEven = false

		slot0:removeEventCb(RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
		slot0:removeEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._refreshPosition, slot0)
	end
end

function slot0._characterPositionChanged(slot0, slot1)
	if slot0._critterMO and slot0._critterMO.trainInfo.heroId ~= slot1 then
		return
	end

	slot0:_refreshPosition()
end

function slot0._refreshPosition(slot0)
	if not slot0:_getCritterEntity() then
		return
	end

	if not (slot1.critterspine:getMountheadGOTrs() or slot1.goTrs) then
		return
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot2)

	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(Vector3(slot3, slot4, slot5)), slot0._gocontentTrs) then
		recthelper.setAnchor(slot0._gospineTrs, slot7.x, slot7.y)
	end
end

function slot0._getCritterEntity(slot0)
	if slot0._scene.cameraFollow:isFollowing() then
		return slot0._scene.crittermgr:getCritterEntity(slot0._critterUid, SceneTag.RoomCharacter)
	end

	return slot0._scene.crittermgr:getTempCritterEntity()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._selectItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	if slot0._critterItem then
		slot0._critterItem = nil

		slot0._critterItem:onDestroy()
	end
end

return slot0
