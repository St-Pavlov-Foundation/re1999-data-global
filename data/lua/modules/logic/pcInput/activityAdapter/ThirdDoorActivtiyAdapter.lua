module("modules.logic.pcInput.activityAdapter.ThirdDoorActivtiyAdapter", package.seeall)

slot0 = class("ThirdDoorActivtiyAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	[5] = function ()
		ViewMgr.instance:openView(ViewName.ExploreMapView)
	end,
	[6] = function ()
		if not ExploreSimpleModel.instance.isShowBag then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.ExploreBackpackView) then
			ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		else
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
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorHelp)
	end,
	[17] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyThirdDoorOpenBook)
	end
}

function slot0.ctor(slot0)
	BaseActivityAdapter.ctor(slot0)

	slot0.keytoFunction = uv0.keytoFunction
	slot0.activitid = PCInputModel.Activity.thrityDoor

	slot0:registerFunction()
end

slot0.instance = slot0.New()

return slot0
