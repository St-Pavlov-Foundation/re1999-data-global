module("modules.logic.room.view.RoomBranchView", package.seeall)

local var_0_0 = class("RoomBranchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._goselectitem = gohelper.findChild(arg_1_0.viewGO, "#go_select/viewport/content/#go_selectitem")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_info")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_spine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_2_0.OnStoryDialogSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_3_0.OnStoryDialogSelect, arg_3_0)
end

function var_0_0._btnnextOnClick(arg_4_0)
	RoomCharacterController.instance:trynextDialogInteraction()
end

function var_0_0._btnclickOnClick(arg_5_0, arg_5_1)
	RoomCharacterController.instance:nextDialogInteraction(arg_5_1)
end

function var_0_0.OnStoryDialogSelect(arg_6_0, arg_6_1)
	if arg_6_1 > 0 and arg_6_1 <= #arg_6_0._selectItemList then
		RoomCharacterController.instance:nextDialogInteraction(arg_6_1)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._scene = RoomCameraController.instance:getRoomScene()
	arg_7_0._gocontentTrs = arg_7_0._gocontent.transform
	arg_7_0._gospineTrs = arg_7_0._gospine.transform

	arg_7_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	gohelper.setActive(arg_7_0._goselectitem, false)

	arg_7_0._selectItemList = {}
	arg_7_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_7_0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_7_0._conMark = gohelper.onceAddComponent(arg_7_0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	arg_7_0._conMark:SetMarkTopGo(arg_7_0._txtmarktop.gameObject)
end

function var_0_0._refreshUI(arg_8_0)
	local var_8_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if not var_8_0 then
		return
	end

	arg_8_0._selectParam = var_8_0.selectParam
	arg_8_0._dialogId = var_8_0.dialogId
	arg_8_0._stepId = var_8_0.stepId
	arg_8_0._critterUid = var_8_0.critterUid
	arg_8_0._heroId = var_8_0.heroId
	arg_8_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_8_0._critterUid)

	if arg_8_0._critterMO then
		arg_8_0:_addPostionEventCb()

		if not arg_8_0._critterItem then
			arg_8_0._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._gospine, RoomCritterTrainCritterItem, arg_8_0)

			arg_8_0._critterItem:init(arg_8_0._gospine)
		end
	else
		arg_8_0:_removePostionEventCb()
	end

	gohelper.setActive(arg_8_0._gospine, arg_8_0._critterMO ~= nil)
	gohelper.setActive(arg_8_0._goselect, arg_8_0._selectParam)
	gohelper.setActive(arg_8_0._gocontent, not arg_8_0._selectParam and arg_8_0._dialogId and arg_8_0._stepId)

	if arg_8_0._selectParam then
		arg_8_0:_refreshSelect()
	elseif arg_8_0._dialogId and arg_8_0._stepId then
		arg_8_0:_refreshDialog()
	end
end

function var_0_0._refreshSelect(arg_9_0)
	for iter_9_0 = 1, #arg_9_0._selectParam do
		local var_9_0 = arg_9_0._selectParam[iter_9_0][1]
		local var_9_1 = arg_9_0._selectItemList[iter_9_0]

		if not var_9_1 then
			var_9_1 = arg_9_0:getUserDataTb_()
			var_9_1.index = iter_9_0
			var_9_1.go = gohelper.cloneInPlace(arg_9_0._goselectitem, "item" .. iter_9_0)
			var_9_1.txtcontent = gohelper.findChildText(var_9_1.go, "bgdark/txtcontentdark")
			var_9_1.btnclick = gohelper.findChildButtonWithAudio(var_9_1.go, "btnselect")

			var_9_1.btnclick:AddClickListener(arg_9_0._btnclickOnClick, arg_9_0, var_9_1.index)

			local var_9_2 = gohelper.findChild(var_9_1.go, "bgdark/#go_pcbtn")

			PCInputController.instance:showkeyTips(var_9_2, nil, nil, iter_9_0)
			table.insert(arg_9_0._selectItemList, var_9_1)
		end

		local var_9_3 = RoomConfig.instance:getCharacterDialogSelectConfig(var_9_0)

		var_9_1.txtcontent.text = var_9_3.content

		gohelper.setActive(var_9_1.go, true)
	end

	for iter_9_1 = #arg_9_0._selectParam + 1, #arg_9_0._selectItemList do
		local var_9_4 = arg_9_0._selectItemList[iter_9_1]

		gohelper.setActive(var_9_4.go, false)
	end
end

function var_0_0._refreshDialog(arg_10_0)
	local var_10_0 = RoomConfig.instance:getCharacterDialogConfig(arg_10_0._dialogId, arg_10_0._stepId)

	if var_10_0 then
		local var_10_1
		local var_10_2 = var_10_0.relateContent

		if string.nilorempty(var_10_2) then
			var_10_2 = var_10_0.content
		end

		local var_10_3 = arg_10_0:_getSpeakerName(var_10_0)

		if not string.nilorempty(var_10_3) then
			var_10_2 = string.format("%s:  %s", var_10_3, var_10_2)
		end

		local var_10_4 = StoryTool.getMarkTopTextList(var_10_2)
		local var_10_5 = StoryTool.filterMarkTop(var_10_2)

		arg_10_0._txtinfo.text = var_10_5

		if arg_10_0._critterMO and arg_10_0._critterItem then
			arg_10_0:_refreshCritterItem(var_10_0.critteremoji)
		end

		TaskDispatcher.runDelay(function()
			arg_10_0._conMark:SetMarksTop(var_10_4)
		end, nil, 0.01)
	end
end

function var_0_0._refreshCritterItem(arg_12_0, arg_12_1)
	if not arg_12_0._critterMO or not arg_12_0._critterItem then
		return
	end

	if arg_12_1 and arg_12_1 ~= 0 then
		arg_12_0._critterItem:fadeIn()
		arg_12_0._critterItem:setEffectByType(arg_12_1)
		arg_12_0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
		arg_12_0:_refreshPosition()
	else
		arg_12_0._critterItem:setEffectByType(0)
		arg_12_0._critterItem:hideEffects()
	end
end

function var_0_0._getSpeakerName(arg_13_0, arg_13_1)
	if not string.nilorempty(arg_13_1.speaker) then
		return arg_13_1.speaker
	end

	if arg_13_0._critterMO then
		if arg_13_1.speakerType == RoomEnum.DialogSpeakerType.Hero then
			local var_13_0 = HeroConfig.instance:getHeroCO(arg_13_0._heroId)

			return var_13_0 and var_13_0.name
		elseif arg_13_1.speakerType == RoomEnum.DialogSpeakerType.Critter then
			return arg_13_0._critterMO:getName()
		end
	end

	return nil
end

function var_0_0._onEscape(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.RoomBranchView, arg_15_0._onEscape, arg_15_0)
	arg_15_0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_15_0._refreshUI, arg_15_0)
end

function var_0_0._addPostionEventCb(arg_16_0)
	if not arg_16_0._isAddPostionEven then
		arg_16_0._isAddPostionEven = true

		arg_16_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, arg_16_0._characterPositionChanged, arg_16_0)
		arg_16_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_16_0._refreshPosition, arg_16_0)
	end
end

function var_0_0._removePostionEventCb(arg_17_0)
	if arg_17_0._isAddPostionEven then
		arg_17_0._isAddPostionEven = false

		arg_17_0:removeEventCb(RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, arg_17_0._characterPositionChanged, arg_17_0)
		arg_17_0:removeEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_17_0._refreshPosition, arg_17_0)
	end
end

function var_0_0._characterPositionChanged(arg_18_0, arg_18_1)
	if arg_18_0._critterMO and arg_18_0._critterMO.trainInfo.heroId ~= arg_18_1 then
		return
	end

	arg_18_0:_refreshPosition()
end

function var_0_0._refreshPosition(arg_19_0)
	local var_19_0 = arg_19_0:_getCritterEntity()

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.critterspine:getMountheadGOTrs() or var_19_0.goTrs

	if not var_19_1 then
		return
	end

	local var_19_2, var_19_3, var_19_4 = transformhelper.getPos(var_19_1)
	local var_19_5 = RoomBendingHelper.worldToBendingSimple(Vector3(var_19_2, var_19_3, var_19_4))
	local var_19_6 = RoomBendingHelper.worldPosToAnchorPos(var_19_5, arg_19_0._gocontentTrs)

	if var_19_6 then
		recthelper.setAnchor(arg_19_0._gospineTrs, var_19_6.x, var_19_6.y)
	end
end

function var_0_0._getCritterEntity(arg_20_0)
	if arg_20_0._scene.cameraFollow:isFollowing() then
		return arg_20_0._scene.crittermgr:getCritterEntity(arg_20_0._critterUid, SceneTag.RoomCharacter)
	end

	return arg_20_0._scene.crittermgr:getTempCritterEntity()
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._simagebg:UnLoadImage()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._selectItemList) do
		iter_22_1.btnclick:RemoveClickListener()
	end

	if arg_22_0._critterItem then
		local var_22_0 = arg_22_0._critterItem

		arg_22_0._critterItem = nil

		var_22_0:onDestroy()
	end
end

return var_0_0
