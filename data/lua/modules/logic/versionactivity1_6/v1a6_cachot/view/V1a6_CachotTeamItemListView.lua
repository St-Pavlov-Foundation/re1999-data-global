module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItemListView", package.seeall)

slot0 = class("V1a6_CachotTeamItemListView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopresetcontent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	slot0._gopreparecontent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._initPresetItemList(slot0)
	if slot0._presetItemList then
		return
	end

	slot0._presetItemList = slot0:getUserDataTb_()

	for slot5 = 1, V1a6_CachotEnum.HeroCountInGroup do
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gopresetcontent, "item" .. tostring(slot5)), V1a6_CachotTeamItem)
		slot0._presetItemList[slot5] = slot7

		slot7:setInteractable(slot0._isInitSelect)
		slot7:setHpVisible(not slot0._isInitSelect)
	end
end

function slot0._initPrepareItemList(slot0)
	if slot0._prepareItemList then
		return
	end

	slot0._prepareItemList = slot0:getUserDataTb_()
	slot2 = V1a6_CachotTeamModel.instance:getPrepareNum()

	for slot6 = 1, 4 do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gopreparecontent, "item" .. tostring(slot6)), V1a6_CachotTeamPrepareItem)
		slot0._prepareItemList[slot6] = slot8

		slot8:setInteractable(slot0._isInitSelect and slot6 <= slot2)
		slot8:setHpVisible(not slot0._isInitSelect)

		if slot2 < slot6 then
			slot8:showNone()
		end
	end
end

function slot0._initParams(slot0)
	slot0._isInitSelect = slot0.viewParam and slot0.viewParam.isInitSelect
end

function slot0.onOpen(slot0)
	slot0:_initParams()

	if slot0._isInitSelect then
		slot0:_initModel()
	end

	slot0:_initPresetItemList()
	slot0:_initPrepareItemList()
	slot0:_updatePresetAndPrepare()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)
end

function slot0._modifyHeroGroup(slot0)
	slot0._isModify = true

	slot0:_updatePresetAndPrepare()

	slot0._isModify = false
end

function slot0._updatePresetAndPrepare(slot0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	slot0:_updatePresetItemList()
	slot0:_updatePrepareItemList()
end

function slot0._initModel(slot0)
	slot3, slot4 = V1a6_CachotModel.instance:getRogueStateInfo():getLastGroupInfo(V1a6_CachotTeamModel.instance:getPrepareNum())
	slot5 = V1a6_CachotHeroGroupMO.New()

	slot5:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)
	slot5:init({
		groupId = 1,
		heroList = slot3,
		equips = slot4
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(slot5)
end

function slot0._updatePresetItemList(slot0)
	for slot4, slot5 in ipairs(slot0._presetItemList) do
		slot6 = V1a6_CachotHeroSingleGroupModel.instance:getById(slot4)

		V1a6_CachotTeamModel.instance:setSeatInfo(slot4, V1a6_CachotTeamModel.instance:getInitSeatLevel(slot4), slot6)

		slot7 = slot6:getHeroMO()

		if slot0._isModify and slot7 and slot5:getHeroMo() ~= slot7 then
			slot5:showSelectEffect()
		end

		slot5:onUpdateMO(slot6)
	end
end

function slot0._updatePrepareItemList(slot0)
	for slot4, slot5 in ipairs(slot0._prepareItemList) do
		slot7 = V1a6_CachotHeroSingleGroupModel.instance:getById(slot4 + V1a6_CachotEnum.HeroCountInGroup):getHeroMO()

		if slot0._isModify and slot7 and slot5:getHeroMo() ~= slot7 then
			slot5:showSelectEffect()
		end

		slot5:onUpdateMO(slot6)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
