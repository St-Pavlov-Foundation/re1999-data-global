module("modules.logic.story.view.StoryHeroView", package.seeall)

slot0 = class("StoryHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorolebg = gohelper.findChild(slot0.viewGO, "#go_rolebg")
	slot0._goroles = gohelper.findChild(slot0.viewGO, "#go_roles")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._addEvent(slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshHero, slot0._onUpdateHero, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshView, slot0._refreshView, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._storyFinished, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0._clearItems, slot0)
end

function slot0._removeEvent(slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshHero, slot0._onUpdateHero, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, slot0._refreshView, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._storyFinished, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Finish, slot0._clearItems, slot0)
end

function slot0._editableInitView(slot0)
	slot0._blitEff = slot0._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	slot0._heros = {}

	slot0:_loadRes()
end

slot1 = "spine/spine_ui_default.mat"
slot2 = "spine/spine_ui_dark.mat"

function slot0._loadRes(slot0)
	slot0._matLoader = MultiAbLoader.New()

	slot0._matLoader:addPath(uv0)
	slot0._matLoader:addPath(uv1)
	slot0._matLoader:startLoad(slot0._onResLoaded, slot0)
end

function slot0._onResLoaded(slot0)
	if slot0._matLoader:getAssetItem(uv0) then
		slot0._normalMat = slot1:GetResource(uv0)
	else
		logError("Resource is not found at path : " .. uv0)
	end

	if slot0._matLoader:getAssetItem(uv1) then
		slot0._darkMat = slot2:GetResource(uv1)
	else
		logError("Resource is not found at path : " .. uv1)
	end

	slot0:_resetHeroMat()
end

function slot0._resetHeroMat(slot0)
	if not slot0._heroCo then
		return
	end

	for slot4, slot5 in pairs(slot0._heroCo) do
		if slot0._heros[slot5.heroIndex] then
			slot0._heros[slot5.heroIndex]:setHeroMat(slot0:_isHeroDark(slot4) and slot0._darkMat or slot0._normalMat, StoryModel.instance:hasBottomEffect())
		end
	end
end

function slot0._isHeroDark(slot0, slot1)
	for slot5, slot6 in pairs(slot0._stepCo.conversation.showList) do
		if slot6 == slot1 - 1 then
			return false
		end
	end

	return true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addEvent()
end

function slot0.onClose(slot0)
	slot0:_removeEvent()
end

function slot0._onUpdateHero(slot0, slot1)
	if #slot1.branches > 0 then
		StoryController.instance:openStoryBranchView(slot1.branches)
	end

	if slot1.stepType ~= StoryEnum.StepType.Normal then
		for slot5, slot6 in pairs(slot0._heros) do
			slot6:stopVoice()
		end

		return
	end

	slot0._stepCo = StoryStepModel.instance:getStepListById(slot1.stepId)

	if slot0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and slot0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		slot0:_updateHeroList(slot0._stepCo.heroList)
	end
end

function slot0._refreshView(slot0)
	TaskDispatcher.cancelTask(slot0._playShowHero, slot0)
	slot0:_updateHeroList(slot0._stepCo.heroList)
end

function slot0._storyFinished(slot0)
	if not StoryController.instance._hideStartAndEndDark then
		return
	end

	slot0:_updateHeroList({})
end

function slot0._updateHeroList(slot0, slot1)
	slot2 = false
	slot3 = false
	slot4 = false

	slot0._blitEff:SetKeepCapture(true)

	if slot0._heroCo then
		if #slot0._heroCo == 0 and #slot1 == 0 then
			slot3 = false
			slot2 = false
		else
			slot5 = false

			for slot9, slot10 in pairs(slot1) do
				for slot14, slot15 in pairs(slot0._heroCo) do
					if slot15.heroIndex == slot10.heroIndex then
						slot5 = true

						break
					end
				end
			end

			if slot5 then
				slot3 = false
				slot2 = false
			else
				slot3 = true
				slot2 = true
			end
		end
	else
		slot2 = false
		slot3 = true
		slot0._heroCo = {}
	end

	if slot0._preStepTransBg then
		slot0._preStepTransBg = false
		slot2 = true
		slot3 = true
	elseif StoryModel.instance:getPreSteps(slot0._stepCo.id) and #slot5 > 0 then
		slot8 = slot0._stepCo.bg

		if StoryStepModel.instance:getStepListById(slot5[1]) and slot6.bg and slot8 and (slot8.offset[1] ~= slot7.offset[1] or slot8.offset[2] ~= slot7.offset[2]) then
			slot0._preStepTransBg = true
		end
	end

	for slot8, slot9 in pairs(slot0._heroCo) do
		slot10 = true

		for slot14, slot15 in pairs(slot1) do
			if slot15.heroIndex == slot9.heroIndex then
				slot10 = false

				break
			end
		end

		if slot10 then
			slot4 = true
		end
	end

	slot0._heroCo = slot1
	slot5 = {}

	for slot9, slot10 in pairs(slot0._heros) do
		slot11 = false

		for slot15, slot16 in pairs(slot0._heroCo) do
			if slot16.heroIndex == slot9 then
				slot11 = true
			end
		end

		if not slot11 then
			slot10:hideHero()
			table.insert(slot5, slot9)
		end
	end

	for slot9, slot10 in pairs(slot5) do
		slot0._heros[slot10] = nil
	end

	if slot2 then
		StoryModel.instance:enableClick(false)

		if slot4 then
			TaskDispatcher.runDelay(slot0._playShowHero, slot0, 1)
		else
			TaskDispatcher.runDelay(slot0._playShowHero, slot0, 0.5)
		end
	elseif slot4 then
		StoryModel.instance:enableClick(false)
		TaskDispatcher.runDelay(slot0._playShowHero, slot0, 0.5)
	else
		slot0:_playShowHero()
	end

	StoryModel.instance:setNeedFadeIn(slot3)
	StoryModel.instance:setNeedFadeOut(slot2)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshConversation)
end

function slot0._playShowHero(slot0)
	slot1 = false

	for slot6, slot7 in pairs(slot0._heroCo) do
		if not slot0._heros[slot7.heroIndex] then
			slot1 = true
			slot10 = StoryHeroItem.New()
			slot0._heros[slot7.heroIndex] = slot10

			slot10:init(slot0._goroles, slot7)
			slot10:buildHero(slot7, slot0:_isHeroDark(slot6) and slot0._darkMat or slot0._normalMat, StoryModel.instance:hasBottomEffect(), slot0._onEnableClick, slot0, slot0._stepCo.conversation.audios[1] or 0)
		else
			slot0._heros[slot7.heroIndex]:resetHero(slot7, slot8, slot9, slot2)
		end
	end

	if not slot1 and StoryStepModel.instance:getStepListById(StoryController.instance._curStepId).conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(true)
	end
end

function slot0._onEnableClick(slot0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function slot0._clearItems(slot0)
	for slot4, slot5 in pairs(slot0._heros) do
		slot5:onDestroy()
	end

	slot0._heros = {}
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playShowHero, slot0)
	ViewMgr.instance:closeView(ViewName.StoryView, true)
	ViewMgr.instance:closeView(ViewName.StoryLeadRoleSpineView, true)
	slot0:_clearItems()
	slot0._blitEff:SetKeepCapture(false)

	if slot0._matLoader then
		slot0._matLoader:dispose()

		slot0._matLoader = nil
	end
end

return slot0
