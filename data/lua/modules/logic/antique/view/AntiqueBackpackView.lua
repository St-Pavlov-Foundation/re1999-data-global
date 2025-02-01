module("modules.logic.antique.view.AntiqueBackpackView", package.seeall)

slot0 = class("AntiqueBackpackView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollantique = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_antique")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._ani = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Antique)

	slot0._ani.enabled = #slot0.tabContainer._tabAbLoaders < 2
	slot0._scrollantique.verticalNormalizedPosition = 1

	slot0:refreshAntique()
end

function slot0.refreshAntique(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(AntiqueModel.instance:getAntiqueList()) do
		table.insert(slot2, slot7)
	end

	AntiqueBackpackListModel.instance:setAntiqueList(slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	AntiqueBackpackListModel.instance:clearAntiqueList()
end

return slot0
