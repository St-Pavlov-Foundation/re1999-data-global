module("modules.logic.gm.view.GM_SummonADView", package.seeall)

slot0 = class("GM_SummonADView")

function slot0.register()
	uv0.SummonMainView_register(SummonMainView)
	uv0.SummonMainCategoryItem_register(SummonMainCategoryItem)
end

function slot0.SummonMainView_register(slot0)
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
		GM_SummonMainViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_SummonMainViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate()
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end
end

function slot0.SummonMainCategoryItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_initCurrentComponents")

	function slot0._initCurrentComponents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_initCurrentComponents", ...)

		if not GM_SummonMainView.s_ShowAllTabId then
			return
		end

		slot2 = gohelper.getRichColorText("=====> id:" .. tostring(slot0._mo.originConf.id), "#FFFF00")
		slot0._txtnameselect.text = slot2
		slot0._txtname.text = slot2
		slot0._txtnameen.text = slot2
		slot0._txtnameenselect.text = slot2
	end
end

return slot0
