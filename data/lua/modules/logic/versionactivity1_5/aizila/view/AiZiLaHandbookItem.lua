module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookItem", package.seeall)

slot0 = class("AiZiLaHandbookItem", AiZiLaGoodsItem)

function slot0._btnclickOnClick(slot0)
	if slot0._mo then
		AiZiLaHandbookListModel.instance:setSelect(slot0._mo.itemId)
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectItem)
	end
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)
	slot0._goimagerare = slot0._imagerare.gameObject
	slot0._goimageicon = slot0._imageicon.gameObject
	slot0._goimagecountBG = slot0._imagecountBG.gameObject
	slot0._lastGray = false
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtcount.text = slot1:getQuantity()

	slot0:_refreshIcon(slot1.itemId)
	slot0:_refreshGray(not AiZiLaModel.instance:isCollectItemId(slot1.itemId))
end

function slot0._refreshGray(slot0, slot1)
	if slot0._lastGray ~= (slot1 and true or false) then
		slot0._lastGray = slot2
		slot0._canvasGroup.alpha = slot2 and 0.75 or 1

		slot0:_setGrayMode(slot0._goimagerare, slot2)
		slot0:_setGrayMode(slot0._goimageicon, slot2)
		slot0:_setGrayMode(slot0._goimagecountBG, slot2)
	end
end

function slot0._setGrayMode(slot0, slot1, slot2)
	if slot2 then
		ZProj.UGUIHelper.SetGrayFactor(slot1, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(slot1, false)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
