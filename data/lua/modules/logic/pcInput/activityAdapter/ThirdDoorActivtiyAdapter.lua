module("modules.logic.pcInput.activityAdapter.ThirdDoorActivtiyAdapter", package.seeall)

slot0 = class("ThirdDoorActivtiyAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	[5] = function ()
		if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
			ViewMgr.instance:closeView(ViewName.ExploreMapView)
		else
			if ViewMgr.instance:IsPopUpViewOpen() or not uv0.instance:getHeroCanMove() then
				return
			end

			ViewMgr.instance:openView(ViewName.ExploreMapView)
		end
	end,
	[6] = function ()
		if not ExploreSimpleModel.instance.isShowBag then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.ExploreBackpackView) then
			ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		else
			if ViewMgr.instance:IsPopUpViewOpen() or not uv0.instance:getHeroCanMove() then
				return
			end

			ViewMgr.instance:openView(ViewName.ExploreBackpackView)
		end
	end,
	[7] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 1)
	end,
	[8] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 2)
	end,
	[9] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 3)
	end,
	[10] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 4)
	end,
	[11] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 5)
	end,
	[12] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 6)
	end,
	[13] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 7)
	end,
	[14] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 8)
	end,
	[15] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorItemSelect, 9)
	end,
	[16] = function ()
		if ViewMgr.instance:isOpen(ViewName.HelpView) then
			ViewMgr.instance:closeView(ViewName.HelpView)

			return
		end

		if ViewMgr.instance:IsPopUpViewOpen() or not uv0.instance:getHeroCanMove() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorHelp)
	end,
	[17] = function ()
		if ViewMgr.instance:isOpen(ViewName.ExploreArchivesView) then
			ViewMgr.instance:closeView(ViewName.ExploreArchivesView)

			return
		end

		if ViewMgr.instance:IsPopUpViewOpen() or not uv0.instance:getHeroCanMove() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorOpenBook)
	end
}

function slot0.getHeroCanMove(slot0)
	if ExploreController.instance:getMap() and slot1:getNowStatus() == ExploreEnum.MapStatus.Normal then
		return true
	end

	return false
end

function slot0.ctor(slot0)
	BaseActivityAdapter.ctor(slot0)

	slot0.keytoFunction = uv0.keytoFunction
	slot0.activitid = PCInputModel.Activity.thrityDoor

	slot0:registerFunction()
end

slot0.instance = slot0.New()

return slot0
