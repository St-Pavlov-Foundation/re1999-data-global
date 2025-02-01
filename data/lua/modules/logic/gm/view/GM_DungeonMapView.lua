module("modules.logic.gm.view.GM_DungeonMapView", package.seeall)

slot0 = class("GM_DungeonMapView", BaseView)

function slot0.register()
	uv0.DungeonMapView_register(DungeonMapView)
	uv0.DungeonMapEpisodeItem_register(DungeonMapEpisodeItem)
end

function slot0.DungeonMapView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_DungeonMapViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_DungeonMapViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function slot0.DungeonMapEpisodeItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onUpdateParam")

	function slot0.onUpdateParam(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onUpdateParam", ...)

		if uv0.s_ShowAllTabId then
			slot1 = slot0._config
			slot0._txtsectionname.text = tostring(slot1.id) .. "\n" .. slot1.name
		end
	end
end

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
end

function slot0.onDestroyView(slot0)
end

slot0.s_ShowAllTabId = false

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = uv0.s_ShowAllTabId
end

function slot0._onItem1ToggleValueChanged(slot0)
	slot1 = slot0._item1Toggle.isOn
	uv0.s_ShowAllTabId = slot1

	GMController.instance:dispatchEvent(GMEvent.DungeonMapView_ShowAllTabIdUpdate, slot1)
end

return slot0
