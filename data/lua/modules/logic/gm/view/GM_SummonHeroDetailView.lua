module("modules.logic.gm.view.GM_SummonHeroDetailView", package.seeall)

slot0 = class("GM_SummonHeroDetailView", BaseView)
slot1 = string.format
slot2 = "#FFFF00"

function slot0.register()
	uv0.SummonHeroDetailView_register(SummonHeroDetailView)
end

function slot0.SummonHeroDetailView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshHero")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_SummonHeroDetailViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_SummonHeroDetailViewContainer.removeEvents(slot0)
	end

	function slot0._refreshHero(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshHero", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot3 = HeroConfig.instance:getHeroCO(slot0._heroId)

		if SkinConfig.instance:getSkinCo(slot0._skinId) then
			slot0._txtnameen.text = slot3.nameEng .. uv1(" (skinId: %s)", gohelper.getRichColorText(slot2, uv2))
		end

		slot0._txtname.text = slot3.name .. gohelper.getRichColorText(slot1, uv2)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:_refreshUI()
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

	GMController.instance:dispatchEvent(GMEvent.SummonHeroDetailView_ShowAllTabIdUpdate, slot1)
end

return slot0
