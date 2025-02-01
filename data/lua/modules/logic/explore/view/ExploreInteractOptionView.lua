module("modules.logic.explore.view.ExploreInteractOptionView", package.seeall)

slot0 = class("ExploreInteractOptionView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gochoicelist = gohelper.findChild(slot0.viewGO, "#go_choicelist")
	slot0._gochoiceitem = gohelper.findChild(slot0.viewGO, "#go_choicelist/#go_choiceitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnclose, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnclose)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gochoiceitem, false)
end

function slot0.onOpen(slot0)
	slot0.optionsBtn = slot0:getUserDataTb_()

	for slot5 = 1, #slot0.viewParam do
		slot6 = gohelper.cloneInPlace(slot0._gochoiceitem, "choiceitem")

		gohelper.setActive(slot6, true)

		gohelper.findChildTextMesh(slot6, "info").text = slot1[slot5].optionTxt
		slot0.optionsBtn[slot5] = gohelper.findChildButtonWithAudio(slot6, "click")

		slot0.optionsBtn[slot5]:AddClickListener(slot0.optionClick, slot0, slot1[slot5])
	end
end

function slot0.optionClick(slot0, slot1)
	slot0:closeThis()
	slot1.optionCallBack(slot1.optionCallObj, slot1.unit, slot1.isClient)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0.optionsBtn do
		slot0.optionsBtn[slot4]:RemoveClickListener()
	end

	gohelper.destroyAllChildren(slot0._gochoicelist)
end

return slot0
