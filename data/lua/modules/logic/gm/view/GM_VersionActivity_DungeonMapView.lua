module("modules.logic.gm.view.GM_VersionActivity_DungeonMapView", package.seeall)

slot0 = class("GM_VersionActivity_DungeonMapView", BaseView)
slot1 = "#FFFF00"

function slot2()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_DungeonMapView)
end

function slot0.VersionActivityX_XDungeonMapView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0, uv0)
		GM_VersionActivity_DungeonMapViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_VersionActivity_DungeonMapViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function slot0.VersionActivityX_XMapEpisodeItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "refreshUI")

	function slot0.refreshUI(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "refreshUI", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot0._txtsectionname.text = tostring(slot0._config.id) .. "\n" .. slot0._config.name
	end
end

function slot0.VersionActivityX_XDungeonMapLevelView_register(slot0, slot1, slot2)
	slot1 = slot1 or 1
	slot2 = slot2 or 0

	function slot3(slot0, slot1)
		if uv0 < slot0 then
			return true
		end

		if uv0 == slot0 then
			return uv1 <= slot1
		end

		return false
	end

	function slot4(slot0, slot1)
		if slot0 < uv0 then
			return true
		end

		if uv0 == slot0 then
			return slot1 <= uv1
		end

		return false
	end

	GMMinusModel.instance:saveOriginalFunc(slot0, "refreshStartBtn")

	function slot0.refreshStartBtn(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "refreshStartBtn", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot1 = slot0.showEpisodeCo
		slot2 = gohelper.getRichColorText(slot1.id, uv1)
		slot0._txtnorstarttext.text = DungeonModel.instance:hasPassLevel(slot1.id) and slot1.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot1.afterStory) and slot2 .. luaLang("p_dungeonlevelview_continuestory") or slot2 .. luaLang("p_dungeonlevelview_startfight")

		if uv2(1, 2) then
			slot0._txtnorstarttext2.text = slot2
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

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_DungeonMapView_ShowAllTabIdUpdate, slot1)
end

return slot0
