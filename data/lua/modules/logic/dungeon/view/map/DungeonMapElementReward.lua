module("modules.logic.dungeon.view.map.DungeonMapElementReward", package.seeall)

slot0 = class("DungeonMapElementReward", BaseView)

function slot0.onInitView(slot0)
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

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0, LuaEventSystem.High)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0._lastViewName then
		if slot0._rewardPoint then
			slot0:_dispatchEvent()
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
	end
end

function slot0.setShowToastState(slot0, slot1)
	slot0.notShowToast = slot1
end

function slot0._OnRemoveElement(slot0, slot1)
	slot2 = lua_chapter_map_element.configDict[slot1]
	slot0._lastViewName = nil
	slot0._rewardPoint = nil

	if not string.nilorempty(DungeonModel.instance:getMapElementReward(slot1)) then
		slot9 = "#"
		slot5 = {}

		for slot9, slot10 in ipairs(GameUtil.splitString2(slot3, false, "|", slot9)) do
			slot11 = MaterialDataMO.New()

			slot11:initValue(slot10[1], slot10[2], slot10[3])
			table.insert(slot5, slot11)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot5)

		slot0._lastViewName = ViewName.CommonPropView
	end

	if slot2.fragment > 0 then
		if lua_chapter_map_fragment.configDict[slot2.fragment] and slot4.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			slot0._lastViewName = ViewName.VersionActivityNewsView
		elseif slot2.type == DungeonEnum.ElementType.Investigate then
			slot0._lastViewName = ViewName.InvestigateTipsView
		else
			slot0._lastViewName = ViewName.DungeonFragmentInfoView
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, slot0._lastViewName, {
			elementId = slot2.id,
			fragmentId = slot2.fragment,
			notShowToast = slot0.notShowToast
		})
	end

	if slot0._lastViewName then
		DungeonController.instance:dispatchEvent(DungeonEvent.BeginShowRewardView)
	end

	if slot2.rewardPoint > 0 then
		slot0._rewardPoint = slot2.rewardPoint

		if not slot0._lastViewName then
			slot0:_dispatchEvent()
		end
	end
end

function slot0._dispatchEvent(slot0)
	DungeonModel.instance:endCheckUnlockChapter()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddRewardPoint, slot0._rewardPoint)

	slot0._rewardPoint = nil
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
