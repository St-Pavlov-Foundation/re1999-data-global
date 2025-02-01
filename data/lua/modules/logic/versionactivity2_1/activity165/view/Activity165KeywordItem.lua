module("modules.logic.versionactivity2_1.activity165.view.Activity165KeywordItem", package.seeall)

slot0 = class("Activity165KeywordItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtkeywords = gohelper.findChildText(slot0.viewGO, "#txt_keywords")
	slot0._btnkeywords = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_keywords")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnkeywords:AddClickListener(slot0._btnkeywordsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnkeywords:RemoveClickListener()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
	slot0:_removeEventListeners()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btnkeywordsOnClick(slot0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickUsedKeyword, slot0._mo.keywordId)
	slot0:onRefresh()
end

function slot0._btnkewordsOnClick(slot0)
end

function slot0._removeEventListeners(slot0)
	if slot0.drag then
		slot0.drag:RemoveDragBeginListener()
		slot0.drag:RemoveDragListener()
		slot0.drag:RemoveDragEndListener()
	end
end

function slot0._editableInitView(slot0)
	slot0._canvasgroup = slot0.viewGO:GetComponent(gohelper.Type_CanvasGroup)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	gohelper.setActive(slot1, true)
	slot0:onInitView()
end

function slot0.setDragEvent(slot0, slot1, slot2, slot3, slot4)
	if slot0._mo then
		slot0.drag = SLFramework.UGUI.UIDragListener.Get(slot0._btnkeywords.gameObject)

		slot0.drag:AddDragBeginListener(slot1, slot4, slot0._mo.keywordId)
		slot0.drag:AddDragListener(slot2, slot4)
		slot0.drag:AddDragEndListener(slot3, slot4)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot1 then
		slot0._txtkeywords.text = slot1.keywordCo.text

		if not string.nilorempty(slot1.keywordCo.pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(slot0._imageicon, slot2)
		end
	end
end

function slot0.onRefresh(slot0)
	if slot0._mo.isUsed then
		slot0:Using()
	else
		slot0:clearUsing()
	end
end

function slot0.Using(slot0)
	slot0:_setAlpha(0.5)
end

function slot0.clearUsing(slot0)
	slot0:_setAlpha(1)
end

function slot0._setAlpha(slot0, slot1)
	if slot0._canvasgroup then
		slot0._canvasgroup.alpha = slot1
	end
end

return slot0
